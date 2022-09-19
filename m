Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739825BC3A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiISHsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiISHse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:48:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48711E3F7;
        Mon, 19 Sep 2022 00:48:32 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id s6so34368527lfo.7;
        Mon, 19 Sep 2022 00:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date;
        bh=f/ohHw0zwXo9hGYKmLMjHmAZtp10Il5h/1fQAo577NY=;
        b=kwtD+gKqOWXSABgVUNVVKnDc1POQMG799g9EpbcabwJbiLT6TRc5joUW1mHjVglvOo
         43iAYBtgWvsrHUCF7CZHI3YeVKKUy2RXSvlXPe+GE1CPKUlejamL3Kb3lPnw34bkbpYH
         A3skcPEPKHHPgOGNrDfXdvBKH0Lga5lBltxPUaNOmi8beSVA7GWPNLGp5G8PbMfJ/BEA
         xQrjXtxOBI61oxQCmlzQse8mbfimnOHDZWu801jfmIHb70ru8EmsoAee+S1GAgvL1Zrv
         oOu0b6M/ZziAm71uvVSkTXxsT/hOJzPeiSzsukBEvKDRe/TEVDv3S6FCYNU0X2z+5j7Y
         i3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date;
        bh=f/ohHw0zwXo9hGYKmLMjHmAZtp10Il5h/1fQAo577NY=;
        b=vS0ERzp8fCAQXzmSvdeuG1z1l1ik7URZcU2Y18SgiYA73QINs6OZrTzzsZsMeCVRYg
         dr1aVZhONGxV0h4lHUsdF5oGbR2ItuSn9/7DZTIExRW4GigMN63+Z9O89W2N8qU+ovQ5
         OxVu+qd9yKslzFC70HSn9dHx45AJx8PlaeY7a4wlviQhnPEDEVHI6nIjvjeJQRpijejG
         lNd730w7F4ogMuQVh8+AiEmnE5ZwGaPZlxbCOg3gADs7VNO8Rx5ZJBkWKF+yyKujxAUp
         AtLO81CY4WJ8ly6XL0lUGupv8w8RwZhIazbLLVBBczl7SJfw2Bls99lFDAB7ulxz5Vl6
         ws4w==
X-Gm-Message-State: ACrzQf3XUMJlc6u69eQoVJsT9sTUKJSY+nWh2ebjBc4sLozweEDhONdt
        +htIB6YLeAnJDaAxTEjuR5JdOFMQM4pOaA==
X-Google-Smtp-Source: AMsMyM6HkvoeuUq4NLAon0UbWyTo51sAKFY3An/yw5j4g/uCTIiz4KeCSCh3prxFsKI6EDhiUhYhjA==
X-Received: by 2002:a05:6512:3184:b0:49d:6b29:201c with SMTP id i4-20020a056512318400b0049d6b29201cmr5676011lfe.363.1663573710408;
        Mon, 19 Sep 2022 00:48:30 -0700 (PDT)
Received: from razdolb ([37.1.42.233])
        by smtp.gmail.com with ESMTPSA id x20-20020a2e9c94000000b0026c5579c64csm40910lji.89.2022.09.19.00.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 00:48:29 -0700 (PDT)
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <CAPY8ntCA3jbpBOiNfoft58sHPeTFSLoLop0VUmkOCWP3cX_rdw@mail.gmail.com>
 <87czbwp9xx.fsf@gmail.com> <YygOzWAHyoP+KwTv@paasikivi.fi.intel.com>
User-agent: mu4e 1.9.0; emacs 28.2
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>, Jimmy Su <jimmy.su@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Arec Kao <arec.kao@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add Omnivision OV4689 image sensor driver
Date:   Mon, 19 Sep 2022 10:01:06 +0300
In-reply-to: <YygOzWAHyoP+KwTv@paasikivi.fi.intel.com>
Message-ID: <87wn9zreic.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Sakari,

