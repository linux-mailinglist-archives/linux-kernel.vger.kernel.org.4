Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B54169DA8C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjBUGHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjBUGHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:07:46 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA392413B;
        Mon, 20 Feb 2023 22:07:45 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id cy6so7230322edb.5;
        Mon, 20 Feb 2023 22:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D52R7ImG/ydLJ1hHNjQzaLZf43fKu/hNGWGcInUKUOg=;
        b=K2IOqTSV3euW6G+c9O6avjLoVf5SZflY3aUQ57Vqf4uxrIXrhopm4WGMjY1Rxd5ya8
         D3S9KDpG0pco3eYfqWx7xrBvhFnZZQY1brxzjU0bn+RKR/Rsvje04G1JSUGT2t7sXOT7
         wsEfZGkpM/FnkH/8UXLM0i2LuqG42VwAZ8IhGqnOfAt4lnBrLWCazUIcrnSYbXsml1bL
         KpusMLtPeEZwp//TImmHKqYt0xwuQau0uFNeOdm6r2pWwMP+7rzNHCpvWNon2yGURbd4
         FlMd4cY511tfsd6wObqFor+OwR+lVOouD5SZVQ68ZOwo6+BajK/Kver8hiXlaoXI5U+w
         yCIw==
X-Gm-Message-State: AO0yUKXI9grZk1uAVXobEcfuihnybQwB01WweLjgra/H3Gt6EuAtP0A/
        S+vlo+6V7ZqioGJAPANMRBL1MC+6mfI=
X-Google-Smtp-Source: AK7set/Dn8kkE3OsY4Rc2DDsqyEeLxWKnAHwBv5mvarc6JpJzqFX62zhYTcM9wpcCD0K4movgUzzbw==
X-Received: by 2002:a17:907:6297:b0:887:aac3:9340 with SMTP id nd23-20020a170907629700b00887aac39340mr19553607ejc.29.1676959664261;
        Mon, 20 Feb 2023 22:07:44 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id fx11-20020a170906b74b00b008bc8ad41646sm4234348ejb.157.2023.02.20.22.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 22:07:43 -0800 (PST)
Message-ID: <89e50f2f-8881-097d-bb47-7d44cafb2e2e@kernel.org>
Date:   Tue, 21 Feb 2023 07:07:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] serial: jsm: Change n to unsigned int
Content-Language: en-US
To:     Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>
Cc:     alexander.vorwerk@stud.uni-goettingen.de,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <70ea8ee5-3f92-fe1c-c59d-74040bd1e610@kernel.org>
 <20230221010339.3032-1-mohammadmahfoozpersonal@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230221010339.3032-1-mohammadmahfoozpersonal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 02. 23, 2:03, Mohammad Mahfooz wrote:
> Change n to an unsigned int and remove casts from min()s.
> 
> Signed-off-by: Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>
> ---
>   drivers/tty/serial/jsm/jsm_neo.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
> index 4cce1e423b06..394121870436 100644
> --- a/drivers/tty/serial/jsm/jsm_neo.c
> +++ b/drivers/tty/serial/jsm/jsm_neo.c
> @@ -277,7 +277,7 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
>   	int qleft = 0;
>   	u8 linestatus = 0;
>   	u8 error_mask = 0;
> -	int n = 0;
> +	u32 n = 0;
>   	int total = 0;
>   	u16 head;
>   	u16 tail;
> @@ -342,15 +342,15 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
>   			break;
>   
>   		/* Make sure we don't go over the end of our queue */
> -		n = min(((u32) total), (RQUEUESIZE - (u32) head));
> +		n = min(total, RQUEUESIZE - head);

This should warn now, right as total is signed too, right? And qleft. 
All should likely be unsigned. And the computation of qleft would need 
to be changed.

It's not as easy as this.

>   
>   		/*
>   		 * Cut down n even further if needed, this is to fix
>   		 * a problem with memcpy_fromio() with the Neo on the
>   		 * IBM pSeries platform.
> -		 * 15 bytes max appears to be the magic number.
> +		 * 12 bytes max appears to be the magic number.
>   		 */
> -		n = min_t(u32, n, 12);
> +		n = min(n, 12U);
>   
>   		/*
>   		 * Since we are grabbing the linestatus register, which

-- 
js
suse labs

