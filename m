Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1C16C98DA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 01:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCZXlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 19:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCZXlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 19:41:04 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525E45B82;
        Sun, 26 Mar 2023 16:40:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e18so6891388wra.9;
        Sun, 26 Mar 2023 16:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679874046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P41fXiXFzQYoqX8WCtNc6OtPCt6dlzfDHiVW1ftks0U=;
        b=DZKVCqFvXkjAFNIEU9tnPxhz0A1z7sr/xRDD2Osxcuw1UHLovyd2E/w73Azdi/v1IK
         T0TfaB1yBC6PUwJstC5M3tYU7B5MQCp499TsQ0XtYXkXZwTugsCwWPzkUoE6sYzIEaQ3
         92KUs/yO2PD8/eGX/ZzhBgoVJ5BNj8O9uT7S6ZwyPeyf29jvWORUgWDSfgVcyJvH/NJ6
         VTcZJHGpWcHMo6ocjv+j7JyStaVpbrbCWEfcsW+FROpcAMSr6mM/6D+CRrkoAXRQo16e
         IhqLMs6wAT1rX2RtPq0KzBRvrOK53PPkTT3Smz4GO6BJX8NNrhslcqA8+7F/yxqV+AZh
         lUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679874046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P41fXiXFzQYoqX8WCtNc6OtPCt6dlzfDHiVW1ftks0U=;
        b=0n0oDNM8HG9Sj/7tuef1YwUPq9Pvx4MktZ/KrroHeQFODcROfeVP4gVduPexH6ioCk
         cLf2niHIDXxfoeyTMXXOPHjAH9O6jLJQuH761pjAbxw56U4Kbr5cR0iEI+AVVOeQUVlr
         CuEGpuaaBRlKoQT2tMhwtbvMfl+Qa6u70z/gA2sOFztigGNb45XcpkUBjVhBrWcJzn53
         FUYv2fvyc402iVSCRadSbQ55YxyqsAQ6iSzduxi4WgMaXH3n67k6h5T0X8YrNgrRocpq
         XCL611tZAOW1R0onis8+gM4Q+1IbW+D9WIiFNq3Ryf5ADznAdS4YmGJUqzuGMbOe9DWg
         zuVA==
X-Gm-Message-State: AAQBX9e2ljOMbufqfEFbBALPMOegvewbp6r4FcaavSXaVUjy57ISIrP0
        /vaVDwNkijYmRd8ZG3/152iWxTL8w1MFsWV38EbiSyyDTZ2QPw==
X-Google-Smtp-Source: AKy350a2D12GsQXmTxLDNWt04UP2ULZuKv1vaMcFRNA1UNw3Jpqtnb9v04YeMlvUtB7IqpW3VFKFRrAUR8ppjFgh+S0=
X-Received: by 2002:adf:ec82:0:b0:2c7:1745:77ec with SMTP id
 z2-20020adfec82000000b002c7174577ecmr1956907wrn.2.1679874045661; Sun, 26 Mar
 2023 16:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
 <20230326001535.149539-2-bigbeeshane@gmail.com> <10930783-e1dd-5e75-a2cc-a09af862d949@linaro.org>
 <CABnpCuCzdbWTTp1Gc6wWPsB80J5GYw1QzKtZzzyEYU456E=1JA@mail.gmail.com>
 <1b9c8e19-10f2-824d-9b50-51e7a9287bb1@linaro.org> <CABnpCuAWm7jh19JKukOquPnZCwHoJispgDPGJzjYy6T_BZSnbg@mail.gmail.com>
 <717bfba9-1d70-ef09-9193-853a57117926@linaro.org> <CABnpCuA7V9ti6BOoz+3Mq-f=PwgxL2K7rOhjo6tJ4QquSZbaSA@mail.gmail.com>
 <03ec1aac-3c6d-892f-fad9-f386a5d4d10e@linaro.org> <87cz4v2nr1.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87cz4v2nr1.fsf@bloch.sibelius.xs4all.nl>
