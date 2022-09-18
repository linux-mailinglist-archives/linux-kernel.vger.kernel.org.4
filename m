Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7E25BBDCE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 14:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIRMkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 08:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIRMke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 08:40:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4FA205FE;
        Sun, 18 Sep 2022 05:40:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e18so12724970wmq.3;
        Sun, 18 Sep 2022 05:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kZN6GVMIS455JRGRpYDZw5MCrxQYeuEnGBclnyLhYxw=;
        b=UyKWNZjjvl5fgx8wA4aQekKjkps9nQyFoijyZ9xqkMjVZip3H9XGHQ7M7sqeeIeGOF
         Sz1gArsZ5FHYEoMmjYATclaz5MgDIjmk02Eih0JADuCERXkKeF1urOO5K/us+1wJV25Q
         UzkB9+JzI8Mlfb2nm3yvCtsvxlFw5fJegn+Mox+1tgZfwb1q+9r5weaGZ9LsvjMNg21n
         zIWVSh5Nwa9jxgN3gBQGQ0a3sim2df6TjO8kg64XbOVzYC8zJdpJ9wRQAylb5KUj2pJa
         60Q/kytiS70KNfLuFWYqFHHjLrjA0qusp9CmPcofHeYNsLyPg0S6NeHhDwsS6e1y18yX
         bvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kZN6GVMIS455JRGRpYDZw5MCrxQYeuEnGBclnyLhYxw=;
        b=Q2Vngmavn4/ZburHFUzNFTpiH9llcTuyNJNRRXdKnkcGwFtvtWfVRBaxzaRZMI9Oso
         438s28GomRJYJhdPcnQ18LVcgTGHbNTHKQTbUCaueSwQbq5Ya2Dvgq6l7npHyUB5+9Ks
         rYXcFdKp8qEEC3bRDfnkpCDerW5U2GlatX3nLL3AQs9G7/TBsKpTAKF76QpaL4qEofU5
         aYMy4kVwYUGU1hrHmI8jgG8FCCxuDHOv7bkFZzh3x2lyzwlN5Xu38Yv1Z43NljGfZIPO
         fp8E89liGP8aDzDF4sxSVrRrIqCeGPKV8WAq93AIVAkXYXaTuDvOB/n+hUacbrR8PDMF
         HSGA==
X-Gm-Message-State: ACgBeo3pNmCc7ZH5u7l1kYMQw6HGsACn6V9X1cLh5IKIG22aaFHXfriH
        7ZfVsNLtcm07YSXXH40aPbqadAxd5ytRk8YhLOjrMcbgFQd4uQ==
X-Google-Smtp-Source: AA6agR4DU4zptHavTMpPgSa1VB76Ujpo1JbVrGgJw9IBTk2oXqz8qbhDNAsfsKFN0qURMYuHHUMC3IMit+T+TvrBdAU=
X-Received: by 2002:a05:600c:2191:b0:3b4:868a:aad3 with SMTP id
 e17-20020a05600c219100b003b4868aaad3mr16171249wme.112.1663504830665; Sun, 18
 Sep 2022 05:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <YySdhiqZgXpl0q/g@lab.hqhome163.com> <CAMdYzYovjSMZgpWd+ATWsv2piNc2ZtnKfB1cTBukvsnfG41g_w@mail.gmail.com>
 <14722513.tv2OnDr8pf@phil> <CAMdYzYp1SYVCxOKwHspvDXoqkAxUj1hTY6J7EeRabKxD5Nrj1w@mail.gmail.com>
 <YyXQi9wfudMvUkgU@lab.hqhome163.com>
In-Reply-To: <YyXQi9wfudMvUkgU@lab.hqhome163.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sun, 18 Sep 2022 08:40:19 -0400
Message-ID: <CAMdYzYoohyKq5dOk+_vQ8Q+kPm6YOS+_E=DmpORxKabxH4QjTw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: k3566-quartz64-a: adds sata variant
To:     Alessandro Carminati <alessandro.carminati@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 9:54 AM Alessandro Carminati
<alessandro.carminati@gmail.com> wrote:
>
> Hello Peter,

Good Morning,

>
> Thank you for the valuable details you added to this thread.
>
> If I understand correctly, the SATA controller has hardware-related
> issues if some electrical conditions are met by devices connected to
> the two SoC ports.

No, the issue stems from having both ports electrically connected in
parallel. This creates impedance and capacitance issues that cause
ringing on the data lines when either is used. This sort of design
would work perfectly fine if a gpio controlled high speed data switch
was installed to isolate the ports. The USB3 port can be restored to
near full functionality by permanently destroying the SATA port, but
there's no way to easily do something similar to the USB3 port in
order to fix SATA.

