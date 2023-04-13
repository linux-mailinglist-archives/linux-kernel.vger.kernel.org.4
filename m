Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86476E0550
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 05:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjDMDeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 23:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDMDeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 23:34:25 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC3659E1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:34:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-632384298b3so6493208b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1681356844; x=1683948844;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rYVWcxpcEucFznKvw2ZBVZak6cYUtcRc61ABeJFVQ7M=;
        b=JHKEcQScy8Klei//HSDNlHPcWWCemzx9Vrg9eQS1sTa0sPQ77CO/+dAz9YUYx00mPw
         leVr0J2QaiGQaCg4j2763YDW1S2RX2rkhJYwSVAMLiO0l37h+ci5RJTQom5sLlDrxBH8
         tYJoPsekLK5xxeU1NzK3VUhnD7Wqa3LqtJt+p0JXHLjF0rhLnuY5tjghMqcaVHcb1SAa
         Cas23GlsY5XWNfcmMBmfu/UVxAARMadeTrgNmj19Jj9t2P26hGeioY3erD4Ot+ajF9WF
         NWfSN1HRY0lseA07X7AicIn6pEGgEYun2z8Ijmf8RsUL940BpMzeCRUTRR2dZ7EbWvp4
         LsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681356844; x=1683948844;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYVWcxpcEucFznKvw2ZBVZak6cYUtcRc61ABeJFVQ7M=;
        b=jXUg90IyHv5a/3PjEPI0fQideoCmr0UI+YNKwicW1+cblJ/ExHWDUOJ+/6IM3LnYN3
         l4jL8tpsBq0MZeJZu83ehOLys7afoUU/Jn2X9sJfT2kedUduKmAXuW18nxAApUp/rs8o
         JtBeOvJt1fzb5j5OeEeUxmAoni2cjnNppvaY8n3/XGgQCMeKN4RFVPRn/f8nCpjYbUcT
         4Y2pa4Y0TNQQOed2B7F/PcrrE4vS5/dTO7aiWk1Jsa13RGo2Vv04+7kROS2ZWfpWzQQG
         1jEqYu8ok8BvbyNO01X0vJ9TKTgpayMOkheCtZ00xXj0ObR/uHyKneWXK/vSwZNmT28H
         r8OQ==
X-Gm-Message-State: AAQBX9eb51Htx8RFWRVzVFTsMyyIGT5+Q4HcNbtlZj8hy7/ULoMU7Ky8
        NQXrR5+CYud0y67snMUK5SA7Mw==
X-Google-Smtp-Source: AKy350alQdFLNK6MZjc3VSgCVuvkguL3X4kzGdnrZjPbMaZNs2jMjwht877tYirA2PUWT0NefJbAPQ==
X-Received: by 2002:a05:6a00:1386:b0:625:cf03:e8cb with SMTP id t6-20020a056a00138600b00625cf03e8cbmr455113pfg.4.1681356843903;
        Wed, 12 Apr 2023 20:34:03 -0700 (PDT)
Received: from [10.240.2.163] ([124.148.245.238])
        by smtp.gmail.com with ESMTPSA id n25-20020aa78a59000000b006396be36457sm204069pfa.111.2023.04.12.20.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 20:34:03 -0700 (PDT)
