Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0F05F2227
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 10:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJBI6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 04:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBI6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 04:58:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B612980B
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 01:58:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id nb11so16829020ejc.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=dnfUReWxODRV4PA+9x/mA+tc6+qh2wSLgA8zs/Pa2yQ=;
        b=kjwHM07Jp92ehQSxc69adZwLt7d4qsHx/OKiX7DixSoGKVKiZOxO33tuNYRfk9FZDg
         ajZPLgRrir7aKJV1Z0n/E7EX7kWateOFN3vo3LeuChujWJiakxlHCHDICyhN6yC1D7hK
         +6wLmaJSYl9uYh+rhTUMO2p2VwSUhSmupfiegxLpsacqpJNDbmaMxJ+WdG7RecgMOVrS
         kYL6ERAFmHN9wjGHWDJbDDRTS19v8Hk/oiA2BKRwEqOFqwUYGezAMsCluLgcKA5wdON/
         UQVFXQVK0U4XU0282ZcBCYWh1AF3LRJveegBmznwyLaX5feRHwe3Pw492NKO2DS/0dvV
         hAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dnfUReWxODRV4PA+9x/mA+tc6+qh2wSLgA8zs/Pa2yQ=;
        b=JbDi5YbnBaZZZ9HZJ04N6S4ThICkn1VVVbW7T9ShikDP+ae5Td7O7FGlXa2ZbKdU0N
         Vyk0hcdjFtY8+7xmH4kgr7LtM1dKN0P3aBebRt8sp/SVpzfPSsILrSn/fKd05gKt9lox
         5WqETsn4VOub3MdrBjr3FsV4mXBbMQV5yOxGKUbI3YExHtr/b4AzvE7RZiC5YdaS148J
         7iBKLgV0dOZ1WZJcdSi0KuCLOvhFJ+RhqFiESjMaY4+sc1KEOkxBb5LjsxirPWR+G9fl
         8UzBmJMk0XtIXkOICCnNShQ8k0mgm57TDLe+99TctAz7f7Xj9TofHtOA0ir09l79+gla
         u39g==
X-Gm-Message-State: ACrzQf1yCaLIhU4hhekKhUDX6BU3gZ37W+vxAqlO/qV+33QeF1+pAUxk
        ayrN309bdWdseOz8yH4XECY=
X-Google-Smtp-Source: AMsMyM5r7r1dz6Qjq0Uusk1aj/0DbnvhtqZ5WFy1ASf7haZnVg8Td1UjMObq45HT9R4ydUWL6aqamw==
X-Received: by 2002:a17:907:86ab:b0:781:f150:84e4 with SMTP id qa43-20020a17090786ab00b00781f15084e4mr11486529ejc.435.1664701128029;
        Sun, 02 Oct 2022 01:58:48 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f3e:6a95:e9c7:da34:4bcf:58e7? (p200300c78f3e6a95e9c7da344bcf58e7.dip0.t-ipconnect.de. [2003:c7:8f3e:6a95:e9c7:da34:4bcf:58e7])
        by smtp.gmail.com with ESMTPSA id bm15-20020a170906c04f00b0073c80d008d5sm3689662ejb.122.2022.10.02.01.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 01:58:47 -0700 (PDT)
