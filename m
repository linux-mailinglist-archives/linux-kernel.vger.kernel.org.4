Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D784F61EAE1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiKGGXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiKGGXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:23:00 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B52410564
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:22:59 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id y14so27333918ejd.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 22:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SG+WLFgRHzlm3QlcyB7thQ6tK8u5/bVePL0R10tV/m8=;
        b=pNqk/WsdFKJ1bR5HrycbB5fMIZhGYW951DKCUbVlo6SrW992rZPik76jdMDEjlS1Jl
         r6yiCcXZHcPUE8ShNJBDCF9ZUsFaYOar2/IV75iekVjiAjf32se9jSFwk+h+Ylj3+xxC
         N7/p3mssjFSo+RTJKf+WQ1oWnP/lWNpNfDIAVUKstOcciY+zgoMoYRf2c8n06prWxduG
         Wlmxkwz5m+lK/ZV6nEPATqgJwBMSfYnmXPeffklJZBRYmYIa3Og241NBjdbzY8jhFwgP
         CLO41S/KDIKHdqd1DgszHwK44Iv5a9flvXTUgttcQHbmolf53AzThRM0h1p0tupoN1Ef
         24iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SG+WLFgRHzlm3QlcyB7thQ6tK8u5/bVePL0R10tV/m8=;
        b=3ACjwr6tzzZvmLTNFYGLb5AbMZMlyEPwROAvgAgYdt3DmMHUhA0WNUUGJLBdADQLeU
         TlFjcrlXZfhdSo3nz/4Er1zvsIdAm5b9egE5FGLS0XUr98WKyvsGG1YzSQg6ZsEMhm9k
         JrRYZBOphUDEJ5kwrOTpsXNMeVua8+si5S7UZpWniiqdD2wEEMyOfwdURCoBdAr4UBiO
         Hkq+bPtnthyfY3o7uXfZgYPlFKeHlrzvhRfn1mwvoFltO7aw6vH+X7tH3kQaj0SL9rRP
         pyRSI05LVvp41LCsvmZ7tIjYIXrG1sfPEjlnaHsz7a+chF0Axh2iR/ON4r6n9B01Nohl
         HjnQ==
X-Gm-Message-State: ACrzQf1lZshmzdHl5jx52J5TRw48qIDyrPG2nKtk+1f/hGWrK/zyiL25
        if0HlQ4LPS1DUOtuB0uOuSE=
X-Google-Smtp-Source: AMsMyM7y1M9TTJXq1cck+LlnUpWS7wa06FMkbDEJsVuzBWJxGFBhEsAFcF8HU7RVgVvukgDpnZKWBA==
X-Received: by 2002:a17:907:3e02:b0:782:1267:f2c8 with SMTP id hp2-20020a1709073e0200b007821267f2c8mr45581825ejc.585.1667802178093;
        Sun, 06 Nov 2022 22:22:58 -0800 (PST)
Received: from [192.168.1.100] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id x6-20020a05640225c600b00463a83ce063sm3595500edb.96.2022.11.06.22.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 22:22:57 -0800 (PST)
Message-ID: <18bb5b61-5dda-c00c-b025-b73e887259bc@gmail.com>
Date:   Mon, 7 Nov 2022 07:22:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: clean up error handling in
 rtw_start_drv_threads()
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221106133443.8872-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221106133443.8872-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/22 14:34, Michael Straube wrote:
> Convert the error handling in the function rtw_start_drv_threads() to
> the common logic used in the kernel. Another step to get rid of _FAIL
> and _SUCCESS which uses inverted logic.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/include/osdep_intf.h |  2 +-
>   drivers/staging/r8188eu/os_dep/os_intfs.c    | 17 +++++++----------
>   2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/osdep_intf.h b/drivers/staging/r8188eu/include/osdep_intf.h
> index 0f7d74a3ff6d..6d66cb57225e 100644
> --- a/drivers/staging/r8188eu/include/osdep_intf.h
> +++ b/drivers/staging/r8188eu/include/osdep_intf.h
> @@ -46,7 +46,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter);
>   void rtw_free_drv_sw(struct adapter *padapter);
>   void rtw_reset_drv_sw(struct adapter *padapter);
>   
> -u32 rtw_start_drv_threads(struct adapter *padapter);
> +int rtw_start_drv_threads(struct adapter *padapter);
>   void rtw_stop_drv_threads (struct adapter *padapter);
>   void rtw_cancel_all_timer(struct adapter *padapter);
>   
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index 970f380bac96..66556e07ed93 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -363,18 +363,16 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
>   	return pnetdev;
>   }
>   
> -u32 rtw_start_drv_threads(struct adapter *padapter)
> +int rtw_start_drv_threads(struct adapter *padapter)
>   {
> -	u32 _status = _SUCCESS;
> -
>   	padapter->cmdThread = kthread_run(rtw_cmd_thread, padapter, "RTW_CMD_THREAD");
>   	if (IS_ERR(padapter->cmdThread))
> -		_status = _FAIL;
> -	else
> -		/* wait for rtw_cmd_thread() to start running */
> -		wait_for_completion(&padapter->cmdpriv.start_cmd_thread);
> +		return PTR_ERR(padapter->cmdThread);
>   
> -	return _status;
> +	/* wait for rtw_cmd_thread() to start running */
> +	wait_for_completion(&padapter->cmdpriv.start_cmd_thread);
> +
> +	return 0;
>   }
>   
>   void rtw_stop_drv_threads(struct adapter *padapter)
> @@ -627,8 +625,7 @@ static int _netdev_open(struct net_device *pnetdev)
>   
>   		netdev_dbg(pnetdev, "MAC Address = %pM\n", pnetdev->dev_addr);
>   
> -		status = rtw_start_drv_threads(padapter);
> -		if (status == _FAIL) {
> +		if (rtw_start_drv_threads(padapter)) {
>   			pr_info("Initialize driver software resource Failed!\n");
>   			goto netdev_open_error;
>   		}
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
