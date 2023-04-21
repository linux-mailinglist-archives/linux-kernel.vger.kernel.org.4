Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9284B6EA393
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDUGOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDUGOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:14:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9461FCE;
        Thu, 20 Apr 2023 23:14:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ec81779f49so1295787e87.3;
        Thu, 20 Apr 2023 23:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682057652; x=1684649652;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHMa8b74FIpH3c6IGFWhRxM78q1kiY00I+AYK/n1nYs=;
        b=UD9pJMZW1cgb7Y7JSRGvJcXyZoI2yjBp3f3gJmRGSTD9rp4tGqJzOLiWWhJpx3cySi
         ENxFmz0P5f8d7Mvk9JG849iqJknw20hrWTmjORXoFmNUYfd7bpPUihFYt/S/HLXi3fIu
         d4vIZzDhTYZnZ29JvSCi6QqZOAksI3YuMXtB1BHYlm2ut81Z1teXA7zh5/6wRmXn1Ebr
         iM8MnLklZJoaSQZ1/CPFSowUOR/DVsy93cYJ1TD6Rd/YpqP/PyNMeo3JXLOZvR1JzJpF
         7/64e27MocwrZf2Ar6p1FviMN0UOh5so0998Pcz1f+FIuEotLUVHbOSURG5v5MfTtpFf
         /8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682057652; x=1684649652;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHMa8b74FIpH3c6IGFWhRxM78q1kiY00I+AYK/n1nYs=;
        b=H6SLctrY5m1WekCK7bfArSXzrxC8t0b9z0g0htZo7zpNyHXFkWh3L8qihK2GDxJoPX
         WfuDgCgmFw4h4v6Ioadjtl81hmIv4wQU9jNhONmUQXBqChsSDD9d6D43RtBWnEWf54L/
         Obcj99f3PJJgK+oL/zy60PPQ7MO97Dk9C6x0khNWNxvYWvgGbZs3M6aCxYn7qCNkj50J
         75qDmwekEGxUfQpiINjTlyJ/mFcFnzUiKtdAExEOweajlkhBpXWx1uEsH+/kDAhN6nwN
         fYzSFPEl5WD/v1/4Ts+Q/c6ply/bnkI58Bbg9N22VzY7qlqMqVfquxaW9WW0IJ1Ycogc
         87Fw==
X-Gm-Message-State: AAQBX9dCsaE2qjOAEtd23DkIlBpqFFcFpITk6mWks5YmVlVtMIS2qJdX
        0is8A9laNPaJVYM1qbhfIilpu0o0+Lc=
X-Google-Smtp-Source: AKy350aZFH/NjAEaI453LZpPKvCB8ysgv9Hmv1Nrc4TRAv9tD+HpMw/v7fVJn7nlPZe0LIJJ5LHodg==
X-Received: by 2002:ac2:5ecf:0:b0:4ec:a786:1f23 with SMTP id d15-20020ac25ecf000000b004eca7861f23mr1003294lfq.59.1682057651808;
        Thu, 20 Apr 2023 23:14:11 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id c15-20020ac244af000000b004d5a6dcb94fsm451453lfm.33.2023.04.20.23.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 23:14:11 -0700 (PDT)
Message-ID: <93b19237-3afd-461f-bdb3-f2cd09cadd9a@gmail.com>
Date:   Fri, 21 Apr 2023 09:14:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
 <2c5d71e37fc7e000091189b3c5d66ede1a6015d2.1682019544.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 4/5] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
In-Reply-To: <2c5d71e37fc7e000091189b3c5d66ede1a6015d2.1682019544.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

Thanks for the v2!

On 4/20/23 23:22, Mehdi Djait wrote:
> Since Kionix accelerometers use various numbers of bits to report data, a
> device-specific function is required.

I think this is the right approach. Thanks for adding this 
device-specific function.

> Move the driver's private data to the header file to support the new function.

Hmm. Why this move is necessary? I didn't immediately spot this struct 
being used outside this C-file. I'd rather saw the struct in C-file if 
possible.

> Make the allocation of the "buffer" array in the fifo_flush function dynamic
> and more generic.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
> v2:
> - separated this change from the chip_info introduction and made it a patch in v2

I am unsure if this separation was needed. I'd only separate the "naming 
changes" which bring no changes to code flow, and then patches which are 
fixes and need to be backported (to minimize backporting effort and 
impact to stable branches). Well, I am fine with this separation though, 
seems like I am just making a noise here :).

> - changed the function from generic implementation for to device-specific one
> - removed blank lines pointed out by checkpatch
> - changed the allocation of the "buffer" array in __kx022a_fifo_flush
> 
>   drivers/iio/accel/kionix-kx022a.c | 72 +++++++++++++------------------
>   drivers/iio/accel/kionix-kx022a.h | 37 ++++++++++++++++
>   2 files changed, 66 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 7f9a2c29790b..1c81ea1657b9 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -150,36 +150,6 @@ static const struct regmap_config kx022a_regmap_config = {
>   	.cache_type = REGCACHE_RBTREE,
>   };

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

