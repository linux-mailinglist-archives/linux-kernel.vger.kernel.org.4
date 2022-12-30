Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2FB6594C6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 06:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiL3FNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 00:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiL3FNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 00:13:46 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDD515FC9;
        Thu, 29 Dec 2022 21:13:44 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BU5DTtd001654;
        Thu, 29 Dec 2022 23:13:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672377209;
        bh=aWpI/2A/8BCwAHOBAzcTOXDKEcPVlLmHAqOympV/RUM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=p1Rw/dbey87w9rhM9dYeHRz0hH6xc6H1CbJeVCq40EsPzJxa64fy0YdkO+NmIMzKR
         eLTIqwS3sWev2KElzdf/ZSa5p3SU1HV4vEAhQ3sDe/Y7TZsYv2O+JaJmxoo2CUF6CX
         xM6juCxBbkWdBL4pTMj6bTb2ni/PsWmB1xay3rM8=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BU5DTu9001478
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Dec 2022 23:13:29 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 29
 Dec 2022 23:13:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 29 Dec 2022 23:13:28 -0600
Received: from [10.250.234.245] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BU5DP0d018402;
        Thu, 29 Dec 2022 23:13:26 -0600
Message-ID: <ff76a343-19bb-7359-73bb-39065f343a42@ti.com>
Date:   Fri, 30 Dec 2022 10:43:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel
 property
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>
References: <20221116091652.112620-1-b-kapoor@ti.com>
 <20221117072635.k4fmjqcnw3kcjrc4@precinct>
From:   Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20221117072635.k4fmjqcnw3kcjrc4@precinct>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/11/22 12:56, Nishanth Menon wrote:
> On 14:46-20221116, Bhavya Kapoor wrote:
>> According to latest errata of J721e [1], HS400 mode is not supported
>> in MMCSD0 subsystem (i2024) .  Speed modes supported has been already
> 			     ^^ space before "."
>
> btw, "The MMCSD peripherals do not support the Multimedia Card HS400
> mode." is the exact text of the erratum. Even though it applies to
> instance 0. I think minor rewording will probably help people from
> running to search for which specific instances.
>
>> updated in commit eb8f6194e807 ("arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems")
> Please format this correctly.
Commit Title was large ( > 72 chars ) so kept in same line.
>
>> but it missed dropping 'ti,strobe-sel' property which is
>> only required by HS400 speed mode.
>>
>> Thus, drop 'ti,strobe-sel' property from kernel dtsi for J721e SoC.
>>
>> [1] https://www.ti.com/lit/er/sprz455/sprz455.pdf
>>
>> Fixes: eb8f6194e807 ("arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems")
>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>> ---
>>
>> Changelog v1 -> v2 :
>> 	- Updated Commit Message based on what Nishanth Menon has told
>> 		in https://lore.kernel.org/all/20221115034324.6qpxl2774bzwbl3t@acorn/
>>
>>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> index 917c9dc99efa..e4748a838d83 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> @@ -1094,7 +1094,6 @@
>>   		ti,itap-del-sel-mmc-hs = <0xa>;
>>   		ti,itap-del-sel-ddr52 = <0x3>;
>>   		ti,trm-icp = <0x8>;
>> -		ti,strobe-sel = <0x77>;
>>   		dma-coherent;
>>   	};
>>   
>> -- 
>> 2.20.1
>>
