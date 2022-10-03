Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDFA5F2CC7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiJCJFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiJCJEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:04:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4E35F50;
        Mon,  3 Oct 2022 01:58:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bu25so15604474lfb.3;
        Mon, 03 Oct 2022 01:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=XqQodRH6a0lQZyrQzj66WYhNicw1wjJoyMwDWMJ/yGw=;
        b=bl1ytC6xg/0TJjIaMmN+k7HXrHD8sja3rF4SvTIZx7wgGqYO/r+PfPOrhBeKihL4f0
         kaO6kuj2Yu6L7uImCcWZ5u9PmECHLQ264Vx031PAxwHI4Q3SUhtNKhCsZJciqhTKabCV
         pBKnGkX8lrftB2h0lPVg98YEw3Xt2g3gRRrmABN+ZWD2JtdA/sYGPy8vl1F9KHz1GmD+
         xCp7P35IhJYRDKtpWBTocD8ZOfapZHSrhC/ZPtoHtVv9CLC4cHahRYMjb/S8VoZlS+xb
         ZEixKtM/Dy2QNEVJYz1rRHw6OF9FjQGsytLKdYupw5tPH63XrFos3zFIwpPOzf3z3i2Y
         u06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XqQodRH6a0lQZyrQzj66WYhNicw1wjJoyMwDWMJ/yGw=;
        b=t/vpHkppB9PozLu1cBrZnENvQ3GARpnBZzbQrj3XOraRQrgES+t+4ngbhKYatesBr9
         STLpAUCCT779pTzXi3DnM60nP1B0XkU492WxzMKPZHRKomRAg/VECQTld7QFTouhyGsb
         MMWtbIQCzAjnkwBKnQF56++v3dOWsWufeHNjkVM2I5XS6Vbd5MRQqy4+QlhGpLcUlzql
         jQ90V8gsD1UbB8GOC9nrgnqPui6+mEiVctzLS8sazExodl9L9H4rpvQsMKz7UTx3/9ih
         dCq9S5KmEXAU6XQkQlrAUA1wu6MoFFnCpSIqSBy2WAmroaAQRl4AXxICC7G/w5L5exWD
         E45A==
X-Gm-Message-State: ACrzQf0et4vX6/Ex6UH3OVyArpIM6o2wwZY50VCtkQ+facMjLulY10/b
        EbP0zlFtNLHvMw6IUu2DBLTNUXWcQdk=
X-Google-Smtp-Source: AMsMyM5iOPWlnaPtqydnwwB96XQWlOM0ceWCm7e8fBeobmzF3gn2nYS9+MkZN4L3bjNU5DHtFJiI0g==
X-Received: by 2002:a05:6512:b21:b0:4a0:45a1:7bf1 with SMTP id w33-20020a0565120b2100b004a045a17bf1mr6618049lfu.461.1664787517419;
        Mon, 03 Oct 2022 01:58:37 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id o5-20020ac24e85000000b004886508ca5csm1051678lfr.68.2022.10.03.01.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 01:58:36 -0700 (PDT)
Message-ID: <b36ee317-abfe-9f55-70b5-bbf3138f50c0@gmail.com>
Date:   Mon, 3 Oct 2022 11:58:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Mihail Chindris <mihail.chindris@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev
References: <cover.1664782676.git.mazziesaccount@gmail.com>
 <63f54787a684eb1232f1c5d275a09c786987fe4a.1664782676.git.mazziesaccount@gmail.com>
 <YzqgqERDTLVkJH67@smile.fi.intel.com>
Content-Language: en-US
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFT PATCH v3 10/10] iio: Don't silently expect attribute types
In-Reply-To: <YzqgqERDTLVkJH67@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for taking the time to review :) Much appreciated.

On 10/3/22 11:43, Andy Shevchenko wrote:
> On Mon, Oct 03, 2022 at 11:13:53AM +0300, Matti Vaittinen wrote:
>> The iio_triggered_buffer_setup_ext() and the
>> devm_iio_kfifo_buffer_setup_ext() were changed by
>> commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
>> to silently expect that all attributes given in buffer_attrs array are
>> device-attributes. This expectation was not forced by the API - and some
>> drivers did register attributes created by IIO_CONST_ATTR().
>>
>> When using IIO_CONST_ATTRs the added attribute "wrapping" does not copy
>> the pointer to stored string constant and when the sysfs file is read the
>> kernel will access to invalid location.
>>
>> Change the function signatures to expect an array of iio_dev_attrs to
>> avoid similar errors in the future.
> 
> ...
> 
> 
> Wouldn't be better to split this on per driver basis or is it impossible?

We need to change the callers and function signatures in one patch so we 
don't break bisecting.

> 
>>   	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>>   	struct iio_dev_attr *p;
> 
>> +	const struct iio_dev_attr *id_attr;
> 
> I'm wondering if we may keep this upper, so "longer line goes first" rule would
> be satisfied.

Sure.

> 
>>   	struct attribute **attr;
>>   	int ret, i, attrn, scan_el_attrcount, buffer_attrcount;
>>   	const struct iio_chan_spec *channels;
> 
> ...
> 
>> +		for (i = 0, id_attr = buffer->attrs[i];
>> +		     (id_attr = buffer->attrs[i]); i++)
> 
> Not sure why we have additional parentheses...

Because gcc warns about the assignment and suggests adding parenthesis 
if we don't.

>> +			attr[ARRAY_SIZE(iio_buffer_attrs) + i] =
>> +				(struct attribute *)&id_attr->dev_attr.attr;
> 
> ...and explicit casting here. Isn't attr is already of a struct attribute?

I am glad you asked :)
This is one of the "things" I was not really happy about. Here we hide 
the fact that our array is full of pointers to _const_ data. If we don't 
cast the compiler points this out. Old code did the same thing but it 
did this by just doing a memcpy for the pointers - which I personally 
consider even worse as it gets really easy to miss this. The cast at 
least hints there is something slightly "fishy" going on.

My "gut feeling" about the correct fix is we should check if some 
attributes in the array (stored to the struct here) actually need to be 
modified later (which I doubt). If I was keen on betting I'd bet we 
could switch the struct definition to also contain pointers to const 
attributes. I am afraid this would mean quite a few more changes to the 
function signatures (changing struct attribute * to const struct 
attribute *) here and there - and possibly also require some changes to 
drivers. Thus I didn't even look at that option in the scope of this 
fix. It should probably be a separate refactoring series. But yes - this 
cast should catch attention as it did.

Yours,
	-- Matti Vaittinen

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

