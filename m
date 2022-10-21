Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165306077DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJUNI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJUNIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:08:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB52F26C471;
        Fri, 21 Oct 2022 06:08:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id e18so2132382wmq.3;
        Fri, 21 Oct 2022 06:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w5IGDZHN/CzCs8J5irp7AqEafQA7vlzOfvm7jaH8xE=;
        b=bhQOYmxexa9vcMNY7f78i5ha+zTT3a2Vv4MsUnF82D0HvibUEN4zRMYmqR5rGVXvTI
         9fwYUnrhyRuCCzImKrvxlV4WAgXqriq0c3hJCaAXhBLgRPSrRoQVNP8piLeWp+vKsER6
         +qQjAaJrbR5r7cuvoQatxe0bTR+T+umDiNOx8KUYOR8V0HBKM1Me8jU5bCmoYRZIdqzj
         GKDdeVTHyizow40it+Tj2qVMABN2Ynay14ns5JGNSiJxHzGYeiTFeX92UVKlPjleAsvw
         1EiymDUMiT5JvlCywRdWVuGWGhRYhDuqcTFDcqqW2AqorsGUiP9qC/yG4AlxoAYVuHlg
         lU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w5IGDZHN/CzCs8J5irp7AqEafQA7vlzOfvm7jaH8xE=;
        b=xswbYJQB1FgC3UcQJ+HamHkbnN+JbKeeJCUUfoOiy4hfxenNBwYkk0ltZ9LfdhpV+X
         7MqSSQvKR5GuzN9euq+mXnIjJGwa/2NYbEh4IJhHxeek1K8D9mXIcZlvxU3yWH2p3iam
         OU5caHdW9FzXGLl5KMSfvUxo+E5GyJLkf10yuv39pFN/1DnKQnXUNE0yjysx/xy6ja01
         p/3Rx5rpXp1S/3Ga7NRhSSgxxRmnSU8RVMFPVoqwPymEU0S2YmqxNhEyQZV7YoDmLHyx
         Z1zzg1CxTOYF0EYNWbUcFf3PXp1xbnq4VoCLqwuqrXhfLIRcAwUSnvujltMALIdBZVwn
         RJEQ==
X-Gm-Message-State: ACrzQf0QUePXpW5oDAXAinJ/gamuFOLm99MmlpSkmBPuRxmqBZ3au2x7
        EXUlEvk6bMxyirFKbLaMlmYoCD98wLxlHOS9vRk=
X-Google-Smtp-Source: AMsMyM4XqVmcNdfMNYBKQD4bcysHkBSI/9iC8QCL8PLLRq5HDkNIwRoYuZjEoN3utPebgr79gA9A8EKMirdjwaWmxbY=
X-Received: by 2002:a05:600c:5122:b0:3c6:fcce:e4e2 with SMTP id
 o34-20020a05600c512200b003c6fccee4e2mr13937287wms.65.1666357681720; Fri, 21
 Oct 2022 06:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221005085439.740992-1-megi@xff.cz> <CAMdYzYrEXEqOmMeozGBbAAvrujZcOxLh4VYOmu5DSjPWTS-5zQ@mail.gmail.com>
 <20221005220812.4psu6kckej63yo2z@core> <4679102.Wku2Vz74k6@phil>
In-Reply-To: <4679102.Wku2Vz74k6@phil>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 21 Oct 2022 09:07:50 -0400
Message-ID: <CAMdYzYq3S2rR3Kb61irpV9xHYijNiJY0mkVnJwPrpXzxg_Zh9g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register map
 and ranges
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 7:56 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Donnerstag, 6. Oktober 2022, 00:08:12 CEST schrieb Ond=C5=99ej Jirman:
> > On Wed, Oct 05, 2022 at 07:42:54AM -0400, Peter Geis wrote:
> > > On Wed, Oct 5, 2022 at 4:54 AM Ondrej Jirman <megi@xff.cz> wrote:
> > > >
> > >
> > > Good Morning,
> > >
> > > > I have two Realtek PCIe wifi cards connected over the 4 port PCIe s=
wtich
> > > > to Quartz64-A. The cards fail to work, when nvme SSD is connected a=
t the
> > > > same time to the bridge. Without nvme connected, cards work fine. T=
he
> > > > issue seems to be related to mixed use of devices which make use of=
 I/O
> > > > ranges and memory ranges.
> > > >
> > > > This patch changes I/O, MEM and config mappings so that config and =
I/O
> > > > mappings use the 0xf4000000 outbound address space, and MEM range u=
ses
> > > > the whole 0x300000000 outbound space.
> > > >
> > > > This is simialar to how BSP does the mappings.
> > >
> > > This change was very recent in the BSP stuff (Jan 2022):
> > > https://github.com/rockchip-linux/kernel/commit/cfab7abefc4093daa379f=
bd90a1e7ac1a484332b
> > > A few other interesting changes there as well. They added a 32 bit
> > > window in the lower range and made the entire upper range a 64 bit
> > > relocatable (why?) and prefetchable window. They also set the viewpor=
t
> > > number to 8. The dt-binding says this is autodetected, but I wonder i=
f
> > > the value is being detected correctly.
> > >
> > > It looks like it is dependent in BSP on a backported change from main=
line:
> > > https://github.com/rockchip-linux/kernel/commit/50a01d3c10a6212f66364=
575a3c8f66c07f41591
> > >
> > > Can someone weigh in why the dw core has config in the reg node
> > > instead of ranges?
> > >
> > > >
> > > > I changed num-ob-windows to value detected by the kernel so if for =
whatever
> > > > reason the kernel ever starts respecting this DT property, it would=
 not
