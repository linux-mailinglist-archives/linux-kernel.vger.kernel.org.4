Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0739E6A3E01
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjB0JNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjB0JMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:12:52 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B355F244BC;
        Mon, 27 Feb 2023 01:05:17 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31R8VmGR098538;
        Mon, 27 Feb 2023 02:31:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677486708;
        bh=cOUx36NOUV9wAf7n+j0ODqotAHa1wOpCu5dRigafLDI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=vr+2ovQ6+2lZQx63tBxZ9o1uH87lUE3ik7Vpj+1euaMMO/cOd2xrCBYVPmjKonIzM
         CMZFBcvK2Tdx4pexCx3+lUn4WJkrs/BRfSln05RtPod/Pu9nFubmTIZOdPEG0tA8zK
         +ZK8UcbUD3AB2wS8KRcudUQ4Xf834eN9tmpJ2MLs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31R8Vm8d062728
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Feb 2023 02:31:48 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 27
 Feb 2023 02:31:47 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 27 Feb 2023 02:31:47 -0600
Received: from [10.24.69.79] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31R8VhNo006934;
        Mon, 27 Feb 2023 02:31:44 -0600
Message-ID: <a50f4623-edc6-f7c6-333d-551cf1f7eea7@ti.com>
Date:   Mon, 27 Feb 2023 14:01:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [EXTERNAL] Re: [PATCH v11 3/8] arm64: dts: ti:
 k3-j721s2-mcu-wakeup: Add support of OSPI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <nm@ti.com>,
        <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <vaishnav.a@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230224102438.6541-1-r-gunasekaran@ti.com>
 <20230224102438.6541-4-r-gunasekaran@ti.com>
 <7e236ecc-1cb4-b53b-fb68-c23aa45c4cd2@linaro.org>
Content-Language: en-US
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <7e236ecc-1cb4-b53b-fb68-c23aa45c4cd2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/02/23 4:39 pm, Krzysztof Kozlowski wrote:
> On 24/02/2023 11:24, Ravi Gunasekaran wrote:
>> From: Aswath Govindraju <a-govindraju@ti.com>
>>
>> Add support for two instance of OSPI in J721S2 SoC.
>>
>> Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> Signed-off-by: Matt Ranostay <mranostay@ti.com>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>> Changes from v10:
>> * Documented the reason for disabling the nodes by default.
>> * Removed Link tag from commmit message
>>

[...]

>>
>>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 62 +++++++++++++++++++
>>  1 file changed, 62 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>> index 0af242aa9816..5005a3ebbd34 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>> @@ -306,4 +306,66 @@
>>  			ti,cpts-periodic-outputs = <2>;
>>  		};
>>  	};
>> +
>> +	fss: bus@47000000 {
>> +		compatible = "simple-bus";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges = <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
>> +			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
>> +			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
>> +
>> +		/*
>> +		 * Disable the node by default in the common include file.
>> +		 * And enable it in the board specific DT file where the
>> +		 * pinmux property is added.
> 
> Why? Bus does not need pinmux.

Right. The comment is invalid for the bus node. Will remove it in the next
series.

> 
>> +		 */
>> +		status = "disabled";
>> +
>> +		ospi0: spi@47040000 {
>> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
>> +			reg = <0x00 0x47040000 0x00 0x100>,
>> +			      <0x05 0x00000000 0x01 0x00000000>;
>> +			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
>> +			cdns,fifo-depth = <256>;
>> +			cdns,fifo-width = <4>;
>> +			cdns,trigger-address = <0x0>;
>> +			clocks = <&k3_clks 109 5>;
>> +			assigned-clocks = <&k3_clks 109 5>;
>> +			assigned-clock-parents = <&k3_clks 109 7>;
>> +			assigned-clock-rates = <166666666>;
>> +			power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			/*
>> +			 * Disable the node by default in the common include
>> +			 * file. And enable it in the board specific DT file
>> +			 * where the pinmux property is added.
> 
> Isn't this comment obvious? It's what we do everywhere on every platform
> every SoC?
> 

Noted. Will remove the elaborate comment.

>> +			 */
>> +			status = "disabled";
>> +		};
>> +
>> +		ospi1: spi@47050000 {
>> +			compatible = "ti,am654-ospi", "cdns,qspi-nor";
>> +			reg = <0x00 0x47050000 0x00 0x100>,
>> +			      <0x07 0x00000000 0x01 0x00000000>;
>> +			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
>> +			cdns,fifo-depth = <256>;
>> +			cdns,fifo-width = <4>;
>> +			cdns,trigger-address = <0x0>;
>> +			clocks = <&k3_clks 110 5>;
>> +			power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			/*
>> +			 * Disable the node by default in the common include
>> +			 * file. And enable it in the board specific DT file
>> +			 * where the pinmux property is added.
>> +			 */
>> +			status = "disabled";
>> +		};
>> +
> 
> No need for blank line.

Will remove the blank line.

> 
>> +	};
>>  };
> 
> Best regards,
> Krzysztof
> 

-- 
Regards,
Ravi
