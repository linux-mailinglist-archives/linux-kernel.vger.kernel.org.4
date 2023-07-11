Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB31474E75E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjGKGcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjGKGcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:32:06 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12208A6;
        Mon, 10 Jul 2023 23:32:05 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36B6VwhA057997;
        Tue, 11 Jul 2023 01:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689057118;
        bh=NT//xZOavgQ88cKD7CQnQDQ/Qu7FIJsFVnx2izFec1Y=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=TquH3BuJkR2GjS3gjonYVOchmH28liUTJY6nkwuUtPNCRGDR2Yg8/MzSvBcIfjcBr
         bGSDssVEFY0B33e9j+cS88c5lClyGRLw83E/2YYS83djTvf9/MGGC//JawVkxUg3H4
         Z81u6ulnboxDoYNfGAM8D6t6+Sx1i2YZ4z5n+3bk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36B6Vw4h100161
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jul 2023 01:31:58 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jul 2023 01:31:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jul 2023 01:31:58 -0500
Received: from [10.24.68.113] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36B6Vsok023503;
        Tue, 11 Jul 2023 01:31:55 -0500
Message-ID: <d0fce3b5-222c-fc0f-ba16-988e4cc0520e@ti.com>
Date:   Tue, 11 Jul 2023 12:01:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/5] arm64: dts: ti: k3-j784s4-main: Add system
 controller and SERDES lane mux
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <nm@ti.com>,
        <vigneshr@ti.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>,
        <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230710101705.154119-1-j-choudhary@ti.com>
 <20230710101705.154119-2-j-choudhary@ti.com>
 <23833669-b9f7-94aa-ea42-56843842cba6@linaro.org>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <23833669-b9f7-94aa-ea42-56843842cba6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/23 17:13, Krzysztof Kozlowski wrote:
> On 10/07/2023 12:17, Jayesh Choudhary wrote:
>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>
>> The system controller node manages the CTRL_MMR0 region.
>> Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> [j-choudhary@ti.com: Add reg property to fix dtc warning]
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 23 ++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> index 2ea0adae6832..68cc2fa053e7 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> @@ -5,6 +5,9 @@
>>    * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
>>    */
>>   
>> +#include <dt-bindings/mux/mux.h>
>> +#include <dt-bindings/mux/ti-serdes.h>
> 
> Why? What do you use from that binding?
> 

Missed idle-state in the mux-controller node here for default values.
I will wait for more feedback and then re-spin the series.

Thanks,
-Jayesh

