Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D407027A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbjEOIz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbjEOIzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:55:24 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891021A4;
        Mon, 15 May 2023 01:55:22 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34F8t6Zh037669;
        Mon, 15 May 2023 03:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684140906;
        bh=y+NNSJg8r4OtaVTPe2llKWpVnqCF9wqUlXweNfQ+J3Y=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=uRu2QeKDkbqaQquDMGnvFBUO+ImA8YxP470CmW1V+nW7FkGA8WIfzwL6Z0XW2jEOJ
         UCCJVm81nvpMkyMmZAU6rxFYpfI4DK/qu0AS77f3we6M6ZBHXw5Q3XkkYWXx8+rWHD
         akpS409ZlFzEXK4Dxe0D5MEQ6XTKY0Ok3dSuXac4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34F8t5DL113835
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 03:55:05 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 03:55:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 03:55:05 -0500
Received: from [172.24.216.170] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34F8t1SO092988;
        Mon, 15 May 2023 03:55:02 -0500
Message-ID: <da5b4576-fa6e-4134-236a-4054644dc8a8@ti.com>
Date:   Mon, 15 May 2023 14:25:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 1/5] arm64: dts: ti: k3-j784s4-main: Add system
 controller and SERDES lane mux
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
CC:     Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <afd@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Achal Verma <a-verma1@ti.com>
References: <20230425131607.290707-1-j-choudhary@ti.com>
 <20230425131607.290707-2-j-choudhary@ti.com>
 <a033cec5-0272-186e-d53e-d101835cc9eb@ti.com>
 <65c6a354-434b-4e50-81ec-8ce705df2888@ti.com>
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <65c6a354-434b-4e50-81ec-8ce705df2888@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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



On 5/15/2023 1:06 PM, Siddharth Vadapalli wrote:
> Achal,
> 
> On 15/05/23 11:25, Verma, Achal wrote:
>> Hi,
>>
>> On 4/25/2023 6:46 PM, Jayesh Choudhary wrote:
>>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>
>>> The system controller node manages the CTRL_MMR0 region.
>>> Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.
>>>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> [j-choudhary@ti.com: Add reg property to fix dtc warning]
>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>> ---
>>>    arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 23 ++++++++++++++++++++++
>>>    1 file changed, 23 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>> b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>> index e9169eb358c1..29be6d28ee31 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>> @@ -5,6 +5,9 @@
>>>     * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>>>     */
>>>    +#include <dt-bindings/mux/mux.h>
>>> +#include <dt-bindings/mux/ti-serdes.h>
>>> +
>>>    &cbass_main {
>>>        msmc_ram: sram@70000000 {
>>>            compatible = "mmio-sram";
>>> @@ -26,6 +29,26 @@ l3cache-sram@200000 {
>>>            };
>>>        };
>>>    +    scm_conf: syscon@100000 {
>> Please check syscon address.
> 
> 0x100000 is the base address of the CTRL_MMR module. Could you please clarify
> why the address is incorrect? The registers for J784S4 SoC can be viewed at:
> https://www.ti.com/lit/zip/spruj52
I got the doubt because of the address used in this [1] series was 
different. Now I realized that it was wrong and it got corrected in this 
patch. So yeah its clear now, 0x100000 is indeed the correct base address.

[1] 
https://serenity.dal.design.ti.com/patchwork/project/linux-patch-review/patch/20220927202534.17148-3-mranostay@ti.com/
> 
>>
>> Thanks,
>> Achal Verma
>>> +        compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
>>> +        reg = <0x00 0x00100000 0x00 0x1c000>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +        ranges = <0x00 0x00 0x00100000 0x1c000>;
>>> +
>>> +        serdes_ln_ctrl: mux-controller@4080 {
>>> +            compatible = "mmio-mux";
>>> +            reg = <0x00004080 0x30>;
>>> +            #mux-control-cells = <1>;
>>> +            mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1
>>> select */
>>> +                    <0x4088 0x3>, <0x408c 0x3>, /* SERDES0 lane2/3 select */
>>> +                    <0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
>>> +                    <0x4098 0x3>, <0x409c 0x3>, /* SERDES1 lane2/3 select */
>>> +                    <0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
>>> +                    <0x40a8 0x3>, <0x40ac 0x3>; /* SERDES2 lane2/3 select */
>>> +        };
>>> +    };
>>> +
>>>        gic500: interrupt-controller@1800000 {
>>>            compatible = "arm,gic-v3";
>>>            #address-cells = <2>;
> 
