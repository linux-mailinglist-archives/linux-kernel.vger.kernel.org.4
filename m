Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2F56EA30D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 07:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjDUFTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 01:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjDUFTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 01:19:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1F53A90
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 22:19:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-506bcf9aa50so406959a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 22:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682054387; x=1684646387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jztjxvTx1Nd++gm+Nl8nvs6/BoVGQCjSa4YLbCS/iU=;
        b=CIY5AfUxax/7lRHV9DD2QQDT3fYJQ85qqpt+ukT59YfzWsQMfXVdRjMu0Y5vOuTS8Q
         9oNJdrlThg9nxiONZCnqHt8qI7ESvPvIL7+krHMezSDxJy4E4VQFBK2tgxIMqXAiREKw
         2JCQb5WaNpU5xupy9oj73B5tpEd9eEusED8BSt/XDHa91sGFG4pYFMYTB/Dy5PvDQ9H8
         9lqbJdsLBiz1LlXNtWDKlNSOK0HdnwQaLEfIKaVmQO26ggAfimeTlS5nrqI2Q2hItW3N
         M7LDwGlQsroN+TgWM+Y0ypCMFxqy9KuaNjeZzvm8P2Sp0+hE7XqeCzDgPTHQv6h4isp1
         LZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682054387; x=1684646387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jztjxvTx1Nd++gm+Nl8nvs6/BoVGQCjSa4YLbCS/iU=;
        b=ML4zXRp0PuI4ehC4pJSvNGcA3SxxZWluWOWDxbBhoqx81rAo5CxejJuo56IyK1Xm64
         RAA2Vepx3J1FmbPxApVRCbreMxJZMUPsDUTaKfEI2IF+B+m83G5wwL1C9OwsubIDivFz
         +aSkVaieN2/lJ0Pe/+slN0Z8IO8IoYkcjp4EKTtkoKuzE0WPB7UvvBEj14HLOANuA3Cu
         L1R5L006KqGNn8k7lk1ZSCbxcoPlRvd7ad4n92s42tZKMhCf8pMFF6G31BTqRreU/RRA
         UCQEvaj0Wogaddl2vftF/cm0hOpmCyuWRZ+9ZTrtazUbZCPZlyD0JPnxXuDucj2JkQHf
         mF0w==
X-Gm-Message-State: AAQBX9cIESYzqYY9Nr6b5/irwjgNVCwBHL948kWcHw2ARYkx+2tV1JOA
        etUjUA5JTs9G8lvVgylX34m2Ft1H9E0=
X-Google-Smtp-Source: AKy350b+lT274nfvY5/Go1LqODkZ2O2wa5me4diBj1+Ep8OdDKGWoybWiZ+AeUI46H2HAP38N8jBkg==
X-Received: by 2002:a05:6402:5202:b0:504:b68e:9676 with SMTP id s2-20020a056402520200b00504b68e9676mr3763948edd.2.1682054386589;
        Thu, 20 Apr 2023 22:19:46 -0700 (PDT)
Received: from [192.168.0.102] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id f7-20020a05640214c700b004fa380a14e7sm1478416edx.77.2023.04.20.22.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 22:19:45 -0700 (PDT)
Message-ID: <89c16e6f-4120-c358-3961-8ec1bbdae3f2@gmail.com>
Date:   Fri, 21 Apr 2023 07:19:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] staging: rtl8192e: add missing braces {}
Content-Language: en-US
To:     Stephan Snyman <rooiratel@tinyglitch.net>,
        gregkh@linuxfoundation.org
Cc:     kamrankhadijadj@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230420133209.4661-1-rooiratel@tinyglitch.net>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230420133209.4661-1-rooiratel@tinyglitch.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/23 15:32, Stephan Snyman wrote:
> Add missing braces to if/else statements to adhere to the
> Linux kernel coding-style guidelines.
> These issues were reported by checkpatch.pl
> 
> "CHECK: braces {} should be used on all arms of this statement"
> 
> Signed-off-by: Stephan Snyman <rooiratel@tinyglitch.net>
> ---
>   drivers/staging/rtl8192e/rtllib_rx.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
> index b649d02dc5c8..d44bf261de54 100644
> --- a/drivers/staging/rtl8192e/rtllib_rx.c
> +++ b/drivers/staging/rtl8192e/rtllib_rx.c
> @@ -264,8 +264,9 @@ static int rtllib_is_eapol_frame(struct rtllib_device *ieee,
>   		   RTLLIB_FCTL_FROMDS &&
>   		   memcmp(hdr->addr1, dev->dev_addr, ETH_ALEN) == 0) {
>   		/* FromDS frame with own addr as DA */
> -	} else
> +	} else {
>   		return 0;
> +	}
>   
>   	if (skb->len < 24 + 8)
>   		return 0;
> @@ -433,8 +434,9 @@ static int is_duplicate_packet(struct rtllib_device *ieee,
>   		if (*last_frag + 1 != frag)
>   			/* out-of-order fragment */
>   			goto drop;
> -	} else
> +	} else {
>   		*last_seq = seq;
> +	}
>   
>   	*last_frag = frag;
>   	*last_time = jiffies;
> @@ -2314,8 +2316,9 @@ static inline int rtllib_network_init(
>   	if (stats->freq == RTLLIB_52GHZ_BAND) {
>   		/* for A band (No DS info) */
>   		network->channel = stats->received_channel;
> -	} else
> +	} else {
>   		network->flags |= NETWORK_HAS_CCK;
> +	}
>   
>   	network->wpa_ie_len = 0;
>   	network->rsn_ie_len = 0;
> @@ -2329,9 +2332,10 @@ static inline int rtllib_network_init(
>   		return 1;
>   
>   	network->mode = 0;
> -	if (stats->freq == RTLLIB_52GHZ_BAND)
> +
> +	if (stats->freq == RTLLIB_52GHZ_BAND) {
>   		network->mode = IEEE_A;
> -	else {
> +	} else {
>   		if (network->flags & NETWORK_HAS_OFDM)
>   			network->mode |= IEEE_G;
>   		if (network->flags & NETWORK_HAS_CCK)

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

