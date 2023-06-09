Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBAA729A46
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbjFIMqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjFIMql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:46:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F95358E;
        Fri,  9 Jun 2023 05:46:25 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f655293a38so1777625e87.0;
        Fri, 09 Jun 2023 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686314783; x=1688906783;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ea6hIeJeWxD+XAcB/DW5cX56LrVOPb9qHummCN645Ak=;
        b=aTg/lTqKSy8RpJlbwB3yaEGOAz9S6fnEd37plKqRWUYOidy8T8c4jpnOqo8ckgHHbO
         pH5B21G8IDUvbxcdqCqdUbVgI/dJlzuWTdC6YyGkP803j1JkOkY7fS7Z02litmt0hqKH
         c9M7kGEpfUxczjU6Ub8Ex04FLzIJthOQVONDm4SQoewg6zA790e37txYj3ao7r8EzC1I
         fqt08iM69BcKDdQ9yn3IEEUOPu1940pg5bzka8/2DXdeC3om1ZvKqG+Vnym36zT0lykk
         szkATfD4Tdt/ISLOA4K/WaaUdeQ7KofjnUhImvBYGtdJUlcwInKudkDohdJXg5FjtPeL
         u+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686314783; x=1688906783;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ea6hIeJeWxD+XAcB/DW5cX56LrVOPb9qHummCN645Ak=;
        b=Dl9z5Fc8Ge4kfZxFyWeHQ9knwnmBc2zwBUOOOjNadSZREgDERDSEk10/KRBJ3vW98o
         YYZM7OoB8DhzspMTvkcgVrUKUshQtnPGdk1irLJQl7XWpwvwnDLxnfwWbAMY/rWe8cV8
         E8tLM4wQ5kd9LhehxxQy2rIIEW3K1Rcgn0tTSgpChXUmDcrsrhaq7wHWFPyvdCZftI1R
         VT1YLXvsCXwJAlaXutsExI7c0b243hFBU4q4668XHSXq1U9Mq2z/ioPqQB7vTL1NVj8t
         oOJsqFEjKi+YcRLlm4z+Ff7hTLKyWyTKvIsh+0Th23QS/03UFac5PIMdv1Ehj5GkL/g2
         8WXQ==
X-Gm-Message-State: AC+VfDwP5DzJiUmpJHDiTPsC9Y8M0AdzPgWwYEcawZZVVyfzezNzPKmJ
        ouIItistfBzTW//8+SC/dS2DRIzuqBk=
X-Google-Smtp-Source: ACHHUZ5CTJMPowbjAFaw+BEQRPD+eNOxSTqHgoQzpIXR1evGJZCq6EZzvQ3pYerDpe/iZ0tNbGbGlw==
X-Received: by 2002:ac2:4db5:0:b0:4f3:b215:ef7c with SMTP id h21-20020ac24db5000000b004f3b215ef7cmr742881lfe.23.1686314782956;
        Fri, 09 Jun 2023 05:46:22 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id b24-20020ac247f8000000b004edc3f06f5csm539324lfp.296.2023.06.09.05.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 05:46:22 -0700 (PDT)
Message-ID: <0173eb2b-b6a5-b90a-9740-7a65f806fabc@gmail.com>
Date:   Fri, 9 Jun 2023 15:46:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
References: <cover.1683541225.git.mazziesaccount@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 0/5] Support ROHM BU27008 RGB sensor
In-Reply-To: <cover.1683541225.git.mazziesaccount@gmail.com>
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

On 5/8/23 13:30, Matti Vaittinen wrote:
> Add support for ROHM BU27008 RGB sensor.
> 
> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> and IR) with four configurable channels. Red and green being always
> available and two out of the rest three (blue, clear, IR) can be
> selected to be simultaneously measured. Typical application is adjusting
> LCD backlight of TVs, mobile phones and tablet PCs.
> 
> This series supports reading the RGBC and IR channels using IIO
> framework. However, only two of the BC+IR can be enabled at the same
> time. Series adds also support for scale and integration time
> configuration, where scale consists of impact of both the integration
> time and hardware gain. The gain and time support is backed by the newly
> introduced IIO GTS helper. This series depends on GTS helper patches
> added in BU27034 support series which is already merged in iio/togreg
> which this series is based on.

I started adding support for the BU27010 RGBC + flickering sensor to the 
BU27008 driver. While at it, I wrote some test(s) which try using also 
the 'insane' gain settings.

What I found out is that the scale setting for BU27008 is broken for 
smallest scales: 0.007812500 0.003906250 0.001953125

Reason is the accuracy.

The GTS helpers were made to use NANO scale accuracy. 999999999 is still 
fitting in an 32 bit integer after all :) This allows to handle greater 
"total gains".

The IIO scale setting interface towards the drivers seems to crop the 
val2 to micros (6 digits). This means that when user writes scale 
0.001953125 via sysfs - the driver will get val = 0, val2 = 1953. 
Currently the BU27008 driver (and probably also the BU27035 which I have 
not yet checked) will pass this value to GTS-helpers - which try to use 
it in computations where scale is tried to be converted to gain + 
integration time settings. This will fail because of rounding error this 
leads to.

Regarding the BU27* drivers I see this bug as annoying rather than 
urgent. Bug will appear only with the very smallest of scales - which 
means gains of magnitude ~1000X with the longest integration times - and 
as someone once said - 1000X gains sound pretty insane as errors will 
probably get quite big... Still, this is a bug - and it bothers me :)

What comes to fixing this - my first thought regarding "the right thing 
to do" would be improving the IIO scale setting accuracy. I wonder if 
there has been some heavy reason(s) to only provide 6 digits of val2? (I 
haven't yet looked how IIO formats the val2 from user input so I may be 
very ignorant here). For userland this fix should be relatively 
invisible - the write of for example 0.001953125 is seemingly successful 
from the user-space POV. IIO does not warn about the excess accuracy.

I am not saying this change would be risk-free. For sure there is an 
application somewhere passing this kind of 'high accuracy' scale values 
to sysfs. And it may be we have a driver which is going to have a hiccup 
is such value is passed to it - but I'd argue the driver should be fixed 
then. It's easier for a driver to drop the excess digits by a division - 
than it is to generate the missing digits...

...which leads us to the other potential way of papering over this 
issue. We could go on defining a set of "magic scale values" in the 
bu27008 driver, namely the 1953, 3906 and 7812 - and when these are used 
as val2 just assume it means 001953125, 003906250 and 007812500 
respectively. This would be quick and simple fix - but it would also 
mean this is a driver specific hack.

Finally, we could dive into GTS helpers and drop the accuracy of those 
to MIRCO scale instead of the NANO. If this was to be done it might be 
best to change the BU27008 and BU27034 intensity channel scales to start 
from bigger integers. Yes, it would potentially break any existing user 
of those intensity channels - but I suspect the amount of such users is 
still 0.

Finally, if we really want to keep the accuracy of scales in micros and 
not support nanos, then we probably should adjust the available scales 
displaying to not accept IIO_VAL_INT_PLUS_NANO type lists...

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

