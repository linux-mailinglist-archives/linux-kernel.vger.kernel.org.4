Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0285D60F05A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiJ0Gdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiJ0Gdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:33:38 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9797162532;
        Wed, 26 Oct 2022 23:33:35 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29R6XOPm112818;
        Thu, 27 Oct 2022 01:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666852404;
        bh=ffuBEshoz466q3ZWFLWrO+vd2ntG6q+18jkXACuEZWU=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=Xw8j0bf74jDKZbJzTEYWRaO6WOH+04O4Nhbg5G5NWCHb1K+Iyxz+w33rkSvCZsEg6
         jhGCDYPJI5ldld8YQ4H2IO3kUKMOGVTRJe/pUTDNIj7Sk1Y9wxU9aQJm+w/AWfj32R
         89g9rl6nwBJGpJU4a0ppx4L/p2DwQye9ZTKAdzAo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29R6XOeb008892
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Oct 2022 01:33:24 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 27
 Oct 2022 01:33:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 27 Oct 2022 01:33:24 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29R6XK5D029046;
        Thu, 27 Oct 2022 01:33:21 -0500
Message-ID: <6abd122d-aacd-ca47-916d-142b68058a69@ti.com>
Date:   Thu, 27 Oct 2022 12:03:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 00/10] AM64x Disable Incomplete DT Nodes
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221017192532.23825-1-afd@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20221017192532.23825-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/10/22 00:55, Andrew Davis wrote:
> Andrew Davis (10):
>   arm64: dts: ti: k3-am64: Enable UART nodes at the board level
>   arm64: dts: ti: k3-am64: Enable I2C nodes at the board level
>   arm64: dts: ti: k3-am64: Enable SPI nodes at the board level
>   arm64: dts: ti: k3-am64: Enable EPWM nodes at the board level
>   arm64: dts: ti: k3-am64: Enable ECAP nodes at the board level
>   arm64: dts: ti: k3-am64: Enable PCIe nodes at the board level
>   arm64: dts: ti: k3-am64: MDIO pinmux should belong to the MDIO node
>   arm64: dts: ti: k3-am64: Enable MDIO nodes at the board level
>   arm64: dts: ti: k3-am64: Enable MCAN nodes at the board level
>   arm64: dts: ti: k3-am64: Enable GPMC and ELM nodes at the board level
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi |  37 ++++++
>  arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  |   6 +
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 119 ++-----------------
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 142 ++---------------------
>  4 files changed, 63 insertions(+), 241 deletions(-)

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>


-- 
Regards
Vignesh
