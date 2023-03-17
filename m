Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7766BEBB4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCQOst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjCQOsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:48:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F95714494;
        Fri, 17 Mar 2023 07:48:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g17so6812122lfv.4;
        Fri, 17 Mar 2023 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679064522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VK1KzYy/5H9i6btPM5HWOxKnSEHvSGLN6SWcopPygK0=;
        b=pLeS9TSnE8P0Qkcrg6o7ZWG9Z4SvbtpUvOdJRVKRXu6kmScSQoAiHA/bG4hlrZO9bh
         AHOg+1cBNQ9o4/c5jQhHZ7LVm59N+VmET5YP07ZwDaz57kR3E0m/Vktjl/IZ76rMxFQp
         W6e63r2ozSkFVVs4CL9fE8t4NIIQItJWsvnHhWVL1XXr4BeSAFoAFOtPjPpjMgrj2PpK
         9aHMYXxVFWrelQpnT0lT03q8r/4OstLcSu1PfSKP0LnMtfKEcpFSEjHbff5nAH4azhrw
         TBZhv9fi5LsPn8X0E1Ah4TGuHY+j8EzWnWjqIazsDxYbHfV3NGbB0b02wMpE/TIdYnS3
         Mbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679064522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VK1KzYy/5H9i6btPM5HWOxKnSEHvSGLN6SWcopPygK0=;
        b=DoAMXaCBpxOTUHqn9a/8Z7tLbiU/z8QwCADp8BH/oqL88xiky2swJ00wAvKoFaLV4J
         pjUICyhyOi9PKIiV+86emg/cH8K5um7bSFBhcUlPpDNyOZMrzRr2XSmmYjp4GjRl/VhE
         6v6OgTqbjtPd4TLrkI4teZlIKSqYpML0/CC1KDL+J3ZTLzjfv+wxASem+hgC5vrZLQho
         X5Hz3dvcZ8KssacRrGwUWxWMoA8/WNNhMACg+6oXhC28nHTRbTP4pn5AypEinuf0HAJc
         yqQYRNhkWSwXuNj3ygqg5KEoOobQiumi2q+qmmkKzLsTOPIzhi+WY1t7fUzhzMp+hLnk
         YhMA==
X-Gm-Message-State: AO0yUKX6nHJwF1CsranQZgAWQjvrkKZ0dmMSrbxhCmw/bUZwJJIAvcIZ
        0q0EzpBiPlhBeefiHbipttI=
X-Google-Smtp-Source: AK7set/kAC3oqG4fJA2gLuteYlSIvY5IZlT7p8MeOMk6ANibXIrPuykNaLUzEBu8ztRXgUkDaWN/+A==
X-Received: by 2002:ac2:59d0:0:b0:4de:7a23:23e2 with SMTP id x16-20020ac259d0000000b004de7a2323e2mr4174573lfn.21.1679064522463;
        Fri, 17 Mar 2023 07:48:42 -0700 (PDT)
Received: from [172.16.196.130] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f22-20020a2e3816000000b00295b0eead9asm442065lja.114.2023.03.17.07.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 07:48:42 -0700 (PDT)
Message-ID: <61169e7e-b839-eb06-046f-e41bd3eabcec@gmail.com>
Date:   Fri, 17 Mar 2023 16:48:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 7/8] iio: light: ROHM BU27034 Ambient Light Sensor
Content-Language: en-US, en-GB
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1679062529.git.mazziesaccount@gmail.com>
 <feb7e7f6785e93af45510ca22d9aecc28e436cf2.1679062529.git.mazziesaccount@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <feb7e7f6785e93af45510ca22d9aecc28e436cf2.1679062529.git.mazziesaccount@gmail.com>
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

On 3/17/23 16:44, Matti Vaittinen wrote:
> ROHM BU27034 is an ambient light sensor with 3 channels and 3 photo diodes
> capable of detecting a very wide range of illuminance. Typical application
> is adjusting LCD and backlight power of TVs and mobile phones.
> 
> Add initial  support for the ROHM BU27034 ambient light sensor.
> 
> NOTE:
> 	- Driver exposes 4 channels. One IIO_LIGHT channel providing the
> 	  calculated lux values based on measured data from diodes #0 and
> 	  #1. In addition, 3 IIO_INTENSITY channels are emitting the raw
> 	  register data from all diodes for more intense user-space
> 	  computations.
> 	- Sensor has GAIN values that can be adjusted from 1x to 4096x.
> 	- Sensor has adjustible measurement times of 5, 55, 100, 200 and
> 	  400 mS. Driver does not support 5 mS which has special
> 	  limitations.
> 	- Driver exposes standard 'scale' adjustment which is
> 	  implemented by:
> 		1) Trying to adjust only the GAIN
> 		2) If GAIN adjustment alone can't provide requested
> 		   scale, adjusting both the time and the gain is
> 		   attempted.
> 	- Driver exposes writable INT_TIME property that can be used
> 	  for adjusting the measurement time. Time adjustment will also
> 	  cause the driver to try to adjust the GAIN so that the
> 	  overall scale is kept as close to the original as possible.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Changes
> v3 => v4:
> - use min_t() for division by zero check
> - adapt to new GTS helper header location
> - calculate luxes not milli luxes
> - drop scale for PROCESSED channel
> - comment improvements
> - do not allow changing gain (scale) for channel 2.
>     - 'tie' channel 2 scale to channel 0 scale
>       This is because channel 0 and channel 2 GAIN settings share part of
>       the bits in the register. This means that setting one will also
>       impact the other. The v3 of the patches attempted to work-around
>       this by only disallowing the channel 2 gain setting to set the bits
>       which were shared with channel 0 gain. This does not work because
>       setting channel 0 gain (which was allowed to set also the shared
>       bits) could result unsupported bit combinations for channel 2 gain.
>       Thus it is safest to always set also the channel 2 gain to same
>       value as channel 0 gain.
> - Use the correct integration time (55 mS) in the gain table as the
>    calcuations can be done based on the time multiplier.
> - styling
> 

And right after sending out this version I realized I forgot to run 
spell-checker for the comments. I will do that for v5 - please bear with me.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

