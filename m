Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2198E5EDB86
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiI1LPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiI1LOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:14:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6ECBFC;
        Wed, 28 Sep 2022 04:14:18 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q17so13921302lji.11;
        Wed, 28 Sep 2022 04:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kR69BSzio1qamLoUKXzM4Bcn/BThmX63zcSQpIPqEh4=;
        b=PNf94hK7WRDdYlqI/ip8YREC9vm7KcEwWiOOyXlcK9upuqHOjvcw3nlrtNDPFx3mbH
         y06Mu84drzmKVn2at9rJGmAdOnV4mB5BmkBgM08VNDFMGcmL1XelVCbeKtHb3TOiqXqF
         3MkwmrwN/FhM3FNFqJXqy68oaAXNuDKwPyUTgEmI6Cyv/9+EZW4LCDwdoD63Gvxk78qb
         3mdho4yyUjwtF93z+peCvOsN6G9DZKuUojoVDsptXW0604LrT8KFh493w2SBWTw0sjB0
         0o+uvjYqJNmSgyhLq3JkSIkuDykCty2Q9mCenVLlC9i4MrO3PJJzkx3dliQMf5mrDfNp
         V1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kR69BSzio1qamLoUKXzM4Bcn/BThmX63zcSQpIPqEh4=;
        b=MXkOZkl7dqOVPt0dgN6cNt4pNHiVn+qIkyLnPjJ8CUKw8XnudEer+hBezBGYMl3+gH
         e7F6hCYHJSrpCBKKB/feXHXfSsEBwY1Yzy9f9VqN5IIoJEf3d/TgdblAU2+A/8+PgrYf
         OxE0Cdp0waINJF9I03M6B1Xu3v28CItVOXbU7MKTK3N2oxpWR7X/AXCctuzQxBXHOkCI
         ejcR0XI5nYNZMMM7r5ptEp69tnfg+7adAVTojiXabIs7Po5rE5URbjtr3m6GeWeWsz6R
         ly4v7inJG7Jfq3wf5CncqLh0sQJDRkdo1Mc6F21DRPB3r64uGYGOxC6XF6oorJ/+fHXz
         N6Sw==
X-Gm-Message-State: ACrzQf1Z3bGaapI9iwBMHVLW2swjrs0jnNE3ug4Ovmt2YkLp8Es2r00r
        V93HlMo3rF5qH7T6v/2rK6E=
X-Google-Smtp-Source: AMsMyM6p/kgRh2uCQ51VPBPMAI5jQRet0BQrmRYvR7LjqTKeHPpgTXnsCCnhFDu/FmtgiRibgv3oZg==
X-Received: by 2002:a05:651c:221e:b0:26c:7a7b:7e61 with SMTP id y30-20020a05651c221e00b0026c7a7b7e61mr9586919ljq.282.1664363656279;
        Wed, 28 Sep 2022 04:14:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id i18-20020a056512007200b004a1e592837esm446377lfo.140.2022.09.28.04.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:14:15 -0700 (PDT)
Message-ID: <3eea7954-3faf-3fc9-7507-c318488c5524@gmail.com>
Date:   Wed, 28 Sep 2022 14:14:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
 <fe1088cebb0de70bcb99af517004c1816b696825.1663760018.git.mazziesaccount@gmail.com>
 <20220922180339.30138141@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20220922180339.30138141@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 9/22/22 20:03, Jonathan Cameron wrote:
