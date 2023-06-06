Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53212724135
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbjFFLlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFFLlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:41:42 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0B5E5B;
        Tue,  6 Jun 2023 04:41:39 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356BfYH4108450;
        Tue, 6 Jun 2023 06:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686051694;
        bh=34G1OzEx+Nag1ISn6m5LvoYDtUhDC1hETE9nnF9JkG0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=dv7a0+ekPmx/JsuOr5vTlSc2HBaX7dDTzkcUfZ/UAjWMmkcXZKAbBR4d2bUXn7MSZ
         LdJaKnPlkWRNKhlxCwgVkW6/47q8m/tFNyfmoOCnIMXZFCoAE1+KJJJK3ircHm8BtE
         NgxFaVlopOE6I9SXj8X6EXMja4reV/jrYxFwWLsI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356BfYR0118617
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 06:41:34 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 06:41:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 06:41:33 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356BfXam019322;
        Tue, 6 Jun 2023 06:41:33 -0500
Date:   Tue, 6 Jun 2023 06:41:33 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Kumar, Udit" <u-kumar1@ti.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH 03/12] arm64: dts: ti: k3-j721e-beagleboneai64: Fixup
 reference to phandles array
Message-ID: <20230606114133.qgokk37e5lcyrqui@prewashed>
References: <20230601152636.858553-1-nm@ti.com>
 <20230601152636.858553-4-nm@ti.com>
 <f1e54167-15bd-8a0b-454d-53b90b18a343@ti.com>
 <20230605204930.3hlg3d36zwtbkal7@scone>
 <cbd314b6-08a9-7a07-7538-c2e3f1b333e9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbd314b6-08a9-7a07-7538-c2e3f1b333e9@ti.com>
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

On 09:56-20230606, Kumar, Udit wrote:
> On 6/6/2023 2:19 AM, Nishanth Menon wrote:
> > On 22:31-20230605, Kumar, Udit wrote:
> > [...]
> > > > diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> > > > index 37c24b077b6a..c13246a9ed8f 100644
> > > > --- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> > > > +++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> > [...]
> > > > @@ -639,7 +639,7 @@ &main_i2c6 {
> > > >    &wkup_i2c0 {
> > > >    	status = "okay";
> > > >    	pinctrl-names = "default";
> > > > -	pinctrl-0 = <&wkup_i2c0_pins_default &eeprom_wp_pins_default>;
> > > > +	pinctrl-0 = <&wkup_i2c0_pins_default>, <&eeprom_wp_pins_default>;
> > > >    	clock-frequency = <400000>;
> > > Why we need more than 2 pio lines for i2c node ,
> > pio lines? I am not sure I understand. If you are suggesting
> > eeprom_wp_pins to be moved to the eeprom node, It is probably
> > un-related to this series, but OK, i think it is probably a valid
> > change (unless Robert sees a reason why he did it the way he did).
> 
> correct, I am suggesting to move  eeprom_wp_pins_default to eeprom node.
> 
> i2c needs 2 lines which are defined in wkup_i2c0_pins_default, Adding
> eeprom_wp_pins_default will not be true representation of i2c node.
> 
> It will be good to have similar changes in main_i2c1 and main_i2c5  node for
> csi0_gpio_pins_default and csi1_gpio_pins_default.

Robert: your opinion here?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
