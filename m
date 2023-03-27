Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2576C9F42
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjC0JWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjC0JWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:22:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB2D210D;
        Mon, 27 Mar 2023 02:22:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h17so7928629wrt.8;
        Mon, 27 Mar 2023 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679908950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUDm94cuqNsQmZlVr5Y+d2/6iij4ZcYk5kPEnEDDj90=;
        b=QEgDqcZaOanHmPkYcMvtQjLd25vh2Hcskbrb1/CQe9v5ULDTQAYBJ1nWHcXNv357UJ
         LHLeu641aL/s3vrRIWsvuYjAczxPvk2gqGKYy733nRICuS1pbVaBKCqiErIu+xbeeG0L
         VUXiOULqEDakvBJXJPGNxpYw/CpcKvnJ0bOKgdiOn6+3r01CTfdSJ+mivVXo6Ps6iqFn
         BLGefqD+OwKBUMvotrqpQTNHqUOybagc1ohUeehXkHrEfA/FRUoNIzfuFwnut/AjMHID
         QHgRExtE4rsO+QTPtXZwNBhdumnQ60nvHmVj+lMVRzbbJ59UOxsPS96SNH5wHUWbYGZd
         CndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679908950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUDm94cuqNsQmZlVr5Y+d2/6iij4ZcYk5kPEnEDDj90=;
        b=2iHQHtUFwYNzBQoiRl2Iknowyrbl3lW/7tP9jYTmcEeHZ50vtWTfSJkW9rVwq6H3M2
         5wPwCRcr22bLRucf4AR2HjTnzf0eWgB3CU+L9zD6G5cDqeTCbC1BBu8s/oCXsRhV3Zij
         r9WSCRYcBrmsP0Nh/QpWAxPzL/X3pm5FtFj+u6JUefBSTV7G7x3hV0FdW8TFNxk0cNXv
         vxms05nqK7Fw9rGGTy3PZ4bXwuKEtgeIolSEqw6OMEN+QnK0gbOfsePOKOiTiLThWnWO
         26k7tqgzTXz228nUJK0JZeC8b+vc1BHzPKfQVo2ouEaeJO1+aXUMZctb395du/VgC2Dj
         rvcg==
X-Gm-Message-State: AAQBX9cVTn49zJuMlCDPNCL/hZFhVm3tY0Nw5XBCiKYziAzRa4AGKoKq
        wy6QdXhocEagQwXsodIfOmJRwV5iuKdKq89cD7Y=
X-Google-Smtp-Source: AKy350bTAlkSbVG8D7+r7I0dbIWroXFlbKeNyJfM2es7Xg1xOxIfCH3ajl/h50HA/pMaUlmhc0C3YmY+pHhkHde5AHE=
X-Received: by 2002:adf:f4c2:0:b0:2ce:ad3a:551d with SMTP id
 h2-20020adff4c2000000b002cead3a551dmr1777328wrp.2.1679908949646; Mon, 27 Mar
 2023 02:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
 <87cz4v2nr1.fsf@bloch.sibelius.xs4all.nl> <CABnpCuAqT-RtdmeaAqyB_CQkLa=vn8zxF_WkYRnj8FoGJLL=_Q@mail.gmail.com>
 <2874439.e9J7NaK4W3@diego>
In-Reply-To: <2874439.e9J7NaK4W3@diego>
From:   Shane Francis <bigbeeshane@gmail.com>
Date:   Mon, 27 Mar 2023 10:22:18 +0100
Message-ID: <CABnpCuBoM23msO0FikL33eDXYV2A4hNfsLkKhNiBs-DKJ5aKCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: clock: update rk3588 clock definitions
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

Hi

> when secure boot is involed, I'd think the whole device will be sufficien=
tly
> locked down to also disallow custom kernels. Otherwise that wouldn't be
> a secure boot. (bootloader verifying kernel image + rootfs)

If you look at the Android boot chain this is the case when in "locked mode=
",
uboot (or whatever 2nd stage you have) validates the boot / kernel image
either via public key or symmetric key. However in unlocked mode using
something like the "unlock" fastboot command this check is disabled but
the signature validation of the uboot / second stage is still enforced. AFA=
IK
this process is part of the Android device validation suite.

Yes Android is only one OS vendor, however it is probably the largest use
case for this SoC.

> So we're in a pickle here. As Peter said, _if_ we wanted to change the id=
s
> one more time, to allow those vendor uboot hacks, now would be the time.
>
> But then als Mark said, the current bindings are used already in a number
> of different places and aren't broken per se.

I agree, its a bit messy, I was just raising the patch now just in case it =
was
something that could be changed with relative ease, if thats not the case t=
he
patch can be ignored

Thanks In Advance

