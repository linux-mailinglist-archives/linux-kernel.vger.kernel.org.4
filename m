Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7326CFBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjC3GoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjC3GoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:44:06 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC387695;
        Wed, 29 Mar 2023 23:43:56 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32U6hiGV052781;
        Thu, 30 Mar 2023 01:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680158624;
        bh=bT80fJZkEzcPwq0rZSo29Ml6Els/2Qq5nIx8+2O0vBo=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=wMUGzLLLo32IMr9dfmZz9vd4VQJi5nSpv8NNQZlfkD75WbHZNOoiO5CySMskIezjV
         JdORohToS0QtKETX2Ny3MWziOMuydCKgLluweYyhsHXaElPN+9hWASVNkUA3bC5t/8
         SszvNB8XWupj2iwYVjVR+d6+llmZwtvwcHMzm9JA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32U6hinY021752
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Mar 2023 01:43:44 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 30
 Mar 2023 01:43:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 30 Mar 2023 01:43:44 -0500
Received: from [10.24.69.141] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32U6hefP074293;
        Thu, 30 Mar 2023 01:43:41 -0500
Message-ID: <ac2e194a-9b16-eec2-4e1b-a6708d1bb9f1@ti.com>
Date:   Thu, 30 Mar 2023 12:13:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V3 2/2] arm64: dts: ti: k3-am68-sk-base-board: Add pinmux
 for RPi Header
Content-Language: en-US
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>, <u-kumar1@ti.com>,
        Rahul Ravikumar <r-ravikumar@ti.com>
References: <20230316114102.3602-1-sinthu.raja@ti.com>
 <20230316114102.3602-3-sinthu.raja@ti.com>
 <da0e31a6-2304-984c-35ea-41e29b2eb418@ti.com>
In-Reply-To: <da0e31a6-2304-984c-35ea-41e29b2eb418@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sinthu,

