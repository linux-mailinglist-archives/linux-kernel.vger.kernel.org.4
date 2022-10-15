Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583B45FFB10
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJOPmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJOPmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:42:05 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DC14DB47
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:42:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r14so11471716lfm.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3HHUyAX1B91skwUMpCNzF5YH2X1NSjsOWajnMHTyfg=;
        b=NcMgL1fI/W6UHod6hJJkyRTb5pbZ24URofllLCclllXe7jqHORqbqxW6iGd40O3Xg7
         famY83tWIAKrqDNcN8QXJj6wkJ7/a79K0Yq1+WnKVwGSysxot408y117Ox2aj5gD4Y0/
         RN9iUUOyDf010En5ysQC6HP1/j6tPdg/dv5xbWMFX58JHDO8CgB59Q8qcuF6YYnHljSq
         9NHifa8v3H8tHNP1OWXlEot0HZgc7UQYZsWk7Wv66CBoNf3wfC6oQUJ5cpONxR8v58ty
         Aj/AnDEIxc8tEWSxu6o015SNir+gQ57OrE/7hRXAW12Ti+vTd+PIY9E826aSP73/D4We
         /RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3HHUyAX1B91skwUMpCNzF5YH2X1NSjsOWajnMHTyfg=;
        b=Vu9Xod3+Kb2aQGGfPyDaTQ5R4lUy8Ere8PP6QLKc0nG9j5HwfODYjlNnXaojr0ecwJ
         na+qBGYK4MyMecrozuTBWrzq4yyEf98opCcaGkRLyjzwzDCMKd96zLwuQHJ+ei080K4+
         uhSSKkqLF7YgeQG0pIXukNyCDBs0gaCqTvEdv16XQByQO9ZGwAqGcoE6vAjgzA4dSTWu
         wn1M4H5uncd0TUi2eyeT7pYOjBToplcZ4qNa7PDG6flpLQOaztAzYHNPALLRG+YPgBNu
         lqUCsUm7FYa5sKSjn7uv9YZGvW5NG06yGRGctpFBXtSa3Wr85kB/ICN//V14legFdu7h
         VdCQ==
X-Gm-Message-State: ACrzQf1w1GZUZzt0xGU0j0nmGeEW9Md3oQjDAiS1orSGBFr5x+dJpJM0
        yF6QNOUuXbrPT6jzX392Lqo=
X-Google-Smtp-Source: AMsMyM6Wy7WYd6X5pGMIDcG/lk2nziAz1b/YfYrOGhcYSODfIStqVlvhLSZVA8L/8ohsY/V3iTDasg==
X-Received: by 2002:a05:6512:1196:b0:4a2:4ddb:8415 with SMTP id g22-20020a056512119600b004a24ddb8415mr1139044lfr.518.1665848521488;
        Sat, 15 Oct 2022 08:42:01 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.224.165])
        by smtp.gmail.com with ESMTPSA id du13-20020a056512298d00b0048b143c09c2sm761317lfb.259.2022.10.15.08.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 08:42:00 -0700 (PDT)
Message-ID: <7d72c804-265e-b515-78a7-976deaa06310@gmail.com>
Date:   Sat, 15 Oct 2022 18:42:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 03/10] staging: r8188eu: fix status updates in SwLedOff
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221015151115.232095-1-martin@kaiser.cx>
 <20221015151115.232095-4-martin@kaiser.cx>
Content-Language: en-US
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20221015151115.232095-4-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin Kaiser <martin@kaiser.cx> says:
> Update bLedOn only if we could update the REG_LEDCFG2 register.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/core/rtw_led.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
> index 4f1cad890cae..38433296d327 100644
> --- a/drivers/staging/r8188eu/core/rtw_led.c
> +++ b/drivers/staging/r8188eu/core/rtw_led.c
> @@ -43,10 +43,11 @@ static void SwLedOn(struct adapter *padapter, struct led_priv *pLed)
>   static void SwLedOff(struct adapter *padapter, struct led_priv *pLed)
>   {
>   	if (padapter->bDriverStopped)
> -		goto exit;
> +		return;
> +
> +	if (rtw_write8(padapter, REG_LEDCFG2, BIT(5) | BIT(3)) != _SUCCESS)
> +		return;
>   
> -	rtw_write8(padapter, REG_LEDCFG2, BIT(5) | BIT(3));
> -exit:
>   	pLed->bLedOn = false;
>   }
>  

If we don't always update the state then, I think, it's better to inform 
the callers about it

I guess, this won't happen often, but you are changing semantic of the 
function



With regards,
Pavel Skripkin
