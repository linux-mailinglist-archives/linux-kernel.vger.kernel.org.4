Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7986E413B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjDQHhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjDQHhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:37:08 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10CD10D8;
        Mon, 17 Apr 2023 00:36:03 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33H7Zp5L051645;
        Mon, 17 Apr 2023 02:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681716951;
        bh=Z4LB/IWF7ou7ipPzsHyZXXQjaY1cCvmLaOqcfk3aGqw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=GvzRGLO8i/x9jaN2hCg9cDTkELxNrkqjj1u+E39JgPG5OUfTo5rtWSBtZeK4tmjHW
         7y4j7RXToWCZOiooM9xzj46Jbz51yjhf5HQ1Hd0nQh485qq6Iavg4q/zGtkzgVweS6
         J2OO2s6ymZ+PVyDYmzUE2Ny6JxYUiVfB0ApGb5sI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33H7ZpBs065183
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Apr 2023 02:35:51 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 17
 Apr 2023 02:35:50 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 17 Apr 2023 02:35:51 -0500
Received: from [172.24.145.7] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33H7ZlA5085138;
        Mon, 17 Apr 2023 02:35:48 -0500
Message-ID: <c41fe817-6ce2-e3dd-3380-d04f3319f7eb@ti.com>
Date:   Mon, 17 Apr 2023 13:05:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/5] arm64: dts: ti: k3-j784s4-main: Add system
 controller and SERDES lane mux
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>, <afd@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230414151553.339599-1-j-choudhary@ti.com>
 <20230414151553.339599-2-j-choudhary@ti.com>
 <bc3e7500-b653-323b-2a8e-86926f1c090e@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <bc3e7500-b653-323b-2a8e-86926f1c090e@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On 17/04/23 10:07, Vignesh Raghavendra wrote:
> Hi Jayesh
> 
> On 14/04/23 20:45, Jayesh Choudhary wrote:
>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>
>> The system controller node manages the CTRL_MMR0 region.
>> Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> index e9169eb358c1..344f4ffa0b82 100644
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
>> +	scm_conf: scm-conf@100000 {
> 
> generic node name please: "syscon@"

Okay.

> 
>> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
>> +		reg = <0x00 0x00100000 0x00 0x1c000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x00 0x00 0x00100000 0x1c000>;
>> +
>> +		serdes_ln_ctrl: mux-controller@4080 {
> 
> Either add reg property or replace @ with -

Will use '-'.

> 
> Run make with W=12 to catch such errors.

Okay. Will do.

Thanks.

[...]