On 28/03/23 16:30, Vaishnav Achath wrote:
> Hi Sinthu,
> 
> On 16/03/23 17:11, Sinthu Raja wrote:
>> From: Sinthu Raja <sinthu.raja@ti.com>
>>
>> Add pinmux required to bring out the i2c and gpios on 40-pin RPi
>> expansion header on the AM68 SK board.
>>
>> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
>> ---
>>
>> No Changes in V3.
>>
> 
> It looks like you missed to carry the tested tag from Rahul on V2,
> was that intentional?
> 
> https://lore.kernel.org/all/20230125200427.2bqlpym5tzz43yqq@uda0490373/
> 
> Thanks and Regards,
> Vaishnav
> 
>>  .../boot/dts/ti/k3-am68-sk-base-board.dts     | 70 ++++++++++++++++++-
>>  1 file changed, 69 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>> index 27a43a8ecffd..118308cfdd75 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
>> @@ -173,6 +173,32 @@ J721S2_IOPAD(0x0a0, PIN_INPUT, 0) /* (AB25) MCASP0_AXR12.MCAN7_RX */
>>  			J721S2_IOPAD(0x09c, PIN_INPUT, 0) /* (T24) MCASP0_AXR11.MCAN7_TX */
>>  		>;
>>  	};
>> +
>> +	main_i2c4_pins_default: main-i2c4-pins-default {
>> +		pinctrl-single,pins = <
>> +			J721S2_IOPAD(0x010, PIN_INPUT_PULLUP, 7) /* (AF28) MCAN13_RX.I2C4_SDA */
>> +			J721S2_IOPAD(0x014, PIN_INPUT_PULLUP, 7) /* (AD25) MCAN14_TX.I2C4_SCL */

While reviewing these changes with Udit, we found that these settings for I2C is
wrong as per the datasheet(or sysconfig), for these PADs the mux mode 7 is GPIO
and mode 8 is I2C, can you please check and correct this.

Thanks and Regards,
Vaishnav


>> +		>;
>> +	};
>> +
>> +	rpi_header_gpio0_pins_default: rpi-header-gpio0-pins-default {
>> +		pinctrl-single,pins = <
>> +			J721S2_IOPAD(0x0a8, PIN_INPUT, 7) /* (U24)  MCASP0_AXR14.GPIO0_42 */
>> +			J721S2_IOPAD(0x090, PIN_INPUT, 7) /* (W24) MCASP0_AXR8.GPIO0_36 */
>> +			J721S2_IOPAD(0x0bc, PIN_INPUT, 7) /* (V28) MCASP1_AFSX.GPIO0_47 */
>> +			J721S2_IOPAD(0x06c, PIN_INPUT, 7) /* (V26) MCAN1_TX.GPIO0_27 */
>> +			J721S2_IOPAD(0x004, PIN_INPUT, 7) /* (W25) MCAN12_TX.GPIO0_1 */
>> +			J721S2_IOPAD(0x008, PIN_INPUT, 7) /* (AC24) MCAN12_RX.GPIO0_2 */
>> +			J721S2_IOPAD(0x0b8, PIN_INPUT, 7) /* (AA24) MCASP1_ACLKX.GPIO0_46 */
>> +			J721S2_IOPAD(0x00c, PIN_INPUT, 7) /* (AE28) MCAN13_TX.GPIO0_3 */
>> +			J721S2_IOPAD(0x034, PIN_INPUT, 7) /* (AD24) PMIC_WAKE0.GPIO0_13 */
>> +			J721S2_IOPAD(0x0a4, PIN_INPUT, 7) /* (T23) MCASP0_AXR13.GPIO0_41 */
>> +			J721S2_IOPAD(0x0c0, PIN_INPUT, 7) /* (T28) MCASP1_AXR0.GPIO0_48 */
>> +			J721S2_IOPAD(0x0b4, PIN_INPUT, 7) /* (U25) MCASP1_AXR4.GPIO0_45 */
>> +			J721S2_IOPAD(0x0cc, PIN_INPUT, 7) /* (AE27) SPI0_CS0.GPIO0_51 */
>> +			J721S2_IOPAD(0x08c, PIN_INPUT, 7) /* (T25) MCASP0_AXR7.GPIO0_35 */
>> +		>;
>> +	};
>>  };
>>  
>>  &wkup_pmx0 {
>> @@ -214,12 +240,39 @@ J721S2_WKUP_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (C23) WKUP_GPIO0_4.MCU_MCAN1_TX*/
>>  		>;
>>  	};
>>  
>> +	mcu_i2c0_pins_default: mcu-i2c0-pins-default {
>> +		pinctrl-single,pins = <
>> +			J721S2_WKUP_IOPAD(0x100, PIN_INPUT, 0) /*(H24) WKUP_GPIO0_63.MCU_I2C0_SCL*/
>> +			J721S2_WKUP_IOPAD(0x104, PIN_INPUT, 0) /*(H27) WKUP_GPIO0_64.MCU_I2C0_SDA*/
>> +		>;
>> +	};
>> +
>>  	mcu_i2c1_pins_default: mcu-i2c1-pins-default {
>>  		pinctrl-single,pins = <
>>  			J721S2_WKUP_IOPAD(0x0e0, PIN_INPUT, 0) /* (F24) WKUP_GPIO0_8.MCU_I2C1_SCL */
>>  			J721S2_WKUP_IOPAD(0x0e4, PIN_INPUT, 0) /* (H26) WKUP_GPIO0_9.MCU_I2C1_SDA */
>>  		>;
>>  	};
>> +
>> +	mcu_rpi_header_gpio0_pins_default: mcu-rpi-header-gpio0-pins-default {
>> +		pinctrl-single,pins = <
>> +			J721S2_WKUP_IOPAD(0x180, PIN_INPUT, 7) /* (G25) WKUP_GPIO0_66 */
>> +			J721S2_WKUP_IOPAD(0x190, PIN_INPUT, 7) /* (K26) WKUP_GPIO0_49 */
>> +			J721S2_WKUP_IOPAD(0x0c4, PIN_INPUT, 7) /* (E24) MCU_SPI1_D0.WKUP_GPIO0_1 */
>> +			J721S2_WKUP_IOPAD(0x0c8, PIN_INPUT, 7) /* (C28) MCU_SPI1_D1.WKUP_GPIO0_2 */
>> +			J721S2_WKUP_IOPAD(0x0c0, PIN_INPUT, 7) /* (D26) MCU_SPI1_CLK.WKUP_GPIO0_0 */
>> +			J721S2_WKUP_IOPAD(0x0fc, PIN_INPUT, 7) /* (D25) MCU_SPI1_CS2.WKUP_GPIO0_15*/
>> +			J721S2_WKUP_IOPAD(0x120, PIN_INPUT, 7) /* (G27) WKUP_GPIO0_56 */
>> +			J721S2_WKUP_IOPAD(0x17c, PIN_INPUT, 7) /* (J26) WKUP_GPIO0_57 */
>> +			J721S2_WKUP_IOPAD(0x184, PIN_INPUT, 7) /* (J27) WKUP_GPIO0_67 */
>> +			J721S2_WKUP_IOPAD(0x0cc, PIN_INPUT, 7) /* (C27) MCU_SPI1_CS0.WKUP_GPIO0_3 */
>> +		>;
>> +	};
>> +};
>> +
>> +&main_gpio0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&rpi_header_gpio0_pins_default>;
>>  };
>>  
>>  &main_gpio2 {
>> @@ -235,7 +288,8 @@ &main_gpio6 {
>>  };
>>  
>>  &wkup_gpio0 {
>> -	status = "disabled";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mcu_rpi_header_gpio0_pins_default>;
>>  };
>>  
>>  &wkup_gpio1 {
>> @@ -271,6 +325,20 @@ exp1: gpio@21 {
>>  	};
>>  };
>>  
>> +&main_i2c4 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&main_i2c4_pins_default>;
>> +	clock-frequency = <400000>;
>> +};
>> +
>> +&mcu_i2c0 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mcu_i2c0_pins_default>;
>> +	clock-frequency = <400000>;
>> +};
>> +
>>  &main_sdhci0 {
>>  	/* Unused */
>>  	status = "disabled";
> 

-- 
Regards,
Vaishnav
