Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AB86B7826
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCMM5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjCMM5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:57:04 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA8969205;
        Mon, 13 Mar 2023 05:57:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id t14so12516724ljd.5;
        Mon, 13 Mar 2023 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678712221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Gr2AaLEFSBaR68Q/TLef3iDpRGM3N9OJo/Ps9/urIs=;
        b=QM9kK++WQKVMo0QzCl9qqpKqmS8gCLckHPLkfDoEPyupjiV4t9sxQzdDupZExj+xaT
         z4Ol6h8FdcX7IQC5t1S+3gkHDMcd6/aslfaqFz2BN00NyTGP6wrtwlIX3HPlA3H6Vij3
         TnilpDtCJQ1wOMf1PsStRa49Si35HVepxaFPehqjIwNK0WDqHvYbmVeHwVrOxeM0UINf
         jOvXo0rtTd0Dy1hbJa4eHgbGCRwTZgRJILbJqPBywUnYq2obrz7E4JOtoeS9cG2igSVS
         31GidUkFZ8Ltqwe/2ISQTTOfMOoWXRA9EynVxCr1iHP1xHIwI2HKh2bn+HqNAbDvSRmq
         W0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678712221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Gr2AaLEFSBaR68Q/TLef3iDpRGM3N9OJo/Ps9/urIs=;
        b=TBpW9C2IQzz9tMoXkN21NqBXNLISc7rTtmQoZvjTeBsKYZX0765AKy2EWiQX9B+gVG
         tRU9xscR5AxREQZsFsLE30rkiYrwzytAvbYodMOvPZwR367ND4XYId5/SkJ3rP4a8CGv
         +Sp6cAeOya2se/lGBo+Yq8IxVycCR5DedW+/YkACz7ZSbZ0JQlEZ3mf9HmW78U3J160E
         Z7srSl/j2kGximnEWCByTXo3qaLi8nj7kjcYkdNZ7X7Ro3B+q86zi74x3O10quFScoAL
         Qtz+N1OqYnf/o2Co6u33z3eM14j8QRJjCmW1KnmKozDeqb5oIajzftVz5EkGAUDSan2/
         fcPg==
X-Gm-Message-State: AO0yUKV2RqXyrsJBlPryG2TWoI+hkpMOEjumaWUNX97S08vaAY5YF8PB
        2kLI/CAbmN0CI27Iyyqk58k=
X-Google-Smtp-Source: AK7set92az/R+d1x4QbCOkrOBKf6u40h2+NWzf6Le0e09ZBD6zL5gqnRtd7GxexvX/SK8KPZXUg8TQ==
X-Received: by 2002:a2e:b94a:0:b0:293:1565:4353 with SMTP id 10-20020a2eb94a000000b0029315654353mr10259443ljs.10.1678712220646;
        Mon, 13 Mar 2023 05:57:00 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id f23-20020a2e3817000000b002987088bda4sm981837lja.69.2023.03.13.05.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 05:57:00 -0700 (PDT)
Message-ID: <bad05e06-3b37-b435-bfac-962aef36cc97@gmail.com>
Date:   Mon, 13 Mar 2023 14:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com> <20230312165100.45de0c9b@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230312165100.45de0c9b@jic23-huawei>
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

On 3/12/23 18:51, Jonathan Cameron wrote:
> On Mon, 6 Mar 2023 14:52:57 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> On Mon, Mar 06, 2023 at 11:17:15AM +0200, Matti Vaittinen wrote:
>>> Some light sensors can adjust both the HW-gain and integration time.
>>> There are cases where adjusting the integration time has similar impact
>>> to the scale of the reported values as gain setting has.
>>>
>>> IIO users do typically expect to handle scale by a single writable 'scale'
>>> entry. Driver should then adjust the gain/time accordingly.
>>>
>>> It however is difficult for a driver to know whether it should change
>>> gain or integration time to meet the requested scale. Usually it is
>>> preferred to have longer integration time which usually improves
>>> accuracy, but there may be use-cases where long measurement times can be
>>> an issue. Thus it can be preferable to allow also changing the
>>> integration time - but mitigate the scale impact by also changing the gain
>>> underneath. Eg, if integration time change doubles the measured values,
>>> the driver can reduce the HW-gain to half.
>>>
>>> The theory of the computations of gain-time-scale is simple. However,
>>> some people (undersigned) got that implemented wrong for more than once.
>>>
>>> Add some gain-time-scale helpers in order to not dublicate errors in all
>>> drivers needing these computations.
>>
>> ...
>>
>>> +/*
>>
>> If it's deliberately not a kernel doc, why to bother to have it looking as one?
>> It's really a provocative to some people who will come with a patches to "fix"
>> this...
> 
> Just make it kernel-doc.
> 

Are you sure...? I don't like the idea of polluting generated docs with 
documentation for this type of tiny internal pieces not usable outside 
this component anyways...

>>
>>> + * iio_gts_get_gain - Convert scale to total gain
>>> + *
>>> + * Internal helper for converting scale to total gain.
>>> + *
>>> + * @max:	Maximum linearized scale. As an example, when scale is created
>>> + *		in magnitude of NANOs and max scale is 64.1 - The linearized
>>> + *		scale is 64 100 000 000.
>>> + * @scale:	Linearized scale to compte the gain for.
>>> + *
>>> + * Return:	(floored) gain corresponding to the scale. -EINVAL if scale
>>> + *		is invalid.
>>> + */
> 
>> ...
>>
>>> +EXPORT_SYMBOL_NS_GPL(iio_gts_total_gain_to_scale, IIO_GTS_HELPER);
>>
>> I would say _HELPER part is too much, but fine with me.
> 
> Hmm. I think I like the HELPER bit as separates it from being a driver.
> Of course I might change my mind after a few sleeps.

Ever considered a career as a politician? ;) (No offense intended - and 
feel free to change your mind on this. I don't expect this to be done 
tomorrow)

> 
>>> +++ b/drivers/iio/light/iio-gts-helper.h
>>
>> Is it _only_ for a Light type of sensors?
> 
> I'd move it up a directory and allow for other users.
> 

Ok. I'll do the move for the next version.

Yours,
	-- Matti

> Jonathan

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