On 2022-09-19 at 06:40 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> Hi Mikhail,
>
> On Fri, Sep 16, 2022 at 12:27:42AM +0300, Mikhail Rudenko wrote:
>>
>> Hi Dave,
>>
>> On 2022-09-14 at 10:58 +01, Dave Stevenson <dave.stevenson@raspberrypi.com> wrote:
>> > Hi Mikhail
>> >
>> > On Sun, 11 Sept 2022 at 21:02, Mikhail Rudenko <mike.rudenko@gmail.com> wrote:
>> >>
>> >> Hello,
>> >>
>> >> this series implements support for Omnivision OV4689 image
>> >> sensor. The Omnivision OV4689 is a high performance, 1/3-inch, 4
>> >> megapixel image sensor. Ihis chip supports high frame rate speeds up
>> >> to 90 fps at 2688x1520 resolution. It is programmable through an I2C
>> >> interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
>> >> connection.
>> >>
>> >> The driver is based on Rockchip BSP kernel [1]. It implements 4-lane CSI-2
>> >> and single 2688x1520 @ 30 fps mode. The driver was tested on Rockchip
>> >> 3399-based FriendlyElec NanoPi M4 board with MCAM400 camera
>> >> module.
>> >> While porting the driver, I stumbled upon two issues:
[snip]
>> >> (2) The original driver exposes analog gain range 0x0 - 0x7ff, but the
>> >> gain is not linear across that range. Instead, it is piecewise linear
>> >> (and discontinuous). 0x0-0xff register values result in 0x-2x gain,
>> >> 0x100-0x1ff to 0x-4x, 0x300-0x3ff to 0x-8x, and 0x700-0x7ff to 0x-16x,
>> >> with more linear segments in between. Rockchip's camera engine code
>> >> chooses one of the above segments depenging on the desired gain
>> >> value. The question is, how should we proceed keeping in mind
>> >> libcamera use case? Should the whole 0x0-0x7ff be exposed as-is and
>> >> libcamera will do the mapping, or the driver will do the mapping
>> >> itself and expose some logical gain units not tied to the actual gain
>> >> register value? Meanwhile, this driver conservatively exposes only
>> >> 0x0-0xf8 gain register range.
>> >
>> > The datasheet linked above says "for the gain formula, please contact
>> > your local OmniVision FAE" :-(
>> > I would assume that the range is from 1x rather than 0x - people
>> > rarely want a totally black image that 0x would give. Or is it ranges
>> > of 1x - 2x, 2x - 4x, 4x - 8x, and 8x - 16x?
>>
>> A picture is worth a thousand words, so I've attached the results of my
>> experimentation with the gain register. They were obtained with Rockchip
>> 3399, with AEC, AGC and black level subtraction disabled. The image was
>> converted from 10-bit RGGB to 8-bit YUV 4:2:0 by the Rockchip ISP.
>
> Based on that it looks like their medication may have been a little too
> strong.
>
> Could this be implemented so that the control value would be linear linear
> but its range would correspond 1x--16x values?
>
> libcamera will be able to cope with that.
>

According to the following fragment of the Rockchip camera engine sensor
configuration file for ov4689 [1]

    <Linear index="1" type="double" size="[4 7]">
       [1 2 128 0 1 128 255
        2 4 64 -248 1 376 504
        4 8 32 -756 1 884 1012
        8 16 16 -1784 1 1912 2040]
    </Linear>,

it uses gain register value range 128-255 for gain 1x-2x, 376-504 for
gain 2x-4x, 884-1024 for 4x-8x, and 1912-2040 for 8x-16x. Do you suggest
to implement this calculation in the sensor driver and expose some
linear "logical" gain to userspace (ranging, e.g., 128-2048 for gains
1x-16x)?


[1] https://github.com/aosp-rockchip/android_external_camera_engine_rkaiq/blob/quartz64/iqfiles/ov4689_JSD3425-C1_JSD3425-C1-36IRC-4M-F20.xml

--
Best regards,
Mikhail
