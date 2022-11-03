Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94F8617639
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKCFho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKCFhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:37:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87BD2DE3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 22:37:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id t25so2405012ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 22:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N6yuz4vaBpXGDDofkp9biEi/JZM9rALV78sm7Rm0mFs=;
        b=nIKDt+21vRMTOrnwSIevXDaFC6NEbImnogX/D4tvD0xfn1Pj7HmpQIpHuD8vZKnsjT
         tyU3gGqazU0vZWd6lemwHKRiic4xZqjRpEZYVZrDfUgzHGcky3HMFZcanNgKOuff3IcN
         Pzd+Zc0mS7047vA2ELUq+6AYPoE0NqyVpI/MWOrPMH6GOsxzYhUH8cxbFq4Us3RT2IYb
         zTJtJC0438wwYAVzf0fTckqgGlq3dT/+0U/bjLnuHWGshgUlOTNTc0Z/8Iit/UTNJaJB
         JyuD/uf2g0y5O8lWfrl5wgnZio2iHAWX6nXuJz1xV8gxqSYH8T8QuwK/cincf0Mk2XAW
         gHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6yuz4vaBpXGDDofkp9biEi/JZM9rALV78sm7Rm0mFs=;
        b=Dx50F5E8MqHPNQNmbU8CEJTJvkNdWrt9KJdLtk7XOA7ZUNxD0/ghRyk9+caEtIDfV9
         31yXKlIVJfcaMdTfNB058wYBz7j6v4bbmm52AXZp5fZop4CC3RxukGmYdSKkHHiuIMc/
         RmRP0AY8k2YEOU1mNjPoL1KW2qon/JPSh7cYKVSFWlCLpwdZQewP67ql1J8u2wAbpYo7
         jAHeD9XSNUodN6+yDjfIf1g0mPamzxuKVCdbYMTpGob1nBtQHWHdOCU/HDSmpVTPg13V
         PjEcuqchP9FMYa9KakqySJzQQ5rTNASGRike/lGACe+vl+m8U6RbabplzwoRqckkoNh2
         A6kQ==
X-Gm-Message-State: ACrzQf1eQ79qAfrRb6y620prSJN0HcssFSxWCWwzguE6C0/3ZwrTYwL3
        YNGwvJ+fq1p6Ig9525bUAY6vEblsGBo=
X-Google-Smtp-Source: AMsMyM40GLHvYKeS3BzkTPHm0n5pKPvj/IL9FROYw3v0be2+HGt7yHQWxBCrrmwFgnOOpHxbdPo1/A==
X-Received: by 2002:a17:907:3f95:b0:7a2:36c7:31bd with SMTP id hr21-20020a1709073f9500b007a236c731bdmr27738226ejc.353.1667453859321;
        Wed, 02 Nov 2022 22:37:39 -0700 (PDT)
Received: from [192.168.0.101] (ip5f5abb6c.dynamic.kabel-deutschland.de. [95.90.187.108])
        by smtp.gmail.com with ESMTPSA id lb18-20020a170907785200b00741a0c3f4cdsm11090ejc.189.2022.11.02.22.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 22:37:38 -0700 (PDT)
Message-ID: <2e065cba-8094-3900-67e6-3a647bec3a7c@gmail.com>
Date:   Thu, 3 Nov 2022 06:37:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] staging: r8188eu: change return type of
 rtw_set_802_11_disassociate to void
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, paskripkin@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221102233637.6648-1-phil@philpotter.co.uk>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20221102233637.6648-1-phil@philpotter.co.uk>
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

Hi Phillip,

On 11/3/22 00:36, Phillip Potter wrote:
> Change return type of rtw_set_802_11_disassociate to void. This function
> always returns 'true' no matter what, so there is no need to return a
> value, and no need to check for it in the two call sites within
> rtw_wx_set_mlme.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>   drivers/staging/r8188eu/core/rtw_ioctl_set.c    | 4 +---
>   drivers/staging/r8188eu/include/rtw_ioctl_set.h | 2 +-
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 6 ++----
>   3 files changed, 4 insertions(+), 8 deletions(-)
> 

<snip>

> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -1020,12 +1020,10 @@ static int rtw_wx_set_mlme(struct net_device *dev,
>   
>   	switch (mlme->cmd) {
>   	case IW_MLME_DEAUTH:
> -		if (!rtw_set_802_11_disassociate(padapter))
> -			ret = -1;
> +		rtw_set_802_11_disassociate(padapter);
>   		break;
>   	case IW_MLME_DISASSOC:
> -		if (!rtw_set_802_11_disassociate(padapter))
> -			ret = -1;
> +		rtw_set_802_11_disassociate(padapter);
>   		break;
>   	default:
>   		return -EOPNOTSUPP;

You could also remove the ret variable and return 0 directly, since ret
is not changed anymore in the function.

regards,
Michael
