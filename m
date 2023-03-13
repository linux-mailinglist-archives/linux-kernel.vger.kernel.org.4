Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E796B81BD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCMTaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCMTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:30:49 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D58D78CBC;
        Mon, 13 Mar 2023 12:30:48 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32DJUcJP106602;
        Mon, 13 Mar 2023 14:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678735838;
        bh=rr7Jwc4bBK2fTMy+2qtETid9QUJOQqt1I/IMuW1FPAQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XxTqR8gcDqgNZYnHtWbEa9daym8O2EUCwJGQ6ci5epKX48LujrnaXYrhbCdGXBvUS
         xiAzqXohfNBBMpHN/GVsOrxIqnLw3pHLq+zmv0td13rhrSckEJBEFqecLyR9c8hDMF
         Fs7Lk6/ju6e+OD/Cy+lEX6GvkQnIRDNH9HHxP98Y=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32DJUceg062484
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Mar 2023 14:30:38 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Mar 2023 14:30:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Mar 2023 14:30:38 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32DJUcPo028642;
        Mon, 13 Mar 2023 14:30:38 -0500
Date:   Mon, 13 Mar 2023 14:30:37 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>, Bryan Brattlof <bb@ti.com>,
        Jason Kridner <jkridner@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: ti: Add k3-am625-beagleplay
Message-ID: <20230313193037.55l5sj3htr3mcnsn@spinner>
References: <20230311111022.23717-1-nm@ti.com>
 <20230311111022.23717-3-nm@ti.com>
 <da7555ae-b56a-f895-96cc-447bfd1c772d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <da7555ae-b56a-f895-96cc-447bfd1c772d@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:50-20230313, Andrew Davis wrote:
> On 3/11/23 5:10 AM, Nishanth Menon wrote:
> > From: Robert Nelson <robertcnelson@gmail.com>
> > 
[...]

> > +		serial1 = &mcu_uart0;
> > +		serial2 = &main_uart0;
> > +		serial3 = &main_uart5;
> 
> What are we using main_uart5 for, and why does it need to be serial3?

As provided in the documentation (referred to in the dts and commit
message), Mikrobus, serial3 since that is the 3rd of the uart
interfaces exposed on the platform.

[...]

> > +		secure_tfa_ddr: tfa@9e780000 {
> > +			reg = <0x00 0x9e780000 0x00 0x80000>;
> > +			alignment = <0x1000>;
> 
> "alignment" not needed since we cannot allocate from "no-map" regions anyway. Same
> for OP-TEE mem below.

Aargh.. yes... I missed it again.
> 
> > +			no-map;
> > +		};
> > +
> > +		secure_ddr: optee@9e800000 {
> > +			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> 
> "for OP-TEE" comment is probably extra now that the node is named "optee".

Will drop.

[...]
> > +&a53_opp_table {
> > +		/* Requires VDD_CORE to be at 0.85V */
> > +		opp-1400000000 {
> > +			opp-hz = /bits/ 64 <1400000000>;
> > +			opp-supported-hw = <0x01 0x0004>;
> > +		};
> 
> Seems tabed out too far.

Uggh.. will check and fix.

> 
> > +};
> > +
> > +&wkup_i2c0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c_csi_pins_default>;
> > +	clock-frequency = <400000>;
> > +	/* Enable with overlay for camera sensor */
> 
> If we don't want to enable it here, why not move all this to the overlay?

Makes no sense in duplicating (and would be error prone). The pinmux
is always constant, no matter which sensor overlay one uses. So,
maintaining the common configuration in the board dts itself.

[...]

> > +&cpsw3g_mdio {
> > +	/* Workaround for errata i2329 - Use mdio bitbang */
> > +	status = "disabled";
> 
> Should already be disabled, but the comment is nice to have so
> probably okay to keep IMHO.

Yeah - wanted to be a bit explicit here.

Thanks for reviewing..

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
