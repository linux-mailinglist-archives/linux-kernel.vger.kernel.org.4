Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18DA6D18BE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCaHjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaHjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:39:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4161E07D;
        Fri, 31 Mar 2023 00:39:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id q16so27750068lfe.10;
        Fri, 31 Mar 2023 00:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680248379;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4jLK6QPOttnvpPEimzfvO/0Ippj1BKOqaorwSauRVA=;
        b=Rb0jsDIq1ic2K7eMkgLXDNllba+yhU94V/PubBfoo9bwnlmPXM0PceYdUhuvgAkBRd
         9b4vJIvqteTS1aXhIVH6XdGLgsvJU5DPLAt0MXKMSjvuH6LU2TUdiaOUf9NTU1oz10ao
         ZOBBQZy1rPrQS7Dic3/ojH4HuObCQTQ3q9USl5+3FHvlU/0rNo3o/oMZdys//F+3jcBm
         96rfLCIuD/QkeU3cYaqRYvcuMnw9Qq0mmaSWRX9PEPFMjh0DnP1i2LsYg7wA8tinlsky
         Iz7kz8L4ocn358fwvhbOm0TpOH9+f8CEzUBGDJbU/5o3AcM+PCi8Aexm66HhSDSKP+X8
         vLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248379;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4jLK6QPOttnvpPEimzfvO/0Ippj1BKOqaorwSauRVA=;
        b=3TPylJTTCgojlR0P8M2EzK2G6WQbmyg8QS0d7eiUPKUmwiK1nK2QR/c4n023jQgh6S
         GoFY+64XGO0odG0VbrfuZJ4esBqUp26Ko7pWMVP4Ba+0bG2wMmhbOuX4UyAE8IhxXcYc
         SbZRfc+17PoHFsLFfCBtx822Wwd2DOFBxGin61VE9mMgd/bFf0rj+P8erVJq+vW2uG2n
         ZEXiTv24NoklKyXgVz/4P/dlPUSwIIedvvEH401RIY1+V+yINBG7H7Ztw354aRY70MPq
         +d79nx+6D3z8PgTpr65gl8KeyqD1k1BqkgMeSQS3ClRm8eZ+OihMFf5vz299/8CxlIZk
         fGhA==
X-Gm-Message-State: AAQBX9fQMFVxGw7xZcnDSw31ke/6a9PeutXC+09T2iizqDxeLCKloqio
        Af6bPStpfFg/0lADPSHpR1N6lwMJ8+4=
X-Google-Smtp-Source: AKy350ZR+NV9kRlRC88z9sEIySHVYbPLjR+gX9MaOngE5QYSAmgXf+Wbr4pOWPhToKwnLZbQaBPmew==
X-Received: by 2002:ac2:531b:0:b0:4e1:8309:1db5 with SMTP id c27-20020ac2531b000000b004e183091db5mr7672162lfh.2.1680248378580;
        Fri, 31 Mar 2023 00:39:38 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id u15-20020ac24c2f000000b004dc4af9089bsm266121lfq.231.2023.03.31.00.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 00:39:38 -0700 (PDT)
Message-ID: <cbbb45d3-b2e0-d57c-870f-553b7a6cbf99@gmail.com>
Date:   Fri, 31 Mar 2023 10:39:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1679915278.git.mazziesaccount@gmail.com>
 <68179bcc8371ef9026d1179847fc9c73aa7460f4.1679915278.git.mazziesaccount@gmail.com>
 <b8904407-87d1-c8fa-d70c-67259211445e@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v6 2/7] iio: light: Add gain-time-scale helpers
