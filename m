Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346236A3D63
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjB0IoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjB0Ine (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:43:34 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FE86A7D;
        Mon, 27 Feb 2023 00:37:57 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31R8a2FF010670;
        Mon, 27 Feb 2023 02:36:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677486962;
        bh=SReC7eYRtCBD2x7utOeo4OljISiDCLbGnFbv8a2yxVA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qKlW1zuGWWvOhIrWRNPAy0BuVV/B9yMvUZqCa9xs853NgFAPjjOacOBUdmoVp0A9x
         rUODm+KaPjFTgqKwwYLaRKwHUG/0MNS2ZhbbIrh+4KcaCDocdZYYe5ZEV92P3Klaib
         r5xPRT+D10US24Ye/geXEEH455OlGqi7SVuH/XRw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31R8a2RG059093
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Feb 2023 02:36:02 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 27
 Feb 2023 02:36:01 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 27 Feb 2023 02:36:01 -0600
Received: from [10.24.69.79] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31R8ZvXB010628;
        Mon, 27 Feb 2023 02:35:58 -0600
Message-ID: <1a98fe0a-fd6f-91ed-ff72-efecdf377334@ti.com>
Date:   Mon, 27 Feb 2023 14:05:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v11 6/8] arm64: dts: ti: k3-j721s2: Add support for OSPI
 Flashes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <nm@ti.com>,
        <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <vaishnav.a@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230224102438.6541-1-r-gunasekaran@ti.com>
 <20230224102438.6541-7-r-gunasekaran@ti.com>
 <e20f5d80-e53a-559d-9a21-fcf77c1cf968@linaro.org>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <e20f5d80-e53a-559d-9a21-fcf77c1cf968@linaro.org>
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



On 24/02/23 4:41 pm, Krzysztof Kozlowski wrote:
> On 24/02/2023 11:24, Ravi Gunasekaran wrote:
>> From: Aswath Govindraju <a-govindraju@ti.com>
>>
>> J721S2 has an OSPI NOR flash on its SOM connected the OSPI0 instance and a
>> QSPI NOR flash on the common processor board connected to the OSPI1
>> instance. Add support for the same
>>
>> Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> Signed-off-by: Matt Ranostay <mranostay@ti.com>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>> Changes from v10:
>> * Removed Link tag from commit message
>>

[...]

>>
>>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 39 +++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 43 +++++++++++++++++++
>>  2 files changed, 82 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> index fa38940fe6cd..76b420379645 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> @@ -206,6 +206,20 @@
>>  			J721S2_WKUP_IOPAD(0x0c8, PIN_INPUT, 7) /* (C28) WKUP_GPIO0_2 */
>>  		>;
>>  	};
>> +
>> +	mcu_fss0_ospi1_pins_default: mcu-fss0-ospi1-pins-default {
>> +		pinctrl-single,pins = <
>> +			J721S2_WKUP_IOPAD(0x040, PIN_OUTPUT, 0) /* (A19) MCU_OSPI1_CLK */
>> +			J721S2_WKUP_IOPAD(0x05c, PIN_OUTPUT, 0) /* (D20) MCU_OSPI1_CSn0 */
>> +			J721S2_WKUP_IOPAD(0x060, PIN_OUTPUT, 0) /* (C21) MCU_OSPI1_CSn1 */
>> +			J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (D21) MCU_OSPI1_D0 */
>> +			J721S2_WKUP_IOPAD(0x050, PIN_INPUT, 0) /* (G20) MCU_OSPI1_D1 */
>> +			J721S2_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (C20) MCU_OSPI1_D2 */
>> +			J721S2_WKUP_IOPAD(0x058, PIN_INPUT, 0) /* (A20) MCU_OSPI1_D3 */
>> +			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (B19) MCU_OSPI1_DQS */
>> +			J721S2_WKUP_IOPAD(0x044, PIN_INPUT, 0) /* (B20) MCU_OSPI1_LBCLKO */
>> +		>;
>> +	};
>>  };
>>  
>>  &main_gpio2 {
>> @@ -347,6 +361,31 @@
>>  	maximum-speed = "high-speed";
>>  };
>>  
>> +&fss {
>> +	status = "okay";
> 
> Where is the pinmux usage you said is required for the bus?

Will remove the comment in [3/8] in the next series.

> 
>> +};
>> +
>> +&ospi1 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
>> +
>> +	flash@0{
>> +		compatible = "jedec,spi-nor";
>> +		reg = <0x0>;
>> +		spi-tx-bus-width = <1>;
>> +		spi-rx-bus-width = <4>;
>> +		spi-max-frequency = <40000000>;
>> +		cdns,tshsl-ns = <60>;
>> +		cdns,tsd2d-ns = <60>;
>> +		cdns,tchsh-ns = <60>;
>> +		cdns,tslch-ns = <60>;
>> +		cdns,read-delay = <2>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
> 
> Are you sure these are correct? Aren't they marked as deprecated?

Right. I found that "address-cells" and "size-cells" are deprecated. 
I will remove these in the next series.

Thank you for reviewing the patch.

> 
> 
> 
> Best regards,
> Krzysztof
> 

-- 
Regards,
Ravi
