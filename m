Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5599F6C0B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 08:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCTHSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 03:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCTHSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:18:00 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4951CBCA;
        Mon, 20 Mar 2023 00:17:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id br6so13633654lfb.11;
        Mon, 20 Mar 2023 00:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679296676;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grH+B5Ynip/N6HMgdMftDomSVtSoUINZLnejbztR3/A=;
        b=TNdyA4/QhYNVveIAkKBTbzZh70CJRzi3U/ptuO8NaVpWTNWEwKQCCHwPr0BDA1oIYd
         7KDSZtspeZMNVmcyGDhgPHnj+5LEhGeuaAn/sHvsxLl/dEfQOTqPJp6zeYs9EH2CPW9h
         YwuwQXko2y9LFk+DF/6frpkXqfvAlfEb4+FMAkK9HUvqxDTXVsuex9NERULgAlbZV2Xf
         8so2Nxq4LpTxWghQwFbKietClsJ2pmTlSLoWHot2VzSccjC6XCHYFzOpDFeRAQMJLIVT
         I2RtEsqKlj4vmQxhx7Tkn0cQU6lajv8PYJ9eNXFPe/w0WFvlDaDB3QtTcnAtSN3X03BG
         KUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679296676;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grH+B5Ynip/N6HMgdMftDomSVtSoUINZLnejbztR3/A=;
        b=fQaAcX8ZkgTOx8fmbwnaotnryGs6OHKU0F2/YNVy2/kh3cxsrs+u/lTHOrJ7CwBBVU
         jbX1qhLdO2Mz0P2wkgnjuxGkRxWrXFSGG38LWiKB5i5u8OoBGLvET7rcG0FP4MetgfNd
         VSqp5j42IrIqpX6Kb7pQJkAxykGmT+DDlHZiE+ujsZkkG6rECfQuZlwobkCKXS7J1Usl
         EcGlyw0U8My2hdf88kCrQ0k0CdnqkkNYP1fflmVv1H+XpfqezqfpGinn7a64Ynax9498
         RR6EYlaRZJLvGvUXcUQrUXDAcnk9GMbQid9FrgetUjf2Ip+uFZJ7gvqPUjwSos8IHJp1
         cqzw==
X-Gm-Message-State: AO0yUKUURlmuuquGWTjbIqACmrsrmoLnIMnz/2jqIGe06b4V4MHpnCyt
        8xwxTMYjSLghRu0qgkUIejE=
X-Google-Smtp-Source: AK7set9aR1BPm23hS0BMvmxSV/+wIFQhsDhj9erncp+2v87T0Q37lQKJd+hDFM5D6TQ0Awp0dQoEsQ==
X-Received: by 2002:ac2:4c16:0:b0:4e1:fa71:f187 with SMTP id t22-20020ac24c16000000b004e1fa71f187mr6372661lfq.3.1679296676065;
        Mon, 20 Mar 2023 00:17:56 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id q13-20020a2e84cd000000b002934a7c04efsm1610757ljh.98.2023.03.20.00.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 00:17:55 -0700 (PDT)
Message-ID: <3d4da08a-d3aa-91d7-0a9d-a6bc2ee87927@gmail.com>
Date:   Mon, 20 Mar 2023 09:17:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
 <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
 <20230319162030.318918b8@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
In-Reply-To: <20230319162030.318918b8@jic23-huawei>
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

Hi Mehdi and Jonathan,

Just my take on couple of comments from Jonathan :) I still have my own 
review to do though...

On 3/19/23 18:20, Jonathan Cameron wrote:
> On Fri, 17 Mar 2023 00:48:36 +0100
> Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> 
>> Refactor the kx022a driver implementation to make it more
>> generic and extensible.
>> Add the chip_info structure will to the driver's private
>> data to hold all the device specific infos.
>> Move the enum, struct and constants definitions to the header
>> file.
> 
> You also introduce an i2c_device_id table
> 
> Without that I think module autoloading will be broken anyway so that's
> definitely a good thing to add.

I am pretty sure the autoloading worked for OF-systems. But yes, adding 
the i2c_device_id is probably a good idea. Thanks.

> A few comments inline.  Mostly around reducing the name changes.
> Wild cards (or simply shorted 'generic' prefixes like KX_)
> almost always bite back in the long run.  Hence we generally just try
> to name things after the first device that they were relevant to.

I must say I disagree on this with you Jonathan. I know wildcards tend 
to get confusing - but I still like the idea of showing which of the 
definitions are IC specific and which ones are generic or at least used 
by more than one variant - especially as long as we only have two 
supported ICs. I definitely like the macro naming added by Mehdi. This 
approach has been very helpful for me for example in the BD718x7 
(BD71837/BD71847/BD71850) PMIC driver. My take on this is:

