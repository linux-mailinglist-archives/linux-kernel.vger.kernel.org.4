Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10BB69EE0A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjBVEvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBVEvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:51:42 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F17D2CFE0;
        Tue, 21 Feb 2023 20:51:40 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31M4pVov008548;
        Tue, 21 Feb 2023 22:51:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677041491;
        bh=GZ2F7R5667Lye5CFgpg6mK7+8fGz7Cc5bqG+FUXmV8s=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=AFaGNSL9FSIqFVIegfDbbhRqSJjTvig07+XYOGq/MyPrh/PGih6zVGI5vCmpNvKzM
         Klw7+54Th4Bxs2L42p/3OwELj7fcXUalHsodPwUEbDcj4X6W0gqzBp5raaRc2mEeAq
         UF8Z2W4taCcCtaIeZNnQyq01DKOCVRPhAfIHAOLA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31M4pViT108034
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Feb 2023 22:51:31 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Feb 2023 22:51:31 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Feb 2023 22:51:31 -0600
Received: from [10.24.69.79] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31M4pR6f047514;
        Tue, 21 Feb 2023 22:51:28 -0600
Message-ID: <a74bf007-40b5-3d92-ba30-c50a2bf4a3c0@ti.com>
Date:   Wed, 22 Feb 2023 10:21:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 2/9] arm64: dts: ti: k3-j721s2-main: Add support for
 USB
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230221120612.27366-1-r-gunasekaran@ti.com>
 <20230221120612.27366-3-r-gunasekaran@ti.com>
 <20230221135852.n3yukx55q7jmqbgk@chowder>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20230221135852.n3yukx55q7jmqbgk@chowder>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/02/23 7:28 pm, Nishanth Menon wrote:
> On 17:36-20230221, Ravi Gunasekaran wrote:
>> From: Aswath Govindraju <a-govindraju@ti.com>
>>
>> Add support for single instance of USB 3.0 controller in J721S2 SoC.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> Signed-off-by: Matt Ranostay <mranostay@ti.com>
>> Link: https://lore.kernel.org/r/20221122101616.770050-2-mranostay@ti.com
> 
> Is the link supposed to signify some reference we need to keep for ever?

No. I will remove the reference to the link. I picked up the v7 series from
previous submitter through "b4" and maintained the Link tag as-is since then.
I will remove the reference to the link in the next series.

> 
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>> I had reviewed this patch in the v5 series [1].
>> Since I'm taking over upstreaming this series, I removed the self
>> Reviewed-by tag.
>>
>> Links:
>>
>> [1] - https://lore.kernel.org/all/134c28a0-2d49-549c-dc8d-0887d8fd29c3@ti.com/
> 
> 
> What changed in this rev of the patch?

Only one change in the patch since v5; Status of the some nodes introduced
in this patch is set to disabled.

> 
>>
>>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 46 ++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> index 8915132efcc1..84e5689fff9f 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> @@ -26,6 +26,20 @@
>>  		};
>>  	};
>>  
>> +	scm_conf: syscon@104000 {
>> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
>> +		reg = <0x00 0x00104000 0x00 0x18000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x00 0x00 0x00104000 0x18000>;
>> +
>> +		usb_serdes_mux: mux-controller@0 {
>> +			compatible = "mmio-mux";
>> +			#mux-control-cells = <1>;
>> +			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
>> +		};
>> +	};
>> +
>>  	gic500: interrupt-controller@1800000 {
>>  		compatible = "arm,gic-v3";
>>  		#address-cells = <2>;
>> @@ -745,6 +759,38 @@
>>  		};
>>  	};
>>  
>> +	usbss0: cdns-usb@4104000 {
>> +		compatible = "ti,j721e-usb";
>> +		reg = <0x00 0x04104000 0x00 0x100>;
>> +		clocks = <&k3_clks 360 16>, <&k3_clks 360 15>;
>> +		clock-names = "ref", "lpm";
>> +		assigned-clocks = <&k3_clks 360 16>; /* USB2_REFCLK */
>> +		assigned-clock-parents = <&k3_clks 360 17>;
>> +		power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +		dma-coherent;
>> +
>> +		status = "disabled";
> 
> Why disabled by default?

One of the comment received in the v9 series was to disable the node in
the include file and then enable it in the board specific DTS file.
Changes in this series addressed that comment.

> 
>> +
>> +		usb0: usb@6000000 {
>> +			compatible = "cdns,usb3";
>> +			reg = <0x00 0x06000000 0x00 0x10000>,
>> +			      <0x00 0x06010000 0x00 0x10000>,
>> +			      <0x00 0x06020000 0x00 0x10000>;
>> +			reg-names = "otg", "xhci", "dev";
>> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "host", "peripheral", "otg";
>> +			maximum-speed = "super-speed";
>> +			dr_mode = "otg";
>> +
>> +			status = "disabled";
> 
> Why disabled by default?

See above.

> 
>> +		};
>> +	};
>> +
>>  	main_mcan0: can@2701000 {
>>  		compatible = "bosch,m_can";
>>  		reg = <0x00 0x02701000 0x00 0x200>,
>> -- 
>> 2.17.1
>>

-- 
Regards,
Ravi