In-Reply-To: <b8904407-87d1-c8fa-d70c-67259211445e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 19:48, Matti Vaittinen wrote:
> On 3/27/23 14:28, Matti Vaittinen wrote:
>> Some light sensors can adjust both the HW-gain and integration time.
>> There are cases where adjusting the integration time has similar impact
>> to the scale of the reported values as gain setting has.
>>
>> IIO users do typically expect to handle scale by a single writable 
>> 'scale'
>> entry. Driver should then adjust the gain/time accordingly.
>>
>> It however is difficult for a driver to know whether it should change
>> gain or integration time to meet the requested scale. Usually it is
>> preferred to have longer integration time which usually improves
>> accuracy, but there may be use-cases where long measurement times can be
>> an issue. Thus it can be preferable to allow also changing the
>> integration time - but mitigate the scale impact by also changing the 
>> gain
>> underneath. Eg, if integration time change doubles the measured values,
>> the driver can reduce the HW-gain to half.
>>
>> The theory of the computations of gain-time-scale is simple. However,
>> some people (undersigned) got that implemented wrong for more than once.
>>
>> Add some gain-time-scale helpers in order to not dublicate errors in all
>> drivers needing these computations.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Currently it is only BU27034 using these in this series. I am however 
>> working
>> with drivers for RGB sensors BU27008 and BU27010 which have similar
>> [gain - integration time - scale] - relation. I hope sending those
>> follows soon after the BU27034 is done.
>>
> 
>> +/**
>> + * iio_gts_find_new_gain_sel_by_old_gain_time - compensate for time 
>> change
>> + * @gts:        Gain time scale descriptor
>> + * @old_gain:        Previously set gain
>> + * @old_time_sel:    Selector corresponding previously set time
>> + * @new_time_sel:    Selector corresponding new time to be set
>> + * @new_gain:        Pointer to value where new gain is to be written
>> + *
>> + * We may want to mitigate the scale change caused by setting a new 
>> integration
>> + * time (for a light sensor) by also updating the (HW)gain. This 
>> helper computes
>> + * new gain value to maintain the scale with new integration time.
>> + *
>> + * Return: 0 on success. -EINVAL if gain matching the new time is not 
>> found.
> 
> Here we need to document another return value denote whether the 
> @new_gain was updated.
> 
>> + */
>> +int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
>> +                           int old_gain, int old_time_sel,
>> +                           int new_time_sel, int *new_gain)
>> +{
>> +    const struct iio_itime_sel_mul *itime_old, *itime_new;
>> +    u64 scale;
>> +    int ret;
>> +
>> +    itime_old = iio_gts_find_itime_by_sel(gts, old_time_sel);
>> +    if (!itime_old)
>> +        return -EINVAL;
>> +
>> +    itime_new = iio_gts_find_itime_by_sel(gts, new_time_sel);
>> +    if (!itime_new)
>> +        return -EINVAL;
>> +
>> +    ret = iio_gts_get_scale_linear(gts, old_gain, itime_old->time_us,
>> +                       &scale);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = gain_get_scale_fraction(gts->max_scale, scale, itime_new->mul,
>> +                      new_gain);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (!iio_gts_valid_gain(gts, *new_gain))
>> +        return -EINVAL;
> 
> I would change this to -ERANGE to differentiate the case where the new 
> gain was computed but was not valid. The bu27034 (and 
> not-yet-fully-finished bu27008) driver uses the computed gain to find 
> closest matching gain the hardware supports. I am not super happy with 
> the -ERANGE, as it is also possible the gain is in the "range" of 
> supported gains but not _exactly_ supported one. In a sense -EINVAL 
> would be more correct. The invalid time could in a sense be interpreted 
> as an "time selector not found" - so maybe the -ENOENT could be somehow 
> tolerated. Still, in my opinion the invalid integration time is very 
> much more an -EINVAL than anything else...

Looks like I keep discussing with myself. This however was not a good 
solution as we might detect non integer gain to be required in the 
gain_get_scale_fraction(). And deciding if that function should return 
-ERANGE or -EINVAL got things even worse.

So, the take N (where N is a positive integer, much greater than 1) is 
that I'll do:

int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
                            int old_gain, int old_time_sel,
                            int new_time_sel, int *new_gain)
{
     const struct iio_itime_sel_mul *itime_old, *itime_new;
     u64 scale;
     int ret;

     *new_gain = -1;

and add return value doc like:

  * Return: 0 if an exactly matching supported new gain was found. When 
a
  * non-zero value is returned, the @new_gain will be set to a negative or
  * positive value. The negative value means that no gain could be computed.
  * Positive value will be the "best possible new gain there could be". 
There
  * can be two reasons why finding the "best possible" new gain is not 
deemed
  * successful. 1) This new value cannot be supported by the hardware. 
2) The new
  * gain required to maintain the scale would not be an integer. In this 
case,
  * the "best possible" new gain will be a floored optimal gain, which 
may or
  * may not be supported by the hardware.

> 
> I will fix this for v7.
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

