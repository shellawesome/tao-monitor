#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import time
import sys
from loguru import logger
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.keys import Keys
import subprocess

logger.remove()
logger.level("DEBUG")
logger.add(sys.stdout, colorize=True, format="<g>{time:YYYY-MM-DD HH:mm:ss}</g> | {level} | {message}")

def main():

    global debugger_address
    debugger_address = "localhost:9222"
    logger.info(f"Debugger Address: {debugger_address}")

    options = Options()
    options.add_experimental_option("debuggerAddress", debugger_address)
    driver = webdriver.Chrome(options=options)

    global wait_fast
    wait_fast = WebDriverWait(driver, 5, 1)
    global wait
    wait = WebDriverWait(driver, 10, 1)
    global wait_slow
    wait_slow = WebDriverWait(driver, 15, 1)

    for subnetUid in range(1,128):
        for i in range(1,3):
            try:
                # 获取当前打开的所有标签页的 handles
                handles = driver.window_handles
                # 保留第一个标签页，关闭其他所有标签页
                for handle in handles[1:]:
                    driver.switch_to.window(handle)
                    driver.close()
                # 切换回第一个标签页
                driver.switch_to.window(handles[0])
                logger.info(f"Opening https://taomarketcap.com/subnets/{subnetUid}/miners")
                driver.get(f"https://taomarketcap.com/subnets/{subnetUid}/miners")
                time.sleep(10)
                logger.info(f"save screen")
                driver.save_screenshot(f"/app/tao-monitor/data/sn{subnetUid}-miner.png")
                break
            except Exception as e:
                print(e)
            finally:
                driver.get("chrome://version")
                time.sleep(3)

        for i in range(1,3):
            try:
                # 获取当前打开的所有标签页的 handles
                handles = driver.window_handles
                # 保留第一个标签页，关闭其他所有标签页
                for handle in handles[1:]:
                    driver.switch_to.window(handle)
                    driver.close()
                # 切换回第一个标签页
                driver.switch_to.window(handles[0])
                logger.info(f"Opening https://taomarketcap.com/subnets/{subnetUid}/registration")
                driver.get(f"https://taomarketcap.com/subnets/{subnetUid}/registration")
                time.sleep(10)
                logger.info(f"save screen")
                driver.save_screenshot(f"/app/tao-monitor/data/sn{subnetUid}-registration.png")
                break
            except Exception as e:
                print(e)
            finally:
                driver.get("chrome://version")
                time.sleep(3)

if __name__ == '__main__':
    main()
