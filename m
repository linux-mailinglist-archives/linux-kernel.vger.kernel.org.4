Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9706719E15
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjFAN3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjFAN2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:28:40 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D951FC;
        Thu,  1 Jun 2023 06:28:19 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 351DRxTq077536;
        Thu, 1 Jun 2023 08:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685626079;
        bh=q/GykU5T9n5Kgc4zooTOyI7oZoY5Y9fll6ju0mX0kt8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=zOBkAZF/KWLCFskhNEWzxoH116fHU2etpkVM42sPWQ3xnzgkXUlZJA/0LpmrFtk5V
         vlpa7wilJGBxN1xQww6YhvBt26VevEQ2r2gkMrJYn8QQiG40OmJ3Xctuvt11dZUfEP
         LO6YWR7qPpVBYqIR6n5wL+XSrUirMhG1GHJFUjXw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 351DRxiY013352
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jun 2023 08:27:59 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Jun 2023 08:27:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Jun 2023 08:27:59 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 351DRxwp033854;
        Thu, 1 Jun 2023 08:27:59 -0500
Date:   Thu, 1 Jun 2023 08:27:59 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Hari Nagalla <hnagalla@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j721s2-main: Add R5F and C7x
 remote processsor nodes
Message-ID: <20230601132759.li7t35pw35gfg6i7@demise>
References: <20230529220941.10801-1-hnagalla@ti.com>
 <20230529220941.10801-2-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230529220941.10801-2-hnagalla@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:09-20230529, Hari Nagalla wrote:
> The J721S2 SoCs have 2 dual-core Arm Cortex-R5F processor (R5FSS)
> subsystems/clusters in MAIN voltage domain. Each of these can be
> configured at boot time to be either run in a LockStep mode or in an
> Asymmetric Multi Processing (AMP) fashion in Split-mode. These
> subsystems have 64 KB each Tightly-Coupled Memory (TCM) internal
> memories for each core split between two banks - ATCM and BTCM
> (further interleaved into two banks). The TCMs of both Cores are
> combined in LockStep-mode to provide a larger 128 KB of memory, but
> otherwise are functionally similar to those on J721E SoCs.
> 
> Add the DT nodes for the MAIN domain R5F cluster/subsystems, the two
> R5F cores are added as child nodes to each of the R5F cluster nodes.
> The clusters are configured to run in LockStep mode by default, with
> the ATCMs enabled to allow the R5 cores to execute code from DDR
> with boot-strapping code from ATCM. The inter-processor communication
> between the main A72 cores and these processors is achieved through
> shared memory and Mailboxes.
> 
> The following firmware names are used by default for these cores, and
> can be overridden in a board dts file if desired:
>         MAIN R5FSS0 Core0: j721s2-main-r5f0_0-fw (both in LockStep & Split modes)
>         MAIN R5FSS0 Core1: j721s2-main-r5f0_1-fw (needed only in Split mode)
>         MAIN R5FSS1 Core0: j721s2-main-r5f1_0-fw (both in LockStep & Split modes)
>         MAIN R5FSS1 Core1: j721s2-main-r5f1_1-fw (needed only in Split mode)
> 
> The K3 J721S2 SoCs have two C71x DSP subsystems in MAIN voltage domain. The
> C71x DSPs are 64 bit machine with fixed and floating point DSP operations.
> Similar to the R5F remote cores, the inter-processor communication
> between the main A72 cores and these DSP cores is achieved through
> shared memory and Mailboxes.
> 
> The following firmware names are used by default for these DSP cores,
> and can be overridden in a board dts file if desired:
>         MAIN C71_0 : j721s2-c71_0-fw
>         MAIN C71_1 : j721s2-c71_1-fw
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 128 +++++++++++++++++----
>  1 file changed, 104 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index 2dd7865f7654..361aa6b24b22 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -463,7 +463,6 @@ mailbox0_cluster0: mailbox@31f80000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";

