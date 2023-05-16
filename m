Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04227053B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjEPQ1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjEPQ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:27:35 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894CE76B2;
        Tue, 16 May 2023 09:27:17 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34GGR4rS064015;
        Tue, 16 May 2023 11:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684254424;
        bh=WqvJ/4WnxrrVuSg2KxGFrr41qkXZ/lftW03c45BZsMU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=op4KKKiuDXewfNPIvAdrfRr04k98MZUYcBaeLu4RIuwNBCZNF8vEHO/6GMrQZSy1q
         jRuW1nhVpTUf+xRn72q7XR3SkTdQyPcRdPSVrjrVaaq1jNAz1nmkEO9KfCbdGAueIH
         v7uWSMr14eG6U204os3uhB0C4olnJZK70TpgsRfU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34GGR4le029398
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 11:27:04 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 11:27:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 11:27:03 -0500
Received: from [10.250.35.184] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34GGR3dZ016723;
        Tue, 16 May 2023 11:27:03 -0500
Message-ID: <4ff112d9-5c94-e7eb-8c94-4be769285a03@ti.com>
Date:   Tue, 16 May 2023 11:27:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/5] arm64: dts: ti: k3-j721e: Remove PCIe endpoint nodes
Content-Language: en-US
To:     "Verma, Achal" <a-verma1@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Nelson <robertcnelson@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230515172137.474626-1-afd@ti.com>
 <20230515172137.474626-2-afd@ti.com>
 <1de1328a-cfc9-d77c-eb11-3c341b46623b@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <1de1328a-cfc9-d77c-eb11-3c341b46623b@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/23 11:22 AM, Verma, Achal wrote:
> 
> 
> On 5/15/2023 10:51 PM, Andrew Davis wrote:
>> These nodes are example nodes for the PCIe controller in "endpoint" mode.
>> By default the controller is in "root complex" mode and there is already a
>> DT node for the same.
>>
>> Examples should go in the bindings or other documentation.
>>
>> Remove this node.
> How we will support EP from now onwards, using overlays ?
> 

They are already disabled, how do you support them today?

Andrew