From:   Shane Francis <bigbeeshane@gmail.com>
Date:   Mon, 27 Mar 2023 00:40:34 +0100
Message-ID: <CABnpCuAqT-RtdmeaAqyB_CQkLa=vn8zxF_WkYRnj8FoGJLL=_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: clock: update rk3588 clock definitions
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

> That code makes absolutely no sense.  This tries to transplant
> phandles from one DTB into another DTB?  Mainline U-Boot has no code
> like that.  I think this is just broken beyond repair.

Yeah its a dumb bit of code, my concern when looking at the R6S is that
when devices look to get mainline support that are unable to change to
another uboot build (such as when secure boot is involved) those will
have a hard time as this ABI breakage ship would have departed long
ago. And the RK3588 support is very new..... I thought about raising it
now.

The question for me is how (in the future) will devices with this SoC
and cannot modify their uboot make use of the mainline kernel ?

I have looked into undoing this clock configuration during early kernel
boot but the SoC seems to hard lock.

I apologise if raising this patch was a bad idea but like I stated to
Krzysztof I am just onboarding this device as a hobby. However
from an outside standpoint having a potential breakage like this
because starting from 0 looked cleaner than 1 seems a bit odd to
me.

Regards

On Sun, Mar 26, 2023 at 10:42=E2=80=AFPM Mark Kettenis <mark.kettenis@xs4al=
l.nl> wrote:
>
> > Date: Sun, 26 Mar 2023 22:02:39 +0200
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > On 26/03/2023 19:51, Shane Francis wrote:
> > >> Bootloader also does not use mainline DTS, so where is exactly the p=
roblem?
> > >
> > > In this case uboot does load the target DTB, and it seems a common
> > > function in rockchips
> > > downstream boot process, see :
> > >
> > > https://github.com/rockchip-linux/u-boot/blob/ef1dd650042f61915c4859e=
cc94623a09a3529fa/arch/arm/mach-rockchip/kernel_dtb.c#L70
> > >
>
> That code makes absolutely no sense.  This tries to transplant
> phandles from one DTB into another DTB?  Mainline U-Boot has no code
> like that.  I think this is just broken beyond repair.
>
> > U-Boot comes with its own DTB, so what does it means "loads the target
> > DTB"? From where? The one appended to the kernel zImage? No, it cannot.=
..
> >
> > Any component which operates on mainline DTB must conform to the
> > bindings (with respect to the ABI), thus your arguments here mean you
> > are not allowed to change ABI in the future. Never. This change,
> > assuming original binding was broken, could be warranted.
>
> The current mainline binding isn't broken; 0 is a perfectly fine clock
> index.  The RK3588 clock bindings are already used by U-Boot (too late
> to fix for the 2023.4 release happening in a few days) and OpenBSD
> (too late to fix for the 7.3 release that will happen a few weeks).
> Changing the clock binding will just create more chaos.
>
> <rant>
>
> What is broken here is the development process.  Rockchip shouldn't be
> maintaining these heavily modified forks of U-Boot and the Linux
> kernel.  But at the same time mainline Linux developers should not be
> asking for arbitrary changes to the device tree bindings just to
> satisfy some unwritten rules.  The clock bindings were originaly
> submitted with clock numbers identical to those that Rockchip uses:
>
>   https://lore.kernel.org/all/20220623160329.239501-2-sebastian.reichel@c=
ollabora.com/
>
> but then changed because a reviewer wanted them to start at 0 and
> didn't want any holes:
>
>   https://lore.kernel.org/all/0841741a-22f6-40f6-c745-6065dfdbcb1d@linaro=
.org/
>
> This isn't the first example where this happened.  And it invariably
> leads to confusion and breakage in projects that try to follow the
> mainline Linux device tree bindings.
>
> </rant>
