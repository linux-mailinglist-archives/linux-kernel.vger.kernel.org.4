Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9786EC393
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 04:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjDXC3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 22:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDXC3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 22:29:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6EB1BE6;
        Sun, 23 Apr 2023 19:29:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517bfdf55c3so2336146a12.2;
        Sun, 23 Apr 2023 19:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682303356; x=1684895356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VydTYC4YKwhPstdajqkkdrOxIjqp+kYdmzBlpVWuf1A=;
        b=emHG3n3AgGC+Y+ZScZW3d5mSAK6+IrGox/lpskiNYNb7Yr3I2JSS5h7me033wyogHv
         /tHRnJNWWqKD4AlsniWTsjZQDwjZMilxQtYTq060kLBe4cNSJKjcjAflwYKkh1jEXrEE
         dKPwl0tlDJN9hhSHPDhjzxp8UG/iwvUIe2PzqiIJtEOD9+vOJ1Zgb6vmyNXaDs9CLk+D
         s6JiUdLwHoenj4DCgQjBeMCdafRrbtpW+kN4iuDvX6yO/3/br8ZcBC6wuBebC+ue4B8F
         laxENVQ6i6tQNdkGe9dP6Nzd9gZVduqjEQUaOqXI4enAyhqOiReO16gDdeecDKGnG5fh
         ephw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682303356; x=1684895356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VydTYC4YKwhPstdajqkkdrOxIjqp+kYdmzBlpVWuf1A=;
        b=GdIrNx8bX1k/vbOzun3f2DJs43Wmizy2xOhHdkreqRUWMOpCvTPev7PtWa+rjnGdJO
         CvA9nV//kkPy2JqsBmlrU8ckowCCRU62Y4VzFSwPmrs0zjDjhq0FwFCbpTxE5kN5o5pp
         qvtJFk+fH4hgQmYk0+NzeRW4lXRAvx77WesTESPuqgQ04v67nyEMYhfb1xtCeCuCGuO8
         cKEKUWjfnvATI++KMBxX0GReFRY4GPzyZDfMu8xqZxNh+AA6hhoJDYH3HVk+adjYILjv
         VBTmPv7sY7X+evk7Seso6bQyh9iRu1Vb0wf4ZMEPV7x71EbFBRExCfOTfHBN1hqH73lH
         NdpA==
X-Gm-Message-State: AAQBX9eJqolRi+GH9i051w9ZnWKM+hdhaHYqpr8dfUzoMHhO/UW7KK7N
        RCGuLIEGnzdFzw0mi6iGLlexosayAZU1aUigUFs=
X-Google-Smtp-Source: AKy350Yvk9JpaxFyE4EavKFrBdiGJgw25zs6Q62IXoMfhGNQTHFp9XIV1WmRopU5nrUH+sKnYi66GlH5frjclzPS29M=
X-Received: by 2002:a17:90b:3108:b0:247:7597:9382 with SMTP id
 gc8-20020a17090b310800b0024775979382mr12133821pjb.47.1682303355633; Sun, 23
 Apr 2023 19:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230423212656.1381002-1-aford173@gmail.com> <20230424004706.GL21943@pendragon.ideasonboard.com>
 <20230424004902.GN21943@pendragon.ideasonboard.com>
In-Reply-To: <20230424004902.GN21943@pendragon.ideasonboard.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 23 Apr 2023 21:29:04 -0500
Message-ID: <CAHCN7xLuJm6_WXFS3eXCf9wF1oyFJFPpEiBMV6UMCAqMRzAqbg@mail.gmail.com>
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

On Sun, Apr 23, 2023 at 7:48=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Apr 24, 2023 at 03:47:13AM +0300, Laurent Pinchart wrote:
> > Hi Adam,
>
> Another comment, do you plan to submit a patch with a camera DT overlay
> for an i.MX8MN board ?

My test repo has the ISI driver working with my OV5640 camera, but for
some reason the mainline doesn't work.  I'm trying to figure out
what's different between my test repo and the mainline.  I am not
planning on an overlay, as the Beacon baseboard was only designed with
one camera module, a TD Next 5640, based on the OV5640.  Newer boards
have been designed with a more generic camera interface, so I plan to
use overlays in the future, but for the imx8mn-beacon-kit, I was
planning to follow a similar design to what was done for the
imx8mm-beacon-kit.  They share the same baseboard with a different
processor on the system-on-module.

Do you want me to add a patch to the imx8mn-beacon-kit so there is at
least one user of this driver, once I get my error resolved?

