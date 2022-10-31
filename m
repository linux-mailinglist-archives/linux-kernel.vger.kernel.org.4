Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35510614152
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJaXHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJaXHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:07:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3789213D36
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 16:07:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y14so33140038ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 16:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=crqpdQRHJAhU4m6hcKdDdoM9iJymyutBOvZ9iFIvWRQ=;
        b=AUylrcOlCbw61Iv/JtAH9AbsUMy3fHGxP/gh6xrkoV2lA5JF5s2CBHTFvDx+KhjqOd
         DgRQMBOkVCv17TyLNuuymfrzjsEENiS2dBPyel7Q/gn90hDV8xadBEM8aoM1mddV18Gf
         C0JR4M1YniPuGr4K42IPcEUwSZfy95p+KjTkp0+OhM1FY/F03qUYwCwWSbpUoEYWGabD
         Sb+A47sq3Ty+ayGignw7eBXVlG65pj8yHqyB2eQ29J7b6w1GLkWIwiFM+YvYS1OSOB1M
         wNyB5XYB1gjJzhuDq76z/SkRhCzqbDVCho1pExGOYcrFyIndc3VI+scT8/Ya9nAUQc/O
         7k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crqpdQRHJAhU4m6hcKdDdoM9iJymyutBOvZ9iFIvWRQ=;
        b=G1/pnIGXT7wVJPtddSsFQcMAB3xwU0fM4QYj18mm4thmOdh/K3uQZnTYyfylvp4vES
         4gsvN0vHwjCjsgQzArQczvogLNaMxdXWhbFIRoaAL/9PuG9FhXNAJGN2igajT1smCBvu
         gJTJXVtQGQluwEoIwAKec6jb9hRSIpUJAf5cmbuolJhExXaXOU/zD7Uu84SWMVLgTBk3
         ByA8YvqEKx+WALSUipc0Sg/Z3uV6wi8ycVIv0x5S/jW5gTuhsGH+el4KJT11VJwbRJpV
         LjgAxpuYpctmXSoBJ4HiXMJn+PGsakI7bscgMzK0gNGNrB+B1g5MuyGDOKY3qTByEk3d
         Aiyw==
X-Gm-Message-State: ACrzQf19Eib8lvTbYsUC7KtzwgYwWqAVeHFLjaJKRP3059yJVaHYhcts
        ghSgQL2UjFfntzXoF9eI/5w=
X-Google-Smtp-Source: AMsMyM4QV2b/X1MgVrBsWGbS/vKIcrLvlqkiV8bzeV4NF9cmQ8CrtGCHagbjBszZKMX3fabSQZ5oRA==
X-Received: by 2002:a17:906:2699:b0:781:a473:9791 with SMTP id t25-20020a170906269900b00781a4739791mr15183392ejc.644.1667257660597;
        Mon, 31 Oct 2022 16:07:40 -0700 (PDT)
Received: from [192.168.1.102] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id i12-20020a170906698c00b007389c5a45f0sm3536197ejr.148.2022.10.31.16.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 16:07:40 -0700 (PDT)
Message-ID: <7d001a49-4e45-fda2-15fe-b05f2c340eaa@gmail.com>
Date:   Tue, 1 Nov 2022 00:07:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: rtl8192e: cleanup coding style issues with
 spacing
Content-Language: en-US
To:     Jerom van der Sar <jerom.vandersar@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     philip.g.hortmann@gmail.com, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221031225155.15678-1-jerom.vandersar@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221031225155.15678-1-jerom.vandersar@gmail.com>
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

