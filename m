Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2B973D14D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjFYOIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjFYOIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:08:19 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED57E54
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:08:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51669dd574aso601750a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687702097; x=1690294097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qb5uaG1ukttpAvFf/VsYxgKDzrt6PGIJhyXlt0S+974=;
        b=oTFbyGblJZQYnCfEHksOhrJu+0t1MjoglVO2m22ZpEHcITylvHiAP0E9dThUfU9bTr
         odWWydWnBURTXM+uBDY1UsLzKheuhtd7QHZjYi8843+GKikSm26HvlrDXtZGgocdbh5I
         +VsyvtJmCRWfsvPMzQjzryvOkNm7utbtCA3NYbw1sb8IsRTzgrYSqSAceXgMTZIxWVSC
         lvxcRGUEzU3jF1djmhnNHkHDqsLReKrWtlSpTKdrjgETFncVjJF+RX8gVqBvIGsggYaE
         uTyq7i0XygbECR2ENoRw+xB+oJPjGQ33geneXrHdvosH8Mppn/0sbMPsiIpBs1CfTFrK
         +mgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687702097; x=1690294097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qb5uaG1ukttpAvFf/VsYxgKDzrt6PGIJhyXlt0S+974=;
        b=JFSgR3NQuPSeS1iJ0wLkvtb9nns0y+eQ+Jswpis0VcVMijpVGPjAA0Ii+lTweqBPVq
         bf2zPisObUy4Alq0QHBjf1u1cqVs1xWSic4aE6y7IIKIs79xP/DTc5gCNI1Pp0diThS/
         VWTGUJ3+MlUbFZbvUBDHj95+1dLS9kzaxqMjmIurA9ajzsZBV/45RNUQaiAxYZQXcgtz
         X9OnnO+yNGB36RZe09nfsO5r019XRZ3lLqTKr4p83PcdN4Md1A0GI1/Qld3KPzpyiXAZ
         yMhxAZxcg7WadSbqhJJfzBXBSNeBfTSYefMJeGbXKAg6Yiwr+4fO5vcW8PtnBU36xdXJ
         V1Fg==
X-Gm-Message-State: AC+VfDwiwglQGi1fYS/lAfD52bV1HYU53Eq6JGUJu1Ee7zR+USqbxjWb
        CtEZx9vzROeD+LkvCWv3YIM=
X-Google-Smtp-Source: ACHHUZ57Y/CLa/g0I4iVLHJPBt4Z7Yne+UFoeaNZya7MdsPH4IzdVE1XB9LzR6GCXRYxRWcjcr7/Ag==
X-Received: by 2002:a05:6402:1e8e:b0:50d:fd8e:e224 with SMTP id f14-20020a0564021e8e00b0050dfd8ee224mr19569949edf.1.1687702096644;
        Sun, 25 Jun 2023 07:08:16 -0700 (PDT)
Received: from [192.168.0.101] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id x2-20020aa7d6c2000000b0051a3f9770dasm1793222edr.8.2023.06.25.07.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 07:08:16 -0700 (PDT)
Message-ID: <b76b810e-7489-9f36-ae57-f6674a1b734f@gmail.com>
Date:   Sun, 25 Jun 2023 16:08:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] staging: rtl8192e: Rename function HTUpdateDefaultSetting
 to ht_update_default_setting
Content-Language: en-US
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        dan.carpenter@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <ZJdmp3PAOAIqC3Zo@tacos.darkphysics>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZJdmp3PAOAIqC3Zo@tacos.darkphysics>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/23 23:56, Tree Davies wrote:
> Rename HTUpdateDefaultSetting to ht_update_default_setting in order to
> Fix checkpatch warning: Avoid CamelCase
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
>   drivers/staging/rtl8192e/rtllib.h         | 2 +-
>   drivers/staging/rtl8192e/rtllib_module.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index f9fa3f2bb728..f526d04839bf 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -67,7 +67,7 @@ static u8 CISCO_BROADCOM[3] = {0x00, 0x17, 0x94};
>   
>   static u8 LINKSYS_MARVELL_4400N[3] = {0x00, 0x14, 0xa4};
>   
> -void HTUpdateDefaultSetting(struct rtllib_device *ieee)
> +void ht_update_default_setting(struct rtllib_device *ieee)
>   {
>   	struct rt_hi_throughput *ht_info = ieee->ht_info;
>   
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index e3ce4431d460..405033c7ed77 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -1982,7 +1982,7 @@ int rtllib_wx_get_rts(struct rtllib_device *ieee, struct iw_request_info *info,
>   void HTSetConnectBwMode(struct rtllib_device *ieee,
>   			enum ht_channel_width bandwidth,
>   			enum ht_extchnl_offset Offset);
> -void HTUpdateDefaultSetting(struct rtllib_device *ieee);
> +void ht_update_default_setting(struct rtllib_device *ieee);
>   void HTConstructCapabilityElement(struct rtllib_device *ieee,
>   				  u8 *posHTCap, u8 *len,
>   				  u8 isEncrypt, bool bAssoc);
> diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
> index d6a4d6b4ec57..841300e3a8bc 100644
> --- a/drivers/staging/rtl8192e/rtllib_module.c
> +++ b/drivers/staging/rtl8192e/rtllib_module.c
> @@ -129,7 +129,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>   	if (!ieee->ht_info)
>   		goto free_softmac;
>   
> -	HTUpdateDefaultSetting(ieee);
> +	ht_update_default_setting(ieee);
>   	HTInitializeHTInfo(ieee);
>   	TSInitialize(ieee);
>   	for (i = 0; i < IEEE_IBSS_MAC_HASH_SIZE; i++)


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