Message-ID: <8dd207d3-a9f0-2c06-795e-efed30656e35@tweaklogic.com>
Date:   Thu, 13 Apr 2023 11:33:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 2/2] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
 <20230411011203.5013-3-subhajit.ghosh@tweaklogic.com>
 <ZDVWB9xV9Cdbwyqd@smile.fi.intel.com>
 <ab1d9746-4d23-efcc-0ee1-d2b8c634becd@tweaklogic.com>
 <ZDa0NIot/4aRJ0pI@smile.fi.intel.com>
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <ZDa0NIot/4aRJ0pI@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 21:37, Andy Shevchenko wrote:
> On Wed, Apr 12, 2023 at 12:29:15PM +0800, Subhajit Ghosh wrote:
> 
> ...
> 
>>>> +static const struct regmap_config apds9306_regmap = {
>>>> +	.name = "apds9306_regmap",
>>>> +	.reg_bits = 8,
>>>> +	.val_bits = 8,
>>>> +	.rd_table = &apds9306_readable_table,
>>>> +	.wr_table = &apds9306_writable_table,
>>>> +	.volatile_table = &apds9306_volatile_table,
>>>> +	.precious_table = &apds9306_precious_table,
>>>> +	.max_register = APDS9306_ALS_THRES_VAR,
>>>> +	.cache_type = REGCACHE_RBTREE,
>>>
>>> Do you need an internal regmap lock? If so, why?
>> For event interface - interrupt enable, adaptive interrupt enable,
>> upper and lower threshold values, selection of clear or als
>> channels for interrupt, the mutex in the driver's private data structure
>> is not used.
>> I thought to use the regmap's internal locking mechanism for
>> mutual exclusion as the values are directly written to or read from
>> the device registers form the write_event(), read_event(),
>> write_event_config() and read_event_config().
>> What do you think?
> 
> I didn't get. If you have a sequence of registers to be read/write/modified/etc
> in IRQ handler and/or elsewhere and at the same time in IRQ or elsewhere you
> have even a single IO access to the hardware you have to be sure that the IO
> ordering has no side effects. regmap API does not guarantee that. It only works
> on a simple read/write/modify of a _single_ register, or a coupled group of
> registers (like bulk ops), if your case is sparse, you on your own and probably
> lucky enough not to have an issue during the testing. So, take your time and
> think more about what you are doing in the driver and what locking schema
> should take place.
> 
> ...
Agree. I have to rethink and re-implement the locking mechanism.

> 
>>>> +static int apds9306_power_state(struct apds9306_data *data,
>>>> +		enum apds9306_power_states state)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	/* Reset not included as it causes ugly I2C bus error */
>>>> +	switch (state) {
>>>> +	case standby:
>>>> +		return regmap_field_write(data->regfield_en, 0);
>>>> +	case active:
>>>> +		ret = regmap_field_write(data->regfield_en, 1);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +		/* 5ms wake up time */
>>>> +		usleep_range(5000, 10000);
>>>> +		break;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>
>>>> +	return 0;
>>>
>>> Move that to a single user of this line inside the switch-case.
>> Sorry, I did not get you. Can you please elaborate?
> 
> The user of this return is only one case in the switch. Instead of breaking
> the switch-case, just move this return statement to there.
> 
Ok. It will be done.

> ...
> 
>>>> +	struct device *dev = &data->client->dev;
>>>
>>> Why data contains I²C client pointer, what for?
>> I copied the implementation. It will be re-implemented.
> 
> I mean, how client pointer is used in comparison to the plain pointer to the
> generic device object.
> 
> ...
> 
>>>> +		while (retries--) {
>>>> +			ret = regmap_read(data->regmap, APDS9306_MAIN_STATUS,
>>>> +					&status);
>>>> +			if (ret) {
>>>> +				dev_err(dev, "read status failed: %d\n", ret);
>>>> +				return ret;
>>>> +			}
>>>> +			if (status & APDS9306_ALS_DATA_STAT_MASK)
>>>> +				break;
>>>> +			/*
>>>> +			 * In case of continuous one-shot read from userspace,
>>>> +			 * new data is available after sampling period.
>>>> +			 * Delays are in the range of 25ms to 2secs.
>>>> +			 */
>>>> +			fsleep(delay);
>>>> +		}
>>>
>>> regmap_read_poll_timeout().
>> According to the regmap_read_poll_timeout() documentation, the maximum time
>> to sleep between reads should be less than ~20ms as it uses usleep_range().
>>
>> If userspace is doing continuous reads, then data is available after sampling
>> period (25ms to 2sec) or integration time (3.125ms to 400ms) whichever is
>> greater.
>>
>> The runtime_suspend() function is called after 5 seconds, so the device is
>> still active and running.
>>
>> If the ALS data bit is not set in status reg, it is efficient to sleep for
>> one sampling period rather than continuously checking the status reg
>> within ~20ms if we use regmap_read_poll_timeout().
>>
>> Do you have any suggestions?
> 
> Yes, Use proposed API. It takes _two_ timeout parameters, one of which is the
> same as your delay. You may actually resplit it by multiplying retries and
> decreasing delay to satisfy the regmap_read_poll_timeout() recommendation.
> 
Yes, that can be done. I will re-write this function in the next patch.

Thanks once again Andy for the detailed review.

Regards,
Subhajit Ghosh

