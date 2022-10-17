Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F9760072B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJQG7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJQG73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:59:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10B625D1;
        Sun, 16 Oct 2022 23:59:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id d26so22686171eje.10;
        Sun, 16 Oct 2022 23:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MTtcDnw810WWBjjekMl1WinMKKNV2g2u0EH/IvZEd1Q=;
        b=MZaJSgMWOzjS9HjRU4uQIErUb7C0Lh9U9+AW6mvQTWh/FHxBMJSFkKUEgPzUcK11n6
         HGAGna36R55/39YRssEjKknfA1E90iSBYwO1vaqyeVh9xIyx39Q21f9zy6XNg4X5LLBp
         kzYCSHIcVPIyFsSmmp9Sk0q52Bh8f18+AwfGfi693TmN9lZHk3Ca0TDAg4idzogeX+g/
         +/QHf3l7OG3V9S+lKRdHAN492VFTCCF5qon+MUIXu/DuBI+Q4EPowLa6TyllUEgdxML3
         ZWCmyZmx2FkJdU+3PJQbwqwqP2btW6ku7Dcdfq0x4MKKJauKNRLXi0uiJHR38hQkczZg
         9aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTtcDnw810WWBjjekMl1WinMKKNV2g2u0EH/IvZEd1Q=;
        b=unSHsMBjCLq/TY7FxB4ncfuY8jjDzIvNVKLCmwkSgF/r63lWoAx9OK9nZiTsAGszVx
         mbrcMy9qFjWW5YUhEPdIanU+FUL7KeO3AkIbEsonTyTxMPNlaPljZNua+t4GVEY6RSxG
         IOLweh0IRU6/M7qpVHVFnXFZm+NpC3IZQzUoRlKnxGJb25bpZEzJEWPSzW1bfu0eqrPm
         ZjU5KLFM882qsdtcrOzQvT0Dq1yYishU5dKg+jw36UHEslLJZ2P62L2Ze2tdHULgrwjh
         nNSEiLvnhwflLTm7Qa27TzmiE4/nzX2S6ZIWEDeNOVFQRYRcXPBvzPT5c5XxAfi8AYYH
         vEXw==
X-Gm-Message-State: ACrzQf26IawO/6z8Dvkn68NopuHjlp94/d5/IKkKO8SQgd0YCPXO9WlW
        5e7AESXgoyJlvA81kCTnk5E=
X-Google-Smtp-Source: AMsMyM6lkm1SjXUZIwmIhZoG4r0Dq2zhB07++26JRNHu88HHCf95UpVCNPkPccXsoqtJmnUnsiPvYA==
X-Received: by 2002:a17:907:dac:b0:78e:17a0:d1cb with SMTP id go44-20020a1709070dac00b0078e17a0d1cbmr7634837ejc.618.1665989965075;
        Sun, 16 Oct 2022 23:59:25 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.15.51])
        by smtp.gmail.com with ESMTPSA id n14-20020a170906700e00b0078d424e8c09sm5559792ejj.77.2022.10.16.23.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 23:59:24 -0700 (PDT)
Message-ID: <007bd4e6-62ce-5c06-4912-9f782fc29742@gmail.com>
Date:   Mon, 17 Oct 2022 09:59:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 3/3] iio: temperature: ltc2983: support more parts
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20221014123724.1401011-1-demonsingur@gmail.com>
 <20221014123724.1401011-4-demonsingur@gmail.com>
 <20221014164435.000016a1@huawei.com>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <20221014164435.000016a1@huawei.com>
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



On 10/14/22 18:44, Jonathan Cameron wrote:
> On Fri, 14 Oct 2022 15:37:24 +0300
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
> 
>> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
>>
>> Add support for the following parts:
>>   * LTC2984
>>   * LTC2986
>>   * LTM2985
>>
>> The LTC2984 is a variant of the LTC2983 with EEPROM.
>> The LTC2986 is a variant of the LTC2983 with only 10 channels,
>> EEPROM and support for active analog temperature sensors.
>> The LTM2985 is software-compatible with the LTC2986.
>>
>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> ...
> 
> Hi Cosmin,
> 
> Looks good except, I think we are still in the position that
> regmap for spi doesn't guarantee to bounce buffer the bulk accesses
> (last time I checked it actually did do so, but before that it didn't
> and there are obvious optimizations to take it back to not doing so -
> IRC Mark Brown's answer was we shouldn't rely on it..)
> 
> Anyhow, the existing driver has instances of this so its no worse
> but we should really clean those up.
> 
> Jonathan
> 

I can submit another patch for it. Although I'm pretty sure that
SPI regmap implementation doesn't need DMA safe access for it,
as I checked when I wrote the code.

> 
>>   
>> +static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
>> +			      unsigned int wait_time, unsigned int status_reg,
>> +			      unsigned long status_fail_mask)
>> +{
>> +	__be32 bval = cpu_to_be32(LTC2983_EEPROM_KEY);
>> +	unsigned long time;
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	ret = regmap_bulk_write(st->regmap, LTC2983_EEPROM_KEY_REG, &bval,
>> +				sizeof(bval));
> 
> SPI device and I was clearly dozing on existing driver but normally
> we avoid assuming that regmap will always use a bounce buffer for bulk
> accessors. Hence this should be a DMA safe buffer.
> 
> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	reinit_completion(&st->completion);
>> +
>> +	ret = regmap_write(st->regmap, LTC2983_STATUS_REG,
>> +			   LTC2983_STATUS_START(true) | cmd);
>> +	if (ret)
>> +		return ret;
>> +
>> +	time = wait_for_completion_timeout(&st->completion,
>> +					   msecs_to_jiffies(wait_time));
>> +	if (!time) {
>> +		dev_err(&st->spi->dev, "EEPROM command timed out\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	ret = regmap_read(st->regmap, status_reg, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (val & status_fail_mask) {
>> +		dev_err(&st->spi->dev, "EEPROM command failed: 0x%02X\n", val);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> 