> Regards,
> Achal Verma
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 24 ------
>>   .../dts/ti/k3-j721e-common-proc-board.dts     | 25 ------
>>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 82 -------------------
>>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 24 ------
>>   4 files changed, 155 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
>> index 8a62ac263b89..d77eeff0d81d 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
>> @@ -892,35 +892,11 @@ &pcie2_rc {
>>       status = "disabled";
>>   };
>> -&pcie0_ep {
>> -    status = "disabled";
>> -    phys = <&serdes0_pcie_link>;
>> -    phy-names = "pcie-phy";
>> -    num-lanes = <1>;
>> -};
>> -
>> -&pcie1_ep {
>> -    status = "disabled";
>> -    phys = <&serdes1_pcie_link>;
>> -    phy-names = "pcie-phy";
>> -    num-lanes = <2>;
>> -};
>> -
>> -&pcie2_ep {
>> -    /* Unused */
>> -    status = "disabled";
>> -};
>> -
>>   &pcie3_rc {
>>       /* Unused */
>>       status = "disabled";
>>   };
>> -&pcie3_ep {
>> -    /* Unused */
>> -    status = "disabled";
>> -};
>> -
>>   &icssg0_mdio {
>>       /* Unused */
>>       status = "disabled";
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
>> index 7db0603125aa..87b7263f6547 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
>> @@ -840,35 +840,10 @@ &pcie2_rc {
>>       num-lanes = <2>;
>>   };
>> -&pcie0_ep {
>> -    phys = <&serdes0_pcie_link>;
>> -    phy-names = "pcie-phy";
>> -    num-lanes = <1>;
>> -    status = "disabled";
>> -};
>> -
>> -&pcie1_ep {
>> -    phys = <&serdes1_pcie_link>;
>> -    phy-names = "pcie-phy";
>> -    num-lanes = <2>;
>> -    status = "disabled";
>> -};
>> -
>> -&pcie2_ep {
>> -    phys = <&serdes2_pcie_link>;
>> -    phy-names = "pcie-phy";
>> -    num-lanes = <2>;
>> -    status = "disabled";
>> -};
>> -
>>   &pcie3_rc {
>>       status = "disabled";
>>   };
>> -&pcie3_ep {
>> -    status = "disabled";
>> -};
>> -
>>   &icssg0_mdio {
>>       status = "disabled";
>>   };
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> index 10c8a5fb4ee2..e39f6d1e8d40 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> @@ -816,26 +816,6 @@ pcie0_rc: pcie@2900000 {
>>           dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
>>       };
>> -    pcie0_ep: pcie-ep@2900000 {
>> -        compatible = "ti,j721e-pcie-ep";
>> -        reg = <0x00 0x02900000 0x00 0x1000>,
>> -              <0x00 0x02907000 0x00 0x400>,
>> -              <0x00 0x0d000000 0x00 0x00800000>,
>> -              <0x00 0x10000000 0x00 0x08000000>;
>> -        reg-names = "intd_cfg", "user_cfg", "reg", "mem";
>> -        interrupt-names = "link_state";
>> -        interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
>> -        ti,syscon-pcie-ctrl = <&scm_conf 0x4070>;
>> -        max-link-speed = <3>;
>> -        num-lanes = <2>;
>> -        power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
>> -        clocks = <&k3_clks 239 1>;
>> -        clock-names = "fck";
>> -        max-functions = /bits/ 8 <6>;
>> -        max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
>> -        dma-coherent;
>> -    };
>> -
>>       pcie1_rc: pcie@2910000 {
>>           compatible = "ti,j721e-pcie-host";
>>           reg = <0x00 0x02910000 0x00 0x1000>,
>> @@ -864,26 +844,6 @@ pcie1_rc: pcie@2910000 {
>>           dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
>>       };
>> -    pcie1_ep: pcie-ep@2910000 {
>> -        compatible = "ti,j721e-pcie-ep";
>> -        reg = <0x00 0x02910000 0x00 0x1000>,
>> -              <0x00 0x02917000 0x00 0x400>,
>> -              <0x00 0x0d800000 0x00 0x00800000>,
>> -              <0x00 0x18000000 0x00 0x08000000>;
>> -        reg-names = "intd_cfg", "user_cfg", "reg", "mem";
>> -        interrupt-names = "link_state";
>> -        interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
>> -        ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
>> -        max-link-speed = <3>;
>> -        num-lanes = <2>;
>> -        power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
>> -        clocks = <&k3_clks 240 1>;
>> -        clock-names = "fck";
>> -        max-functions = /bits/ 8 <6>;
>> -        max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
>> -        dma-coherent;
>> -    };
>> -
>>       pcie2_rc: pcie@2920000 {
>>           compatible = "ti,j721e-pcie-host";
>>           reg = <0x00 0x02920000 0x00 0x1000>,
>> @@ -912,26 +872,6 @@ pcie2_rc: pcie@2920000 {
>>           dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
>>       };
>> -    pcie2_ep: pcie-ep@2920000 {
>> -        compatible = "ti,j721e-pcie-ep";
>> -        reg = <0x00 0x02920000 0x00 0x1000>,
>> -              <0x00 0x02927000 0x00 0x400>,
>> -              <0x00 0x0e000000 0x00 0x00800000>,
>> -              <0x44 0x00000000 0x00 0x08000000>;
>> -        reg-names = "intd_cfg", "user_cfg", "reg", "mem";
>> -        interrupt-names = "link_state";
>> -        interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
>> -        ti,syscon-pcie-ctrl = <&scm_conf 0x4078>;
>> -        max-link-speed = <3>;
>> -        num-lanes = <2>;
>> -        power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
>> -        clocks = <&k3_clks 241 1>;
>> -        clock-names = "fck";
>> -        max-functions = /bits/ 8 <6>;
>> -        max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
>> -        dma-coherent;
>> -    };
>> -
>>       pcie3_rc: pcie@2930000 {
>>           compatible = "ti,j721e-pcie-host";
>>           reg = <0x00 0x02930000 0x00 0x1000>,
>> @@ -960,28 +900,6 @@ pcie3_rc: pcie@2930000 {
>>           dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
>>       };
>> -    pcie3_ep: pcie-ep@2930000 {
>> -        compatible = "ti,j721e-pcie-ep";
>> -        reg = <0x00 0x02930000 0x00 0x1000>,
>> -              <0x00 0x02937000 0x00 0x400>,
>> -              <0x00 0x0e800000 0x00 0x00800000>,
>> -              <0x44 0x10000000 0x00 0x08000000>;
>> -        reg-names = "intd_cfg", "user_cfg", "reg", "mem";
>> -        interrupt-names = "link_state";
>> -        interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
>> -        ti,syscon-pcie-ctrl = <&scm_conf 0x407c>;
>> -        max-link-speed = <3>;
>> -        num-lanes = <2>;
>> -        power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
>> -        clocks = <&k3_clks 242 1>;
>> -        clock-names = "fck";
>> -        max-functions = /bits/ 8 <6>;
>> -        max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
>> -        dma-coherent;
>> -        #address-cells = <2>;
>> -        #size-cells = <2>;
>> -    };
>> -
>>       serdes_wiz4: wiz@5050000 {
>>           compatible = "ti,am64-wiz-10g";
>>           #address-cells = <1>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>> index f650a7fd66b4..07d3282a583b 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
>> @@ -896,35 +896,11 @@ &pcie2_rc {
>>       status = "disabled";
>>   };
>> -&pcie0_ep {
>> -    status = "disabled";
>> -    phys = <&serdes0_pcie_link>;
>> -    phy-names = "pcie-phy";
>> -    num-lanes = <1>;
>> -};
>> -
>> -&pcie1_ep {
>> -    status = "disabled";
>> -    phys = <&serdes1_pcie_link>;
>> -    phy-names = "pcie-phy";
>> -    num-lanes = <2>;
>> -};
>> -
>> -&pcie2_ep {
>> -    /* Unused */
>> -    status = "disabled";
>> -};
>> -
>>   &pcie3_rc {
>>       /* Unused */
>>       status = "disabled";
>>   };
>> -&pcie3_ep {
>> -    /* Unused */
>> -    status = "disabled";
>> -};
>> -
>>   &icssg0_mdio {
>>       status = "disabled";
>>   };