> > > > switch to sharing I/O and CFG spaces via a single iATU mapping for
> > > > no reason.
> > >
> > > This worries me that this value may be being detected incorrectly,
> > > they set it to this for a reason. It's not unheard of for Rockchip to
> > > need to override what they encode in the silicon.
> >
> > I just noticed that you may be thinking that BSP does some detection. I=
t does
> > not. It just uses either value from DT or hardcoded value 2 in the code=
.
> >
> > https://github.com/rockchip-linux/kernel/blob/develop-4.19/drivers/pci/=
controller/dwc/pcie-designware-host.c#L450
>
> @Peter or other people in the recipient list with more PCIe
> experience than me, can someone provide some more judgement
> on this topic?

Good Morning Heiko,

Apologies for just getting to this, I'm still in the middle of moving
and just got my lab set back up.

I've tested this patch series and it leads to the same regression with
NVMe drives. A loop of md5sum on two identical 4GB random files
produces the following results:
d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
fad97e91da8d4fd554c895cafa89809b  test-rand2.img
2d56a7baa05c38535f4c19a2b371f90a  test-rand.img
74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
25cfcfecf4dd529e4e9fbbe2be482053  test-rand.img
74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
b9637505bf88ed725f6d03deb7065dab  test-rand.img
f7437e88d524ea92e097db51dce1c60d  test-rand2.img

Before this patch series:
d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img

Though I do love where this patch is going and would like to see if it
can be made to work, in its current form it does not.

Very Respectfully,
Peter Geis

>
> Thanks
> Heiko
>
>
> > > Very Respectfully,
> > > Peter Geis
> > >
> > > >
> > > > This change to the regs/ranges makes the issue go away and both nvm=
e and
> > > > wifi cards work when connected at the same time to the bridge. I te=
sted
> > > > the nvme with large amount of reads/writes, both behind the PCIe br=
idge
> > > > and when directly connected to Quartz64-A board.
> > > >
> > > > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > > > ---
> > > > BSP for reference: https://github.com/rockchip-linux/kernel/blob/de=
velop-4.19/arch/arm64/boot/dts/rockchip/rk3568.dtsi#L2370
> > > >
> > > > v2:
> > > > - change ranges to use 0x300000000 fully for MEM and make use of
> > > >   the 0xf4000000 outbound range for IO and config
> > > > - full retest with/without the switch
> > > > - if lscpi/dmesg is useful in the future for comparison, see:
> > > >   https://xff.cz/kernels/random/quartz64a-pcie/
> > > >
> > > > I used this script for the tests:
> > > >
> > > > #!/bin/bash
> > > >
> > > > OUT=3D/mnt/data
> > > > n=3D8
> > > >
> > > > test -f /tmp/test.dat || \
> > > >     dd if=3D/dev/urandom of=3D/tmp/test.dat bs=3D1M count=3D1024
> > > > md5sum /tmp/test.dat
> > > >
> > > > i=3D0
> > > > while test $i -lt $n
> > > > do
> > > >     dd if=3D/tmp/test.dat of=3D$OUT/test$i.dat bs=3D4M oflag=3Ddire=
ct
> > > >
> > > >     i=3D$(($i+1))
> > > > done
> > > >
> > > > i=3D0
> > > > while test $i -lt $n
> > > > do
> > > >     dd if=3D$OUT/test$i.dat bs=3D4M iflag=3Ddirect | md5sum
> > > >
> > > >     i=3D$(($i+1))
> > > > done
> > > >
> > > >
> > > >  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/=
boot/dts/rockchip/rk356x.dtsi
> > > > index 319981c3e9f7..99fd9543fc6f 100644
> > > > --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > > > +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> > > > @@ -855,7 +855,8 @@ pcie2x1: pcie@fe260000 {
> > > >                 compatible =3D "rockchip,rk3568-pcie";
> > > >                 reg =3D <0x3 0xc0000000 0x0 0x00400000>,
> > > >                       <0x0 0xfe260000 0x0 0x00010000>,
> > > > -                     <0x3 0x3f000000 0x0 0x01000000>;
> > > > +                     <0x0 0xf4000000 0x0 0x01f00000>;
> > > > +
> > > >                 reg-names =3D "dbi", "apb", "config";
> > > >                 interrupts =3D <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> > > >                              <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> > > > @@ -877,15 +878,15 @@ pcie2x1: pcie@fe260000 {
> > > >                                 <0 0 0 4 &pcie_intc 3>;
> > > >                 linux,pci-domain =3D <0>;
> > > >                 num-ib-windows =3D <6>;
> > > > -               num-ob-windows =3D <2>;
> > > > +               num-ob-windows =3D <8>;
> > > >                 max-link-speed =3D <2>;
> > > >                 msi-map =3D <0x0 &gic 0x0 0x1000>;
> > > >                 num-lanes =3D <1>;
> > > >                 phys =3D <&combphy2 PHY_TYPE_PCIE>;
> > > >                 phy-names =3D "pcie-phy";
> > > >                 power-domains =3D <&power RK3568_PD_PIPE>;
> > > > -               ranges =3D <0x01000000 0x0 0x3ef00000 0x3 0x3ef0000=
0 0x0 0x00100000
> > > > -                         0x02000000 0x0 0x00000000 0x3 0x00000000 =
0x0 0x3ef00000>;
> > > > +               ranges =3D <0x01000000 0x0 0x00000000 0x0 0xf5f0000=
0 0x0 0x00100000
> > > > +                         0x02000000 0x0 0x40000000 0x3 0x00000000 =
0x0 0x40000000>;
> > > >                 resets =3D <&cru SRST_PCIE20_POWERUP>;
> > > >                 reset-names =3D "pipe";
> > > >                 #address-cells =3D <3>;
> > > > --
> > > > 2.37.3
> > > >
> >
>
>
>
>
