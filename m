Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F290A750892
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjGLMoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjGLMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:44:22 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50131170E;
        Wed, 12 Jul 2023 05:44:21 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36CCi072074962;
        Wed, 12 Jul 2023 07:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689165840;
        bh=spNPRZC8sNqm2PQf0XbXqwzo32+EsCDsDsMeIh9M4Z8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=jMx6srzwxb/krEsgytQxdgYR90Wj5DndQ6KGyDaxcuzfJJ09W3e1X3F3hsB6sMj92
         Z4CAWCZJpt9F/o7jeqAI5QVw0obe7ZFZ0jc5jjTQ9CoRB4SXolJBg0hbL59V8Em2VU
         5joebqaNcwMnYWPDo1nTjzKxmvQRWThq1CFU4EXc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36CCi0pL017505
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jul 2023 07:44:00 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jul 2023 07:43:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jul 2023 07:43:59 -0500
Received: from [172.24.227.112] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36CChuwa070068;
        Wed, 12 Jul 2023 07:43:56 -0500
Message-ID: <5d2ec125-1f05-2316-1e9a-24b5d85aa4c9@ti.com>
Date:   Wed, 12 Jul 2023 18:13:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/5] arm64: dts: ti: k3-j784s4-main: Add system
 controller and SERDES lane mux
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <afd@ti.com>, <s-vadapalli@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230710101705.154119-1-j-choudhary@ti.com>
 <20230710101705.154119-2-j-choudhary@ti.com>
 <23833669-b9f7-94aa-ea42-56843842cba6@linaro.org>
 <d0fce3b5-222c-fc0f-ba16-988e4cc0520e@ti.com>
 <20230711153144.jvofubaez5uoog5p@unmanaged>
 <1e3b4fa4-6de7-e7bb-f1f7-266a73d87fb0@linaro.org>
 <b24c2124-fe3b-246c-9af9-3ecee9fb32d4@kernel.org>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <b24c2124-fe3b-246c-9af9-3ecee9fb32d4@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/07/23 16:51, Roger Quadros wrote:
> 
> 
> On 12/07/2023 08:44, Krzysztof Kozlowski wrote:
>> On 11/07/2023 17:31, Nishanth Menon wrote:
>>> On 12:01-20230711, Jayesh Choudhary wrote:
>>>>
>>>>
>>>> On 10/07/23 17:13, Krzysztof Kozlowski wrote:
>>>>> On 10/07/2023 12:17, Jayesh Choudhary wrote:
>>>>>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>>>>
>>>>>> The system controller node manages the CTRL_MMR0 region.
>>>>>> Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.
>>>>>>
>>>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>>>> [j-choudhary@ti.com: Add reg property to fix dtc warning]
>>>>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>>>>> ---
>>>>>>    arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 23 ++++++++++++++++++++++
>>>>>>    1 file changed, 23 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>>>>> index 2ea0adae6832..68cc2fa053e7 100644
>>>>>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>>>>>> @@ -5,6 +5,9 @@
>>>>>>     * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>>>>>>     */
>>>>>> +#include <dt-bindings/mux/mux.h>
>>>>>> +#include <dt-bindings/mux/ti-serdes.h>
>>>>>
>>>>> Why? What do you use from that binding?
>>>>>
>>>>
>>>> Missed idle-state in the mux-controller node here for default values.
>>>> I will wait for more feedback and then re-spin the series.
>>>
>>> btw, I am wondering if ti-serdes.h should even exist in dt-bindings -
>>> are any of the macros used in the driver? or should this follow the
>>> pinctrl style macros that could happily reside in arch/arm64/boot/dts/ti
>>> ?
>>
>> I don't see any usage in drivers, which is a clear indication that it
>> might not be suitable for bindings. What are these values? Look like
>> some register values, which there is little sense in making a binding.
>>
>> Best regards,
>> Krzysztof
>>
>>
> 
> You are right. They are constants not used in the driver directly.
> mmio-mux driver uses it to set the idle state of the mux via the
> 'idle-states' property.
> 
> I agree with Nishanth that they should be moved to arch/arm64/boot/dts/ti
> 

Then I will do the cleanup for all platforms and then post the dependent
series before spinning v6.

Thanks and Warm regards,
-Jayesh

