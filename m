Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8116333C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiKVDOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiKVDOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:14:00 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2BC1E714;
        Mon, 21 Nov 2022 19:13:57 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AM3DlYu008487;
        Mon, 21 Nov 2022 21:13:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669086827;
        bh=TKEbhj1suQCIIV1Fk7hur1T6VW/Gs8A83nLvMiQ/5u4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=iRyshwd+3ylMP7KD5ULJ8zdk7c+mEL73bpS6cd5gnZBKNPrHDMXxwBNMfS3pW6lRW
         5zms1JzESFTzxx+9roMNmtsNtWoDJE40JcaGVfQU2t7PdyW4jiVjoj79z0Q1nKOynv
         4GOOk0jvRwYBXxavI1/NARfEQXUoqNavatQno3FY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AM3DlxP012352
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Nov 2022 21:13:47 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 21
 Nov 2022 21:13:47 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 21 Nov 2022 21:13:47 -0600
Received: from ubuntu (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with SMTP id 2AM3DZl2094840;
        Mon, 21 Nov 2022 21:13:37 -0600
Date:   Mon, 21 Nov 2022 19:13:34 -0800
From:   Matt Ranostay <mranostay@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 7/8] arm64: dts: ti: k3-j721s2-main: Add PCIe device
 tree node
Message-ID: <Y3w+Xmn2ttRHM8ZM@ubuntu>
References: <20221119040906.9495-1-mranostay@ti.com>
 <20221119040906.9495-8-mranostay@ti.com>
 <dafbff84-209c-a4d5-1e84-f08e84156ed8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dafbff84-209c-a4d5-1e84-f08e84156ed8@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:12:18AM -0600, Andrew Davis wrote:
> On 11/18/22 10:09 PM, Matt Ranostay wrote:
> > From: Aswath Govindraju <a-govindraju@ti.com>
> > 
> > Add PCIe device tree node (both RC and EP) for the single PCIe
> > instance present in j721s2.
> > 
> 
> So which is it, you have two nodes but this is one device. It can
> switch between the two modes, a property should have been used to
> select the mode for the device.
> 
> Making two nodes for the same device as examples of what they could
> look like, then only enabling one of the two in the board level DT
> is not how this is done anywhere else. Take the common parts and
> make one node here with those. Then at the board level .dts where we
> select what mode this driver will act in, add the specific bits for
> the chosen mode.
>

This isn't how it is done in k3-j7200-common-proc-board.dts and k3-j7200-main.dtsi
Now I'm fine with making it common node if that is way to go..

- Matt

> Andrew
> 
> > Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > Signed-off-by: Matt Ranostay <mranostay@ti.com>
> > ---
> >   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 61 ++++++++++++++++++++++
> >   1 file changed, 61 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> > index adbb172658b9..04294e25d587 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> > @@ -841,6 +841,67 @@ serdes0: serdes@5060000 {
> >   		};
> >   	};
> > +	pcie1_rc: pcie@2910000 {
> > +		compatible = "ti,j7200-pcie-host", "ti,j721e-pcie-host";
> > +		reg = <0x00 0x02910000 0x00 0x1000>,
> > +		      <0x00 0x02917000 0x00 0x400>,
> > +		      <0x00 0x0d800000 0x00 0x00800000>,
> > +		      <0x00 0x18000000 0x00 0x00001000>;
> > +		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
> > +		interrupt-names = "link_state";
> > +		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
> > +		device_type = "pci";
> > +		ti,syscon-pcie-ctrl = <&scm_conf 0x074>;
> > +		max-link-speed = <3>;
> > +		num-lanes = <4>;
> > +		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
> > +		clocks = <&k3_clks 276 41>;
> > +		clock-names = "fck";
> > +		#address-cells = <3>;
> > +		#size-cells = <2>;
> > +		bus-range = <0x0 0xff>;
> > +		vendor-id = <0x104c>;
> > +		device-id = <0xb013>;
> > +		msi-map = <0x0 &gic_its 0x0 0x10000>;
> > +		dma-coherent;
> > +		ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
> > +			 <0x02000000 0x0 0x18011000  0x00 0x18011000  0x0 0x7fef000>;
> > +		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
> > +		#interrupt-cells = <1>;
> > +		interrupt-map-mask = <0 0 0 7>;
> > +		interrupt-map = <0 0 0 1 &pcie1_intc 0>, /* INT A */
> > +				<0 0 0 2 &pcie1_intc 0>, /* INT B */
> > +				<0 0 0 3 &pcie1_intc 0>, /* INT C */
> > +				<0 0 0 4 &pcie1_intc 0>; /* INT D */
> > +
> > +		pcie1_intc: interrupt-controller {
> > +			interrupt-controller;
> > +			#interrupt-cells = <1>;
> > +			interrupt-parent = <&gic500>;
> > +			interrupts = <GIC_SPI 324 IRQ_TYPE_EDGE_RISING>;
> > +		};
> > +	};
> > +
> > +	pcie1_ep: pcie-ep@2910000 {
> > +		compatible = "ti,j7200-pcie-ep", "ti,j721e-pcie-ep";
> > +		reg = <0x00 0x02910000 0x00 0x1000>,
> > +		      <0x00 0x02917000 0x00 0x400>,
> > +		      <0x00 0x0d800000 0x00 0x00800000>,
> > +		      <0x00 0x18000000 0x00 0x08000000>;
> > +		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
> > +		interrupt-names = "link_state";
> > +		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
> > +		ti,syscon-pcie-ctrl = <&scm_conf 0x074>;
> > +		max-link-speed = <3>;
> > +		num-lanes = <4>;
> > +		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
> > +		clocks = <&k3_clks 276 41>;
> > +		clock-names = "fck";
> > +		max-functions = /bits/ 8 <6>;
> > +		max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
> > +		dma-coherent;
> > +	};
> > +
> >   	main_mcan0: can@2701000 {
> >   		compatible = "bosch,m_can";
> >   		reg = <0x00 0x02701000 0x00 0x200>,
