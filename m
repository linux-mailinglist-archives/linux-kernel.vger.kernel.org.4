Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B9E72FDCB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244328AbjFNMDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243772AbjFNMDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:03:14 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFA019AC;
        Wed, 14 Jun 2023 05:03:13 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35EC34AG008072;
        Wed, 14 Jun 2023 07:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686744184;
        bh=exqtvFT+nbVlmhGeLa2rPoTuLDjsI9iSTt+Gq8Txzx8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aHW27taJwCJ6cZFhwtkfywFTp0n/jEmo9crO3vw8m9wu6H/U1pUnOooHf/QX1kEMU
         9htAe+vLEb4L19+cakByG09e/bDKLgDoyFNUQ2hr0/UcSP9dclR51pnfgxwJSD4d9K
         o5XqfOoWhbj6hY8y8Z0dth488Hb+EMfgEDrppXHQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35EC34rG003402
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Jun 2023 07:03:04 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Jun 2023 07:03:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Jun 2023 07:03:03 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35EC33wD050419;
        Wed, 14 Jun 2023 07:03:03 -0500
Date:   Wed, 14 Jun 2023 07:03:03 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Kumar, Udit" <u-kumar1@ti.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH 6/9] arm64: dts: ti: k3-j721e-beagleboneai64: Add
 wakeup_uart pinmux
Message-ID: <20230614120303.5ievpixlpjb3wtdz@elective>
References: <20230601183151.1000157-1-nm@ti.com>
 <20230601183151.1000157-7-nm@ti.com>
 <22b67e80-1f5f-d8e0-3c85-c69d97ea0d39@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22b67e80-1f5f-d8e0-3c85-c69d97ea0d39@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:26-20230613, Kumar, Udit wrote:
> Hi Nishanth,
> 
> On 6/2/2023 12:01 AM, Nishanth Menon wrote:
> > Define the wakeup uart pin-mux for completeness. This allows the
> > device tree usage in bootloader and firmwares that can configure the
> > same appropriately.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >   arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> > index c13246a9ed8f..bc53ca566a68 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> > @@ -531,6 +531,13 @@ J721E_WKUP_IOPAD(0xfc, PIN_INPUT_PULLUP, 0) /* (H24) WKUP_I2C0_SDA */
> >   		>;
> >   	};
> > +	wkup_uart0_pins_default: wkup-uart0-pins-default {
> > +		pinctrl-single,pins = <
> > +			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */
> > +			J721E_WKUP_IOPAD(0xa4, PIN_OUTPUT, 0) /* (J28) WKUP_UART0_TXD */
> > +		>;
> > +	};
> > +
> >   	mcu_usbss1_pins_default: mcu-usbss1-pins-default {
> >   		pinctrl-single,pins = <
> >   			J721E_WKUP_IOPAD(0x3c, PIN_OUTPUT_PULLUP, 5) /* (A23) MCU_OSPI1_LBCLKO.WKUP_GPIO0_30 */
> > @@ -541,6 +548,8 @@ J721E_WKUP_IOPAD(0x3c, PIN_OUTPUT_PULLUP, 5) /* (A23) MCU_OSPI1_LBCLKO.WKUP_GPIO
> >   &wkup_uart0 {
> >   	/* Wakeup UART is used by TIFS firmware. */
> >   	status = "reserved";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&wkup_uart0_pins_default>;
> >   };
> 
> 
> If you like to consider alias for wkup_uart0 for this board ,
> 
> Just to align with other boards for this SOC family.  I understand
> wkup_uart0 is not being used.

Vignesh,
could you squash this locally OR if you like, I can post a v2:

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index 3304460f6a0b..9922d7bb061f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -20,6 +20,7 @@ / {
 	model = "BeagleBoard.org BeagleBone AI-64";
 
 	aliases {
+		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
 		mmc0 = &main_sdhci0;
 		mmc1 = &main_sdhci1;

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
