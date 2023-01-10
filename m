Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D654E6649F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbjAJS2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbjAJS1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:27:51 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A17A17E12;
        Tue, 10 Jan 2023 10:22:58 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id d127so10772654oif.12;
        Tue, 10 Jan 2023 10:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1tLa08dc9XQGqb8aHRMYcS3cuZWguHoTHphHBtiZ5ZQ=;
        b=BaM3z0FWcz6IuWAnw07PtJxiEg6W3AzkbHliTBFGesUBRV4sWMKPHYeDzsS0cQPg/v
         YawH2DJaM++8QzcjdcmUSZaAHbulelcs7Kagdbrt53bkQHZvSwwEmnUMtAH9/R5Rp/bC
         Db9jmUZlLEYXdd/BXsAX2r4dTgpY/jspH47sK+X/5wzKA/6iGFXWpU5gXoQpzf0eI2K4
         kLaWPRYuzaJGBFpRXAa2GBbyzepJdDb6X947nz1MhKBjmI3xoZcCR6obETWx6P/YeMvF
         j73pil7M3f6U/ARKMpJIZC52nvm3hqKODjjJAgeZbq78nEXeZsEdrJ3XjG0Trv5UKvJQ
         E/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tLa08dc9XQGqb8aHRMYcS3cuZWguHoTHphHBtiZ5ZQ=;
        b=v87DHD//O480ck0obkKhVd3Yj4JhW0eAkm73pr+PtjDquVx5z3/QemC11g5q86Y+dr
         yJ0muxWaTcFFjyzcmOJV+R9pbdxyvbRF4nEqUq4DDaq874SKVNHvLTudHGas1WU0M6ct
         BrwcrQaYGixBkA4t1gNc20pMPl7Yk4sbEz1SXe8wSlirtsjHa58LRZvx3UOX7fuOmCfH
         bWFTq/tygst3Rf1xcp4ujeUmK5e/A8zFfMSsP9Hki6DAzVkGL/Odkq9VnhfmfR3GyPA1
         /VUCSH6LoI3nTog7vyGE2DTc7P6zRwDDhSUMcC2ORcdM20sym/vh+d+NsvPJWZSdBzkF
         gy1g==
X-Gm-Message-State: AFqh2krttgB2ixnUfIW52Y+QynRg5AdLtyuBceum2SZJxWQH4EmB8ql7
        tFY3OIoS72u/6En4N/oV4n1Pe1DK6rs=
X-Google-Smtp-Source: AMrXdXsJzlT3UTFZjE3LIAhXGqQjN2fXUowvG7OFtYBdGzHeDDE1O/iVbJwu+d5l0Nl0C7wEg5h2Dg==
X-Received: by 2002:a05:6808:985:b0:35e:aaf3:b289 with SMTP id a5-20020a056808098500b0035eaaf3b289mr30005899oic.49.1673374977288;
        Tue, 10 Jan 2023 10:22:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 21-20020aca2115000000b00354d8589a15sm5575800oiz.45.2023.01.10.10.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 10:22:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dd80ee77-3b71-ee47-2744-36b09e0ec372@roeck-us.net>
Date:   Tue, 10 Jan 2023 10:22:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 3/5] hwmon: ltc2945: Handle error case in
 ltc2945_value_store
Content-Language: en-US
To:     Jon Cormier <jcormier@criticallink.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>,
        Dan Vincelette <dvincelette@criticallink.com>
References: <20221214220727.1350784-3-jcormier@criticallink.com>
 <20230109233534.1932370-1-jcormier@criticallink.com>
 <20230109233534.1932370-4-jcormier@criticallink.com>
 <d49d4b4c-e7ee-e0a1-56e6-7f193e0d1340@roeck-us.net>
 <CADL8D3YEkZaOjUY3mRLGT0M+b7MwN5zQZrbsw5W8Mn=PJ7PtcA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CADL8D3YEkZaOjUY3mRLGT0M+b7MwN5zQZrbsw5W8Mn=PJ7PtcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 10:19, Jon Cormier wrote:
