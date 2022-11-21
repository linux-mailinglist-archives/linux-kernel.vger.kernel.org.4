Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA0C6320CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiKULhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiKULgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:36:53 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EBDEE0E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:33:19 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id l8so14141634ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0tCXYHEHaJSwqdeaKtt1G46UU+pCmrfUsjdAfzfpehk=;
        b=mHMAAdV0C6ICvJwTMevtLqzSrKXNvNxOLKXlHq6pWKOtuw14FVQ5M27S1jQGK5BYXR
         DUryb7GdTzi2EPfRJCajOrcLG6OigQ9NYQw3QGMLC3qA4T21X+7UMDIILE3S0pvK67j4
         mt+YeGcuKe31M24k1bcKJQhB88iJoxBYce7rwpQDiximOTQOJ9qUBe00AXb1QmwBB+XN
         bPEKXZXFcjk/ALTta4BmJXWihcV3Kx+Ls8xICv7CVyenuPuNlFbMqYyyl1cMGImSUW8T
         M1kvUjBX+S50+rzeIVPyVSLIrJ+HG/1gDT4KXMrJcx3UrqHsGKIXFW8gLJpgkx8ySNj5
         3TpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tCXYHEHaJSwqdeaKtt1G46UU+pCmrfUsjdAfzfpehk=;
        b=XnwR8eyDGo/AIQKT0gVr11G2NkVeABzMuijf+YcS3SZJPN7YVEmlvdCdn7O4KYsYdE
         0ZKLnnawyTZC6bvJls+jupqsrPtYdpu7i4luuIr2sYWsoQLeP9zGIWeRZLfap5KZW/9C
         KBpV7uyfqt8I9LzygRgVwEFiSORAonGkepysrfAriNDZbsVUkJzajW30N1zuThzFxzSL
         E0tX7QrqhVQI94zCl7G5BV2en2yQjykTWVmqMkJ0xqQ037yBxQ8Jy68gQR+zbvHGJDAI
         PrQu/oDRfBCjYSHeiU+5CE+S4YHocBNTkiN0G5B+iaIR1v9nyH5cJHVLfeZPRfZR/DMU
         KXtg==
X-Gm-Message-State: ANoB5plPhqsesF13aFYfx8JDOI5XvIDQPdIbX26sevvRvLm0YU1JXjlu
        3aStanuuzMliOgZubCjd2rcmN7mVbfk=
X-Google-Smtp-Source: AA0mqf6qJnr5vGeDQym0HR4gXWaTTEo+q2wb17duO0bVRkQXKOw5aaKbwQa1qrHJmS2pbnNr9X32oQ==
X-Received: by 2002:a2e:9103:0:b0:278:fa62:bc90 with SMTP id m3-20020a2e9103000000b00278fa62bc90mr5927595ljg.360.1669030397770;
        Mon, 21 Nov 2022 03:33:17 -0800 (PST)
Received: from [172.16.196.95] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id j23-20020ac253b7000000b004a62ff61b3dsm1998685lfh.252.2022.11.21.03.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:33:17 -0800 (PST)
Message-ID: <e84f8d00-616e-14d7-5427-61065c88c015@gmail.com>
Date:   Mon, 21 Nov 2022 13:33:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] mfd: rohm-bd9576: convert to i2c's .probe_new()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20221121102454.15664-1-u.kleine-koenig@pengutronix.de>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221121102454.15664-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Uwe!

On 11/21/22 12:24, Uwe Kleine-König wrote:
> The probe function doesn't make use of the i2c_device_id * parameter so
> it can be trivially converted.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/mfd/rohm-bd9576.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/rohm-bd9576.c b/drivers/mfd/rohm-bd9576.c
> index f37cd4f27aeb..c854ab5bcd80 100644
> --- a/drivers/mfd/rohm-bd9576.c
> +++ b/drivers/mfd/rohm-bd9576.c
> @@ -88,8 +88,7 @@ static struct regmap_irq_chip bd9576_irq_chip = {
>   	.irq_reg_stride = 1,
>   };
>   
> -static int bd957x_i2c_probe(struct i2c_client *i2c,
> -			     const struct i2c_device_id *id)
> +static int bd957x_i2c_probe(struct i2c_client *i2c)
>   {
>   	int ret;
>   	struct regmap *regmap;
> @@ -180,7 +179,7 @@ static struct i2c_driver bd957x_drv = {
>   		.name = "rohm-bd957x",
>   		.of_match_table = bd957x_of_match,
>   	},
> -	.probe = &bd957x_i2c_probe,
> +	.probe_new = &bd957x_i2c_probe,
>   };
>   module_i2c_driver(bd957x_drv);
>   

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

