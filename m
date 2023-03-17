Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873036BE770
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCQK7d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Mar 2023 06:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCQK7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:59:30 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937FD1BAF2;
        Fri, 17 Mar 2023 03:59:28 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 164C624DBC2;
        Fri, 17 Mar 2023 18:59:27 +0800 (CST)
Received: from EXMBX071.cuchost.com (172.16.6.81) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 17 Mar
 2023 18:59:27 +0800
Received: from [192.168.125.108] (113.72.145.194) by EXMBX071.cuchost.com
 (172.16.6.81) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 17 Mar
 2023 18:59:26 +0800
Message-ID: <11873190-a8ff-e93d-5c08-8a24903c170d@starfivetech.com>
Date:   Fri, 17 Mar 2023 18:59:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 5/5] dts: usb: add StarFive JH7110 USB dts
 configuration.
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20230315104411.73614-1-minda.chen@starfivetech.com>
 <20230315104411.73614-6-minda.chen@starfivetech.com>
 <79593668-6ded-7290-f39b-e226d30e6e95@linaro.org>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <79593668-6ded-7290-f39b-e226d30e6e95@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.145.194]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX071.cuchost.com
 (172.16.6.81)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/17 16:44, Krzysztof Kozlowski wrote:
> On 15/03/2023 11:44, Minda Chen wrote:
>> USB Glue layer and Cadence USB subnode configuration,
>> also includes USB and PCIe phy dts configuration.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> 
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).
>ok
>> ---
>>  .../jh7110-starfive-visionfive-2.dtsi         |  7 +++
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 54 +++++++++++++++++++
>>  2 files changed, 61 insertions(+)
>> 
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> index a132debb9b53..c64476aebc1a 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> @@ -236,3 +236,10 @@
>>  	pinctrl-0 = <&uart0_pins>;
>>  	status = "okay";
>>  };
>> +
>> +&usb0 {
>> +	status = "okay";
>> +	usbdrd_cdns3: usb@0 {
> 
> You should rather override by phandle this as well.
> 
I will remove the wrapper node 'usb0'. 

Just like this :
+&usbdrd_cdns3 {
+       dr_mode = "peripheral";
+};


（similar configuration in arch/arm64/boot/dts/ti/k3-j721e-sk.dts, usb1 node)
   &usb1 {
        dr_mode = "host";
        ....
  
>> +		dr_mode = "peripheral";
>> +	};
>> +};
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> index f70a4ed47eb4..17722fd1be62 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -362,6 +362,60 @@
>>  			status = "disabled";
>>  		};
>>  
>> +		usb0: usb@10100000 {
>> +			compatible = "starfive,jh7110-usb";
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
>> +			starfive,stg-syscon = <&stg_syscon 0x4 0xc4 0x148 0x1f4>;
>> +			starfive,sys-syscon = <&sys_syscon 0x18>;
>> +			status = "disabled";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges = <0x0 0x0 0x10100000 0x100000>;
> 
> reg and ranges should be second property. This also applies to your
> binding example.
> 
> 
ok, thanks
> Best regards,
> Krzysztof
> 
