Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE9A6E7698
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjDSJoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjDSJoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:44:14 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77193D8;
        Wed, 19 Apr 2023 02:44:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33J9i6sm041283;
        Wed, 19 Apr 2023 04:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681897446;
        bh=CGx4uFvQIkEZ+fcH01+xRI3amlAhk368P0phRIYgCOU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ELS9K+5NyX4geb23vgcSPMMe8NnwiZWX30Yihbj4CyAvUOewuguu0aPuBeFkGbNyY
         4jhFHfYgruQZlVUosSr6RHoU5RSMTxOLQs70Yu6pxm2+FbVrpnmeY1Fejqp5TTnXRz
         gvpGgX+vKXg7Jz/6OzEeaGwdwJ/m5rewpbyE8vFY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33J9i6lA123562
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 04:44:06 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 04:44:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 04:44:06 -0500
Received: from [172.24.145.7] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33J9i20r002167;
        Wed, 19 Apr 2023 04:44:03 -0500
Message-ID: <82db1ec5-1138-cff9-7a87-b65f591a3851@ti.com>
Date:   Wed, 19 Apr 2023 15:14:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: k3-j784s4-main: Add system
 controller and SERDES lane mux
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <nm@ti.com>,
        <vigneshr@ti.com>, <afd@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <a-bhatia1@ti.com>
References: <20230419061710.290068-1-j-choudhary@ti.com>
 <20230419061710.290068-2-j-choudhary@ti.com>
 <eb2540e6-6768-aa38-ec3e-d0f9bb75d797@linaro.org>
Content-Language: en-US
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <eb2540e6-6768-aa38-ec3e-d0f9bb75d797@linaro.org>
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

Hi Krzysztof,

On 19/04/23 13:19, Krzysztof Kozlowski wrote:
> On 19/04/2023 08:17, Jayesh Choudhary wrote:
>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>
>> The system controller node manages the CTRL_MMR0 region.
>> Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> [j-choudhary@ti.com: Minor cleanup to fix dtc warnings]
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> index e9169eb358c1..5fb7edf4f5a0 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> @@ -5,6 +5,9 @@
>>    * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>>    */
>>   
>> +#include <dt-bindings/mux/mux.h>
>> +#include <dt-bindings/mux/ti-serdes.h>
>> +
>>   &cbass_main {
>>   	msmc_ram: sram@70000000 {
>>   		compatible = "mmio-sram";
>> @@ -26,6 +29,25 @@ l3cache-sram@200000 {
>>   		};
>>   	};
>>   
>> +	scm_conf: syscon@100000 {
>> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
>> +		reg = <0x00 0x00100000 0x00 0x1c000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x00 0x00 0x00100000 0x1c000>;
>> +
>> +		serdes_ln_ctrl: mux-controller-4080 {
> 
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).
> 

Ohkay. The base seems to be from k3-j7200-main.dtsi which has the node
name as mux-controller@4080 without reg property. After comments in v2,
I used '-' instead of adding reg property to this node. Will change the
node name again and add the reg property to fix the warning that I see
now with dtbs_check.

Thanks!!

