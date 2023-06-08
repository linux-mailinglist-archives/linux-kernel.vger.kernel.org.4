Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A6A7279F7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjFHIak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbjFHIah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:30:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B35269E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:30:36 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f4db9987f8so435753e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 01:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686213034; x=1688805034;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XY47hELzwip0lIu4ibeSPP8B13egx66c2j6pExWBEA=;
        b=Cau52P98VQ2uueYSexxRDcaZORLJubNm6rSDoh+vDnNXM+uLh6tWYAUTZ7R8lTqZRk
         acEwVCISqxlIZNNz12Uy6sNGoZ0mkNiVMDYRdkb1q9pOE88DU1zKxitKNCtTJl9efiQg
         PlObBpFvIXmbfPkVjofKOI5sUcpRMAPXLEGEEuyRmJqma84lY/v0lRgMOXlPrQQOOGVP
         EJromc9xEeyfUFTNmknsM84/jeLF2owbR5FLSxNS/CJrg1BP3V0/tyRFHIrPgtpK7sWD
         dS0sM+ESqfARLc68omGcHN5XldsUQhFU/7/BYu1Ys6JxiOIdXpvGNh/9M4NxqNqOfJ+R
         gxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686213034; x=1688805034;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XY47hELzwip0lIu4ibeSPP8B13egx66c2j6pExWBEA=;
        b=N6VbdRlx4+dv7o5JeHx8avgOp49TMBKhx1taIxR2tRuJguGQrn8YKOTQWt6E3UB1+k
         Tw82rdtdTCTyxLGzpf2bVytwfYb4WG3izsOwDYIaj1zuQ3qwpEkMwcb7nlogjxqwpkna
         nXdRDirzZVU6POzKZyJywQEETCouLB8VE9O2WSvIff84SKCD1sPdM6hWvzwB+lzmzkGz
         WBLHloBko79WTX4DqYXwG6QxaKposUR0b0MfUCxp7QgmNsd/0I8XR507q3v49+Kmn///
         2FTSq6e+SnpInhgjpp0gzuug9EwaTNWwfESJ1/pLlzMvqOwpqRxfBECWixKCInRaRehm
         Qm3Q==
X-Gm-Message-State: AC+VfDyePEzzRGj+W42r9Bf3GFgrsQ6ivqmTsw0dxl41nsYxj/gPMrbz
        GaE/IYbs1tUeJrKC03epsJE=
X-Google-Smtp-Source: ACHHUZ7nNqvlGBT2n2ZGLpCjYm0ss1hx/qmwjv5eBkF1mTi9N2vny9l32a015Cbfpa7/IpZqYqFKUA==
X-Received: by 2002:a05:6512:2309:b0:4f6:4466:7ebb with SMTP id o9-20020a056512230900b004f644667ebbmr455326lfu.20.1686213034102;
        Thu, 08 Jun 2023 01:30:34 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id v26-20020a2e925a000000b002a7899eaf9csm147177ljg.63.2023.06.08.01.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 01:30:33 -0700 (PDT)
Message-ID: <775471c6-7a68-938d-3641-6eb2a0f055f2@gmail.com>
Date:   Thu, 8 Jun 2023 11:30:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Chen-Yu Tsai <wenst@chromium.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230608075651.3214540-1-wenst@chromium.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH] regulator: Use bitfield values for range selectors
In-Reply-To: <20230608075651.3214540-1-wenst@chromium.org>
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

On 6/8/23 10:56, Chen-Yu Tsai wrote:
> Right now the regulator helpers expect raw register values for the range
> selectors. This is different from the voltage selectors, which are
> normalized as bitfield values. This leads to a bit of confusion. Also,
> raw values are harder to copy from datasheets or match up with them,
> as datasheets will typically have bitfield values.
> 
> Make the helpers expect bitfield values, and convert existing users.
> Include bitops.h explicitly for ffs(), and reorder the header include
> statements. While at it, also replace module.h with export.h, since the
> only use is EXPORT_SYMBOL_GPL.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   drivers/regulator/atc260x-regulator.c  | 2 +-
>   drivers/regulator/bd718x7-regulator.c  | 8 ++++----
>   drivers/regulator/helpers.c            | 9 ++++++---
>   drivers/regulator/tps6287x-regulator.c | 2 +-
>   4 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/regulator/atc260x-regulator.c b/drivers/regulator/atc260x-regulator.c
> index 87e237d740bc..0bba33955a1a 100644
> --- a/drivers/regulator/atc260x-regulator.c
> +++ b/drivers/regulator/atc260x-regulator.c
> @@ -37,7 +37,7 @@ static const struct linear_range atc2609a_ldo_voltage_ranges1[] = {
>   };
>   
>   static const unsigned int atc260x_ldo_voltage_range_sel[] = {
> -	0x0, 0x20,
> +	0x0, 0x1,
>   };
>   
>   static int atc260x_dcdc_set_voltage_time_sel(struct regulator_dev *rdev,
> diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
> index b0b9938c20a1..da1eea1207e5 100644
> --- a/drivers/regulator/bd718x7-regulator.c
> +++ b/drivers/regulator/bd718x7-regulator.c
> @@ -289,7 +289,7 @@ static const struct linear_range bd71837_buck5_volts[] = {
>    * and 0x1 for last 3 ranges.
>    */
>   static const unsigned int bd71837_buck5_volt_range_sel[] = {
> -	0x0, 0x0, 0x0, 0x80, 0x80, 0x80
> +	0x0, 0x0, 0x0, 0x1, 0x1, 0x1
>   };
>   
>   /*
> @@ -309,7 +309,7 @@ static const struct linear_range bd71847_buck3_volts[] = {
>   };
>   
>   static const unsigned int bd71847_buck3_volt_range_sel[] = {
> -	0x0, 0x0, 0x0, 0x40, 0x80, 0x80, 0x80
> +	0x0, 0x0, 0x0, 0x1, 0x2, 0x2, 0x2
>   };
>   
>   static const struct linear_range bd71847_buck4_volts[] = {
> @@ -360,7 +360,7 @@ static const struct linear_range bd718xx_ldo1_volts[] = {
>   	REGULATOR_LINEAR_RANGE(1600000, 0x00, 0x03, 100000),
>   };

Shouldn't the
static const unsigned int bd71847_buck4_volt_range_sel[] = { 0x0, 0x40 };

be also converted to { 0x0, 0x1 }? The range mask seems to be:
#define BD71847_BUCK4_RANGE_MASK        0x40

Other than that - the helpers + bd718x7 look good to me.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

