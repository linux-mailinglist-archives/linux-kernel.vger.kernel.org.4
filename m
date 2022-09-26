Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090EB5EA780
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiIZNlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbiIZNlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:41:17 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A271C434;
        Mon, 26 Sep 2022 04:59:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j16so10475968lfg.1;
        Mon, 26 Sep 2022 04:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date;
        bh=3fiVLVcUh3+SOwnzqpQkLVBXvKCW+tSDz3lzhRyJRhg=;
        b=bvKY+SsKAFKb3wFvtZxUTed3ftokXw2fznOz+SCcktskCPmaTcWo0ezaKDPs/S60sM
         8eXadmXpFDl1oMo0gixgb6vHmEKls69dm8yidR9clQXU1TMLZQemDhOGb9XxaFsGqFS4
         WkE6vrFcfhcvbsanGTZsm9vRiibVeDIxpu7Tj307q9Osm3NaaCmkJM9YyBOqb1gDgyFM
         gd/To6dSrqcbY+82xNYsUWTgxlrZyecwqUps2fro83iNZp5JTlI2dq/7tjZvOzDRJiiK
         w+nPHY5CY+bFqbnvK1PLntwFbqfYQi3rjRecbi9UDXTfbF/x75ESvIFYaSYtuBPI9eIr
         pg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date;
        bh=3fiVLVcUh3+SOwnzqpQkLVBXvKCW+tSDz3lzhRyJRhg=;
        b=CqzPEFeanvzmfUZQeVZKhA5oF4jy/G5BX22cp2RdZiaiOC+G+ff2oYb45FjeC1+Fx5
         cDm53QX5jExZzfnlwJORuVhzmdFWRfIjOnp3UXBozaSEekGL8se55Qgp3Sv2gnyKuuBi
         l4euIUku2ZweLnmfYpioCrjHPb1gAqo96rFYvBV7DrRDNdKWGKSX6fYJGkIi76f81Mo6
         6CBCOdvL7PdXFLQsYtJtb3o98b7XZ6vR4i6zZkuqjeiADqbCnyd3LIlNPNao49kgKDj3
         1JBhf0zqGkOI3kh8XRjSAZ016E4EZxJ5w0zX33sT4r77+JDPIZoBd0ALNeq8rnuUx69Z
         AfNw==
X-Gm-Message-State: ACrzQf3IVlmYbhRnclMivb5iG+bt57x6mDJ/aRHH1aD9O1JyR4gj+c7d
        RjfZMbuLp2SQf0RjxN37KjDmWC4P8I4c4A==
X-Google-Smtp-Source: AMsMyM47afAmrhDLuMOBHK03jTZFu/MLH+pUdc7B0if/ersOtzwJ4i9RNObB8gOom2cn2UMQoeKllA==
X-Received: by 2002:a05:6512:1092:b0:4a1:de5f:1cc9 with SMTP id j18-20020a056512109200b004a1de5f1cc9mr771306lfg.219.1664193505993;
        Mon, 26 Sep 2022 04:58:25 -0700 (PDT)
