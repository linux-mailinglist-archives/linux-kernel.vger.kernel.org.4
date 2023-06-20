Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86A7365A2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjFTIDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjFTIDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:03:23 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA20CE;
        Tue, 20 Jun 2023 01:03:20 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b46cad2fd9so37933551fa.1;
        Tue, 20 Jun 2023 01:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687248198; x=1689840198;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OLrQlH9MsDar1FT4tekGAwUtALcq34/akUziS4Ojsc=;
        b=IlH6m7gn39zFotP60aajztX4z0/AWMYGTEwYWdf4r7QCbFBCG++Z51oXguqbBQ2ghF
         cX/h5Mzt1LGMP+PxSgWkXvrzXaCFV8Nr2dZyj2dZTXk2fy5hN18l4WnPNCYoz2uzJAnR
         Mo8teqbxJ9Fjyv8NPP1dZkWu6L9NjP17qNjIL6jJgGyOaaQU/14X+L6DXfiM1FtIYGaP
         oXFWz3WrOv3juJujaNwbpAPiaXs9/86AgDoglsZAqxLmLn5DXejJ64kn+HsbgUq4dPd2
         8wqWOgVJvx9hDjm8kvAS6h5M+6ec8PQXI06rd5dfFXJbBA1yGgr5SF3M2ZRoxGKL8dv6
         bOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687248198; x=1689840198;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OLrQlH9MsDar1FT4tekGAwUtALcq34/akUziS4Ojsc=;
        b=RtmhyYBMeM3jeqSxAdWOWWsTL9KgaLDgi8jOBEvv6YwI26SzCDuOVPRtv/5YOSBYul
         8KaTrRrO6I7qDH37YZHTv939RG3NS4CAjyKtDYR1ouSfbC49Z9+HUfe/xIPfp6QJtv10
         xcw61Adqu05PYakHfKBcE/yY+/8jq6UG0Ys2uUleNuNRjpl0AYjdiZ9r+3cu6kTGLx7C
         BALiKDolzRV7flYpuV26/qH7aB79QC4gp1qWOQTAQ8cKB2sXb7tbt94aPeT/YLSgi46M
         kaJ7QdeooPHUkEcjld/37h6RbwCq3mIVgxnzrN6Ox7zuIVsTdTOU3wcf8WxJKvDd5229
         i50A==
X-Gm-Message-State: AC+VfDx3ZwgJzf7kjM9a0C2jhBtcU43wzRlFLwrj7aXuwyoBrkItmhEB
        IYvNnnkRB7f9g/h2sTtrLIQ=
X-Google-Smtp-Source: ACHHUZ54+v06cL6k4ixXiI7qwV6BSTIs1JdcOnHBwI5F4MMAL5JgdM39z/SSLQslq5ZM8i6Z6kJsaA==
X-Received: by 2002:a2e:b70d:0:b0:2b4:3faf:c3d3 with SMTP id j13-20020a2eb70d000000b002b43fafc3d3mr7429501ljo.31.1687248198141;
        Tue, 20 Jun 2023 01:03:18 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id h19-20020a2eb0f3000000b002b3318c8d6fsm288460ljl.28.2023.06.20.01.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 01:03:17 -0700 (PDT)
Message-ID: <4ce177c1-fe94-c523-6597-7ca7183a955a@gmail.com>
Date:   Tue, 20 Jun 2023 11:03:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1686650184.git.mazziesaccount@gmail.com>
 <e898bb74afdbc9aa030932e82c36b4ce6d13bab7.1686651445.git.mazziesaccount@gmail.com>
 <20230617204824.6f3d9b20@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/3] iio: light: bu27008: add chip info
In-Reply-To: <20230617204824.6f3d9b20@jic23-huawei>
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

Thanks for the reviews Jonathan!

I am a bit of overloaded right now so it may be reworking this series 
will be postponed. Let's see. I will in any case take your feedback with 
me and come back with the V2 of this series - later if not sooner :)

On 6/17/23 22:48, Jonathan Cameron wrote:
> On Tue, 13 Jun 2023 13:20:07 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BU27010 RGB + flickering sensor is in many regards similar to
>> the BU27008. Prepare for adding support for BU27010 by allowing
>> chip-specific properties to be brought from the of_device_id data.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> A few things inline - including some commented out code you missed
> when tidying up before sending.

Ouch. I must've done some of the tidying in latter patches. I'll do the 
necessary cleanups and re-spin.

