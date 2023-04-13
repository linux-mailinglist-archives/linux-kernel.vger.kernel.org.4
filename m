Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5E26E067C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjDMFmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMFmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:42:11 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C0E2688;
        Wed, 12 Apr 2023 22:42:10 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33D5FfAe057595;
        Thu, 13 Apr 2023 00:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681362941;
        bh=JXn0CUcuMWb4wkleuP5EkTzadTX5cRASyBFA/zDBBgU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=BNm7Oygn58bWXT7zTzOToBxUXtaToq4EP/a/tH4fKcnkbayEJXTS24gpuo1imzXpP
         nXMfYACz2rElsq77xnlEv0/w4Ws4upFVmkreCRuQvW9T4iXUWBAMbV9v8B2E5G8Kl9
         U/9xxBQXJgrAU+B+ROhk8nJI4vnZb+Ttqy2REr5s=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33D5FfBd109985
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Apr 2023 00:15:41 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 13
 Apr 2023 00:15:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 13 Apr 2023 00:15:40 -0500
Received: from [172.24.145.109] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33D5Fbrg028761;
        Thu, 13 Apr 2023 00:15:37 -0500
Message-ID: <36fc3872-96ba-e503-cfff-754036e561e1@ti.com>
Date:   Thu, 13 Apr 2023 10:45:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-main: fix msmc node
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <a-govindraju@ti.com>,
        <kishon@ti.com>, <n-dasan@ti.com>
References: <20230412173609.1307837-1-u-kumar1@ti.com>
 <20230412195656.a53nalvjuhelniz4@populace>
From:   Udit Kumar <u-kumar1@ti.com>
In-Reply-To: <20230412195656.a53nalvjuhelniz4@populace>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 13/04/23 01:26, Nishanth Menon wrote:
> On 23:06-20230412, Udit Kumar wrote:
>> On J721S2 SOC, l3cache-sram size is configured as zero by
>> system firmware.
>> Also top 64K of msmc_ram (0x703F_0000 to 0x703F_FFFF) is used by system
>> firmware tifs-sram.
>>
>> This patch removes l3cache-sram node and update range for tifs-sram.
>>
>> Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
>>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> index 2dd7865f7654..cbc784f915a9 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> @@ -17,13 +17,10 @@ atf-sram@0 {
>>   			reg = <0x0 0x20000>;
>>   		};
>>   
>> -		tifs-sram@1f0000 {
>> -			reg = <0x1f0000 0x10000>;
>> +		tifs-sram@3f0000 {
>> +			reg = <0x3f0000 0x10000>;
>>   		};
>>   
>> -		l3cache-sram@200000 {
>> -			reg = <0x200000 0x200000>;
>> -		};
>>   	};
>>   
>>   	gic500: interrupt-controller@1800000 {
>> -- 
>> 2.34.1
>>
> Are you saying that j721s2 is incapable of l3 cache? say some level 1
> errata?
No
> or is it because, the chip is really capable of l3 cache and we are
> really setting it to 0?
>
> https://git.ti.com/cgit/k3-image-gen/k3-image-gen/tree/soc/j721s2/evm/board-cfg.c#n71
This is because, l3 cache size is set to zero.
> unless the chip has an errata, you are supposed to fix it up based on
> configuration by using the API and this patch is a NAK
> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-query-msmc
ok
