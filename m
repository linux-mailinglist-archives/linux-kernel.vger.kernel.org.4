Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F22F6EF4A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbjDZMrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbjDZMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4839D5FCA;
        Wed, 26 Apr 2023 05:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A451F6364D;
        Wed, 26 Apr 2023 12:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02C2C433EF;
        Wed, 26 Apr 2023 12:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682513172;
        bh=6wRdWp5ZpsEcT/z2Q3IrFU3hpwPCXkjls4+igISayBY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WR9mzrdB0a2QcQSr2cebEYy0+rSZZIT2UeeZJtYZ2cjuRYbyexcANkIpYHj0Ch7fA
         n7nsTIEmrWi8JwBlVqWlU/BQI8GFplCoJzV/cwAv6T+sExWOfO8ze9h8//BJ/7nLj1
         yu3c0qEMOJ+UVVg8pNMZRM4EK9CKTdyUnj2HTk3aQ/YSzh08lwyxNSL3rMgqMQlzbz
         G+JUuuIngQtA8VGGSM2lFI6BfGa5n7vd6yCjClg/6T8g0SUBUZrMyGKLpKxsPA+bhh
         HqWFmOqcFHef0hnau22g7/dLnnRSnXY8cK55AXGKS5iiX0avqfTLz4uAamqGO2+nd3
         rfgHJp4PWdd8w==
Message-ID: <d1051856-1177-b5b8-6761-28da80a3cb7c@kernel.org>
Date:   Wed, 26 Apr 2023 15:46:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 7/7] riscv: dts: starfive: Add USB dts configuration
 for JH7110
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
References: <20230420110052.3182-1-minda.chen@starfivetech.com>
 <20230420110052.3182-8-minda.chen@starfivetech.com>
 <3f2baded-c5d6-7d94-00f3-6d8fb24262c4@kernel.org>
 <4b0220ac-23bf-4206-eba2-2842a216bb24@starfivetech.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <4b0220ac-23bf-4206-eba2-2842a216bb24@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minda,

