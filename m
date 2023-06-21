Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95563737B11
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjFUGFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFUGFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:05:06 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5311728;
        Tue, 20 Jun 2023 23:05:02 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8781024E276;
        Wed, 21 Jun 2023 14:04:59 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 21 Jun
 2023 14:04:59 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 21 Jun
 2023 14:04:58 +0800
Message-ID: <4bed9d52-6729-6e0d-5267-17d8f6eb892a@starfivetech.com>
Date:   Wed, 21 Jun 2023 14:04:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: Add QSPI controller node for
 StarFive JH7110 SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230619083517.415597-1-william.qiu@starfivetech.com>
 <20230619083517.415597-4-william.qiu@starfivetech.com>
 <7b7694da-8b40-d76a-adca-4cf9aa206ff4@linaro.org>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <7b7694da-8b40-d76a-adca-4cf9aa206ff4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/19 20:20, Krzysztof Kozlowski wrote:
> On 19/06/2023 10:35, William Qiu wrote:
>> Add the quad spi controller node for the StarFive JH7110 SoC.
>> 
>> Co-developed-by: Ziv Xu <ziv.xu@starfivetech.com>
>> Signed-off-by: Ziv Xu <ziv.xu@starfivetech.com>
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../jh7110-starfive-visionfive-2.dtsi         | 32 +++++++++++++++++++
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 18 +++++++++++
>>  2 files changed, 50 insertions(+)
>> 
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> index 2a6d81609284..22212c1150f9 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> @@ -126,6 +126,38 @@ &i2c6 {
>>  	status = "okay";
>>  };
>>  
>> +&qspi {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	nor_flash: flash@0 {
>> +		compatible = "jedec,spi-nor";
>> +		reg=<0>;
> 
> Missing spaces.
> 
Will fix.
>> +		cdns,read-delay = <5>;
>> +		spi-max-frequency = <12000000>;
>> +		cdns,tshsl-ns = <1>;
>> +		cdns,tsd2d-ns = <1>;
>> +		cdns,tchsh-ns = <1>;
>> +		cdns,tslch-ns = <1>;
>> +
>> +		partitions {
>> +			compatible = "fixed-partitions";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			spl@0 {
>> +				reg = <0x0 0x20000>;
>> +			};
>> +			uboot@100000 {
>> +				reg = <0x100000 0x300000>;
>> +			};
>> +			data@f00000 {
>> +				reg = <0xf00000 0x100000>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>>  &sysgpio {
>>  	i2c0_pins: i2c0-0 {
>>  		i2c-pins {
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> index 4c5fdb905da8..0b24f9e66e67 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -440,6 +440,24 @@ i2c6: i2c@12060000 {
>>  			status = "disabled";
>>  		};
>>  
>> +		qspi: spi@13010000 {
>> +			compatible = "starfive,jh7110-qspi", "cdns,qspi-nor";
>> +			reg = <0x0 0x13010000 0x0 0x10000
>> +				0x0 0x21000000 0x0 0x400000>;
> 
> This should be two items so <>, <>. Not one item.
> 
> Best regards,
> Krzysztof
> 
Will fix.
Thanks for taking time to review this patch series.

Best reagards
William