> On Mon, Jan 9, 2023 at 7:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 1/9/23 15:35, Jonathan Cormier wrote:
>>> ltc2945_val_to_reg errors were not being handled
>>> which would have resulted in register being set to
>>> 0 (clamped) instead of being left alone.
>>>
>>> Change reg_to_val and val_to_reg to return values
>>> via parameters to make it more obvious when an
>>> error case isn't handled. Also to allow
>>> the regval type to be the correct sign in prep for
>>> next commits.
>>>
>>
>> Sorry, I don't see that as reason or argument for such invasive changes.
>> As far as I can see, a two-liner to check the return value of val_to_reg()
>> should have been sufficient. Most of the rest, such as splitting
>> the return value into two elements, is POV and just adds additional code
>> and complexity for zero gain.
> I can do that. However, you had also mentioned changing the return
> type to match what the calling function was expecting, an unsigned
> long. But I can't do that since error codes are negative so it would
> be a signed long which would lose precision and seemingly defeat the
> point of matching the variable type the caller wants.  I could make it
> a signed long long but that still doesn't match.  So it seemed saner
> to just return the error and the value separately, that way the
> function declaration was explicit about the types it wanted/returned,
> and less room for error.  Would love to know your preferred solution.
> 

That is only true if the upper bit is actually ever set in that signed long.
Which means I'll have to verify if "would lose precision" is actually
a correct statement.

Guenter

>>
>> Guenter
>>
>>> Fixes: 6700ce035f83 ("hwmon: Driver for Linear Technologies LTC2945")
>>>
>>> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
>>> ---
>>>    drivers/hwmon/ltc2945.c | 30 ++++++++++++++++++------------
>>>    1 file changed, 18 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
>>> index 9af3e3821152..c66acf8d2124 100644
>>> --- a/drivers/hwmon/ltc2945.c
>>> +++ b/drivers/hwmon/ltc2945.c
>>> @@ -70,12 +70,12 @@ static inline bool is_power_reg(u8 reg)
>>>    }
>>>
>>>    /* Return the value from the given register in uW, mV, or mA */
>>> -static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>>> +static int ltc2945_reg_to_val(struct device *dev, u8 reg, u64 *regval)
>>>    {
>>>        struct regmap *regmap = dev_get_drvdata(dev);
>>>        unsigned int control;
>>>        u8 buf[3];
>>> -     long long val;
>>> +     u64 val;
>>>        int ret;
>>>
>>>        ret = regmap_bulk_read(regmap, reg, buf,
>>> @@ -148,11 +148,12 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
>>>        default:
>>>                return -EINVAL;
>>>        }
>>> -     return val;
>>> +     *regval = val;
>>> +     return 0;
>>>    }
>>>
>>>    static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>>> -                           unsigned long val)
>>> +                           unsigned long val, unsigned long *regval)
>>>    {
>>>        struct regmap *regmap = dev_get_drvdata(dev);
>>>        unsigned int control;
>>> @@ -220,19 +221,21 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
>>>        default:
>>>                return -EINVAL;
>>>        }
>>> -     return val;
>>> +     *regval = val;
>>> +     return 0;
>>>    }
>>>
>>>    static ssize_t ltc2945_value_show(struct device *dev,
>>>                                  struct device_attribute *da, char *buf)
>>>    {
>>>        struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>>> -     long long value;
>>> +     int ret;
>>> +     u64 value;
>>>
>>> -     value = ltc2945_reg_to_val(dev, attr->index);
>>> -     if (value < 0)
>>> -             return value;
>>> -     return sysfs_emit(buf, "%lld\n", value);
>>> +     ret = ltc2945_reg_to_val(dev, attr->index, &value);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +     return sysfs_emit(buf, "%llu\n", value);
>>>    }
>>>
>>>    static ssize_t ltc2945_value_store(struct device *dev,
>>> @@ -245,7 +248,7 @@ static ssize_t ltc2945_value_store(struct device *dev,
>>>        unsigned long val;
>>>        u8 regbuf[3];
>>>        int num_regs;
>>> -     int regval;
>>> +     unsigned long regval;
>>>        int ret;
>>>
>>>        ret = kstrtoul(buf, 10, &val);
>>> @@ -253,7 +256,10 @@ static ssize_t ltc2945_value_store(struct device *dev,
>>>                return ret;
>>>
>>>        /* convert to register value, then clamp and write result */
>>> -     regval = ltc2945_val_to_reg(dev, reg, val);
>>> +     ret = ltc2945_val_to_reg(dev, reg, val, &regval);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>>        if (is_power_reg(reg)) {
>>>                regval = clamp_val(regval, 0, 0xffffff);
>>>                regbuf[0] = regval >> 16;
>>
> 
> 
> --
> Jonathan Cormier
> Software Engineer
> 
> Voice:  315.425.4045 x222
> 
> 
> 
> http://www.CriticalLink.com
> 6712 Brooklawn Parkway, Syracuse, NY 13211