On 10/31/22 23:51, Jerom van der Sar wrote:
> Fixed several coding style issues in rtl_cam.c such as double blank lines
> and lack of spaces around binary operators. It passes without trivial
> warnings about spaces. Some other warnings still remain.
> 
> Signed-off-by: Jerom van der Sar <jerom.vandersar@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_cam.c | 25 +++++++++------------
>   1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
> index 41faeb4b9b9b..aeef735679db 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
> @@ -17,7 +17,7 @@ void rtl92e_cam_reset(struct net_device *dev)
>   {
>   	u32 ulcommand = 0;
>   
> -	ulcommand |= BIT31|BIT30;
> +	ulcommand |= BIT31 | BIT30;
>   	rtl92e_writel(dev, RWCAM, ulcommand);
>   }
>   
> @@ -40,7 +40,6 @@ void rtl92e_enable_hw_security_config(struct net_device *dev)
>   		SECR_value |= SCR_TxUseDK;
>   	}
>   
> -
>   	ieee->hwsec_active = 1;
>   	if ((ieee->pHTInfo->iot_action & HT_IOT_ACT_PURE_N_MODE) || !hwwep) {
>   		ieee->hwsec_active = 0;
> @@ -100,33 +99,32 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
>   	}
>   
>   	if (DefaultKey)
> -		usConfig |= BIT15 | (KeyType<<2);
> +		usConfig |= BIT15 | (KeyType << 2);
>   	else
> -		usConfig |= BIT15 | (KeyType<<2) | KeyIndex;
> -
> +		usConfig |= BIT15 | (KeyType << 2) | KeyIndex;
>   
>   	for (i = 0; i < CAM_CONTENT_COUNT; i++) {
>   		TargetCommand  = i + CAM_CONTENT_COUNT * EntryNo;
> -		TargetCommand |= BIT31|BIT16;
> +		TargetCommand |= BIT31 | BIT16;
>   
>   		if (i == 0) {
> -			TargetContent = (u32)(*(MacAddr+0)) << 16 |
> -				(u32)(*(MacAddr+1)) << 24 |
> +			TargetContent = (u32)(*(MacAddr + 0)) << 16 |
> +				(u32)(*(MacAddr + 1)) << 24 |
>   				(u32)usConfig;
>   
>   			rtl92e_writel(dev, WCAMI, TargetContent);
>   			rtl92e_writel(dev, RWCAM, TargetCommand);
>   		} else if (i == 1) {
> -			TargetContent = (u32)(*(MacAddr+2)) |
> -				(u32)(*(MacAddr+3)) <<  8 |
> -				(u32)(*(MacAddr+4)) << 16 |
> -				(u32)(*(MacAddr+5)) << 24;
> +			TargetContent = (u32)(*(MacAddr + 2)) |
> +				(u32)(*(MacAddr + 3)) <<  8 |
> +				(u32)(*(MacAddr + 4)) << 16 |
> +				(u32)(*(MacAddr + 5)) << 24;
>   			rtl92e_writel(dev, WCAMI, TargetContent);
>   			rtl92e_writel(dev, RWCAM, TargetCommand);
>   		} else {
>   			if (KeyContent != NULL) {
>   				rtl92e_writel(dev, WCAMI,
> -					      (u32)(*(KeyContent+i-2)));
> +					      (u32)(*(KeyContent + i - 2)));
>   				rtl92e_writel(dev, RWCAM, TargetCommand);
>   				udelay(100);
>   			}
> @@ -152,7 +150,6 @@ void rtl92e_cam_restore(struct net_device *dev)
>   
>   	if ((priv->rtllib->pairwise_key_type == KEY_TYPE_WEP40) ||
>   	    (priv->rtllib->pairwise_key_type == KEY_TYPE_WEP104)) {
> -
>   		for (EntryId = 0; EntryId < 4; EntryId++) {
>   			MacAddr = CAM_CONST_ADDR[EntryId];
>   			if (priv->rtllib->swcamtable[EntryId].bused) {

Text from greg k-h's patch email bot:

- Your patch did many different things all at once, making it difficult
   to review.  All Linux kernel patches need to only do one thing at a
   time.  If you need to do multiple things (such as clean up all coding
   style issues in a file/driver), do it in a sequence of patches, each
   one doing only one thing.  This will make it easier to review the
   patches to ensure that they are correct, and to help alleviate any
   merge issues that larger patches can cause.

Comment PH: Try one simple patch first and then increase. Do not start 
with a series if you do not have any experience.

- You did not specify a description of why the patch is needed, or
   possibly, any description at all, in the email body.  Please read the
   section entitled "The canonical patch format" in the kernel file,
   Documentation/SubmittingPatches for what is needed in order to
   properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
   and everyone else, to know what this patch is all about.  Please read
   the section entitled "The canonical patch format" in the kernel file,
   Documentation/SubmittingPatches for what a proper Subject: line should
   look like.

Bye Philipp
