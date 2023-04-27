Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DB56F0C14
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244596AbjD0Smv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243639AbjD0Smr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:42:47 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85032103
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 11:42:45 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-32e74139877so2829955ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 11:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682620965; x=1685212965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJCwkrf5r8TPiK35wSY7bI8DqSRmPjjoER5hWO2H+6s=;
        b=DqgVR8IPVWj9lvO/p2TNEArUnq1yO5NFejZlOVdhX+ao0Hqy5ABUMByGvNVIlS22Qo
         osfHeZFyepnY9W3RHsCwySw+vxMjk1GEYx0zLFiwtyDQpDRGcWctechvNegEBmraH9Ck
         OzpYztJeWCEODpkBl5IW7N65u50mUlf4W3Z+rEHNiT20oU/5I1RONWZeY4S1/e7WKLne
         30vHvV5TdXcPgQCX43p+EgBQ338I8RgGr2QDlh6GbUcpRqaNNiwQNQZyJxu8xOjNhIdr
         8oxE5Cfg4cyBzVDJFvzyGtsSDUGXZCMWBQyRnmYu4nOJAuDHYnodDRnEQW55f06luc1a
         Tpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682620965; x=1685212965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJCwkrf5r8TPiK35wSY7bI8DqSRmPjjoER5hWO2H+6s=;
        b=B1hzSsw7UtcFm7JXPTSbkUvd0EBZ34cImNQ7blUi52tGQo09VEADgdPCb+LJ7YYkYO
         LcRj4ojh1fbFTh7ut7E1BCdEgQY/t+1Yt33qnn2pvqLpo5Hj+1JXm/MEQADK6HAjFi48
         4GOnZvguT4NiTrHiZxGeuAwKl9ffuRH6jLABjMLcOhoKhvYckdqRXSmZqDiSRvdtEAXc
         +Y8HCc8+IO3epjGzwEkZ6yTh3RwbmY5jUPyjEnpSsqpttKs8O+E/PHk9gaxkdb9kIBDw
         nO29y40GnCNVdxOLDQ7dCPy14Xyxcd4d7rI+8kekRXDWc3YzcVef784QX2iHMgx/dC9E
         H4KQ==
X-Gm-Message-State: AC+VfDybt8ITV5feXeANUH05nrxupORtkCG8fozbck2ZfrgAckbceCYm
        cqHW7+tGd46mwPze+3TPk2IGNsp/EHxTMsAbziA=
X-Google-Smtp-Source: ACHHUZ4zxeGfPnfv3QOVzrw6mbz3lM/UzfZPvCqhkbRxPCApcS6H+1aigffvASwmtKWo6oK/CxpXsw==
X-Received: by 2002:a05:6e02:972:b0:32a:eacb:c5d4 with SMTP id q18-20020a056e02097200b0032aeacbc5d4mr1256068ilt.0.1682620965246;
        Thu, 27 Apr 2023 11:42:45 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cl5-20020a0566383d0500b0040bb600eb81sm5766664jab.149.2023.04.27.11.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 11:42:44 -0700 (PDT)
Message-ID: <03b13c8f-0f4c-0692-b2f0-e90d7877e327@kernel.dk>
Date:   Thu, 27 Apr 2023 12:42:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] io_uring/kbuf: Fix size for shared buffer ring
Content-Language: en-US
To:     Tudor Cretu <tudor.cretu@arm.com>, io-uring@vger.kernel.org
Cc:     =axboe@kernel.dk, asml.silence@gmail.com, kevin.brodsky@arm.com,
        linux-kernel@vger.kernel.org
References: <20230427143142.3013020-1-tudor.cretu@arm.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230427143142.3013020-1-tudor.cretu@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 8:31 AM, Tudor Cretu wrote:
> The size of the ring is the product of ring_entries and the size of
> struct io_uring_buf. Using struct_size is equivalent to
>   (ring_entries + 1) * sizeof(struct io_uring_buf)
> and generates an off-by-one error. Fix it by using size_mul directly.
> 
> Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
> ---
>  io_uring/kbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> index 4a6401080c1f..9770757c89a0 100644
> --- a/io_uring/kbuf.c
> +++ b/io_uring/kbuf.c
> @@ -505,7 +505,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
>  	}
>  
>  	pages = io_pin_pages(reg.ring_addr,
> -			     struct_size(br, bufs, reg.ring_entries),
> +			     size_mul(sizeof(struct io_uring_buf), reg.ring_entries),
>  			     &nr_pages);
>  	if (IS_ERR(pages)) {
>  		kfree(free_bl);

Looking into this again, and some bells ringing in the back of my head,
we do have:

commit 48ba08374e779421ca34bd14b4834aae19fc3e6a
Author: Wojciech Lukowicz <wlukowicz01@gmail.com>
Date:   Sat Feb 18 18:41:41 2023 +0000

    io_uring: fix size calculation when registering buf ring

which should have fixed that issue. What kernel version are you looking at?

-- 
Jens Axboe


