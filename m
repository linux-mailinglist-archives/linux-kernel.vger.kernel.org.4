Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2815D5BB7FC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 13:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiIQLX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 07:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIQLXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 07:23:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB58729C82;
        Sat, 17 Sep 2022 04:23:51 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h8so32938435wrf.3;
        Sat, 17 Sep 2022 04:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BLaZsI5cHIlw7RVl5F8MBLXrX/g4UKCzX1CL0avGDbA=;
        b=d0K6CztBq5gRQLYp4DDG2Mlix0A/5s/oWvW19VjAaWyceu4IANY1RW+rCcgOZYTvYr
         XqeEwLTRjXYXediwKovvIMz4DltaXuzOxU148WbLacW8solEY56bdil+cBqnSssDgv4G
         e3n0dokQ6pl0m2M4jVAFi0KrVQ6GdCYPWbyfnYbEuNW5PaW4Rklwg6psnfwmIxxQHAWf
         QcvPaWrMxHlAL4tRgHmBmBymzna10Gcvc95Ny7qnpl3k5qwsWB0H5c39xgIKDtRik3HH
         6/OR7AOgaG5xweuPbZSjPrvL/GX9dBoy4I0UWTjqhogXPJPzevKi2uEefiUgSHaG8/0s
         Wq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BLaZsI5cHIlw7RVl5F8MBLXrX/g4UKCzX1CL0avGDbA=;
        b=RMsO16x6I5Pe5ZnUzN0EjB5ng5n4fro951V/FfqFYNy0wez/PE7Rt1Cjy4efBayixz
         aFNWzCYnHw4Gqryg2ZFjZpHJkaSfK2BJ7YKXUpAD/HTY1ycYrIyivJmPIdMy/TvMlsMW
         4JS81pQsYfXuOtN6BMJygYXt2olIS2CUGHQt4j6IXijZMo9532/YhzlkoDQaNV2OX00N
         /izKY8kB4rHzTLid+M8ylpALSUnzjeT60fUiyBZWvgvr89urZvANYEkgyNHmTEj02PYT
         a7wVbDjj1c1nbmcGrqLeCVEmTmfyehZ98xg7MBVKoQIT7+o1SBMuX9foY8wjWKnODQYO
         tADQ==
X-Gm-Message-State: ACrzQf3ixrl2y7sqPaNZFI+rRVnZNdOm6jvxSgfi/FaBd5Z+GYV1L08q
        REYNEZ3RiTTtquk8k2Alz/rBPO2QwzysCrk5B5+xfIc0KIg=
X-Google-Smtp-Source: AMsMyM4G6Rwfjo82H5KT2z/QKbJZY4Yd5IU+QdU93M2HfI/3kfSMUgjqS6/NG3y7+nRyTw6QE0jw40pFqFl2ZxbazYg=
X-Received: by 2002:adf:e806:0:b0:22a:f5c6:6954 with SMTP id
 o6-20020adfe806000000b0022af5c66954mr310007wrm.539.1663413830274; Sat, 17 Sep
 2022 04:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <YySdhiqZgXpl0q/g@lab.hqhome163.com> <CAMdYzYovjSMZgpWd+ATWsv2piNc2ZtnKfB1cTBukvsnfG41g_w@mail.gmail.com>
 <14722513.tv2OnDr8pf@phil>
In-Reply-To: <14722513.tv2OnDr8pf@phil>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 17 Sep 2022 07:23:39 -0400
Message-ID: <CAMdYzYp1SYVCxOKwHspvDXoqkAxUj1hTY6J7EeRabKxD5Nrj1w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: k3566-quartz64-a: adds sata variant
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Alessandro Carminati <alessandro.carminati@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
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

On Sat, Sep 17, 2022 at 2:42 AM Heiko Stuebner <heiko@sntech.de> wrote:

Good Morning Heiko,


>
> Hi Peter,
>
> Am Samstag, 17. September 2022, 03:40:07 CEST schrieb Peter Geis:
> > On Fri, Sep 16, 2022 at 12:06 PM Alessandro Carminati
> > <alessandro.carminati@gmail.com> wrote:
> > >
> > > The Quartz64 board is built upon Rockchip RK3566.
> > > Rockchip RK3566 has two combo phys.
> > > The first connects USB3 and SATA ctrl1, and the second PCIe lane and SATA
> > > ctrl2.
> > > The second combo phy is hardwired to the PCIe slot, where for the first,
> > > the hardware on the board provides both the USB3 connector and the SATA
> > > connector.
> > > This DT allows the users to switch the combo phy to the SATA connector.
> >
> > Good Evening,
> >
> > NACK to this whole series. Neither works correctly in the hardware as
> > is,
>
> Just for my understanding for the future, sata not working is that a bug
> in the soc or the board?

This is a board level problem. Attempting to build a device that had
both ports electrically connected without a switch chip created a
device where neither worked correctly. The SATA controllers themselves
are amazing. I've used both nvme and sata m2 drives on the model b for
example.

>
> > and USB3 was decided to be left enabled as the SATA port will be
> > removed completely in the next revision.
>
> That is good to know. Thanks for the heads up :-)

In regards to this sort of stuff in the future, we're working on
fragment overlay support in U-Boot to work around the kernel's lack of
support. If I remember correctly EDK2 will be implementing the switch
in firmware as well. Devices that support both (at least ones I
maintain) will have both in the dts, with the less likely use case
left disabled. End users can simply switch which one is enabled if
they want.

Very Respectfully,
Peter

>
> Heiko
>
>
> > > Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/Makefile                   | 1 +
> > >  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts | 9 +++++++++
> > >  2 files changed, 10 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > > index 8c843f6fc3cc..1d5dd91d1a34 100644
> > > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > > @@ -60,6 +60,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a-usb3.dts
> > > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a-sata.dts
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-roc-pc.dtb
> > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
> > > new file mode 100644
> > > index 000000000000..8620df7ec01e
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
> > > @@ -0,0 +1,9 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "rk3566-quartz64-a.dtsi"
> > > +
> > > +&sata1 {
> > > +       status = "okay";
> > > +};
> > > --
> > > 2.34.1
> > >
> > >
> > > _______________________________________________
> > > Linux-rockchip mailing list
> > > Linux-rockchip@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> >
>
>
>
>
