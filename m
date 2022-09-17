Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE3A5BB893
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 15:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIQNy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIQNyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 09:54:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4806E165B5;
        Sat, 17 Sep 2022 06:54:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m3so15411230eda.12;
        Sat, 17 Sep 2022 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=S8ftARU60tpfYXAboRA44VH/3e+C8sah/bpLiKM70U8=;
        b=ZgiLtA2E0Apsg51vOkHTElykpsyPfsNWzzNlENbY8oFVxW5m+wza3rul8ckxchebcZ
         nixXk0Q6zK40zWdWyEQd8dggL4C0G8EyPGo9WpySczXFIXekgHmKBj+Sst8QdWd1GKA/
         bWATgVIM/PYWQ5VrO/V+2reufQ8P2KdXRFudKwUfA7v5GHgLsDON7v+bZsfDcbvdtc1B
         FfjEq3PkOnm8raNQ8da1pCJg23AEzwxeJ5KpBU7rj8oxsB9J6q16z7nB+nf2wjZn3zIq
         eyX+iygw2cUltDkhtJQVjqj4MPNJ9yTgAq71iX+6VLwRTpt2p/yYy7xZHJ8UPU8sVyWG
         9/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=S8ftARU60tpfYXAboRA44VH/3e+C8sah/bpLiKM70U8=;
        b=SEr+EEQ17i8KNWXW9GFI4fN0PyuI5BkGf4ivjKwrd9433V9wMjTQlt4YREIM0S7rvV
         URiDgIIBmK/hcDlQlW28qVPkzNXKXHVV7hdHZK7SB9FSYIJk90TXNcIK1bCRwT+EDpbN
         KRymJRaShu1JzMOYhmv5175oHKctg8ZLuJV8MbXTSvOpLppTHEmBIt3AXEof6J8BhiUE
         ArUa+rBImLsO+ZXuaymHYrND9kl4r8o4tNNSs21LsiTz+7/KfTL35wb8Ou+TqiYX/fc7
         m71KHf8chlS6KBrlTkfx83V5cMmDGz+6CG22jDDQrWcH1XcqmYoud0jCFyKj32h72K+2
         ADSA==
X-Gm-Message-State: ACrzQf0i1LphGGlVvb51c93BnliBIYFwKU4ZIiu+lp7jm96EuM6Ok1CT
        1hzyQDgW3OOkNF9qBxt7Njc=
X-Google-Smtp-Source: AMsMyM5ztim6e7zUfdUo/c57LvKbQ8EqsbvJKbEpy4l+xiSNfLs0WO6m4gGePnAwbG6WnskJI806yg==
X-Received: by 2002:a05:6402:b45:b0:44e:a071:2b3b with SMTP id bx5-20020a0564020b4500b0044ea0712b3bmr8055690edb.95.1663422891326;
        Sat, 17 Sep 2022 06:54:51 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.gmail.com with ESMTPSA id b25-20020a17090630d900b007803083a36asm5624155ejb.115.2022.09.17.06.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 06:54:50 -0700 (PDT)
Date:   Sat, 17 Sep 2022 13:50:03 +0000
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: k3566-quartz64-a: adds sata
 variant
Message-ID: <YyXQi9wfudMvUkgU@lab.hqhome163.com>
References: <YySdhiqZgXpl0q/g@lab.hqhome163.com>
 <CAMdYzYovjSMZgpWd+ATWsv2piNc2ZtnKfB1cTBukvsnfG41g_w@mail.gmail.com>
 <14722513.tv2OnDr8pf@phil>
 <CAMdYzYp1SYVCxOKwHspvDXoqkAxUj1hTY6J7EeRabKxD5Nrj1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYp1SYVCxOKwHspvDXoqkAxUj1hTY6J7EeRabKxD5Nrj1w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

Thank you for the valuable details you added to this thread.

If I understand correctly, the SATA controller has hardware-related 
issues if some electrical conditions are met by devices connected to 
the two SoC ports.

Here an example of a faulty device layout would be helpful.

But I guess this is not such common situation if you just connect a 
SATA device to the board.