On Mon, Mar 27, 2023 at 10:07=E2=80=AFAM Heiko St=C3=BCbner <heiko@sntech.d=
e> wrote:
>
> Am Montag, 27. M=C3=A4rz 2023, 01:40:34 CEST schrieb Shane Francis:
> > Hi Mark
> >
> > > That code makes absolutely no sense.  This tries to transplant
> > > phandles from one DTB into another DTB?  Mainline U-Boot has no code
> > > like that.  I think this is just broken beyond repair.
> >
> > Yeah its a dumb bit of code, my concern when looking at the R6S is that
> > when devices look to get mainline support that are unable to change to
> > another uboot build (such as when secure boot is involved)
>
> when secure boot is involed, I'd think the whole device will be sufficien=
tly
> locked down to also disallow custom kernels. Otherwise that wouldn't be
> a secure boot. (bootloader verifying kernel image + rootfs)
>
>
> > those will
> > have a hard time as this ABI breakage ship would have departed long
> > ago. And the RK3588 support is very new..... I thought about raising it
> > now.
> >
> > The question for me is how (in the future) will devices with this SoC
> > and cannot modify their uboot make use of the mainline kernel ?
> >
> > I have looked into undoing this clock configuration during early kernel
> > boot but the SoC seems to hard lock.
> >
> > I apologise if raising this patch was a bad idea but like I stated to
> > Krzysztof I am just onboarding this device as a hobby. However
> > from an outside standpoint having a potential breakage like this
> > because starting from 0 looked cleaner than 1 seems a bit odd to
> > me.
>
> In general we can't be on the "whim" of SoC vendors.
>
> I.e. dt-bindings are supposed to be reviewed _first_ and not invented in
> some SoC vendor's dark basement. That did work in the past with Rockchip
> but in recent years they did loose most of their upstream momentum it
> seems.
>
> Because vendors often invent unpractical or even conflicting bindings on
> their own.
>
> So we're in a pickle here. As Peter said, _if_ we wanted to change the id=
s
> one more time, to allow those vendor uboot hacks, now would be the time.
>
> But then als Mark said, the current bindings are used already in a number
> of different places and aren't broken per se.
>
> So I guess either decision possibility is bad ;-)
>
>
> Heiko
>
>
> > On Sun, Mar 26, 2023 at 10:42=E2=80=AFPM Mark Kettenis <mark.kettenis@x=
s4all.nl> wrote:
> > >
> > > > Date: Sun, 26 Mar 2023 22:02:39 +0200
> > > > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > >
> > > > On 26/03/2023 19:51, Shane Francis wrote:
> > > > >> Bootloader also does not use mainline DTS, so where is exactly t=
he problem?
> > > > >
> > > > > In this case uboot does load the target DTB, and it seems a commo=
n
> > > > > function in rockchips
> > > > > downstream boot process, see :
> > > > >
> > > > > https://github.com/rockchip-linux/u-boot/blob/ef1dd650042f61915c4=
859ecc94623a09a3529fa/arch/arm/mach-rockchip/kernel_dtb.c#L70
> > > > >
> > >
> > > That code makes absolutely no sense.  This tries to transplant
> > > phandles from one DTB into another DTB?  Mainline U-Boot has no code
> > > like that.  I think this is just broken beyond repair.
> > >
> > > > U-Boot comes with its own DTB, so what does it means "loads the tar=
get
> > > > DTB"? From where? The one appended to the kernel zImage? No, it can=
not...
> > > >
> > > > Any component which operates on mainline DTB must conform to the
> > > > bindings (with respect to the ABI), thus your arguments here mean y=
ou
> > > > are not allowed to change ABI in the future. Never. This change,
> > > > assuming original binding was broken, could be warranted.
> > >
> > > The current mainline binding isn't broken; 0 is a perfectly fine cloc=
k
> > > index.  The RK3588 clock bindings are already used by U-Boot (too lat=
e
> > > to fix for the 2023.4 release happening in a few days) and OpenBSD
> > > (too late to fix for the 7.3 release that will happen a few weeks).
> > > Changing the clock binding will just create more chaos.
> > >
> > > <rant>
> > >
> > > What is broken here is the development process.  Rockchip shouldn't b=
e
> > > maintaining these heavily modified forks of U-Boot and the Linux
> > > kernel.  But at the same time mainline Linux developers should not be
> > > asking for arbitrary changes to the device tree bindings just to
> > > satisfy some unwritten rules.  The clock bindings were originaly
> > > submitted with clock numbers identical to those that Rockchip uses:
> > >
> > >   https://lore.kernel.org/all/20220623160329.239501-2-sebastian.reich=
el@collabora.com/
> > >
> > > but then changed because a reviewer wanted them to start at 0 and
> > > didn't want any holes:
> > >
> > >   https://lore.kernel.org/all/0841741a-22f6-40f6-c745-6065dfdbcb1d@li=
naro.org/
> > >
> > > This isn't the first example where this happened.  And it invariably
> > > leads to confusion and breakage in projects that try to follow the
> > > mainline Linux device tree bindings.
> > >
> > > </rant>
> >
>
>
>
>
