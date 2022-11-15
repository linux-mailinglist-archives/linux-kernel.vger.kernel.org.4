Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FD362914B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 05:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiKOEwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 23:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiKOEwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 23:52:37 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEF91582E;
        Mon, 14 Nov 2022 20:52:34 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AF4qRE5071518;
        Mon, 14 Nov 2022 22:52:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668487947;
        bh=/E64PIHXFOY3H6YTDaG6PFJhJzJ2G3dj+Y42ilK0YHI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aidddNcZMEXSMIFt4ma3aqQPuCCtDWL2Up5uxYPJJdMUaccZ+Cas4iF2OiX/e2YOx
         46LrzXc1bixZLllpIGnm0oyQA2pE82t2yuerGE3Ycw7H+zxUX/n/jY8BDh9bDC7Xql
         2nolg+uzTSKgNJBghzQ9a8Pn+pGu0h3zqCdsr++g=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AF4qRhC129576
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Nov 2022 22:52:27 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 14
 Nov 2022 22:52:26 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 14 Nov 2022 22:52:26 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AF4qQhv009627;
        Mon, 14 Nov 2022 22:52:26 -0600
Date:   Mon, 14 Nov 2022 22:52:26 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>
CC:     Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: ti: Add support for J784S4 EVM board
Message-ID: <20221115045226.6l4j4qbvedv2whjq@effects>
References: <20221014082314.118361-1-a-nandan@ti.com>
 <20221014082314.118361-5-a-nandan@ti.com>
 <cd5dbbb0-2d9f-8d7d-b051-f8d01d710c62@ti.com>
 <581d0735-8294-5805-9a44-ed4ec3e9ae54@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <581d0735-8294-5805-9a44-ed4ec3e9ae54@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:48-20221111, Apurva Nandan wrote:
> 
[...]

> > > Schematics: https://www.ti.com/lit/zip/sprr458


> > > 
> > > Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> > > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > Signed-off-by: Matt Ranostay <mranostay@ti.com>
> > > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > > Signed-off-by: Suman Anna <s-anna@ti.com>
> > > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Uggh - too many Signed-off-by -> Can we either trim this down or use
Co-developed-by ?

The last of the SoB should be yours as you are handing the patch over.
> > > ---
> > >    arch/arm64/boot/dts/ti/Makefile          |   2 +
> > >    arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 199 +++++++++++++++++++++++
> > >    2 files changed, 201 insertions(+)
> > >    create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> > > index 02e5d80344d0..6381c458738a 100644
> > > --- a/arch/arm64/boot/dts/ti/Makefile
> > > +++ b/arch/arm64/boot/dts/ti/Makefile
> > > @@ -19,6 +19,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
> > >    dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb

One EoL here please? helps keeps the dtbs grouped.

> > > +dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
> > > +
> > >    dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
> > >    dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
> > > diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> > > new file mode 100644
> > > index 000000000000..bf2f2dfb7658
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> > > @@ -0,0 +1,199 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> > > + *
> > > + * Common Processor Board: https://www.ti.com/tool/J721EXCPXEVM
> > This doesn't seem to be the right EVM, I'd just drop this link.

Please use the proper link -> I think it is in commit message.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
