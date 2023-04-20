Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611D76E9366
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjDTLva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjDTLv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:51:27 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A659C4;
        Thu, 20 Apr 2023 04:51:18 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33KBp0cK016925;
        Thu, 20 Apr 2023 06:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681991460;
        bh=Ifm/hGtRjfMGMo3Gan5UQZ3I8wk/lzg8q+bcE2TWbz8=;
        h=From:To:CC:Subject:In-Reply-To:References:Date;
        b=IOT5qG3y7JFVOxjp4FwCLMYawGv2DyrT3UwGJ6E34ZlgJq9T+cZuXOMIhmENt0Iue
         XSdOCr6pGe2DCp/SF+AUpR2mM4Q5I9WCnalu+gHxl77RIFnOM5s25Od2Qtj071bLo/
         L/UHDvZIzlQtOnxGmDZHp2iMXKsU74mjYhTVdSx8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33KBp0wn032323
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Apr 2023 06:51:00 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 20
 Apr 2023 06:50:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 20 Apr 2023 06:50:59 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33KBoxcW064533;
        Thu, 20 Apr 2023 06:50:59 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 0/7] arm64: dts: ti: k3-am65: Cleanups and minor additions
In-Reply-To: <20230419225913.663448-1-nm@ti.com>
References: <20230419225913.663448-1-nm@ti.com>
Date:   Thu, 20 Apr 2023 17:20:58 +0530
Message-ID: <87wn26ydp9.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
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

Nishanth Menon <nm@ti.com> writes:

> Hi,
>
> This is a result of looking to cleanup u-boot and realizing there are
> pieces missing in kernel that need to be pushed out.
>
> So, minor cleanups and adding a few missing pieces.
>
> Bootlog: https://gist.github.com/nmenon/f4dc43aef616dfcb3d38701cc074ff6d
>
> Nishanth Menon (7):
>   arm64: dts: ti: k3-am654-base-board: Add missing pinmux wkup_uart,
>     mcu_uart and mcu_i2c
>   arm64: dts: ti: k3-am654-base-board: Rename regulator node name
>   arm64: dts: ti: k3-am654-base-board: Add VTT GPIO regulator for DDR
>   arm64: dts: ti: k3-am654-base-board: Add missing PMIC
>   arm64: dts: ti: k3-am654-base-board: Add board detect eeprom
>   arm64: dts: ti: k3-am654-base-board: Add aliases
>   arm64: dts: ti: k3-am65: Drop aliases
>
>  arch/arm64/boot/dts/ti/k3-am65.dtsi           | 17 ----
>  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 93 ++++++++++++++++++-
>  2 files changed, 88 insertions(+), 22 deletions(-)
>
> -- 
> 2.40.0
All patches look good to me.

Reviewed-by: Kamlesh Gurudasani <kamlesh@ti.com>
