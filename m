Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D3617027
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiKBWAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKBWAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:00:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5579FDC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 15:00:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z18so385659edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFa9ZhCMepZq24Vnn18j9j7JCVeUv8BABqc0vmgQSBA=;
        b=O567pRj2nj/frtcM+5YvZA8T0NCYHcrKp1+VVHNo7zrReLYbWbbK5nEbPZ8ffn/h9S
         yp2vVrBSNGkANUAzIU1cQlcSJA4kucix3t3nMPpmC0uQYE9WT0BlM0L2I1zEjWN4dDvE
         IWTcoJBMuwp4XbjzsXhdsIHitJC9KoNBa9V7j4M+Er2DsesgSAkl+CKca4cPtcSw+fNr
         SSaBHJXh3MDfmKq6+2VVS/B+jOGH0G2EsNpv27q4DxLTHX9Pp919rEIFjHdj7t9zkRH2
         Yb9+yTqHsCzLDJA67KC4Y0AhZHceGvfVkI7cHFezlpYYea8YkejH+Kny3mO1yXzVoG6m
         QPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFa9ZhCMepZq24Vnn18j9j7JCVeUv8BABqc0vmgQSBA=;
        b=l/ZTuqqnnTTlBj6SwUa4Pflv0tz4qNcYUN7r8lPxhs9SpPr/kDDVEK4aX0Bt6K8+2L
         FgbYNC/ReX18VuW90cg64HKHXRNOFclHQD9MssA+sNfXTR8dbDHbRRWewwScJLnA1jsG
         dQ/IvX5vWBuKDogb4hmY+Jj/nomxiTWRIJqAN1roMN/QO0fXrEAYmaeADW6MylhSAlWi
         Y76C1DfFbxhNMk0wGts8PzKHehilDCIDrIMlCNOQXzLWcXnVWdK0PKfikiYf0Ggd37oN
         8Mpn3pKxIrHJtgpnzd3rlMKgHjecIsHz/QItS9XLqieGUzlvX5oQ4Lbnr+4IJ4a1IA7f
         SPEA==
X-Gm-Message-State: ACrzQf16F/fUO5aqQoJHFZfJ52Vuo08888gxP/ujtl5IVMQUhmYnGDSc
        OSbhBH107NGYn86n4PgTN1Q=
X-Google-Smtp-Source: AMsMyM6+9FbULypkREv1lMx4Gsy5w2aJ7DhhKyi4VArUJlIvoL56XephMvx0Vp0E70gKWsieAIbO4w==
X-Received: by 2002:aa7:c78d:0:b0:454:fe1d:8eb1 with SMTP id n13-20020aa7c78d000000b00454fe1d8eb1mr26411467eds.59.1667426418859;
        Wed, 02 Nov 2022 15:00:18 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:b839:703d:34d9:ac18:ee1c? (p200300c78f2ab839703d34d9ac18ee1c.dip0.t-ipconnect.de. [2003:c7:8f2a:b839:703d:34d9:ac18:ee1c])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709063d3100b00782fbb7f5f7sm5896446ejf.113.2022.11.02.15.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 15:00:18 -0700 (PDT)
Message-ID: <2fea9cb6-04a0-c709-9263-a35badad4d20@gmail.com>
Date:   Wed, 2 Nov 2022 23:00:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] staging: rtl8192e: space formatting fixes in rtl_cam.c
Content-Language: en-US
To:     Jerom van der Sar <jerom.vandersar@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     error27@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <Y2IbI8ib5+k+bVRo@kroah.com>
 <20221102200057.397-1-jerom.vandersar@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221102200057.397-1-jerom.vandersar@gmail.com>
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

On 11/2/22 21:00, Jerom van der Sar wrote:
> Fixed a few coding style issues in rtl_cam.c: two times lack of
> spaces around binary operators. Some other warnings still remain.
> These issues were found by scripts/checkpatch.pl.
> 
> This patch helps clean up the rtl8192e driver in staging, making it
> easier to read and maintain.
> 
> Signed-off-by: Jerom van der Sar <jerom.vandersar@gmail.com>
> ---
> Changes in v4:
>   - Reverted more double blank line formatting fixes to make the patch
>     even smaller.
> 
> Changes in v3:
>    - Fixed faulty dot at the end of the patch sign-off.
> 
> Changes in v2:
>    - Reverted some formatting fixes to make the diff easier to review.
> 
>   drivers/staging/rtl8192e/rtl8192e/rtl_cam.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
> index 41faeb4b9b9b..41bff46d1b3a 100644
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
> @@ -107,7 +107,7 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
>   
>   	for (i = 0; i < CAM_CONTENT_COUNT; i++) {
>   		TargetCommand  = i + CAM_CONTENT_COUNT * EntryNo;
> -		TargetCommand |= BIT31|BIT16;
> +		TargetCommand |= BIT31 | BIT16;
>   
>   		if (i == 0) {
>   			TargetContent = (u32)(*(MacAddr+0)) << 16 |

Please rebase. I cannot apply your patch.

Bye Philipp