> 
> Jonathan
> 
>> ---
>>   drivers/iio/light/rohm-bu27008.c | 185 +++++++++++++++++++++++--------
>>   1 file changed, 138 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27008.c
>> index b50bf8973d9a..8c7f6f20a523 100644
>> --- a/drivers/iio/light/rohm-bu27008.c
>> +++ b/drivers/iio/light/rohm-bu27008.c
>> @@ -211,7 +211,33 @@ static const struct iio_chan_spec bu27008_channels[] = {
>>   	IIO_CHAN_SOFT_TIMESTAMP(BU27008_NUM_CHANS),
>>   };
>>   
>> +struct bu27008_data;
>> +
>> +struct bu27_chip_data {
>> +	const char *name;
>> +	int (*chip_init)(struct bu27008_data *data);
>> +	int (*get_gain_sel)(struct bu27008_data *data, int *sel);
>> +	int (*write_gain_sel)(struct bu27008_data *data, int sel);
>> +	const struct regmap_config *regmap_cfg;
>> +	const struct iio_gain_sel_pair *gains;
>> +	const struct iio_gain_sel_pair *gains_ir;
>> +	int num_gains;
>> +	int num_gains_ir;
>> +	int scale1x;
>> +
>> +	int drdy_en_reg;
>> +	int drdy_en_mask;
>> +	int meas_en_reg;
>> +	int meas_en_mask;
>> +	int valid_reg;
>> +	int chan_sel_reg;
>> +	int chan_sel_mask;
>> +	int int_time_mask;
>> +	u8 part_id;
>> +};
>> +
>>   struct bu27008_data {
>> +	const struct bu27_chip_data *cd;
>>   	struct regmap *regmap;
>>   	struct iio_trigger *trig;
>>   	struct device *dev;
>> @@ -282,6 +308,32 @@ static const struct regmap_config bu27008_regmap = {
>>   	.disable_locking = true,
>>   };
>>   
>> +static int bu27008_chip_init(struct bu27008_data *data);
>> +static int bu27008_write_gain_sel(struct bu27008_data *data, int sel);
>> +static int bu27008_get_gain_sel(struct bu27008_data *data, int *sel);
>> +
>> +static const struct bu27_chip_data bu27008_chip = {
>> +	.name = "bu27008",
>> +	.chip_init = bu27008_chip_init,
>> +	.scale1x = BU27008_SCALE_1X,
> 
> I'd keep this in same order as the definition unless there is a
> strong reason for a different ordering (perhaps the structure
> is ordered for packing purposes or something like that 

I tried avoid adding much of padding. Didn't go through the embedded 
structs to see alignment though.

I don't think this is a strong reason though. I don't expect many copies 
of these structs being instantiated.

> and assigning
> can be done in an order that groups things better?)

Yes. I do like having some grouping there.

> Cost of out of order is that it's hard to check if everything is assigned.

I'll revise the order. Thanks for pointing this out.

>> +	.get_gain_sel = bu27008_get_gain_sel,
>> +	.write_gain_sel = bu27008_write_gain_sel,
>> +	.part_id = BU27008_ID,
>> +	.regmap_cfg = &bu27008_regmap,
>> +	.drdy_en_reg = BU27008_REG_MODE_CONTROL3,
>> +	.drdy_en_mask = BU27008_MASK_INT_EN,
>> +	.valid_reg = BU27008_REG_MODE_CONTROL3,
>> +	.meas_en_reg = BU27008_REG_MODE_CONTROL3,
>> +	.meas_en_mask = BU27008_MASK_MEAS_EN,
>> +	.chan_sel_reg = BU27008_REG_MODE_CONTROL3,
>> +	.chan_sel_mask = BU27008_MASK_CHAN_SEL,
>> +	.int_time_mask = BU27008_MASK_MEAS_MODE,
>> +	.gains = &bu27008_gains[0],
>> +	.num_gains = ARRAY_SIZE(bu27008_gains),
>> +	.gains_ir = &bu27008_gains_ir[0],
>> +	.num_gains_ir = ARRAY_SIZE(bu27008_gains_ir),
>> +};
> 
> Could you move this down to below all the callbacks so that no need for forward
> definitions of the functions?

Well, I will see how it works. I think there were some dependency - 
chip_info is probably embedded in struct bu27008_data - which is needed 
in these functions - but I'll check this.


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

