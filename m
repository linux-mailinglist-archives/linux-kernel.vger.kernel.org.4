Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B6B70262B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbjEOHhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbjEOHgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:36:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDEF1710;
        Mon, 15 May 2023 00:36:51 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34F7aZXP064742;
        Mon, 15 May 2023 02:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684136195;
        bh=08o8EyWqOpKfyd0hyqux8FTD1PJ7h92J62j8ZZJ/QPc=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=epLlIyNQwg2S18mNbFRtTHOFiobOWOEqtKi59Snq5qmCcg4ufveNCFY3OjQnssTXS
         XfDvmjbXLjBG8K9vvbY2evrifF4NJYDUOT2BeJQypbBcAm1F1+0BLQqmBFsGSH2oaL
         EDy6crlJT1B/J65hZhHkRZABDkHwDzECpg2WDyio=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34F7aZOE114774
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 02:36:35 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 02:36:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 02:36:35 -0500
Received: from [172.24.145.61] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34F7aVHm059347;
        Mon, 15 May 2023 02:36:32 -0500
Message-ID: <65c6a354-434b-4e50-81ec-8ce705df2888@ti.com>
Date:   Mon, 15 May 2023 13:06:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
CC:     Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <afd@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v4 1/5] arm64: dts: ti: k3-j784s4-main: Add system
 controller and SERDES lane mux
Content-Language: en-US
To:     "Verma, Achal" <a-verma1@ti.com>
References: <20230425131607.290707-1-j-choudhary@ti.com>
 <20230425131607.290707-2-j-choudhary@ti.com>
 <a033cec5-0272-186e-d53e-d101835cc9eb@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <a033cec5-0272-186e-d53e-d101835cc9eb@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Achal,

On 15/05/23 11:25, Verma, Achal wrote:
> Hi,
> 
> On 4/25/2023 6:46 PM, Jayesh Choudhary wrote:
>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>
>> The system controller node manages the CTRL_MMR0 region.
>> Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> [j-choudhary@ti.com: Add reg property to fix dtc warning]
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 23 ++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> index e9169eb358c1..29be6d28ee31 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> @@ -5,6 +5,9 @@
>>    * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>>    */
>>   +#include <dt-bindings/mux/mux.h>
>> +#include <dt-bindings/mux/ti-serdes.h>
>> +
>>   &cbass_main {
>>       msmc_ram: sram@70000000 {
>>           compatible = "mmio-sram";
>> @@ -26,6 +29,26 @@ l3cache-sram@200000 {
>>           };
>>       };
>>   +    scm_conf: syscon@100000 {
> Please check syscon address.

0x100000 is the base address of the CTRL_MMR module. Could you please clarify
why the address is incorrect? The registers for J784S4 SoC can be viewed at:
https://www.ti.com/lit/zip/spruj52

> 
> Thanks,
> Achal Verma
>> +        compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
>> +        reg = <0x00 0x00100000 0x00 0x1c000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges = <0x00 0x00 0x00100000 0x1c000>;
>> +
>> +        serdes_ln_ctrl: mux-controller@4080 {
>> +            compatible = "mmio-mux";
>> +            reg = <0x00004080 0x30>;
>> +            #mux-control-cells = <1>;
>> +            mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1
>> select */
>> +                    <0x4088 0x3>, <0x408c 0x3>, /* SERDES0 lane2/3 select */
>> +                    <0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
>> +                    <0x4098 0x3>, <0x409c 0x3>, /* SERDES1 lane2/3 select */
>> +                    <0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
>> +                    <0x40a8 0x3>, <0x40ac 0x3>; /* SERDES2 lane2/3 select */
>> +        };
>> +    };
>> +
>>       gic500: interrupt-controller@1800000 {
>>           compatible = "arm,gic-v3";
>>           #address-cells = <2>;

-- 
Regards,
Siddharth.