On Sat, Sep 17, 2022 at 07:23:39AM -0400, Peter Geis wrote:
> On Sat, Sep 17, 2022 at 2:42 AM Heiko Stuebner <heiko@sntech.de> wrote:
> 
> Good Morning Heiko,
> 
> 
> >
> > Hi Peter,
> >
> > Am Samstag, 17. September 2022, 03:40:07 CEST schrieb Peter Geis:
> > > On Fri, Sep 16, 2022 at 12:06 PM Alessandro Carminati
> > > <alessandro.carminati@gmail.com> wrote:
> > > >
> > > > The Quartz64 board is built upon Rockchip RK3566.
> > > > Rockchip RK3566 has two combo phys.
> > > > The first connects USB3 and SATA ctrl1, and the second PCIe lane and SATA
> > > > ctrl2.
> > > > The second combo phy is hardwired to the PCIe slot, where for the first,
> > > > the hardware on the board provides both the USB3 connector and the SATA
> > > > connector.
> > > > This DT allows the users to switch the combo phy to the SATA connector.
> > >
> > > Good Evening,
> > >
> > > NACK to this whole series. Neither works correctly in the hardware as
> > > is,
> >
> > Just for my understanding for the future, sata not working is that a bug
> > in the soc or the board?
> 
> This is a board level problem. Attempting to build a device that had
> both ports electrically connected without a switch chip created a
> device where neither worked correctly. The SATA controllers themselves
> are amazing. I've used both nvme and sata m2 drives on the model b for
> example.
> 
> >
> > > and USB3 was decided to be left enabled as the SATA port will be
> > > removed completely in the next revision.
> >
> > That is good to know. Thanks for the heads up :-)
> 
> In regards to this sort of stuff in the future, we're working on
> fragment overlay support in U-Boot to work around the kernel's lack of
> support. If I remember correctly EDK2 will be implementing the switch
> in firmware as well. Devices that support both (at least ones I
> maintain) will have both in the dts, with the less likely use case
> left disabled. End users can simply switch which one is enabled if
> they want.

Reading through your message, I have the impression that you are trying 
to solve the problem on the firmware side.
I want to express my admiration for this effort.
I think that this is the right approach to solve this kind of problem, 
and that the more appropriate place to be for device trees is on the 
firmware and not in the kernel.
Currently, the kernel includes a considerable amount of device trees, 
and the Quarttz64-a device tree is already upstream.

As I understand, there's currently an effort to standardize the already 
existing device trees and give direction to the newcomers.
In a recent interaction with Krzysztof Kozlowski, I learned the already 
existing device trees are likely not to respond to these regulations. 

Sooner or later, each upstream device tree will need to be adjusted, 
and the currently upstreamed quartz64-a DTS is one of these.

I understand you are working on the u-boot side, possibly the EDK2. 
They alone are more than 80% of all the firmware running at this moment, 
but there's still a non-neglectable number of boots that use something 
else.

All these words to say: 

* Krzysztof confirmed the upstreamed device tree for the quartz64 needs 
  to be adjusted to meet the device trees node name regulation.

* The work needed to add the SATA support is minimal.

* Having this SATA DTS is not completely useless since numerous SATA 
  configurations work smoothly.

I am willing to work on this patch to make it suitable to be upstreamed.

Regards
Alessandro

> 
> Very Respectfully,
> Peter
> 
> >
> > Heiko
> >
> >
> > > > Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> > > > ---
> > > >  arch/arm64/boot/dts/rockchip/Makefile                   | 1 +
> > > >  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts | 9 +++++++++
> > > >  2 files changed, 10 insertions(+)
> > > >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
> > > >
> > > > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > > > index 8c843f6fc3cc..1d5dd91d1a34 100644
> > > > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > > > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > > > @@ -60,6 +60,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a-usb3.dts
> > > > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a-sata.dts
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-roc-pc.dtb
> > > >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
> > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
> > > > new file mode 100644
> > > > index 000000000000..8620df7ec01e
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
> > > > @@ -0,0 +1,9 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "rk3566-quartz64-a.dtsi"
> > > > +
> > > > +&sata1 {
> > > > +       status = "okay";
> > > > +};
> > > > --
> > > > 2.34.1
> > > >
> > > >
> > > > _______________________________________________
> > > > Linux-rockchip mailing list
> > > > Linux-rockchip@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> > >
> >
> >
> >
> >
