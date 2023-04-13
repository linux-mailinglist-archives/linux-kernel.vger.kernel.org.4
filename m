Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D045C6E066B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDMFXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDMFX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:23:29 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25F82727;
        Wed, 12 Apr 2023 22:23:27 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33D5NB16105301;
        Thu, 13 Apr 2023 00:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681363391;
        bh=PKXQR8rUpcbbj+zXzBgtvKddwzynfBMsTTvJZhfYcEU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=AkohBomIen+8NzI2iVsMXu11xHByQUJgqGWOUvH3bOfMLhv2e3i03WRaJ5wpR+yUh
         IJUjVf43IIlLNb4Mj03HQU26pTU+cP3NSNp/7yA88AMKwa5gSTO22cl4zHxW5r5hgg
         We5rcaQEKL8vw9qYMhUb4N5S1ua9rFXhs7XLFwD0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33D5NALK114271
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Apr 2023 00:23:10 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 13
 Apr 2023 00:23:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 13 Apr 2023 00:23:10 -0500
Received: from [172.24.145.182] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33D5N7Kv035271;
        Thu, 13 Apr 2023 00:23:07 -0500
Message-ID: <89b6b67b-1ccb-87fb-211d-f4427ef131b3@ti.com>
Date:   Thu, 13 Apr 2023 10:53:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-main: fix msmc node
Content-Language: en-US
To:     Udit Kumar <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <a-govindraju@ti.com>,
        <kishon@ti.com>, <n-dasan@ti.com>
References: <20230412173609.1307837-1-u-kumar1@ti.com>
 <20230412195656.a53nalvjuhelniz4@populace>
 <36fc3872-96ba-e503-cfff-754036e561e1@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <36fc3872-96ba-e503-cfff-754036e561e1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Hi Udit,

On 13/04/23 10:45, Udit Kumar wrote:
> Hi Nishanth,
> 
> On 13/04/23 01:26, Nishanth Menon wrote:
>> On 23:06-20230412, Udit Kumar wrote:
>>> On J721S2 SOC, l3cache-sram size is configured as zero by
>>> system firmware.
>>> Also top 64K of msmc_ram (0x703F_0000 to 0x703F_FFFF) is used by system
>>> firmware tifs-sram.
>>>
>>> This patch removes l3cache-sram node and update range for tifs-sram.
>>>
>>> Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2
>>> SoC")
>>>
>>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 7 ++-----
>>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> index 2dd7865f7654..cbc784f915a9 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> @@ -17,13 +17,10 @@ atf-sram@0 {
>>>               reg = <0x0 0x20000>;
>>>           };
>>>   -        tifs-sram@1f0000 {
>>> -            reg = <0x1f0000 0x10000>;
>>> +        tifs-sram@3f0000 {
>>> +            reg = <0x3f0000 0x10000>;
>>>           };
>>>   -        l3cache-sram@200000 {
>>> -            reg = <0x200000 0x200000>;
>>> -        };
>>>       };
>>>         gic500: interrupt-controller@1800000 {
>>> -- 
>>> 2.34.1
>>>
>> Are you saying that j721s2 is incapable of l3 cache? say some level 1
>> errata?
> No
>> or is it because, the chip is really capable of l3 cache and we are
>> really setting it to 0?
>>
>> https://git.ti.com/cgit/k3-image-gen/k3-image-gen/tree/soc/j721s2/evm/board-cfg.c#n71
> This is because, l3 cache size is set to zero.
>> unless the chip has an errata, you are supposed to fix it up based on
>> configuration by using the API and this patch is a NAK
>> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-query-msmc
> ok

U-Boot already does this. See fdt_fixup_msmc_ram() at board/ti/j721s2/evm.c

tifs-sram fixup probably is still needed and possible bug in the original patch?

-- 
Regards
Vignesh
