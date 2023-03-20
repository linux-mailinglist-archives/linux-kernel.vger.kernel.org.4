Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B00C6C1A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjCTPqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjCTPqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:46:11 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ED71449B;
        Mon, 20 Mar 2023 08:37:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32KFanmp004337;
        Mon, 20 Mar 2023 10:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679326609;
        bh=FB9V7ot/l1vqWyvOklMmEs6w7A6C77GIOnMJLjkxaFo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YhgBtifD/VG87/BGJN7RrRUEbGUhVV+ohIjJxccre6NZirrT2ulffgjMHs0deG5lR
         vfaQD/VCXyCQNV6tQMLUAfsTtdnEEZ2N+B6GyRcZAVYj7MtKamO03sEz12pLO6/v32
         zyZMzjCjTN/oY/cP477s0R8P92bOxVNUSO+pxy5M=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32KFanx7092023
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 10:36:49 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 10:36:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 10:36:49 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32KFanVZ094827;
        Mon, 20 Mar 2023 10:36:49 -0500
Date:   Mon, 20 Mar 2023 10:36:49 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am62: Add watchdog nodes
Message-ID: <20230320153649.zfmyhk65ngh4u35d@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20230311105850.21811-1-nm@ti.com>
 <20230311105850.21811-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20230311105850.21811-3-nm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 11, 2023 thus sayeth Nishanth Menon:
> From: Julien Panis <jpanis@baylibre.com>
> 
> Add nodes for watchdogs :
> - 5 in main domain
> - 1 in MCU domain
> - 1 in wakeup domain
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V3:
> - Dropped the board level wdt reservation, do that with overlays based on
>   modifiable firmware dependencies.
> 
> V3: https://lore.kernel.org/all/20221109093026.103790-2-jpanis@baylibre.com/
> 
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi   | 45 ++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    |  9 +++++
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 11 ++++++
>  3 files changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index ea683fd77d6a..90d5f145de4f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -758,6 +758,51 @@ main_mcan0: can@20701000 {
>  		status = "disabled";
>  	};
>  
> +	main_rti0: watchdog@e000000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x0e000000 0x00 0x100>;
> +		clocks = <&k3_clks 125 0>;
> +		power-domains = <&k3_pds 125 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 125 0>;
> +		assigned-clock-parents = <&k3_clks 125 2>;
> +	};
> +
> +	main_rti1: watchdog@e010000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x0e010000 0x00 0x100>;
> +		clocks = <&k3_clks 126 0>;
> +		power-domains = <&k3_pds 126 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 126 0>;
> +		assigned-clock-parents = <&k3_clks 126 2>;
> +	};
> +
> +	main_rti2: watchdog@e020000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x0e020000 0x00 0x100>;
> +		clocks = <&k3_clks 127 0>;
> +		power-domains = <&k3_pds 127 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 127 0>;
> +		assigned-clock-parents = <&k3_clks 127 2>;
> +	};
> +
> +	main_rti3: watchdog@e030000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x0e030000 0x00 0x100>;
> +		clocks = <&k3_clks 128 0>;
> +		power-domains = <&k3_pds 128 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 128 0>;
> +		assigned-clock-parents = <&k3_clks 128 2>;
> +	};
> +
> +	main_rti4: watchdog@e0f0000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x0e0f0000 0x00 0x100>;
> +		clocks = <&k3_clks 130 0>;
> +		power-domains = <&k3_pds 130 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 130 0>;
> +		assigned-clock-parents = <&k3_clks 130 2>;
> +	};
> +

This may be a dumb question, though the ti-sci and TRM documentation is 
labeling this as rti15? idk if we should label this the same? it might 
make grepping a little easier :)

~Bryan
