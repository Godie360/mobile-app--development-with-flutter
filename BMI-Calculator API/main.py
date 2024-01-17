from fastapi import FastAPI, HTTPException

app = FastAPI()

def calculate_bmi(weight: float, height: float) -> float:
    bmi = weight / (height ** 2)
    return bmi

def get_health_status(bmi: float) -> str:
    if bmi < 18.5:
        return 'Underweight'
    elif 18.5 <= bmi < 24.9:
        return 'Healthy'
    elif 25 <= bmi < 29.9:
        return 'Overweight'
    else:
        return 'Obese'

@app.get("/calculate_bmi")
def calculate_bmi_endpoint(weight: float, height: float):
    try:
        bmi = calculate_bmi(weight, height)
        health_status = get_health_status(bmi)

        result = {
            'bmi': bmi,
            'health_status': health_status
        }

        return result

    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
