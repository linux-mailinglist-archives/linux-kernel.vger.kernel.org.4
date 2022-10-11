Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699D65FBB78
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJKTop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJKTok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:44:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7218BE09
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:44:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s30so21671537eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHcyhXBS8LO+1pTGUBy6875y1oBGWuaCiIaP8C/oCic=;
        b=LaTXMmM76cYuz6MbiBv81nh/oLam6SjjvVL0PCGEwxnNOACwAsqvz7AAospOvs2t3e
         6kcMT3jOcY1KeSdYSMhkssSjkgv/Das6SAxpA9BU6aVpl1Ys14xxqw5EZs7I5J4IWkUg
         pEp7TwOJBtoJpaFXOR4yG4UWKIiHQSoTzS3dRFxYVjOr5+kq2ZTlmzzmpWF6sOlpbpyy
         K18DDWq1OIH9+PRQFud0sg1FKK+nwStGtVUPSf/Ia8Oqslv9HtuHU3+7kgVNlDfkhCXe
         /8XfAx6Sl4DZ1V+v5YhXRGQP2tfacXM91tdqY6xFYLy5MkYwRAc1HsIGHMjvnhShDw1L
         oG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHcyhXBS8LO+1pTGUBy6875y1oBGWuaCiIaP8C/oCic=;
        b=3miPRfdi7ltwYaAsSNceOu6M/unNyAjkT/4zCUVLT4VskxCIwjqjEf5ZNky5mtM9pz
         Bk0QBQjliU5iwYULR3YP9DDiiY9ShMs5A2ksz+VWTw1Sm/AjyR/pdGgmGpPnU92M79oe
         7+SJSUGggz0Ei0Ldj2+lrioyTwBJAaJWEDa96KH9Ul7QS7u6f6VQqB+R3nPnMX8r1XXY
         NVJL4FyVWuu6aDR0UXJukK2RiHZPEk84HedAj8ie9r35M2Q5HeuXwmWeU3RdlUDDzMb/
         iDM/2Gnpnyas3oU6YyZf9PX6aXmpaFKX4vn9BUBKxqsdDSypu1sJTEBR+JFioY0TIRjM
         f++A==
X-Gm-Message-State: ACrzQf1AGegpTthJUR6vS430edCbdCJeAgVDNFIdnUsxFbPgT6Dlx1J5
        NOffm4Hx9YM05FW84f71gW0=
X-Google-Smtp-Source: AMsMyM7J/Datky3CcDpyErFNVWXXewoU1ysci2hdUpQTsxkNV1fXPV+wNo3d7NidfpcugfFX1nz6OA==
X-Received: by 2002:a05:6402:358e:b0:45c:aa8b:f7e9 with SMTP id y14-20020a056402358e00b0045caa8bf7e9mr6767edc.33.1665517475883;
        Tue, 11 Oct 2022 12:44:35 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f3e:6a25:da79:77b5:fd5d:5e3f? (p200300c78f3e6a25da7977b5fd5d5e3f.dip0.t-ipconnect.de. [2003:c7:8f3e:6a25:da79:77b5:fd5d:5e3f])
        by smtp.gmail.com with ESMTPSA id e15-20020a50fb8f000000b00459f4974128sm9808966edq.50.2022.10.11.12.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 12:44:35 -0700 (PDT)
Message-ID: <633927a0-c763-ae41-e023-1e797d95f1d9@gmail.com>
Date:   Tue, 11 Oct 2022 21:44:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: rtl8192e: Remove single statement braces
Content-Language: en-US
To:     Dragan Cvetic <dragan.m.cvetic@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221010190252.12402-1-dragan.m.cvetic@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221010190252.12402-1-dragan.m.cvetic@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 21:02, Dragan Cvetic wrote:
> Remove braces around single line statement, to resolve checkpatch.pl
> warnings "braces {} are not necessary for single statement blocks"
> 
> Signed-off-by: Dragan Cvetic <dragan.m.cvetic@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> index 702551056227..d7bfaf68291c 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> @@ -267,10 +267,8 @@ static void _rtl92e_dm_check_ac_dc_power(struct net_device *dev)
>   			"PATH=/usr/bin:/bin",
>   			 NULL};
>   
> -	if (priv->ResetProgress == RESET_TYPE_SILENT) {
> +	if (priv->ResetProgress == RESET_TYPE_SILENT)
>   		return;
> -	}
> -
>   	if (priv->rtllib->state != RTLLIB_LINKED)
>   		return;
>   	call_usermodehelper(ac_dc_script, argv, envp, UMH_WAIT_PROC);
> @@ -330,9 +328,8 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
>   	bool bshort_gi_enabled = false;
>   	static u8 ping_rssi_state;
>   
> -	if (!priv->up) {
> +	if (!priv->up)
>   		return;
> -	}
>   
>   	if (pra->rate_adaptive_disabled)
>   		return;
> @@ -777,9 +774,8 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
>   		tmpRegA = rtl92e_get_bb_reg(dev, rOFDM0_XATxIQImbalance,
>   					    bMaskDWord);
>   		for (i = 0; i < OFDM_Table_Length; i++) {
> -			if (tmpRegA == OFDMSwingTable[i]) {
> +			if (tmpRegA == OFDMSwingTable[i])
>   				priv->OFDM_index[0] = i;
> -			}
>   		}
>   
>   		TempCCk = rtl92e_get_bb_reg(dev, rCCK0_TxFilter1, bMaskByte2);
> @@ -1066,9 +1062,8 @@ void rtl92e_dm_restore_state(struct net_device *dev)
>   	u32	reg_ratr = priv->rate_adaptive.last_ratr;
>   	u32 ratr_value;
>   
> -	if (!priv->up) {
> +	if (!priv->up)
>   		return;
> -	}
>   
>   	if (priv->rate_adaptive.rate_adaptive_disabled)
>   		return;

This patch interferes with:
[PATCH v3] staging: rtl8192e: remove unnecessary braces for single 
statement blocks
from: me@lirui.org

Bye Philipp