> On Wed, 21 Sep 2022 14:45:35 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>> +
>> +/*
>> + * The sensor HW can support ODR up to 1600 Hz - which is beyond what most of
>> + * Linux CPUs can handle w/o dropping samples. Also, the low power mode is not
>> + * available for higher sample rates. Thus the driver only supports 200 Hz and
>> + * slower ODRs. Slowest being 0.78 Hz
>> + */
>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.78 1.563 3.125 6.25 12.5 25 50 100 200");
>> +static IIO_CONST_ATTR(scale_available,
>> +		      "598.550415 1197.10083 2394.20166 4788.40332");
>> +
>> +static struct attribute *kx022a_attributes[] = {
>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>> +	&iio_const_attr_scale_available.dev_attr.attr,
> 
> Use the read_avail() callback instead of doing these as attributes.
> That makes the values available to consumer drivers...

Am I correct that populating the read_avail() does not add sysfs entries 
for available scale/frequency? Eg, if I wish to expose the supported 
values via sysfs I still need these attributes? Implementing the 
read_avail() as well is not a problem though.

>> +static int kx022a_turn_on_unlock(struct kx022a_data *data)
>> +{
>> +	int ret;
>> +
> This is not used enough that I can see a strong reason for the
> wrapper.  Just put the two calls inline and rename the unlocked case.

In my opinion the kx022a_turn_on_unlock() and  kx022a_turn_off_lock() do 
simplify functions. Especially after I started using the 
iio_device_claim_direct_mode() :) Thus I will leave these for the v2 - 
please ping me again if you still want to see them removed (but I think 
the usage of iio_device_claim_direct_mode() changed this to favour the 
kx022a_turn_on_unlock() and kx022a_turn_off_lock()).

>> +static int kx022a_chip_init(struct kx022a_data *data)
>> +{
>> +	int ret, dummy;
>> +
>> +	/*
>> +	 * Disable IRQs because if the IRQs are left on (for example by
>> +	 * a shutdown which did not deactivate the accelerometer) we do
>> +	 * most probably end up flooding the system with unhandled IRQs
>> +	 * and get the line disabled from SOC side.
>> +	 */
>> +	ret = regmap_write(data->regmap, KX022A_REG_INC4, 0);
> 
> Unusual to do this rather than a reset.  Quick look suggests there is
> a suitable software reset (CNTL2)

I switched to the software reset as you suggested. I am not really 
convinced it is a better way. It seems the software reset requires us to 
re-init the regmap cache. Well, I don't think it is a bid geal though - 
just something worth noticing I guess.

>> +
>> +int kx022a_probe_internal(struct device *dev, int irq)
>> +{
>> +	static const char * const regulator_names[] = {"io_vdd", "vdd"};
>> +	struct iio_trigger *indio_trig;
>> +	struct kx022a_data *data;
>> +	struct regmap *regmap;
>> +	unsigned int chip_id;
>> +	struct iio_dev *idev;
>> +	int ret;
>> +
>> +	if (WARN_ON(!dev))
>> +		return -ENODEV;
>> +
>> +	regmap = dev_get_regmap(dev, NULL);
>> +	if (!regmap) {
>> +		dev_err(dev, "no regmap\n");
> 
> Use dev_err_probe() for all dev_err() stuff in probe paths.
> It ends up cleaner and we don't care about the tiny overhead
> of checking for deferred.

This one bothers me a bit. It just does not feel correct to pass -EINVAL 
for the dev_err_probe() so the dev_err_probe() can check if -EINVAL != 
-EPROBE_DEFER. I do understand perfectly well the consistent use of 
dev_err_probe() for all cases where we get an error-code from a function 
and return it - but using dev_err_probe() when we hard-code the return 
value in code calling the dev_err_probe() does not feel like "the right 
thing to do" (tm).

Eg, I agree that
return dev_err_probe(dev, ret, "bar");
is nice even if we know the function that gave us the "ret" never 
requests defer (as that can change some day).

However, I don't like issuing:
return dev_err_probe(dev, -EINVAL, "bar");

Well, please let me know if you think the dev_err_probe() should be used 
even in cases where we hard code the return to something...

For v2 I do change the other prints (like the one about failed regmap 
read below).

> 
>> +
>> +		return -EINVAL;
>> +	}
>> +
>> +	idev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!idev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(idev);
>> +
>> +	/*
>> +	 * VDD is the analog and digital domain voltage supply
>> +	 * IO_VDD is the digital I/O voltage supply
>> +	 */
>> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
>> +					     regulator_names);
>> +	if (ret && ret != -ENODEV)
>> +		return dev_err_probe(dev, ret, "failed to enable regulator\n");
>> +
>> +	ret = regmap_read(regmap, KX022A_REG_WHO, &chip_id);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to access sensor\n");
Yours,
	-- Matti Vaittinen

-- 
-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
