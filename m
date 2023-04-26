Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86A16EF309
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbjDZLFP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Apr 2023 07:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjDZLFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:05:12 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD70CDE;
        Wed, 26 Apr 2023 04:05:10 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4A83424E1D2;
        Wed, 26 Apr 2023 19:05:09 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Apr
 2023 19:05:09 +0800
Received: from [192.168.125.108] (113.72.145.137) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Apr
 2023 19:05:08 +0800
Message-ID: <4b0220ac-23bf-4206-eba2-2842a216bb24@starfivetech.com>
Date:   Wed, 26 Apr 2023 19:05:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 7/7] riscv: dts: starfive: Add USB dts configuration
 for JH7110
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Mason Huo" <mason.huo@starfivetech.com>
References: <20230420110052.3182-1-minda.chen@starfivetech.com>
 <20230420110052.3182-8-minda.chen@starfivetech.com>
 <3f2baded-c5d6-7d94-00f3-6d8fb24262c4@kernel.org>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <3f2baded-c5d6-7d94-00f3-6d8fb24262c4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.145.137]
X-ClientProxiedBy: EXCAS065.cuchost.com (172.16.6.25) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/24 22:53, Roger Quadros wrote:
> 
> 
> On 20/04/2023 14:00, Minda Chen wrote:
>> Add USB wrapper layer and Cadence USB3 controller dts
>> configuration for StarFive JH7110 SoC and VisionFive2
>> Board.
>> USB controller connect to PHY, The PHY dts configuration
>> are also added.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>  .../jh7110-starfive-visionfive-2.dtsi         |  7 +++
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 44 +++++++++++++++++++
>>  2 files changed, 51 insertions(+)
>> 
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> index 1155b97b593d..fa97ebfd93ad 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> @@ -221,3 +221,10 @@
>>  	pinctrl-0 = <&uart0_pins>;
>>  	status = "okay";
>>  };
>> +
>> +&usb0 {
>> +	phys = <&usbphy0>;
>> +	phy-names = "usb2";
>> +	dr_mode = "peripheral";
>> +	status = "okay";
>> +};
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> index 29cd798b6732..eee395e19cdb 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -366,6 +366,50 @@
>>  			status = "disabled";
>>  		};
>>  
>> +		usb0: usb@10100000 {
>> +			compatible = "starfive,jh7110-usb";
>> +			reg = <0x0 0x10100000 0x0 0x10000>,
>> +			      <0x0 0x10110000 0x0 0x10000>,
>> +			      <0x0 0x10120000 0x0 0x10000>;
>> +			reg-names = "otg", "xhci", "dev";
>> +			interrupts = <100>, <108>, <110>;
>> +			interrupt-names = "host", "peripheral", "otg";
>> +			clocks = <&stgcrg JH7110_STGCLK_USB0_LPM>,
>> +				 <&stgcrg JH7110_STGCLK_USB0_STB>,
>> +				 <&stgcrg JH7110_STGCLK_USB0_APB>,
>> +				 <&stgcrg JH7110_STGCLK_USB0_AXI>,
>> +				 <&stgcrg JH7110_STGCLK_USB0_UTMI_APB>;
>> +			clock-names = "lpm", "stb", "apb", "axi", "utmi_apb";
>> +			resets = <&stgcrg JH7110_STGRST_USB0_PWRUP>,
>> +				 <&stgcrg JH7110_STGRST_USB0_APB>,
>> +				 <&stgcrg JH7110_STGRST_USB0_AXI>,
>> +				 <&stgcrg JH7110_STGRST_USB0_UTMI_APB>;
>> +			reset-names = "pwrup", "apb", "axi", "utmi_apb";
> 
> All this can really be "cdns,usb3" node. The cdns,usb3 driver should
> do reset and clocks init as it is generic.
> 
But I can't find clock and reset init in Cadence codes while dwc usb3 can find. 
It looks only if clocks and reset generic init codes required to be added in  Cadence codes to support generic clock and reset init.
>> +			starfive,stg-syscon = <&stg_syscon 0x4>;
>> +			status = "disabled";
> 
> Only the syscon handling looks starfive specific so only that handling
> should be done in starfive USB driver.
> 
> This node should look like this
> 
>  
> 	starfive-usb@4 {
> 		compatible = "starfive,jh7110-usb";
> 		starfive,stg-syscon = <&stg_syscon 0x4>;
> 
> 		usb0: usb@10100000 {
> 			compatible = "cdns,usb3";
> 			reg = <0x0 0x10100000 0x0 0x10000>,
> 			      <0x0 0x10110000 0x0 0x10000>,
> 			      <0x0 0x10120000 0x0 0x10000>;
> 			reg-names = "otg", "xhci", "dev";
> 			interrupts = <100>, <108>, <110>;
> 			interrupt-names = "host", "peripheral", "otg";
> 			clocks = <&stgcrg JH7110_STGCLK_USB0_LPM>,
> 				 <&stgcrg JH7110_STGCLK_USB0_STB>,
> 				 <&stgcrg JH7110_STGCLK_USB0_APB>,
> 				 <&stgcrg JH7110_STGCLK_USB0_AXI>,
> 				 <&stgcrg JH7110_STGCLK_USB0_UTMI_APB>;
> 			clock-names = "lpm", "stb", "apb", "axi", "utmi_apb";
> 			resets = <&stgcrg JH7110_STGRST_USB0_PWRUP>,
> 				 <&stgcrg JH7110_STGRST_USB0_APB>,
> 				 <&stgcrg JH7110_STGRST_USB0_AXI>,
> 				 <&stgcrg JH7110_STGRST_USB0_UTMI_APB>;
> 			reset-names = "pwrup", "apb", "axi", "utmi_apb";
> 			starfive,stg-syscon = <&stg_syscon 0x4>;
> 			status = "disabled";
> 		};
> 	}
>> In starfife-usb driver you can use of_platform_default_populate()
> to create the cdns,usb3 child for you.
> 
But actually the the syscon is not belong to USB. Below is Rob's previous comments. I am follow Rob's comments to change this.
 
  This pattern of USB wrapper and then a "generic" IP node is discouraged if it is just clocks, resets, power-domains, etc. IOW, unless there's an actual wrapper h/w block with its own registers, then don't do this split. 
  Merge it all into a single node.

Rob and Rogers
  Could you design whether merge the usb nodes？ 
dt-binding，USB codes are different in two case.
 
>> +		};
>> +
>> +		usbphy0: phy@10200000 {
>> +			compatible = "starfive,jh7110-usb-phy";
>> +			reg = <0x0 0x10200000 0x0 0x10000>;
>> +			clocks = <&syscrg JH7110_SYSCLK_USB_125M>,
>> +				 <&stgcrg JH7110_STGCLK_USB0_APP_125>;
>> +			clock-names = "125m", "app_125m";
>> +			#phy-cells = <0>;
>> +		};
>> +
>> +		pciephy0: phy@10210000 {
>> +			compatible = "starfive,jh7110-pcie-phy";
>> +			reg = <0x0 0x10210000 0x0 0x10000>;
>> +			#phy-cells = <0>;
>> +		};
>> +
>> +		pciephy1: phy@10220000 {
>> +			compatible = "starfive,jh7110-pcie-phy";
>> +			reg = <0x0 0x10220000 0x0 0x10000>;
>> +			#phy-cells = <0>;
>> +		};
>> +
>>  		stgcrg: clock-controller@10230000 {
>>  			compatible = "starfive,jh7110-stgcrg";
>>  			reg = <0x0 0x10230000 0x0 0x10000>;
> 
> cheers,
> -roger
