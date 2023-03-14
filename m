Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA66B8EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjCNJja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCNJj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:39:27 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40AF36691;
        Tue, 14 Mar 2023 02:39:25 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f16so15314972ljq.10;
        Tue, 14 Mar 2023 02:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678786764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zcEQOOnzszFUwCzQKIFzn1i0LJS8FFsxhSGEYxNISjk=;
        b=fihQeiCHT56D9CQzgDogmMLYd5wUjDIjxKnQraGQ4HbU6F172pHDBvL7/i/xepC5Bz
         oxclubpLwXHVw8GHI5vd8SJ0Ko6H6chnzQH9lUppOiT2cyV4WDePa24yN8vrPqQNOpfl
         g5B5MfAQ8ITW1RSLZ4CBdqAR6Ie7K5zv7IiPdep2a65kM36zd2T8Zx+eaGnXSvo9dNm3
         bFj750SKC0MPoyyYYVg5GkfuQy7Q1yZOPxpdDwsKKxseMcfqJ568NAPhZyThOKRlYVLZ
         iLI9K7qvanJNWbi2+/BGOWQMuu0EKxJWZtXH7aSiNI3fhSbLNfeqLYLMh3mK5z+b55br
         hPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678786764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcEQOOnzszFUwCzQKIFzn1i0LJS8FFsxhSGEYxNISjk=;
        b=BSVscO2nY9TYMrn5TwrjF0iE5i0m+9ARrRZV/nFLbwbr6DGWrIuXmqWANvPut3aKuZ
         R1a5jYsrk+48f2srEh1Jxamp4FUAyI+Nj2LGGid45AufTxSkDQEUIP4r8EUluDufclaV
         kknwPP4B3G4+cqSGVUWrjGy6/yKz0xLj0hGMb0VStSOdLeIWITE+TLY0YZRpjHc6uVIX
         m5xtCg+yyKnluABjarlHpU+pal6eAokFKSEcnVLgk9GII+oLK6ykBdQNL1r+C8L7Q60F
         oaA0MCcN3AaSCpPer4ThhzJBtFzjBtwYS8BQC5SECOTqkOCHwRnsgJgmIGLd+wSDQQsI
         A04w==
X-Gm-Message-State: AO0yUKXCAnYJecoCva3ZHmp86wu+Du4hpyChu2r1083k/aztr3Fm57Sa
        xz0RVOOvFSBIyl5J9yPmWbR/AwETjxA=
X-Google-Smtp-Source: AK7set+II/bSQk1YmwThgclb50DANRr8kP/FCpJWXHDiz47loXRoCReqCE8/+Cg9zq/VudR1EDiBQA==
X-Received: by 2002:a05:651c:10e:b0:295:b2a1:20ed with SMTP id a14-20020a05651c010e00b00295b2a120edmr10379603ljb.22.1678786764031;
        Tue, 14 Mar 2023 02:39:24 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id g7-20020a2e9e47000000b002945b04e1ebsm363920ljk.94.2023.03.14.02.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 02:39:23 -0700 (PDT)
Message-ID: <1161c822-ece3-4654-f11d-c775f8c64f65@gmail.com>
Date:   Tue, 14 Mar 2023 11:39:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
 <20230304201720.2d554f07@jic23-huawei>
 <c16d372f-a122-16d6-ad08-1fbffb01d9ff@gmail.com>
 <20230312153655.052d5730@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230312153655.052d5730@jic23-huawei>
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

On 3/12/23 17:36, Jonathan Cameron wrote:
> On Sun, 5 Mar 2023 14:22:51 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 3/4/23 22:17, Jonathan Cameron wrote:
>>> On Thu, 2 Mar 2023 12:58:59 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:

//snip

>>>    
>>>> +static const struct iio_chan_spec bu27034_channels[] = {
>>>> +	{
>>>> +		.type = IIO_LIGHT,
>>>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>>>> +				      BIT(IIO_CHAN_INFO_SCALE),
>>>
>>> What is this scale for?
>>
>> The scale is to inform users that we return data using milli lux.
>>
>>> Given the channel is computed from various different inputs, is there a
>>> clear definition of how it is scaled?  What does a write to it mean?
>>
>> Nothing. writing anything else but milli lux scale fails with -EINVAL.
>>
>> I guess I am doing something in an unusual way here :) Do you have a
>> suggestion for me?
> 
> Return data in lux?  Or return it as INFO_RAW - thus making it clear
> that the reading is not in expected units and a conversion must be
> applied by userspace.  SCALE is not applied to PROCESSED by userspace.
> 

I just noticed a thing. I used the iio_generic_buffer to test the 
changes - and it got the channel values scaled to luxes even for the 
PROCESSED channel. So, it seems to me the iio_generic_buffer does apply 
the scale for PROCESSED channels too. I think that is slightly 
misleading. Oh, and this is not intended to be a complaint - just a 
report that there might be some room for an improvement :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

