Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46016E7782
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjDSKfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjDSKfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:35:42 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBC95FD2;
        Wed, 19 Apr 2023 03:35:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33JAZW9l058843;
        Wed, 19 Apr 2023 05:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681900532;
        bh=FH17H7KKtGPSsc0jpS9WI6drpuyTQIl/Hov80h2U7MQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=xPOATEyt/vrN714FxUdZcb/yQsuBv/3wnPS0hnLTlHKx5WuCh22Ptdehp2Q/APzv+
         lo/wczYrn96fBe6ek7p6EsQ8z7voD4SgsTzzWYbQPRvw8s4wmvbjbY0GGFHOQCAt5r
         fFktfJfRtacfaLi/QJQsg4UV2amiCccoAygNaOwI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33JAZW5k079299
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 05:35:32 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 05:35:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 05:35:32 -0500
Received: from [172.24.145.7] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33JAZST3028110;
        Wed, 19 Apr 2023 05:35:28 -0500
Message-ID: <bc58b9cc-f1a1-9c60-341c-9a00777e7142@ti.com>
Date:   Wed, 19 Apr 2023 16:05:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 4/5] arm64: dts: ti: k3-j784s4-main: Add DSS and
 DP-bridge node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <nm@ti.com>,
        <vigneshr@ti.com>, <afd@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <a-bhatia1@ti.com>
References: <20230419061710.290068-1-j-choudhary@ti.com>
 <20230419061710.290068-5-j-choudhary@ti.com>
 <83c8bce1-f4e2-899e-46a9-0ba9da702572@linaro.org>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <83c8bce1-f4e2-899e-46a9-0ba9da702572@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/23 13:21, Krzysztof Kozlowski wrote:
> On 19/04/2023 08:17, Jayesh Choudhary wrote:
>> From: Rahul T R <r-ravikumar@ti.com>
>>
>> Add DSS and DP-bridge node for J784S4 SoC. DSS IP in J784S4 is
>> same as DSS IP in J721E, so same compatible is being used.
>> The DP is Cadence MHDP8546.
>>
>> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
>> [j-choudhary@ti.com: move all k3-j784s4-main.dtsi changes together]
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 77 ++++++++++++++++++++++
>>   1 file changed, 77 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> index 51aa476dedba..739741e93bc1 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> @@ -1373,4 +1373,81 @@ main_spi7: spi@2170000 {
>>   		clocks = <&k3_clks 383 1>;
>>   		status = "disabled";
>>   	};
>> +
>> +	mhdp: dp-bridge@a000000 {
>> +		compatible = "ti,j721e-mhdp8546";
>> +
>> +		reg = <0x0 0xa000000 0x0 0x30a00>,
>> +		      <0x0 0x4f40000 0x0 0x20>;
>> +		reg-names = "mhdptx", "j721e-intg";
>> +
>> +		clocks = <&k3_clks 217 11>;
>> +
>> +		interrupt-parent = <&gic500>;
>> +		interrupts = <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +		power-domains = <&k3_pds 217 TI_SCI_PD_EXCLUSIVE>;
>> +
>> +		status = "disabled";
>> +
>> +		dp0_ports: ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +	};
>> +
>> +	dss: dss@4a00000 {
>> +		compatible = "ti,j721e-dss";
>> +		reg =
>> +			<0x00 0x04a00000 0x00 0x10000>,
> 
> Fix indent/stray line break.
> 
>> +			<0x00 0x04a10000 0x00 0x10000>,
>> +			<0x00 0x04b00000 0x00 0x10000>,
>> +			<0x00 0x04b10000 0x00 0x10000>,
>> +
>> +			<0x00 0x04a20000 0x00 0x10000>,
>> +			<0x00 0x04a30000 0x00 0x10000>,
>> +			<0x00 0x04a50000 0x00 0x10000>,
>> +			<0x00 0x04a60000 0x00 0x10000>,
>> +
>> +			<0x00 0x04a70000 0x00 0x10000>,
>> +			<0x00 0x04a90000 0x00 0x10000>,
>> +			<0x00 0x04ab0000 0x00 0x10000>,
>> +			<0x00 0x04ad0000 0x00 0x10000>,
>> +
>> +			<0x00 0x04a80000 0x00 0x10000>,
>> +			<0x00 0x04aa0000 0x00 0x10000>,
>> +			<0x00 0x04ac0000 0x00 0x10000>,
>> +			<0x00 0x04ae0000 0x00 0x10000>,
>> +			<0x00 0x04af0000 0x00 0x10000>;
>> +
>> +		reg-names = "common_m", "common_s0",
>> +			"common_s1", "common_s2",
>> +			"vidl1", "vidl2","vid1","vid2",
>> +			"ovr1", "ovr2", "ovr3", "ovr4",
>> +			"vp1", "vp2", "vp3", "vp4",
>> +			"wb";
>> +
>> +		clocks =	<&k3_clks 218 0>,
> 
> Broken indentation.

Indentation at both places are similar to j721e dss node.
Changes are needed in both?

-Jayesh

> 
> 
> 
> Best regards,
> Krzysztof
> 
