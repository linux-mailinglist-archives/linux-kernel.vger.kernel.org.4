Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E98C619FB8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiKDSWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiKDSWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:22:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E25748D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:21:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id f5so15440358ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sFmEFntrpXTlbTEQ0DoAwZpXgc7ElcMBwCl9NY4ZlBo=;
        b=bZqHX9AUdPofmljUxapDDGVsLlE019jqlAWVFSqKWiATVMB/wAzNjLWtn+u7+qQeTB
         fMJEy7EmUWFVghynz7ljKWvllM8JCcSruuA3aavw4phRg7gJ47mqi5ndQ7ek0sQX3Mg0
         e+D/2/s/byTsDxoNASJa0+KfYCueXpBRnxiZFbstEnyigmnnwOjyec3XAGw89BNGSq7G
         2edSyWJ0Ni60cAaFGhRJJi/zissvY48sJsSDOE4qJh9IeCZE/8k7t75l7n9cmm8jVRsJ
         KJVLeGOXBxjp37CujI2sy5thOMCAtp4LACOr3IN9zSpXr/RX5vEFO0eQEUi8g5ctZ+qk
         rgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFmEFntrpXTlbTEQ0DoAwZpXgc7ElcMBwCl9NY4ZlBo=;
        b=0sHtfLorUVhvxpP9s4zN1lIPzMWNoBpCi6zP5rldm5SJuyAahRZvQdYLXQjNT50lI3
         HfjnUH5ka+DJLVSFhrIXK+U9CX5kUiIMjp0BGBNS6ekVns2yNix/JYSmSZdfq/Q9cNWM
         KAliAsQpEobs759K604v27otVTYuGI+y6j4QePwM2QubJEq2J3euZbvsIEy1QkNaDACE
         0wbSipBjw0fBiyIVHM5OMmdE6FTVwcvwkUHnKe+u/ZMD4ouhXSjtpFFI/6kXU4JCFUVb
         nLjgcdjfXtfTdbHsOW1jTc3TIjAO/qGUTWpZejqxs3106HEzwyWCeVzL6tihq/4heOJR
         FetQ==
X-Gm-Message-State: ACrzQf1QlTl7sJo2w5lv6D/523f/GbLdae3YJlDazkoS/SQYMkEo3Ljv
        5jgzbXVUrR276Xwri7cfM/M=
X-Google-Smtp-Source: AMsMyM6bj/b8Vp4cAfCg1no2f6ax4I0ptcgjquR9WxzfTsePaZ203iAarPy0okqqJPrX9vsOs1g39g==
X-Received: by 2002:a17:907:d22:b0:78e:2788:51ae with SMTP id gn34-20020a1709070d2200b0078e278851aemr34582590ejc.689.1667586114624;
        Fri, 04 Nov 2022 11:21:54 -0700 (PDT)
Received: from [192.168.1.100] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id k22-20020aa7c396000000b00461bd82581asm51030edq.84.2022.11.04.11.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 11:21:54 -0700 (PDT)
Message-ID: <754301ee-c430-60ff-1c87-ba96fd032550@gmail.com>
Date:   Fri, 4 Nov 2022 19:21:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] staging: r8188eu: change return type of
 rtw_set_802_11_disassociate to void
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, paskripkin@gmail.com,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221103230632.6946-1-phil@philpotter.co.uk>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221103230632.6946-1-phil@philpotter.co.uk>
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

On 11/4/22 00:06, Phillip Potter wrote:
> Change return type of rtw_set_802_11_disassociate to void. This function
> always returns 'true' no matter what, so there is no need to return a
> value, and no need to check for it in the two call sites within
> rtw_wx_set_mlme. Also, as we are no longer using ret in rtw_wx_set_mlme
> except as the return value, just remove it and return 0 directly.
> 
> Suggested-by: Michael Straube <straube.linux@gmail.com>
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
> 
> Changes from V1: Act on feedback from Michael Straube:
> * Remove ret variable from rtw_wx_set_mlme and return 0 directly in
>    success case.
> 
> ---
>   drivers/staging/r8188eu/core/rtw_ioctl_set.c    | 4 +---
>   drivers/staging/r8188eu/include/rtw_ioctl_set.h | 2 +-
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 9 +++------
>   3 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> index 786431826659..785c0dba508f 100644
> --- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> +++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> @@ -314,7 +314,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
>   	return true;
>   }
>   
> -u8 rtw_set_802_11_disassociate(struct adapter *padapter)
> +void rtw_set_802_11_disassociate(struct adapter *padapter)
>   {
>   	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>   
> @@ -328,8 +328,6 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
>   	}
>   
>   	spin_unlock_bh(&pmlmepriv->lock);
> -
> -	return true;
>   }
>   
>   u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_ssid *pssid, int ssid_max_num)
> diff --git a/drivers/staging/r8188eu/include/rtw_ioctl_set.h b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
> index abe460d6504d..c3eb2479f27b 100644
> --- a/drivers/staging/r8188eu/include/rtw_ioctl_set.h
> +++ b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
> @@ -12,7 +12,7 @@ u8 rtw_set_802_11_authentication_mode(struct adapter *adapt,
>   				      enum ndis_802_11_auth_mode authmode);
>   u8 rtw_set_802_11_bssid(struct adapter *adapter, u8 *bssid);
>   u8 rtw_set_802_11_add_wep(struct adapter *adapter, struct ndis_802_11_wep *wep);
> -u8 rtw_set_802_11_disassociate(struct adapter *adapter);
> +void rtw_set_802_11_disassociate(struct adapter *adapter);
>   u8 rtw_set_802_11_bssid_list_scan(struct adapter *adapter,
>   				  struct ndis_802_11_ssid *pssid,
>   				  int ssid_max_num);
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index dda48a2a6d0c..8e9b7b0664bc 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -1011,7 +1011,6 @@ static int rtw_wx_set_mlme(struct net_device *dev,
>   			     struct iw_request_info *info,
>   			     union iwreq_data *wrqu, char *extra)
>   {
> -	int ret = 0;
>   	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
>   	struct iw_mlme *mlme = (struct iw_mlme *)extra;
>   
> @@ -1020,17 +1019,15 @@ static int rtw_wx_set_mlme(struct net_device *dev,
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
>   	}
> -	return ret;
> +	return 0;
>   }
>   
>   static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
