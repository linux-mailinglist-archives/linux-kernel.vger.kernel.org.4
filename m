Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7082F61E0E2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiKFIgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiKFIgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:36:11 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF12D2C4
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:36:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bj12so22935651ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 01:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+7CekdsHq3o9kP3EBlvL2Isxys3n4Y2CKKaBFtZHFmY=;
        b=jtSJGBK1bieEG6sijFoat41fEfFt2bMDnVRsldhV8stdSoZNPoLuWbh7z3CK4+Y7IR
         9wkdJ2DUxJfe2NykXYBrOltrog2pdZWKGrm9wZ4nxQ0BAKNWVfif/rUtM1vuauQTZgd8
         tlYcF8K0dfwxamnY24gFvN77nO9Lkr89r9YvId47XIVXItBWVFrA14Q076CeVsvP+tRM
         g+WJR2rWuf7cK5w1SXeAfwL/BCR0ge33A3S29nezEwHlyhSiShREGwgE0KvIfjXHN383
         slF34HDr++WiyETl3eATA76SdLZqszMbDPpzfTiP7SfKwQ9QFWHRXbH4ZUQLpt1StUcn
         7ZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7CekdsHq3o9kP3EBlvL2Isxys3n4Y2CKKaBFtZHFmY=;
        b=bb5a/dPWFdSNYWSMs3b3HtD+QJnJcRgwnHntf0WzZhWRffC6oIk2YODN4GIAEhwL9P
         TC7Po8ITph0/2dbfOWwT2l7R7m1URMF4cSewuj4pbD3HrEu06YyoK9wS0blrsYsyW0g0
         HqumCXbNVphHaPLUJlrgEtDLS/8CGQIR6NcEGJ4lP1k6L9CnOIcXROqSuEDbAtM+3bzm
         lA424qUDG1LFDEzQe8TbpKH5XpiLDxt/M+iYLdCh4quBaej686hn/fKAOfgY0vNcl6Pv
         wmA9KKtZ4f1PERpPf14GWoJAiuciUKQm+YPuXw904w6/+nDSG71G1UTuoLIjaV47Qrxc
         pU1A==
X-Gm-Message-State: ACrzQf3SYg4gjHAjm0z5kjmLOOHmwpJwESMl/rm366cJJPj1y++Vr4zD
        +bh+MCjYfFO4ktnw+o3nxHA=
X-Google-Smtp-Source: AMsMyM6O6gGj9j+axrISZpxtKlQI88MGa12/mobBrIOrm3TgGf5zFgJsDuMWH59fCp5ujW0QwWLbpA==
X-Received: by 2002:a17:907:1def:b0:7ad:9673:8668 with SMTP id og47-20020a1709071def00b007ad96738668mr41376461ejc.698.1667723769523;
        Sun, 06 Nov 2022 01:36:09 -0700 (PDT)
Received: from [192.168.1.100] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id g26-20020a056402321a00b00463bc1ddc76sm2314024eda.28.2022.11.06.01.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 01:36:09 -0700 (PDT)
Message-ID: <9d8ed71b-abee-bc3e-df66-fc9d8d498d1d@gmail.com>
Date:   Sun, 6 Nov 2022 09:36:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: convert three functions to bool
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221105093916.8255-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221105093916.8255-1-straube.linux@gmail.com>
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

On 11/5/22 10:39, Michael Straube wrote:
> The functions
> 
> is_client_associated_to_ap()
> is_client_associated_to_ibss()
> is_IBSS_empty()
> 
> return boolean values. Convert their return type to bool and replace
> _FAIL, which is defined as 0, with false. Another step to get rid of
> _SUCCESS / _FAIL.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_wlan_util.c   | 18 +++++++++---------
>   drivers/staging/r8188eu/include/rtw_mlme_ext.h |  6 +++---
>   2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> index e50631848cab..c95438a12b59 100644
> --- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
> +++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> @@ -331,35 +331,35 @@ u16 get_beacon_interval(struct wlan_bssid_ex *bss)
>   	return le16_to_cpu(val);
>   }
>   
> -int is_client_associated_to_ap(struct adapter *padapter)
> +bool is_client_associated_to_ap(struct adapter *padapter)
>   {
>   	struct mlme_ext_priv	*pmlmeext;
>   	struct mlme_ext_info	*pmlmeinfo;
>   
>   	if (!padapter)
> -		return _FAIL;
> +		return false;
>   
>   	pmlmeext = &padapter->mlmeextpriv;
>   	pmlmeinfo = &pmlmeext->mlmext_info;
>   
>   	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE))
>   		return true;
> -	else
> -		return _FAIL;
> +
> +	return false;
>   }
>   
> -int is_client_associated_to_ibss(struct adapter *padapter)
> +bool is_client_associated_to_ibss(struct adapter *padapter)
>   {
>   	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
>   	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
>   
>   	if ((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE))
>   		return true;
> -	else
> -		return _FAIL;
> +
> +	return false;
>   }
>   
> -int is_IBSS_empty(struct adapter *padapter)
> +bool is_IBSS_empty(struct adapter *padapter)
>   {
>   	unsigned int i;
>   	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
> @@ -367,7 +367,7 @@ int is_IBSS_empty(struct adapter *padapter)
>   
>   	for (i = IBSS_START_MAC_ID; i < NUM_STA; i++) {
>   		if (pmlmeinfo->FW_sta_info[i].status == 1)
> -			return _FAIL;
> +			return false;
>   	}
>   	return true;
>   }
> diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> index e234a3b9af6f..7652e72a03f4 100644
> --- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> +++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> @@ -432,9 +432,9 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
>   u8 *get_my_bssid(struct wlan_bssid_ex *pnetwork);
>   u16 get_beacon_interval(struct wlan_bssid_ex *bss);
>   
> -int is_client_associated_to_ap(struct adapter *padapter);
> -int is_client_associated_to_ibss(struct adapter *padapter);
> -int is_IBSS_empty(struct adapter *padapter);
> +bool is_client_associated_to_ap(struct adapter *padapter);
> +bool is_client_associated_to_ibss(struct adapter *padapter);
> +bool is_IBSS_empty(struct adapter *padapter);
>   
>   unsigned char check_assoc_AP(u8 *pframe, uint len);
>   
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
