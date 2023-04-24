Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B71D6EC3E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 05:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjDXDRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 23:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDXDRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 23:17:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722DA1AB;
        Sun, 23 Apr 2023 20:17:14 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 70025D97;
        Mon, 24 Apr 2023 05:17:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1682306223;
        bh=ehdmYl/jaA6duul7znxRZsdS0F40ZUmXEBVHmkZxWF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTfFzLpCIRCxxio4G0I0pn2kajf45ooKjFhZputWACHgnl/0DCe34paVrenky94hq
         xwT/6mVfuGQLoUKNhRruAlf8vtklOE2QO55KZGI/Tyi3ZCvxTgir2KLyMrvZzIVZO8
         TWUjIqlihQR1kYvekTApN5H3Wxy/Waaja3dN+gn4=
Date:   Mon, 24 Apr 2023 06:17:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Adam Ford <aford173@gmail.com>
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
Subject: Re: [PATCH 1/2] arm64: dts: imx8mn: Enable CSI and ISI Nodes
Message-ID: <20230424031725.GB4652@pendragon.ideasonboard.com>
References: <20230423212656.1381002-1-aford173@gmail.com>
 <20230424004706.GL21943@pendragon.ideasonboard.com>
 <20230424004902.GN21943@pendragon.ideasonboard.com>
 <CAHCN7xLuJm6_WXFS3eXCf9wF1oyFJFPpEiBMV6UMCAqMRzAqbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xLuJm6_WXFS3eXCf9wF1oyFJFPpEiBMV6UMCAqMRzAqbg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 09:29:04PM -0500, Adam Ford wrote:
> On Sun, Apr 23, 2023 at 7:48 PM Laurent Pinchart wrote:
> > On Mon, Apr 24, 2023 at 03:47:13AM +0300, Laurent Pinchart wrote:
> > > Hi Adam,
> >
> > Another comment, do you plan to submit a patch with a camera DT overlay
> > for an i.MX8MN board ?
> 
> My test repo has the ISI driver working with my OV5640 camera, but for
> some reason the mainline doesn't work.  I'm trying to figure out
> what's different between my test repo and the mainline.  I am not
> planning on an overlay, as the Beacon baseboard was only designed with
> one camera module, a TD Next 5640, based on the OV5640.  Newer boards
> have been designed with a more generic camera interface, so I plan to
> use overlays in the future, but for the imx8mn-beacon-kit, I was
> planning to follow a similar design to what was done for the
> imx8mm-beacon-kit.  They share the same baseboard with a different
> processor on the system-on-module.
> 
> Do you want me to add a patch to the imx8mn-beacon-kit so there is at
> least one user of this driver, once I get my error resolved?

That would be nice.

> > > Thank you for the patch.
> > >
> > > On Sun, Apr 23, 2023 at 04:26:55PM -0500, Adam Ford wrote:
> > > > The CSI in the imx8mn is the same as what is used in the imx8mm,
> > > > but it's routed to the ISI on the Nano. Add both the ISI and CSI
> > > > nodes, and pointing them to each other. Since the CSI capture is
> > > > dependent on an attached camera, mark both ISI and CSI as
> > > > disabled by default.
> > >
> > > I'd then write the subject line as "Add CSI and ISI nodes".
> > >
> > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > index 8be8f090e8b8..102550b41f22 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > > > @@ -1104,6 +1104,24 @@ dsim_from_lcdif: endpoint {
> > > >                             };
> > > >                     };
> > > >
> > > > +                   isi: isi@32e20000 {
> > > > +                           compatible = "fsl,imx8mn-isi";
> > > > +                           reg = <0x32e20000 0x100>;
> > >
> > > The i.MX8MN reference manual documents the ISI registers block size to
> > > be 64kB. Should we use the same here, even if all the registers we need
> > > are within the first 256 bytes ?
> > >
> > > > +                           interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> > > > +                           clocks = <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
> > > > +                                    <&clk IMX8MN_CLK_DISP_APB_ROOT>;
> > > > +                           clock-names = "axi", "apb";
> > > > +                           fsl,blk-ctrl = <&disp_blk_ctrl>;
> > > > +                           power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_ISI>;
> > > > +                           status = "disabled";
> > > > +
> > > > +                           port {
> > > > +                                   isi_in: endpoint {
> > > > +                                           remote-endpoint = <&mipi_csi_out>;
> > > > +                                   };
> > > > +                           };
> > >
> > > This will fail to validate against the ISI DT binding, as they require a
> > > "ports" node. When a single port is present using a "port" node directly
> > > is fine from an OF graph point of view, but to avoid too much complexity
> > > in the ISI binding the consensus was to always require a "ports" node
> > > for the ISI.
> > >
> > > > +                   };
> > > > +
> > > >                     disp_blk_ctrl: blk-ctrl@32e28000 {
> > > >                             compatible = "fsl,imx8mn-disp-blk-ctrl", "syscon";
> > > >                             reg = <0x32e28000 0x100>;
> > > > @@ -1147,6 +1165,42 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
> > > >                             #power-domain-cells = <1>;
> > > >                     };
> > > >
> > > > +                   mipi_csi: mipi-csi@32e30000 {
> > > > +                           compatible = "fsl,imx8mm-mipi-csi2";
> > > > +                           reg = <0x32e30000 0x1000>;
> > > > +                           interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > > > +                           assigned-clocks = <&clk IMX8MN_CLK_CAMERA_PIXEL>,
> > > > +                                             <&clk IMX8MN_CLK_CSI1_PHY_REF>;
> > > > +                           assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_1000M>,
> > > > +                                                     <&clk IMX8MN_SYS_PLL2_1000M>;
> > > > +                           assigned-clock-rates = <333000000>;
> > > > +                           clock-frequency = <333000000>;
> > > > +                           clocks = <&clk IMX8MN_CLK_DISP_APB_ROOT>,
> > > > +                                    <&clk IMX8MN_CLK_CAMERA_PIXEL>,
> > > > +                                    <&clk IMX8MN_CLK_CSI1_PHY_REF>,
> > > > +                                    <&clk IMX8MN_CLK_DISP_AXI_ROOT>;
> > > > +                           clock-names = "pclk", "wrap", "phy", "axi";
> > > > +                           power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_MIPI_CSI>;
> > > > +                           status = "disabled";
> > > > +
> > > > +                           ports {
> > > > +                                   #address-cells = <1>;
> > > > +                                   #size-cells = <0>;
> > > > +
> > > > +                                   port@0 {
> > > > +                                           reg = <0>;
> > > > +                                   };
> > > > +
> > > > +                                   port@1 {
> > > > +                                           reg = <1>;
> > > > +
> > > > +                                           mipi_csi_out: endpoint {
> > > > +                                                   remote-endpoint = <&isi_in>;
> > > > +                                           };
> > > > +                                   };
> > > > +                           };
> > > > +                   };
> > > > +
> > > >                     usbotg1: usb@32e40000 {
> > > >                             compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
> > > >                             reg = <0x32e40000 0x200>;

-- 
Regards,

Laurent Pinchart
