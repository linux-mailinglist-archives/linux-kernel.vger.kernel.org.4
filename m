Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1450D5E66F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiIVPWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiIVPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:22:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7796BF3934;
        Thu, 22 Sep 2022 08:22:46 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k10so15262855lfm.4;
        Thu, 22 Sep 2022 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date;
        bh=msyaATLtpUDfZvwVWC8ZPLCBwSZQGSHnshMVyhYGes8=;
        b=kZi/1Hv/G80W/rHq3+4jlNbJ54Kb8VvUwidktU21hyNMMWbM6m6VZWiKKtJp06Ca1V
         +QqzRrfhRxw+2fUvorfvCClcoayBC5qjPokuYTs+WlXYAYN+IgTfOSMl8mEr+3ojd2q3
         mmF/dXLAV29hOkX1Bx/kKNpGUMThI/ug9eY09Dgq1Ug7ltdUIt6rNKu+mlUYxpnf7I5z
         a5b8oD5bMz8DNzCyMCG+Vls9raG8KqF7+frfhttVgFdkg7yUkEL9TgX+af7JJUDLHx0W
         UB9UHbF/IQdfGd8GvbeQHtAvlNB7Jwff324OgmpI0G0snephKghrxThrgqc/ESEGJ+UX
         84YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date;
        bh=msyaATLtpUDfZvwVWC8ZPLCBwSZQGSHnshMVyhYGes8=;
        b=FaNKrCM/PkLaQrYpNLQ/auJ5j+v8KQWlvqJltm4rZ1o0p35LVg1o9Zkh+7LQO8fwB8
         DlnKra2UmB+bijDioSorgSv1LqQFuAq8ZvIjcYB8yk91yy7N0JH9IjszdsFECFeEfv+v
         oOK5wWWJn6XDYEkR8dCQrAHnYSE8OKkGcINcSF4bFkLfTdDL0si3L7J6c2doHhpuajgO
         /wToqO0B5zcxaNwYDzNi7eWy3p3fnl/hMrG+a9DTgBX9lpU0D1wN4ujgoBPfrkZl4ZJH
         lGdz47zOGMrE54jZxpySvBhUr/Dl5xqeUvgeLmLchfETaG2om/s1gp3o5B/Y4DWSwVPP
         U1AA==
X-Gm-Message-State: ACrzQf0k+llrs2h/l3TPYvVMFleeKgo+Bfzq5wupa+r4XvXZu4k3Pq27
        +X57c4lxJrdU0ASpbHRohMSc6u6ybHgEQg==
X-Google-Smtp-Source: AMsMyM5uD/lskGwm00pj4BjSg1rG5nNlBcm71CQRBDo9usmvSH4VzWDnEdqkKBASaOSefSI8eWkIZg==
X-Received: by 2002:a19:dc1a:0:b0:494:903a:1fa8 with SMTP id t26-20020a19dc1a000000b00494903a1fa8mr1456167lfg.55.1663860164315;
        Thu, 22 Sep 2022 08:22:44 -0700 (PDT)
Received: from razdolb (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id a7-20020a19f807000000b0048b256bb005sm991307lff.49.2022.09.22.08.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:22:43 -0700 (PDT)
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
Date:   Thu, 22 Sep 2022 18:13:27 +0300
In-reply-to: <CAPY8ntAvos4Et4c5mAiw=6Wb4b53p2PLRX_Jw03bHckpD+e-sg@mail.gmail.com>
Message-ID: <87a66rjuwt.fsf@gmail.com>
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

Thanks for sharing this! Actually, I'm going to do some experimentation
with these registers next weekend, and post the result here.

> Just some thoughts.
>   Dave

--
Best regards,
Mikhail Rudenko
