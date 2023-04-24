Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DECF6EC38F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 04:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjDXCXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 22:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXCXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 22:23:13 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A5AE60;
        Sun, 23 Apr 2023 19:23:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a50cb65c92so32842395ad.0;
        Sun, 23 Apr 2023 19:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682302991; x=1684894991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S0sFVoFyu2eJh9f1TXlvcKTjZ/nv79PKMNTv2RFnZY=;
        b=dOXATqLaT7rQ1M4ciT7u3JXsPfBIfBRRdEiYC15lo5pMdt+5qmBCy0TZyy7UdCQetF
         5MMtg5nKw/QuJlfVb52QI+t4IpQPOyyrQcV7Zv5JT+0bdCKxcSEuCeSGOuE+cEKZFovq
         Aku8IA4l8EAvgTt4NoLvhL1tXwuA8/tGRw93AyN8UqPzXeqdNbSMfiQ3s0KnTuG5OakJ
         OjBasQmhsfqtPh8uwfPXkdPfnzEcPxg4wCg7Cc3Qz/jXcdpSBSzNmnxmDQ6nDD9l49ul
         fbrPbUsESw3FhrHpBlgHoae/kZTCHs01K6qxQ0ExhH1DtE3OG8r24dk80EnTa7SZmeIS
         vmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682302991; x=1684894991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3S0sFVoFyu2eJh9f1TXlvcKTjZ/nv79PKMNTv2RFnZY=;
        b=RA2lY4iBUH0WKvOr8kxUap7kz69jPSEvRmanJuPf+E1IZaagYLj6p3zc3a0My/G+ON
         GzDI2v4lY9e6MUAo4bJDU7XbAgccHyi4E0uML6zz1GWrbjGoxEwI+IBurgR7mptfhSaW
         Ep0/YP06p6bEg97FB1MQfSZLxmzSrssoWr4qkE5jQVuOpaaJYfdQu0CIphJEymgdIugK
         2kuMQ5f2BF4nO9+r3yy3WwiLBpE4u6ZXB4ShvOdjsWgQWdel8dZG4HncPyCLsZL+FAWJ
         uMhcVEWak7V5BaseyHsHecFmuEmyf7QRildo8JaxxVUnTn0XkfoWmK6qrf3u0294zF0X
         nqgQ==
X-Gm-Message-State: AAQBX9ffXhHyZNEC+qHPgHcCJITsjsBKCm0Vm8WMZuOvQnu3v7R3DGP2
        Mn6J2iXokbzbgV5bBTWmblo6gO4nsPYnA2CSWKE=
X-Google-Smtp-Source: AKy350ZEgpH9cb1IfDjHHfT7SEB07X/oaT+/CXJHGA6AUie2M0cMMp+VyS3ptYN+5vgwiuejw4NApCesJZ2MYx69omI=
X-Received: by 2002:a17:903:2987:b0:1a6:bb7b:7a40 with SMTP id
 lm7-20020a170903298700b001a6bb7b7a40mr12123123plb.64.1682302990569; Sun, 23
 Apr 2023 19:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230423212656.1381002-1-aford173@gmail.com> <20230424004706.GL21943@pendragon.ideasonboard.com>
In-Reply-To: <20230424004706.GL21943@pendragon.ideasonboard.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 23 Apr 2023 21:22:59 -0500
Message-ID: <CAHCN7xKM38RgFW9DAc9co_xcC7NjfymcVEwzu3LMwgYxytCpLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mn: Enable CSI and ISI Nodes
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 7:46=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Adam,
>
> Thank you for the patch.
>
> On Sun, Apr 23, 2023 at 04:26:55PM -0500, Adam Ford wrote:
> > The CSI in the imx8mn is the same as what is used in the imx8mm,
> > but it's routed to the ISI on the Nano. Add both the ISI and CSI
> > nodes, and pointing them to each other. Since the CSI capture is
> > dependent on an attached camera, mark both ISI and CSI as
> > disabled by default.
>
> I'd then write the subject line as "Add CSI and ISI nodes".

