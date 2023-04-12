Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD266DFF41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjDLT5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDLT5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:57:14 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869A3172C;
        Wed, 12 Apr 2023 12:57:12 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33CJuvOS026756;
        Wed, 12 Apr 2023 14:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681329417;
        bh=55PrKKkIhQxvxBSsvZXp9quQx6wpWtCaUKyGDu8YdYQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=D7sqeNeMjgmr2g37OFHpk0rMpmsOAaqGjTcLecZFyT5FNX3P6fkO/ClMYVp5grwO0
         ETVqn4QUg/UmfZZ/i+bTjumm/lkIdnbA5fqaoMqQM/U6jQQ3v+SZu/jhrat4gAsXW+
         f9H6mbqQ2Nx3WOlFusHyC7U3dTlVut4Zn8dV6puY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33CJuvt4077086
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Apr 2023 14:56:57 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 12
 Apr 2023 14:56:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 12 Apr 2023 14:56:56 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33CJuuLm074122;
        Wed, 12 Apr 2023 14:56:56 -0500
Date:   Wed, 12 Apr 2023 14:56:56 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Udit Kumar <u-kumar1@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <a-govindraju@ti.com>,
        <kishon@ti.com>, <n-dasan@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-main: fix msmc node
Message-ID: <20230412195656.a53nalvjuhelniz4@populace>
References: <20230412173609.1307837-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230412173609.1307837-1-u-kumar1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:06-20230412, Udit Kumar wrote:
> On J721S2 SOC, l3cache-sram size is configured as zero by
> system firmware.
> Also top 64K of msmc_ram (0x703F_0000 to 0x703F_FFFF) is used by system
> firmware tifs-sram.
> 
> This patch removes l3cache-sram node and update range for tifs-sram.
> 
> Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index 2dd7865f7654..cbc784f915a9 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -17,13 +17,10 @@ atf-sram@0 {
>  			reg = <0x0 0x20000>;
>  		};
>  
> -		tifs-sram@1f0000 {
> -			reg = <0x1f0000 0x10000>;
> +		tifs-sram@3f0000 {
> +			reg = <0x3f0000 0x10000>;
>  		};
>  
> -		l3cache-sram@200000 {
> -			reg = <0x200000 0x200000>;
> -		};
>  	};
>  
>  	gic500: interrupt-controller@1800000 {
> -- 
> 2.34.1
> 

Are you saying that j721s2 is incapable of l3 cache? say some level 1
errata?

or is it because, the chip is really capable of l3 cache and we are
really setting it to 0?

https://git.ti.com/cgit/k3-image-gen/k3-image-gen/tree/soc/j721s2/evm/board-cfg.c#n71

unless the chip has an errata, you are supposed to fix it up based on
configuration by using the API and this patch is a NAK
https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-query-msmc

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
