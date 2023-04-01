Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D376C6D340F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 23:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjDAVUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 17:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjDAVUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 17:20:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EF283F3
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 14:20:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e18so25683009wra.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 14:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680384038; x=1682976038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ByAoZWXhCyKwFW+7RrBi6qp6VuxHVvsdrIcCs8B1g/A=;
        b=ltk51KbXub0mj3FrZK4k32vjHzuabJlksHq2z6CjgDmgJb/6/YpHqn4D8ZQhWrp8F0
         2O0FfoyZDmig+CK7zv0J4ECOK6ZXROEOiBB9z8sDh1sSSQTxtu1GKuo2FySrq6V/SLRK
         xSxO/PJ+BvSJGX2FrJF/xTEkE+FjyqLg3oMEh1i2oyCM4cgwapZuHt4+vj0SNAbRSGlh
         0EwyfUI+vSus84icjC5X6xDhdjF6c7ZSg+R7swiH2LtwzKIQA0aP7oWf8Gw2hg8LuagV
         id6p12HHenbiLUT2IJShoeSOCWNUDMhON3UTe7T2prs/USeBLV2aPX5PTqWEFcCN3qm5
         OPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680384038; x=1682976038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByAoZWXhCyKwFW+7RrBi6qp6VuxHVvsdrIcCs8B1g/A=;
        b=JfeNGLKaPVnxR8U+X3+pXcf0fDo0F5Kgq3XR9fhenZiRvQS7oAt2GcoP1Cf/hAYoD7
         CLuy6VOoACCENpplnxGi6tor02dZ8n1TuVHVO+2oWJI4D5hSd57XfzIMjtpJDEuZcaEN
         RLQUm0zLkE/6Ce4DqJ0mUvnwJSvEoWZUlqYd023zCRTJO+GM9hu1gNfQSAVaLbXC0t/g
         sk3wKePepiHoH1rvuhK2c82AEpzxJ/4NX3GWI4sE2XSx1LPzqGzb26jMvH+j7hqmZ43A
         Edf9MpPUcvMXYInu/+Kodrq9PFDf5Hbw7SN/fOoh/08r8ZAb8ZQpqQOFWTT9WvvzVN2T
         fggA==
X-Gm-Message-State: AAQBX9eZNVrjQl63JKthE0h00Vb9wieDEvD3tQc3GzKbSF/gS+9X0+C2
        oN7Y2aIFmezezftoUztFPtU=
X-Google-Smtp-Source: AKy350YgtkT4Bw1fq4SE5H3x2PpD2KACelr/oOt3B+d32gtlPCdYYDMtO0OFGAQbLGi3Sfk98sknCg==
X-Received: by 2002:adf:f78b:0:b0:2e4:aa42:7872 with SMTP id q11-20020adff78b000000b002e4aa427872mr5908805wrp.4.1680384038368;
        Sat, 01 Apr 2023 14:20:38 -0700 (PDT)
Received: from [192.168.0.103] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d474f000000b002d7a75a2c20sm5752639wrs.80.2023.04.01.14.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 14:20:37 -0700 (PDT)
Message-ID: <624a11a3-2461-6c8f-155d-e76e5e3e471e@gmail.com>
Date:   Sat, 1 Apr 2023 23:20:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/5] staging: rtl8192e: avoid camel-case
 <dot11RSNAStatsCCMPFormatErrors>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Deepak R Varma <drv@mailo.com>
References: <cover.1680375200.git.kamrankhadijadj@gmail.com>
 <7ed9ed4df19b1ab818fc4b3ec43083e1a051c38e.1680375200.git.kamrankhadijadj@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <7ed9ed4df19b1ab818fc4b3ec43083e1a051c38e.1680375200.git.kamrankhadijadj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/23 20:58, Khadija Kamran wrote:
> Linux kernel coding-style does not suggest mixed-case names. This issue
> is reported by checkpatch.
> 
> Fix variable name by changing it from camel-case to lower-case. In order
> to describe the variable name better, add a comment above it.
> 

I think you are changing from camel case to snake case.

> Suggested-by: Deepak R Varma <drv@mailo.com>
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> index 8d3067a6ccca..e8a3bc94efdc 100644
> --- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> +++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> @@ -34,7 +34,8 @@ struct rtllib_ccmp_data {
>   	u8 tx_pn[CCMP_PN_LEN];
>   	u8 rx_pn[CCMP_PN_LEN];
>   
> -	u32 dot11RSNAStatsCCMPFormatErrors;
> +	/* .11 RSNA stats for CCMP */
> +	u32 ccmp_format_errors;
>   	u32 dot11RSNAStatsCCMPReplays;
>   	u32 dot11RSNAStatsCCMPDecryptErrors;


Is it obvious that CCMPFormatErrors is a part of dot11RSNAStats? OK. You 
added a comment. Often for me the issue is that the comment is only 
valid to one line or to more?

I would prefer something like: dot11rsna_stats_ccmp_format_err
This is keeping the information the author gave variable and I would 
understand better and see it in every place.

>   
> @@ -226,7 +227,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
>   	u8 pn[6];
>   
>   	if (skb->len < hdr_len + CCMP_HDR_LEN + CCMP_MIC_LEN) {
> -		key->dot11RSNAStatsCCMPFormatErrors++;
> +		key->ccmp_format_errors++;
>   		return -1;
>   	}
>   
> @@ -238,7 +239,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
>   			pr_debug("CCMP: received packet without ExtIV flag from %pM\n",
>   				 hdr->addr2);
>   		}
> -		key->dot11RSNAStatsCCMPFormatErrors++;
> +		key->ccmp_format_errors++;
>   		return -2;
>   	}
>   	keyidx >>= 6;
> @@ -374,7 +375,7 @@ static void rtllib_ccmp_print_stats(struct seq_file *m, void *priv)
>   		   "key[%d] alg=CCMP key_set=%d tx_pn=%pM rx_pn=%pM format_errors=%d replays=%d decrypt_errors=%d\n",
>   		   ccmp->key_idx, ccmp->key_set,
>   		   ccmp->tx_pn, ccmp->rx_pn,
> -		   ccmp->dot11RSNAStatsCCMPFormatErrors,
> +		   ccmp->ccmp_format_errors,
>   		   ccmp->dot11RSNAStatsCCMPReplays,
>   		   ccmp->dot11RSNAStatsCCMPDecryptErrors);
>   }