Message-ID: <52d07767-2347-67af-6365-29834da2c09c@gmail.com>
Date:   Sun, 2 Oct 2022 10:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: remove bLedLinkBlinkInProgress
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221001170618.444444-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221001170618.444444-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/22 19:06, Martin Kaiser wrote:
> Remove the bLedLinkBlinkInProgress component from struct led_priv. Its
> only use is to block requests for "link blinking" when this blinking
> pattern is already active.
> 
> The "link blinking" pattern is a continuous blinking pattern (as opposed
> to other patterns where we blink N times), it's no problem to restart this
> pattern when it's already running.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/core/rtw_led.c    | 14 --------------
>   drivers/staging/r8188eu/include/rtw_led.h |  1 -
>   2 files changed, 15 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
> index 1e316e6358ea..2527c252c3e9 100644
> --- a/drivers/staging/r8188eu/core/rtw_led.c
> +++ b/drivers/staging/r8188eu/core/rtw_led.c
> @@ -26,7 +26,6 @@ static void ResetLedStatus(struct led_priv *pLed)
>   
>   	pLed->BlinkTimes = 0; /*  Number of times to toggle led state for blinking. */
>   
> -	pLed->bLedLinkBlinkInProgress = false;
>   	pLed->bLedScanBlinkInProgress = false;
>   }
>   
> @@ -99,7 +98,6 @@ static void blink_work(struct work_struct *work)
>   		pLed->BlinkTimes--;
>   		if (pLed->BlinkTimes == 0) {
>   			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> -				pLed->bLedLinkBlinkInProgress = true;
>   				pLed->CurrLedState = LED_BLINK_NORMAL;
>   				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
>   			} else {
> @@ -115,7 +113,6 @@ static void blink_work(struct work_struct *work)
>   		pLed->BlinkTimes--;
>   		if (pLed->BlinkTimes == 0) {
>   			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> -				pLed->bLedLinkBlinkInProgress = true;
>   				pLed->CurrLedState = LED_BLINK_NORMAL;
>   				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
>   			} else {
> @@ -132,7 +129,6 @@ static void blink_work(struct work_struct *work)
>   		break;
>   	case LED_BLINK_WPS_STOP:	/* WPS success */
>   		if (!pLed->bLedOn) {
> -			pLed->bLedLinkBlinkInProgress = true;
>   			pLed->CurrLedState = LED_BLINK_NORMAL;
>   			schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
>   
> @@ -189,23 +185,18 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
>   
>   		cancel_delayed_work(&pLed->blink_work);
>   
> -		pLed->bLedLinkBlinkInProgress = false;
>   		pLed->bLedBlinkInProgress = false;
>   
>   		pLed->CurrLedState = LED_BLINK_SLOWLY;
>   		schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
>   		break;
>   	case LED_CTL_LINK:
> -		if (!pLed->bLedLinkBlinkInProgress)
> -			return;
> -
>   		if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
>   			return;
>   
>   		cancel_delayed_work(&pLed->blink_work);
>   
>   		pLed->bLedBlinkInProgress = false;
> -		pLed->bLedLinkBlinkInProgress = true;
>   
>   		pLed->CurrLedState = LED_BLINK_NORMAL;
>   		schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
> @@ -222,7 +213,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
>   
>   		cancel_delayed_work(&pLed->blink_work);
>   
> -		pLed->bLedLinkBlinkInProgress = false;
>   		pLed->bLedBlinkInProgress = false;
>   		pLed->bLedScanBlinkInProgress = true;
>   
> @@ -240,7 +230,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
>   
>   		cancel_delayed_work(&pLed->blink_work);
>   
> -		pLed->bLedLinkBlinkInProgress = false;
>   		pLed->bLedBlinkInProgress = true;
>   
>   		pLed->CurrLedState = LED_BLINK_TXRX;
> @@ -253,7 +242,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
>   
>   		cancel_delayed_work(&pLed->blink_work);
>   
> -		pLed->bLedLinkBlinkInProgress = false;
>   		pLed->bLedBlinkInProgress = false;
>   		pLed->bLedScanBlinkInProgress = false;
>   		pLed->bLedWPSBlinkInProgress = true;
> @@ -263,7 +251,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
>   	case LED_CTL_STOP_WPS:
>   		cancel_delayed_work(&pLed->blink_work);
>   
> -		pLed->bLedLinkBlinkInProgress = false;
>   		pLed->bLedBlinkInProgress = false;
>   		pLed->bLedScanBlinkInProgress = false;
>   		pLed->bLedWPSBlinkInProgress = true;
> @@ -283,7 +270,6 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
>   		break;
>   	case LED_CTL_POWER_OFF:
>   		pLed->CurrLedState = RTW_LED_OFF;
> -		pLed->bLedLinkBlinkInProgress = false;
>   		pLed->bLedBlinkInProgress = false;
>   		pLed->bLedWPSBlinkInProgress = false;
>   		pLed->bLedScanBlinkInProgress = false;
> diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
> index 8520f022a67f..f57dcf6c8b24 100644
> --- a/drivers/staging/r8188eu/include/rtw_led.h
> +++ b/drivers/staging/r8188eu/include/rtw_led.h
> @@ -47,7 +47,6 @@ struct led_priv {
>   
>   	u32 BlinkTimes; /*  Number of times to toggle led state for blinking. */
>   
> -	bool bLedLinkBlinkInProgress;
>   	bool bLedScanBlinkInProgress;
>   	struct delayed_work blink_work;
>   };

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