That makes sense, especially since I disabled them by default.
>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mn.dtsi
> > index 8be8f090e8b8..102550b41f22 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > @@ -1104,6 +1104,24 @@ dsim_from_lcdif: endpoint {
> >                               };
> >                       };
> >
> > +                     isi: isi@32e20000 {
> > +                             compatible =3D "fsl,imx8mn-isi";
> > +                             reg =3D <0x32e20000 0x100>;
>
> The i.MX8MN reference manual documents the ISI registers block size to
> be 64kB. Should we use the same here, even if all the registers we need
> are within the first 256 bytes ?

I can do that.
>
> > +                             interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL=
_HIGH>;
> > +                             clocks =3D <&clk IMX8MN_CLK_DISP_AXI_ROOT=
>,
> > +                                      <&clk IMX8MN_CLK_DISP_APB_ROOT>;
> > +                             clock-names =3D "axi", "apb";
> > +                             fsl,blk-ctrl =3D <&disp_blk_ctrl>;
> > +                             power-domains =3D <&disp_blk_ctrl IMX8MN_=
DISPBLK_PD_ISI>;
> > +                             status =3D "disabled";
> > +
> > +                             port {
> > +                                     isi_in: endpoint {
> > +                                             remote-endpoint =3D <&mip=
i_csi_out>;
> > +                                     };
> > +                             };
>
> This will fail to validate against the ISI DT binding, as they require a
> "ports" node. When a single port is present using a "port" node directly
> is fine from an OF graph point of view, but to avoid too much complexity
> in the ISI binding the consensus was to always require a "ports" node
> for the ISI.


Argh!  I pulled from the wrong test repo.  I remember the discussion
from a few months back.  I'll fix it and the others when I submit V2.

>
> > +                     };
> > +
> >                       disp_blk_ctrl: blk-ctrl@32e28000 {
> >                               compatible =3D "fsl,imx8mn-disp-blk-ctrl"=
, "syscon";
> >                               reg =3D <0x32e28000 0x100>;
> > @@ -1147,6 +1165,42 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
> >                               #power-domain-cells =3D <1>;
> >                       };
> >
> > +                     mipi_csi: mipi-csi@32e30000 {
> > +                             compatible =3D "fsl,imx8mm-mipi-csi2";
> > +                             reg =3D <0x32e30000 0x1000>;
> > +                             interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL=
_HIGH>;
> > +                             assigned-clocks =3D <&clk IMX8MN_CLK_CAME=
RA_PIXEL>,
> > +                                               <&clk IMX8MN_CLK_CSI1_P=
HY_REF>;
> > +                             assigned-clock-parents =3D <&clk IMX8MN_S=
YS_PLL2_1000M>,
> > +                                                       <&clk IMX8MN_SY=
S_PLL2_1000M>;
> > +                             assigned-clock-rates =3D <333000000>;
> > +                             clock-frequency =3D <333000000>;
> > +                             clocks =3D <&clk IMX8MN_CLK_DISP_APB_ROOT=
>,
> > +                                      <&clk IMX8MN_CLK_CAMERA_PIXEL>,
> > +                                      <&clk IMX8MN_CLK_CSI1_PHY_REF>,
> > +                                      <&clk IMX8MN_CLK_DISP_AXI_ROOT>;
> > +                             clock-names =3D "pclk", "wrap", "phy", "a=
xi";
> > +                             power-domains =3D <&disp_blk_ctrl IMX8MN_=
DISPBLK_PD_MIPI_CSI>;
> > +                             status =3D "disabled";
> > +
> > +                             ports {
> > +                                     #address-cells =3D <1>;
> > +                                     #size-cells =3D <0>;
> > +
> > +                                     port@0 {
> > +                                             reg =3D <0>;
> > +                                     };
> > +
> > +                                     port@1 {
> > +                                             reg =3D <1>;
> > +
> > +                                             mipi_csi_out: endpoint {
> > +                                                     remote-endpoint =
=3D <&isi_in>;
> > +                                             };
> > +                                     };
> > +                             };
> > +                     };
> > +
> >                       usbotg1: usb@32e40000 {
> >                               compatible =3D "fsl,imx8mn-usb", "fsl,imx=
7d-usb", "fsl,imx27-usb";
> >                               reg =3D <0x32e40000 0x200>;
>
> --
> Regards,
>
> Laurent Pinchart