1) I like the generic KX_define.
2) I would not try adding wildcards like KX_X22 - to denote support for 
122 and 022 - while not supporting 132 - in my experience - that won't 
scale.
3) I definitely like the idea of using exact model number prefix for 
'stuff' which is intended to work only on one exact model.

Regarding the 3) - I am not so strict on how the register/mask defines 
are handled - I _like_ the 1) 2) 3) approach above - but mask/register 
defines tend to get set (correctly) once and not required to be looked 
up after this. But. When the 'stuff' is functions - this gets very 
useful as one is very often required to see which functions are executed 
on which IC variant. Same goes to structs.

So, if we manage to convince Jonathan about the naming, then I like what 
yoo had here! I would hovever do it in two steps. I would at first do 
renaming patch where the generic defines were renamed - without any 
functional changes - and only then add the kx132 stuff in a subsequent 
patch. That would simplify seeing which changes are just renaming and 
which are functional ones.

But here, I must go with the wind - if subsystem maintainer says the 
code should not have naming like this - then I have no say over it... :/

>>   
>> +static const struct i2c_device_id kx022a_i2c_id[] = {
>> +	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx_chip_info[KX022A] },
> If there are a small set and we aren't ever going to index the chip_info structure
> we might be better off not bothering with the enum and instead using a separate
> instance of the structure for each chip.
> 

I kind of like also the table added by Mehdi. I admit I was at first 
just thinking that we should have a pointer to the struct here without 
any tables - but... After I took a peek in the kionix-kx022a.c - I kind 
of liked the table and not exporting the struct names. So, I don't have 
a strong opinion on this.

I think it's worth noting that this driver could (maybe easily enough) 
be extended to support also a few other kionix accelerometers. Maybe, if 
we don't scare Mehdi away, we will see a few other variants supported as 
well ;)

>>   	data->regmap = regmap;
>>   	data->dev = dev;
>>   	data->irq = irq;
>> -	data->odr_ns = KX022A_DEFAULT_PERIOD_NS;
>> +	data->odr_ns = KX_DEFAULT_PERIOD_NS;
>>   	mutex_init(&data->mutex);
>>   
>> -	idev->channels = kx022a_channels;
>> -	idev->num_channels = ARRAY_SIZE(kx022a_channels);
>> -	idev->name = "kx022-accel";
> 
> Ah. Missed this naming in original driver review.  We only normally
> postfix with accel in devices that have multiple sensors with separate
> drivers. Don't think that is true of the kx022a.

Ouch. I am not 100% sure but may be you didn't miss it. It may be I just 
missed fixing this because your comment here sounds somewhat familiar to 
me! (Or then you commented on suffix in driver-name).

> It's ABI so we are stuck with it, but avoid repeating that issue
> for new devices. >

>>   
>> +enum kx022a_device_type {
>> +	KX022A,
>> +};
> 
> As below. I'd avoid using the enum unless needed.
> That can make sense where a driver supports lots of devices but I don't think
> it does here.

Well, I know it is usually not too clever to be prepared for the future 
stuff too well. But - I don't think the enum and table are adding much 
of complexity? I am saying this as I think this driver could be extended 
to support also kx022 (without the A), kx023, kx122. I've also seen some 
references to model kx022A-120B (but I have no idea what's the story 
there or if that IC is publicly available). Maybe Mehdi would like to 
extend this driver further after the KX132 is done ;)

>> -int kx022a_probe_internal(struct device *dev);
>> -extern const struct regmap_config kx022a_regmap;
>> +struct kx022a_chip_info {
>> +	const char *name;
>> +	enum kx022a_device_type type;
>> +	const struct regmap_config *regmap_config;
>> +	const struct iio_chan_spec *channels;
>> +	unsigned int num_channels;
>> +	unsigned int fifo_length;
>> +	u8 who;
> Some of these are no immediately obvious so either rename the
> field so it is more obvious what it is, or add comments.

I would vote for adding a comment :) I like the who. Both the band and 
this member here :) Data-sheet has register named as "who_am_i" - so I 
don't think this name is too obfuscating - and what matters to me - it 
is short yet meaningful.

>> +	u8 id;
>> +	u8 cntl;
>> +	u8 cntl2;
>> +	u8 odcntl;
>> +	u8 buf_cntl1;
>> +	u8 buf_cntl2;
>> +	u8 buf_clear;
>> +	u8 buf_status1;
>> +	u16 buf_smp_lvl_mask;
>> +	u8 buf_read;
>> +	u8 inc1;
>> +	u8 inc4;
>> +	u8 inc5;
>> +	u8 inc6;
>> +	u8 xout_l;
>> +};
>> +
>> +struct kx022a_data {
> 
> Why move this to the header?  Unless there is a strong reason
> I'd prefer this to stay down in the .c file.

So would I. It's definitely nice to be able to see the struct in the 
same file where the code referencing it is.


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