>
> Here an example of a faulty device layout would be helpful.
>
> But I guess this is not such common situation if you just connect a
> SATA device to the board.
>
>
>
> On Sat, Sep 17, 2022 at 07:23:39AM -0400, Peter Geis wrote:
> > On Sat, Sep 17, 2022 at 2:42 AM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > Good Morning Heiko,
> >
> >
> > >
> > > Hi Peter,
> > >
> > > Am Samstag, 17. September 2022, 03:40:07 CEST schrieb Peter Geis:
> > > > On Fri, Sep 16, 2022 at 12:06 PM Alessandro Carminati
> > > > <alessandro.carminati@gmail.com> wrote:
> > > > >
> > > > > The Quartz64 board is built upon Rockchip RK3566.
> > > > > Rockchip RK3566 has two combo phys.
> > > > > The first connects USB3 and SATA ctrl1, and the second PCIe lane and SATA
> > > > > ctrl2.
> > > > > The second combo phy is hardwired to the PCIe slot, where for the first,
> > > > > the hardware on the board provides both the USB3 connector and the SATA
> > > > > connector.
> > > > > This DT allows the users to switch the combo phy to the SATA connector.
> > > >
> > > > Good Evening,
> > > >
> > > > NACK to this whole series. Neither works correctly in the hardware as
> > > > is,
> > >
> > > Just for my understanding for the future, sata not working is that a bug
> > > in the soc or the board?
> >
> > This is a board level problem. Attempting to build a device that had
> > both ports electrically connected without a switch chip created a
> > device where neither worked correctly. The SATA controllers themselves
> > are amazing. I've used both nvme and sata m2 drives on the model b for
> > example.
> >
> > >
> > > > and USB3 was decided to be left enabled as the SATA port will be
> > > > removed completely in the next revision.
> > >
> > > That is good to know. Thanks for the heads up :-)
> >
> > In regards to this sort of stuff in the future, we're working on
> > fragment overlay support in U-Boot to work around the kernel's lack of
> > support. If I remember correctly EDK2 will be implementing the switch
> > in firmware as well. Devices that support both (at least ones I
> > maintain) will have both in the dts, with the less likely use case
> > left disabled. End users can simply switch which one is enabled if
> > they want.
>
> Reading through your message, I have the impression that you are trying
> to solve the problem on the firmware side.
> I want to express my admiration for this effort.
> I think that this is the right approach to solve this kind of problem,
> and that the more appropriate place to be for device trees is on the
> firmware and not in the kernel.
> Currently, the kernel includes a considerable amount of device trees,
> and the Quarttz64-a device tree is already upstream.

The problem we are trying to solve in firmware is the end user
switching modes problem, not a device specific problem. The issue with
the SATA/USB port is a board level design problem that cannot be
solved in software.

>
> As I understand, there's currently an effort to standardize the already
> existing device trees and give direction to the newcomers.
> In a recent interaction with Krzysztof Kozlowski, I learned the already
> existing device trees are likely not to respond to these regulations.

This is simply not true. As the dt-bindings are improved blanket
updates are being applied to the existing trees. As of 5.19,
Quartz64-A had no dt-bindings check failures that didn't stem from
legacy dt-bindings that haven't been updated to yaml. I am aware of
the fixed-regulator not enforcing _regulator as a tail, as well as the
other deficiencies with the Quartz64-A dts. They are on my long list
of things to work on once I'm done moving.

>
> Sooner or later, each upstream device tree will need to be adjusted,
> and the currently upstreamed quartz64-a DTS is one of these.
>
> I understand you are working on the u-boot side, possibly the EDK2.
> They alone are more than 80% of all the firmware running at this moment,
> but there's still a non-neglectable number of boots that use something
> else.

Aside from EDK2, pretty much every other boot mechanism for rk356x is
either U-Boot or something based on U-Boot. Any fixes we apply to
U-Boot can easily trickle down to the others. EDK2 on the other hand
renders the dts moot as for the time being everything will be using
acpi and generic drivers.

>
> All these words to say:
>
> * Krzysztof confirmed the upstreamed device tree for the quartz64 needs
>   to be adjusted to meet the device trees node name regulation.

The dt-bindings for fixed-regulator should be fixed as part of this. I
certainly wouldn't complain about that being done standalone.

>
> * The work needed to add the SATA support is minimal.

This adds a second dts configuration to an already growing folder, and
will force a third configuration when the final hardware revision that
*isn't fundamentally broken* lands. If you want to add the SATA port
disabled to both phys I would be alright with that, as they work great
with simple conversion cables on every device I've tested. For the
record, my main problem with this series is the physical SATA port
will not exist in the final hardware revision of the Quartz64-A.

>
> * Having this SATA DTS is not completely useless since numerous SATA
>   configurations work smoothly.

There are many configurations that do not downshift correctly as well
and require manual intervention to work. Unfortunately you won't be
the one answering the angry end users that don't understand this
situation.

>
> I am willing to work on this patch to make it suitable to be upstreamed.

There is significantly more work that needs to happen in order for
rk356x (and rk3588 when the time comes) to be first class citizens.
For example, almost everyone booting rk356x is either using some
variation of the awful bsp u-boot or my hacked together mainline
u-boot. The edk2 port shows a lot of promise, but it's not even close
to fully functional. I won't complain about assistance with these
endeavors either.

Very Respectfully,
Peter

>
> Regards
> Alessandro
>
> >
> > Very Respectfully,
> > Peter
> >
> > >
> > > Heiko
> > >
> > >
> > > > > Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> > > > > ---
> > > > >  arch/arm64/boot/dts/rockchip/Makefile                   | 1 +
> > > > >  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts | 9 +++++++++
> > > > >  2 files changed, 10 insertions(+)
> > > > >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > > > > index 8c843f6fc3cc..1d5dd91d1a34 100644
> > > > > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > > > > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > > > > @@ -60,6 +60,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
> > > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
> > > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
> > > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a-usb3.dts
> > > > > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a-sata.dts
> > > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
> > > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-roc-pc.dtb
> > > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
> > > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
> > > > > new file mode 100644
> > > > > index 000000000000..8620df7ec01e
> > > > > --- /dev/null
> > > > > +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
> > > > > @@ -0,0 +1,9 @@
> > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > +
> > > > > +/dts-v1/;
> > > > > +
> > > > > +#include "rk3566-quartz64-a.dtsi"
> > > > > +
> > > > > +&sata1 {
> > > > > +       status = "okay";
> > > > > +};
> > > > > --
> > > > > 2.34.1
> > > > >
> > > > >
> > > > > _______________________________________________
> > > > > Linux-rockchip mailing list
> > > > > Linux-rockchip@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> > > >
> > >
> > >
> > >
> > >
