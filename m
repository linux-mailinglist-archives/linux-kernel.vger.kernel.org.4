Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E457231BA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjFEUtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjFEUtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:49:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723F792;
        Mon,  5 Jun 2023 13:49:40 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 355KnUvt127847;
        Mon, 5 Jun 2023 15:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685998170;
        bh=4V3fq9EKmwNGQ2bKqH9G1hqo+dixSV5pctbKnWYtTRo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=EzTMymaz/hhrGc4hyc3ZGB9Ll1M1X6KQR7wRShYNxzRPSaf0rLaYJOqwXx5uvas7S
         2VEobV33b5sq+RJ/xoHCXs2UJmbPCdyyX8HhzRRa8+ouHiV6PCIrVkX7Gv8JMbqEOS
         ftUBHLf3oGhZUAQ7gCC8DM39PXoDnBuLNydZImk0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 355KnUip004203
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jun 2023 15:49:30 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Jun 2023 15:49:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Jun 2023 15:49:30 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 355KnUgK107483;
        Mon, 5 Jun 2023 15:49:30 -0500
Date:   Mon, 5 Jun 2023 15:49:30 -0500
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
Message-ID: <20230605204930.3hlg3d36zwtbkal7@scone>
References: <20230601152636.858553-1-nm@ti.com>
 <20230601152636.858553-4-nm@ti.com>
 <f1e54167-15bd-8a0b-454d-53b90b18a343@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f1e54167-15bd-8a0b-454d-53b90b18a343@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22:31-20230605, Kumar, Udit wrote:
[...]
> > diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> > index 37c24b077b6a..c13246a9ed8f 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
[...]
> > @@ -639,7 +639,7 @@ &main_i2c6 {
> >   &wkup_i2c0 {
> >   	status = "okay";
> >   	pinctrl-names = "default";
> > -	pinctrl-0 = <&wkup_i2c0_pins_default &eeprom_wp_pins_default>;
> > +	pinctrl-0 = <&wkup_i2c0_pins_default>, <&eeprom_wp_pins_default>;
> >   	clock-frequency = <400000>;
> 
> Why we need more than 2 pio lines for i2c node ,

pio lines? I am not sure I understand. If you are suggesting
eeprom_wp_pins to be moved to the eeprom node, It is probably
un-related to this series, but OK, i think it is probably a valid
change (unless Robert sees a reason why he did it the way he did).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