Received: from razdolb (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id 4-20020a2e1544000000b0026c17415c11sm2331393ljv.99.2022.09.26.04.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 04:58:25 -0700 (PDT)
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <YywwqFi+2Nah2RpY@paasikivi.fi.intel.com>
 <CAPY8ntAvos4Et4c5mAiw=6Wb4b53p2PLRX_Jw03bHckpD+e-sg@mail.gmail.com>
User-agent: mu4e 1.9.0; emacs 28.2
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
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
Date:   Mon, 26 Sep 2022 13:47:57 +0300
In-reply-to: <CAPY8ntAvos4Et4c5mAiw=6Wb4b53p2PLRX_Jw03bHckpD+e-sg@mail.gmail.com>
Message-ID: <87wn9qmjog.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dave,

On 2022-09-22 at 11:43 +01, Dave Stevenson <dave.stevenson@raspberrypi.com>=
 wrote:

> Hi Mikhail & Sakari
>
> On Thu, 22 Sept 2022 at 10:55, Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
>>
>> Hi Mikhail,
>>
>> On Sun, Sep 11, 2022 at 11:01:33PM +0300, Mikhail Rudenko wrote:
>> > Hello,
>> >
>> > this series implements support for Omnivision OV4689 image
>> > sensor. The Omnivision OV4689 is a high performance, 1/3-inch, 4
>> > megapixel image sensor. Ihis chip supports high frame rate speeds up
>> > to 90 fps at 2688x1520 resolution. It is programmable through an I2C
>> > interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
>> > connection.
>> >
>> > The driver is based on Rockchip BSP kernel [1]. It implements 4-lane C=
SI-2
>> > and single 2688x1520 @ 30 fps mode. The driver was tested on Rockchip
>> > 3399-based FriendlyElec NanoPi M4 board with MCAM400 camera module.
>> >
>> > While porting the driver, I stumbled upon two issues:
>> >
>> > (1) In the original driver, horizontal total size (HTS) was set to a
>> > value (2584) lower then the frame width (2688), resulting in negative
>> > hblank. In this driver, I increased HTS to 2688, but fps dropped from
>> > 29.88 to 28.73. What is the preferred way to handle this?
>>
>> If horizontal total size is less than the frame width, something is
>> certainly wrong there. You can't have negative horizontal blanking. Neit=
her
>> it can be zero.
>
> Something certainly seems odd.
>
> To continue my thoughts from earlier in this patch set, Omnivision's
> Product Brief [1] states:
> The 1/3-inch OV4689 can capture full-resolution 4-megapixel high
> definition (HD) video at 90 frames per second (fps), 1080p HD at 120
> fps, and binned 720p HD at 180 fps
>
> The datasheet section 2.1 states:
> The OV4689 color image sensor is a high performance, 4 megapixel RAW
> image sensor that delivers 2688x1520 at 90 fps using OmniBSI-2=E2=84=A2 p=
ixel
> technology.
>
> So 4MP 90fps or 1080p120 should be achievable somehow.
>
> 2688x1520 @ 90fps is 367.7MPix/s, and that tallies quite nicely with
> table 2-9 listing the DAC PLL speed limitation of 360-378MHz. Exactly
> how that is then converted into PCLK or SCLK is unclear.
> Ideally you'd be able to contact an Omnivision FAE to confirm, but
> that means you need to be buying modules directly from them or
> otherwise have a business relationship.
> I do note that there is an NVidia Tegra driver for OV4689 at [2]. I
> wonder if analysis of that would reveal anything.
>
> I have just been looking at the ov9282 driver and the timings don't
> tally there either - configure it for 60fps and you get 30fps. The
> TIMING_HTS register appears to be in units of 2 pixels. The default is
> 0x2d8 (728 decimal) on a 1280x720 mode, but consider it as units of 2
> pixels and HTS of 1456 (1280 active and hblank of 176) does match up.
> It works in the general case too.
>
> Looking at the OV4689 datasheet again, the default for TIMING_HTS
> (0x380c/d) is 0x5f8 (1528 decimal) when HOUTPUT_SIZE (0x3808/9) is
> 0x1200 (4608 decimal). Whilst there are no guarantees that default
> register settings will stream in any sensible form, it does imply
> TIMING_HTS is not in units of 1 pixel, and potentially 4 pixels.
> From the Rockchip BSP driver it plainly does stream at 30 (or 29.88)
> fps with TIMING_HTS < HOUTPUT_SIZE, so a quick test of reducing it
> further would be worthwhile. What does the default of 0x2d8 give you
> as a frame rate, and are the images correct?
>

I've done some experimentation with timing registers and here is what I
found. First of all, there are two tables with default values of timing
registers (table 4-2 and table 6-9) in publicly available datasheet, and
they (values) are completely different. I'll just leave relevant parts
here for reference:

    Defaults (table 4-2):
    H_OUT_SIZE: 4608 (0x1200)
    V_OUT_SIZE: 3456 (0x0d80)
    HTS: 1528 (0x05f8)
    VTS: 3492 (0x0da4)

    Defaults (table 6-9):
    H_OUT_SIZE: 2688 (0xa80)
    V_OUT_SIZE: 1520 (0x5f0)
    HTS: 860 (0x35c)
    VTS: 1552 (0x610)

    Driver v2:
    H_OUT_SIZE: 2688
    V_OUT_SIZE: 1520
    HTS(0x380c/0d): 2688 (0x0a80)
    VTS(0x380e/0f): 1554 (0x0612)

Then I tried decreasing hts/vts and seeing what happens. The lowest
possible values before frame dropping started were hts=3D886 and vts=3D1552,
and the frame rate was 87.27 fps. Multiplying these three numbers yields
pixel rate of 120.0025e6.

So it looks like you are right, and the unit of HTS register is at least
4 pixels. Hence, in order to allow libcamera do correct timing
calculations, we should report pixel rate of 4*120e6 =3D=3D 480e6, and
HBLANK of (4*HTS - H_OUT_SIZE). For 30 fps and VTS of 1554, this yields
HTS=3D2574 and HBLANK =3D (4*2574 - 2688) =3D 7608.

In fact, the above is what I'm going to implement in v3. Comments,
anyone?

> Just some thoughts.
>   Dave
>
> [1] https://www.ovt.com/wp-content/uploads/2022/01/OV4689-PB-v1.7-WEB.pdf
> [2] https://github.com/bogsen/STLinux-Kernel/blob/master/drivers/media/pl=
atform/tegra/ov4689.c
>

--
Best regards,
Mikhail Rudenko
