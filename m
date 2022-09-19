Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57B05BC28C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 07:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiISFgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 01:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiISFgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 01:36:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3395E00B
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 22:36:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lh5so20158866ejb.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 22:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yg99Um8d4jt64FWgHGDUMNsUzte0vMXpvNDgCLw++4A=;
        b=hFJqUgf2XKWeSq36EsXW9QHsjKLUgSVuxKV/NF6MVOHMD1+PdwVQ3iC6n50Q2IDfNO
         5BXO9qATcm7dOcWNYpktwz1WMNtSdUd0pdrtU6Nx0xgc/EyVKCynx4cuHNbzxFG7a28u
         LXHtRRWkNcxiJTVdvfkK3yyPTnu9YhJy++qPIoNNtCoSX6/h3sd/A7AsfCAVMrzm2med
         VsdluvF/lkVC7z90c1GIP6kYIPczbokJDIGJ89ptoM/gB5bQ8EHN2mi0joapuwY8cNYP
         ru+kKe3Tf8JuGffGy1ZXafQXldHkkif4uNWjuDfNCPbcPL6Ez/da8LvydviTFz8k4enj
         uwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yg99Um8d4jt64FWgHGDUMNsUzte0vMXpvNDgCLw++4A=;
        b=AChKF2UWWF7wumDXFj72mNg/p1gWFEIBJMKeUPlQ6vL8FOTWsr0YRD6wMgS5Hpdl0i
         PJ2PaFfjxyOSsR6a88nDmMDT30ZWgxR/Deg14BCEfLaOMWzq3IMWOgjf/D3zc4om6+Oa
         NbiLa1sVd0L+JjD1mT/daaXNsKYm9yeC88yzvCaWYxCkPtM6hCkC7VFE5SCu769s1JXU
         nDVoyBwr14CUawC/yXfX2S8skaJFSweN1xSzGt5+tLUWeYzEe1dKdk1S+fE9gX+JaaiG
         XGWcECv8TYYoIXfo48lvORAmBrcMed3HRPIbwn4+Bofg87NxsOamASPzB4Ws4oFZZsEP
         3N3g==
X-Gm-Message-State: ACrzQf0JeBBzjuoMvLrPShJav7Q+iEbFMC588dgLXRuWYBxXBmfwYiQB
        Zvc85UmqG8QsnM+9yntj+xtSMn6AwXE=
X-Google-Smtp-Source: AMsMyM4XF8gtvbv4+z2G0MzqTKOsCMRQ/B6fKxehQZaawAsX8vvHIyO+2b6TzdoxC544j8HCDPXrlA==
X-Received: by 2002:a17:906:eecb:b0:73c:5bcb:8eb3 with SMTP id wu11-20020a170906eecb00b0073c5bcb8eb3mr11704435ejb.284.1663565773503;
        Sun, 18 Sep 2022 22:36:13 -0700 (PDT)
Received: from [192.168.0.100] (ip5f5abb62.dynamic.kabel-deutschland.de. [95.90.187.98])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b0078027e6e92csm8544982eja.84.2022.09.18.22.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 22:36:12 -0700 (PDT)
Message-ID: <8b17ac60-b2ec-26eb-d82c-9770e9733cdf@gmail.com>
Date:   Mon, 19 Sep 2022 07:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/6] staging: r8188eu: remove duplicate bSurpriseRemoved
 check
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220918175700.215170-1-martin@kaiser.cx>
 <20220918175700.215170-6-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20220918175700.215170-6-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/22 19:56, Martin Kaiser wrote:
> We don't have to check bSurpriseRemoved in the SwLedOn function.
> 
> SwLedOn calls rtw_read8 which in turn calls usb_read. This function checks
> bSurpriseRemoved for us.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/core/rtw_led.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
> index 744247af5956..989808a2b171 100644
> --- a/drivers/staging/r8188eu/core/rtw_led.c
> +++ b/drivers/staging/r8188eu/core/rtw_led.c
> @@ -35,7 +35,7 @@ static void SwLedOn(struct adapter *padapter, struct led_priv *pLed)
>   	u8	LedCfg;
>   	int res;
>   
> -	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
> +	if (padapter->bDriverStopped)
>   		return;
>   
>   	res = rtw_read8(padapter, REG_LEDCFG2, &LedCfg);

Hi Martin,

same could be done in SwLedOff.

regards,
Michael