See https://lore.kernel.org/all/20221020160305.18711-9-afd@ti.com/
NAK.
>  		};
>  
>  		mailbox0_cluster1: mailbox@31f81000 {
> @@ -473,7 +472,6 @@ mailbox0_cluster1: mailbox@31f81000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox0_cluster2: mailbox@31f82000 {
> @@ -483,7 +481,6 @@ mailbox0_cluster2: mailbox@31f82000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox0_cluster3: mailbox@31f83000 {
> @@ -493,7 +490,6 @@ mailbox0_cluster3: mailbox@31f83000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox0_cluster4: mailbox@31f84000 {
> @@ -503,7 +499,6 @@ mailbox0_cluster4: mailbox@31f84000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox0_cluster5: mailbox@31f85000 {
> @@ -513,7 +508,6 @@ mailbox0_cluster5: mailbox@31f85000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox0_cluster6: mailbox@31f86000 {
> @@ -523,7 +517,6 @@ mailbox0_cluster6: mailbox@31f86000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox0_cluster7: mailbox@31f87000 {
> @@ -533,7 +526,6 @@ mailbox0_cluster7: mailbox@31f87000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox0_cluster8: mailbox@31f88000 {
> @@ -543,7 +535,6 @@ mailbox0_cluster8: mailbox@31f88000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox0_cluster9: mailbox@31f89000 {
> @@ -553,7 +544,6 @@ mailbox0_cluster9: mailbox@31f89000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox0_cluster10: mailbox@31f8a000 {
> @@ -563,7 +553,6 @@ mailbox0_cluster10: mailbox@31f8a000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox0_cluster11: mailbox@31f8b000 {
> @@ -573,7 +562,6 @@ mailbox0_cluster11: mailbox@31f8b000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox1_cluster0: mailbox@31f90000 {
> @@ -583,7 +571,6 @@ mailbox1_cluster0: mailbox@31f90000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox1_cluster1: mailbox@31f91000 {
> @@ -593,7 +580,6 @@ mailbox1_cluster1: mailbox@31f91000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox1_cluster2: mailbox@31f92000 {
> @@ -603,7 +589,6 @@ mailbox1_cluster2: mailbox@31f92000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox1_cluster3: mailbox@31f93000 {
> @@ -613,7 +598,6 @@ mailbox1_cluster3: mailbox@31f93000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox1_cluster4: mailbox@31f94000 {
> @@ -623,7 +607,6 @@ mailbox1_cluster4: mailbox@31f94000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox1_cluster5: mailbox@31f95000 {
> @@ -633,7 +616,6 @@ mailbox1_cluster5: mailbox@31f95000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox1_cluster6: mailbox@31f96000 {
> @@ -643,7 +625,6 @@ mailbox1_cluster6: mailbox@31f96000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox1_cluster7: mailbox@31f97000 {
> @@ -653,7 +634,6 @@ mailbox1_cluster7: mailbox@31f97000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox1_cluster8: mailbox@31f98000 {
> @@ -663,7 +643,6 @@ mailbox1_cluster8: mailbox@31f98000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox1_cluster9: mailbox@31f99000 {
> @@ -673,7 +652,6 @@ mailbox1_cluster9: mailbox@31f99000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox1_cluster10: mailbox@31f9a000 {
> @@ -683,7 +661,6 @@ mailbox1_cluster10: mailbox@31f9a000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		mailbox1_cluster11: mailbox@31f9b000 {
> @@ -693,7 +670,6 @@ mailbox1_cluster11: mailbox@31f9b000 {
>  			ti,mbox-num-users = <4>;
>  			ti,mbox-num-fifos = <16>;
>  			interrupt-parent = <&main_navss_intr>;
> -			status = "disabled";
>  		};
>  
>  		main_ringacc: ringacc@3c000000 {
> @@ -1102,4 +1078,108 @@ main_spi7: spi@2170000 {
>  		clocks = <&k3_clks 346 1>;
>  		status = "disabled";
>  	};
> +
> +	main_r5fss0: r5fss@5c00000 {
> +		compatible = "ti,j721s2-r5fss";
> +		ti,cluster-mode = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
> +			 <0x5d00000 0x00 0x5d00000 0x20000>;
> +		power-domains = <&k3_pds 277 TI_SCI_PD_EXCLUSIVE>;
> +
> +		main_r5fss0_core0: r5f@5c00000 {
> +			compatible = "ti,j721s2-r5f";
> +			reg = <0x5c00000 0x00010000>,
> +			      <0x5c10000 0x00010000>;
> +			reg-names = "atcm", "btcm";
> +			ti,sci = <&sms>;
> +			ti,sci-dev-id = <279>;
> +			ti,sci-proc-ids = <0x06 0xff>;
> +			resets = <&k3_reset 279 1>;
> +			firmware-name = "j721s2-main-r5f0_0-fw";
> +			ti,atcm-enable = <1>;
> +			ti,btcm-enable = <1>;
> +			ti,loczrama = <1>;
> +		};
> +
> +		main_r5fss0_core1: r5f@5d00000 {
> +			compatible = "ti,j721s2-r5f";
> +			reg = <0x5d00000 0x00010000>,
> +			      <0x5d10000 0x00010000>;
> +			reg-names = "atcm", "btcm";
> +			ti,sci = <&sms>;
> +			ti,sci-dev-id = <280>;
> +			ti,sci-proc-ids = <0x07 0xff>;
> +			resets = <&k3_reset 280 1>;
> +			firmware-name = "j721s2-main-r5f0_1-fw";
> +			ti,atcm-enable = <1>;
> +			ti,btcm-enable = <1>;
> +			ti,loczrama = <1>;
> +		};
> +	};
> +
> +	main_r5fss1: r5fss@5e00000 {
> +		compatible = "ti,j721s2-r5fss";
> +		ti,cluster-mode = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
> +			 <0x5f00000 0x00 0x5f00000 0x20000>;
> +		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
> +
> +		main_r5fss1_core0: r5f@5e00000 {
> +			compatible = "ti,j721s2-r5f";
> +			reg = <0x5e00000 0x00010000>,
> +			      <0x5e10000 0x00010000>;
> +			reg-names = "atcm", "btcm";
> +			ti,sci = <&sms>;
> +			ti,sci-dev-id = <281>;
> +			ti,sci-proc-ids = <0x08 0xff>;
> +			resets = <&k3_reset 281 1>;
> +			firmware-name = "j721s2-main-r5f1_0-fw";
> +			ti,atcm-enable = <1>;
> +			ti,btcm-enable = <1>;
> +			ti,loczrama = <1>;
> +		};
> +
> +		main_r5fss1_core1: r5f@5f00000 {
> +			compatible = "ti,j721s2-r5f";
> +			reg = <0x5f00000 0x00010000>,
> +			      <0x5f10000 0x00010000>;
> +			reg-names = "atcm", "btcm";
> +			ti,sci = <&sms>;
> +			ti,sci-dev-id = <282>;
> +			ti,sci-proc-ids = <0x09 0xff>;
> +			resets = <&k3_reset 282 1>;
> +			firmware-name = "j721s2-main-r5f1_1-fw";
> +			ti,atcm-enable = <1>;
> +			ti,btcm-enable = <1>;
> +			ti,loczrama = <1>;
> +		};
> +	};
> +
> +	c71_0: dsp@64800000 {
> +		compatible = "ti,j721s2-c71-dsp";
> +		reg = <0x00 0x64800000 0x00 0x00080000>,
> +		      <0x00 0x64e00000 0x00 0x0000c000>;
> +		reg-names = "l2sram", "l1dram";
> +		ti,sci = <&sms>;
> +		ti,sci-dev-id = <8>;
> +		ti,sci-proc-ids = <0x30 0xff>;
> +		resets = <&k3_reset 8 1>;
> +		firmware-name = "j721s2-c71_0-fw";
> +	};
> +
> +	c71_1: dsp@65800000 {
> +		compatible = "ti,j721s2-c71-dsp";
> +		reg = <0x00 0x65800000 0x00 0x00080000>,
> +		      <0x00 0x65e00000 0x00 0x0000c000>;
> +		reg-names = "l2sram", "l1dram";
> +		ti,sci = <&sms>;
> +		ti,sci-dev-id = <11>;
> +		ti,sci-proc-ids = <0x31 0xff>;
> +		resets = <&k3_reset 11 1>;
> +		firmware-name = "j721s2-c71_1-fw";
> +	};
>  };
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