On 26/04/2023 14:05, Minda Chen wrote:
> 
> 
> On 2023/4/24 22:53, Roger Quadros wrote:
>>
>>
>> On 20/04/2023 14:00, Minda Chen wrote:
>>> Add USB wrapper layer and Cadence USB3 controller dts
>>> configuration for StarFive JH7110 SoC and VisionFive2
>>> Board.
>>> USB controller connect to PHY, The PHY dts configuration
>>> are also added.
>>>
>>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>>> ---
>>>  .../jh7110-starfive-visionfive-2.dtsi         |  7 +++
>>>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 44 +++++++++++++++++++
>>>  2 files changed, 51 insertions(+)
>>>
>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>>> index 1155b97b593d..fa97ebfd93ad 100644
>>> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>>> @@ -221,3 +221,10 @@
>>>  	pinctrl-0 = <&uart0_pins>;
>>>  	status = "okay";
>>>  };
>>> +
>>> +&usb0 {
>>> +	phys = <&usbphy0>;
>>> +	phy-names = "usb2";
>>> +	dr_mode = "peripheral";
>>> +	status = "okay";
>>> +};
>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>> index 29cd798b6732..eee395e19cdb 100644
>>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>> @@ -366,6 +366,50 @@
>>>  			status = "disabled";
>>>  		};
>>>  
>>> +		usb0: usb@10100000 {
>>> +			compatible = "starfive,jh7110-usb";
>>> +			reg = <0x0 0x10100000 0x0 0x10000>,
>>> +			      <0x0 0x10110000 0x0 0x10000>,
>>> +			      <0x0 0x10120000 0x0 0x10000>;
>>> +			reg-names = "otg", "xhci", "dev";
>>> +			interrupts = <100>, <108>, <110>;
>>> +			interrupt-names = "host", "peripheral", "otg";
>>> +			clocks = <&stgcrg JH7110_STGCLK_USB0_LPM>,
>>> +				 <&stgcrg JH7110_STGCLK_USB0_STB>,
>>> +				 <&stgcrg JH7110_STGCLK_USB0_APB>,
>>> +				 <&stgcrg JH7110_STGCLK_USB0_AXI>,
>>> +				 <&stgcrg JH7110_STGCLK_USB0_UTMI_APB>;
>>> +			clock-names = "lpm", "stb", "apb", "axi", "utmi_apb";
>>> +			resets = <&stgcrg JH7110_STGRST_USB0_PWRUP>,
>>> +				 <&stgcrg JH7110_STGRST_USB0_APB>,
>>> +				 <&stgcrg JH7110_STGRST_USB0_AXI>,
>>> +				 <&stgcrg JH7110_STGRST_USB0_UTMI_APB>;
>>> +			reset-names = "pwrup", "apb", "axi", "utmi_apb";
>>
>> All this can really be "cdns,usb3" node. The cdns,usb3 driver should
>> do reset and clocks init as it is generic.
>>
> But I can't find clock and reset init in Cadence codes while dwc usb3 can find. 
> It looks only if clocks and reset generic init codes required to be added in  Cadence codes to support generic clock and reset init.
>>> +			starfive,stg-syscon = <&stg_syscon 0x4>;
>>> +			status = "disabled";
>>
>> Only the syscon handling looks starfive specific so only that handling
>> should be done in starfive USB driver.
>>
>> This node should look like this
>>
>>  
>> 	starfive-usb@4 {
>> 		compatible = "starfive,jh7110-usb";
>> 		starfive,stg-syscon = <&stg_syscon 0x4>;
>>
>> 		usb0: usb@10100000 {
>> 			compatible = "cdns,usb3";
>> 			reg = <0x0 0x10100000 0x0 0x10000>,
>> 			      <0x0 0x10110000 0x0 0x10000>,
>> 			      <0x0 0x10120000 0x0 0x10000>;
>> 			reg-names = "otg", "xhci", "dev";
>> 			interrupts = <100>, <108>, <110>;
>> 			interrupt-names = "host", "peripheral", "otg";
>> 			clocks = <&stgcrg JH7110_STGCLK_USB0_LPM>,
>> 				 <&stgcrg JH7110_STGCLK_USB0_STB>,
>> 				 <&stgcrg JH7110_STGCLK_USB0_APB>,
>> 				 <&stgcrg JH7110_STGCLK_USB0_AXI>,
>> 				 <&stgcrg JH7110_STGCLK_USB0_UTMI_APB>;
>> 			clock-names = "lpm", "stb", "apb", "axi", "utmi_apb";
>> 			resets = <&stgcrg JH7110_STGRST_USB0_PWRUP>,
>> 				 <&stgcrg JH7110_STGRST_USB0_APB>,
>> 				 <&stgcrg JH7110_STGRST_USB0_AXI>,
>> 				 <&stgcrg JH7110_STGRST_USB0_UTMI_APB>;
>> 			reset-names = "pwrup", "apb", "axi", "utmi_apb";
>> 			starfive,stg-syscon = <&stg_syscon 0x4>;
>> 			status = "disabled";
>> 		};
>> 	}
>>> In starfife-usb driver you can use of_platform_default_populate()
>> to create the cdns,usb3 child for you.
>>
> But actually the the syscon is not belong to USB. Below is Rob's previous comments. I am follow Rob's comments to change this.

Managing these syscon registers cannot be done in cdns,usb3 driver.
So you definitely need a wrapper driver for that.

>  
>   This pattern of USB wrapper and then a "generic" IP node is discouraged if it is just clocks, resets, power-domains, etc. IOW, unless there's an actual wrapper h/w block with its own registers, then don't do this split. 
>   Merge it all into a single node.
> 
> Rob and Rogers
>   Could you design whether merge the usb nodes？ 
> dt-binding，USB codes are different in two case.
>  

There should ideally be only one USB node and that should use "cdns,usb3" compatible.
Clocks, resets and power-domain handling should be done in cdns,usb3 driver.

But since you also need to manage some syscon registers "cdsn,usb3" driver is not
sufficient for you.

I will leave the DT-binding question for this case to Rob.

cheers,
-roger
