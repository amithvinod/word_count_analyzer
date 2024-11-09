from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, HttpUrl
from collections import Counter
from typing import List, Dict
import requests
from bs4 import BeautifulSoup
import re

app = FastAPI()

class URLRequest(BaseModel):
    url: HttpUrl
    n_value: int = 10

class WordFrequencyResponse(BaseModel):
    word: str
    frequency: int

@app.post("/analyze", response_model=List[WordFrequencyResponse])
async def analyze_url(data: URLRequest):
    try:
        response = requests.get(data.url)
        if response.status_code != 200:
            raise HTTPException(status_code=400, detail="Could not fetch the URL content")
        
        soup = BeautifulSoup(response.text, 'html.parser')
        text = soup.get_text()
        
        words = re.findall(r'\b\w+\b', text.lower())
        
        word_counts = Counter(words)
        top_words = word_counts.most_common(data.n_value)
        
        result = [{"word": word, "frequency": freq} for word, freq in top_words]
        return result
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