adam
>
> > Thank you for the patch.
> >
> > On Sun, Apr 23, 2023 at 04:26:55PM -0500, Adam Ford wrote:
> > > The CSI in the imx8mn is the same as what is used in the imx8mm,
> > > but it's routed to the ISI on the Nano. Add both the ISI and CSI
> > > nodes, and pointing them to each other. Since the CSI capture is
> > > dependent on an attached camera, mark both ISI and CSI as
> > > disabled by default.
> >
> > I'd then write the subject line as "Add CSI and ISI nodes".
> >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/b=
oot/dts/freescale/imx8mn.dtsi
> > > index 8be8f090e8b8..102550b41f22 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > @@ -1104,6 +1104,24 @@ dsim_from_lcdif: endpoint {
> > >                             };
> > >                     };
> > >
> > > +                   isi: isi@32e20000 {
> > > +                           compatible =3D "fsl,imx8mn-isi";
> > > +                           reg =3D <0x32e20000 0x100>;
> >
> > The i.MX8MN reference manual documents the ISI registers block size to
> > be 64kB. Should we use the same here, even if all the registers we need
> > are within the first 256 bytes ?
> >
> > > +                           interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL=
_HIGH>;
> > > +                           clocks =3D <&clk IMX8MN_CLK_DISP_AXI_ROOT=
>,
> > > +                                    <&clk IMX8MN_CLK_DISP_APB_ROOT>;
> > > +                           clock-names =3D "axi", "apb";
> > > +                           fsl,blk-ctrl =3D <&disp_blk_ctrl>;
> > > +                           power-domains =3D <&disp_blk_ctrl IMX8MN_=
DISPBLK_PD_ISI>;
> > > +                           status =3D "disabled";
> > > +
> > > +                           port {
> > > +                                   isi_in: endpoint {
> > > +                                           remote-endpoint =3D <&mip=
i_csi_out>;
> > > +                                   };
> > > +                           };
> >
> > This will fail to validate against the ISI DT binding, as they require =
a
> > "ports" node. When a single port is present using a "port" node directl=
y
> > is fine from an OF graph point of view, but to avoid too much complexit=
y
> > in the ISI binding the consensus was to always require a "ports" node
> > for the ISI.
> >
> > > +                   };
> > > +
> > >                     disp_blk_ctrl: blk-ctrl@32e28000 {
> > >                             compatible =3D "fsl,imx8mn-disp-blk-ctrl"=
, "syscon";
> > >                             reg =3D <0x32e28000 0x100>;
> > > @@ -1147,6 +1165,42 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
> > >                             #power-domain-cells =3D <1>;
> > >                     };
> > >
> > > +                   mipi_csi: mipi-csi@32e30000 {
> > > +                           compatible =3D "fsl,imx8mm-mipi-csi2";
> > > +                           reg =3D <0x32e30000 0x1000>;
> > > +                           interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL=
_HIGH>;
> > > +                           assigned-clocks =3D <&clk IMX8MN_CLK_CAME=
RA_PIXEL>,
> > > +                                             <&clk IMX8MN_CLK_CSI1_P=
HY_REF>;
> > > +                           assigned-clock-parents =3D <&clk IMX8MN_S=
YS_PLL2_1000M>,
> > > +                                                     <&clk IMX8MN_SY=
S_PLL2_1000M>;
> > > +                           assigned-clock-rates =3D <333000000>;
> > > +                           clock-frequency =3D <333000000>;
> > > +                           clocks =3D <&clk IMX8MN_CLK_DISP_APB_ROOT=
>,
> > > +                                    <&clk IMX8MN_CLK_CAMERA_PIXEL>,
> > > +                                    <&clk IMX8MN_CLK_CSI1_PHY_REF>,
> > > +                                    <&clk IMX8MN_CLK_DISP_AXI_ROOT>;
> > > +                           clock-names =3D "pclk", "wrap", "phy", "a=
xi";
> > > +                           power-domains =3D <&disp_blk_ctrl IMX8MN_=
DISPBLK_PD_MIPI_CSI>;
> > > +                           status =3D "disabled";
> > > +
> > > +                           ports {
> > > +                                   #address-cells =3D <1>;
> > > +                                   #size-cells =3D <0>;
> > > +
> > > +                                   port@0 {
> > > +                                           reg =3D <0>;
> > > +                                   };
> > > +
> > > +                                   port@1 {
> > > +                                           reg =3D <1>;
> > > +
> > > +                                           mipi_csi_out: endpoint {
> > > +                                                   remote-endpoint =
=3D <&isi_in>;
> > > +                                           };
> > > +                                   };
> > > +                           };
> > > +                   };
> > > +
> > >                     usbotg1: usb@32e40000 {
> > >                             compatible =3D "fsl,imx8mn-usb", "fsl,imx=
7d-usb", "fsl,imx27-usb";
> > >                             reg =3D <0x32e40000 0x200>;
>
> --
> Regards,
>
> Laurent Pinchart
