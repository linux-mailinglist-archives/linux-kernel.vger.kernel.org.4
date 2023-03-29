Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084DA6CD99D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjC2Mvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjC2Mvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:51:41 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDA54C02;
        Wed, 29 Mar 2023 05:51:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32TCpSQN081739;
        Wed, 29 Mar 2023 07:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680094288;
        bh=Mj+/segdAMKUDPfh7SQ9ysrDidKSNW2a4NQKDKdjr2U=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aucULICgGBYDQ8z62PZuur4teRF2zX3a5Kp+BaxcUyK/kGhOJp1yADFZx+gMRKF6T
         RQ2tIe58/A7FQXfbJmL1Q1FnuxsnRd/JxKKsr9GeksguXSEfoCc7MzUJjmGdw5Wqb1
         jKt12R/RlAi9PC6yxR5/LtxakN7SjgcxWKdCQ88Y=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32TCpSXa036417
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 07:51:28 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 07:51:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 07:51:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32TCpRad011174;
        Wed, 29 Mar 2023 07:51:27 -0500
Date:   Wed, 29 Mar 2023 07:51:27 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Hari Nagalla <hnagalla@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j784s4-mcu: Add MCU domain R5F
 cluster node
Message-ID: <20230329125127.emzzajbobmvuo5ml@choosing>
References: <20230329093627.30719-1-hnagalla@ti.com>
 <20230329093627.30719-3-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230329093627.30719-3-hnagalla@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04:36-20230329, Hari Nagalla wrote:
> The J784S4 SoCs have 4 dual-core Arm Cortex-R5F processor (R5FSS)
> subsystems/clusters. One R5F cluster (MCU_R5FSS0) is present within
> the MCU domain (MCU_R5FSS0), and the remaining three clusters are
> present in the MAIN domain (MAIN_R5FSS0, MAIN_R5FSS1 & MAIN_R5FSS2).
> The functionality of the R5FSS is same as the R5FSS functionality on
> earlier K3 platform devices J721S2. Each of the R5FSS can be configured
> at boot time to be either run in a LockStep mode or in an Asymmetric
> Multi Processing (AMP) fashion in Split-mode.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>  .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> index 64bd3dee14aa..e290e0925bc9 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> @@ -309,4 +309,46 @@
>  			ti,cpts-periodic-outputs = <2>;
>  		};
>  	};
> +
> +	mcu_r5fss0: r5fss@41000000 {
> +		compatible = "ti,j721s2-r5fss";
> +		ti,cluster-mode = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x41000000 0x00 0x41000000 0x20000>,
> +			 <0x41400000 0x00 0x41400000 0x20000>;
> +		power-domains = <&k3_pds 345 TI_SCI_PD_EXCLUSIVE>;
> +
> +		mcu_r5fss0_core0: r5f@41000000 {
> +			compatible = "ti,j721s2-r5f";
> +			reg = <0x41000000 0x00010000>,
> +			      <0x41010000 0x00010000>;
> +			reg-names = "atcm", "btcm";
> +			ti,sci = <&sms>;
> +			ti,sci-dev-id = <346>;
> +			ti,sci-proc-ids = <0x01 0xff>;
> +			resets = <&k3_reset 346 1>;
> +			firmware-name = "j784s4-mcu-r5f0_0-fw";
> +			ti,atcm-enable = <1>;
> +			ti,btcm-enable = <1>;
> +			ti,loczrama = <1>;
> +			status = "disabled";

Why are these disabled by default?

> +		};
> +
> +		mcu_r5fss0_core1: r5f@41400000 {
> +			compatible = "ti,j721s2-r5f";
> +			reg = <0x41400000 0x00010000>,
> +			      <0x41410000 0x00010000>;
> +			reg-names = "atcm", "btcm";
> +			ti,sci = <&sms>;
> +			ti,sci-dev-id = <347>;
> +			ti,sci-proc-ids = <0x02 0xff>;
> +			resets = <&k3_reset 347 1>;
> +			firmware-name = "j784s4-mcu-r5f0_1-fw";
> +			ti,atcm-enable = <1>;
> +			ti,btcm-enable = <1>;
> +			ti,loczrama = <1>;
> +			status = "disabled";
> +		};
> +	};
>  };
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
