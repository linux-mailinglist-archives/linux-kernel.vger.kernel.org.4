Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8446F67B3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbjAYOKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjAYOKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:10:12 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97A94684;
        Wed, 25 Jan 2023 06:10:09 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30PE9rje036426;
        Wed, 25 Jan 2023 08:09:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674655793;
        bh=oODlheUYhO8KpQFQLissi1LdKr1GMy+/0QqKjabpzB8=;
        h=Date:To:CC:References:From:Subject:In-Reply-To;
        b=Zo89Tl5fOAwcwA8F+Tc4Zizuj8aFhQNGzAIXAWHXmdhp8oj+smTTlBI3ag58OfLl9
         Z3aTQtCzjMGQqooZAehL8R4IWMZLHbKhU1sUzDWotBqjcNL3qnNSs9vdURtpOC1A6m
         yZuWe2U62ayQlmzecPkLkohZp3T0HsEA6J1zZeME=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30PE9rST066311
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jan 2023 08:09:53 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 25
 Jan 2023 08:09:53 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 25 Jan 2023 08:09:53 -0600
Received: from [10.250.234.92] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30PE9n0B113597;
        Wed, 25 Jan 2023 08:09:50 -0600
Message-ID: <00e46b57-4cf2-76ab-48b5-83593cb629e4@ti.com>
Date:   Wed, 25 Jan 2023 19:39:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Dasnavis Sabiya <sabiya.d@mistralsolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Dasnavis Sabiya <sabiya.d@ti.com>
References: <20230119132958.124435-1-sabiya.d@ti.com>
 <20230119132958.124435-3-sabiya.d@ti.com>
 <802ae1e3-8046-675d-cf4e-d3468604a3e8@linaro.org>
 <90fe0c56-0179-0be1-7a7c-91c26a1eedb6@ti.com>
 <CAAyKsAb0sC_amsPwiQY4XcwK2Mj-ck4SJNKSMVCZH8rwzU6qWw@mail.gmail.com>
 <CAAyKsAZmB1b=EMcf2=VZ1h66-vCzjiCkHF9tE+yJesXVv8kB4Q@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/2] arch: arm64: dts: Add support for AM69 Starter Kit
In-Reply-To: <CAAyKsAZmB1b=EMcf2=VZ1h66-vCzjiCkHF9tE+yJesXVv8kB4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sabiya

On 25/01/23 6:44 pm, Dasnavis Sabiya wrote:
> Hi Krzysztof,
> 
> On Mon, Jan 23, 2023 at 12:58 PM Dasnavis Sabiya
> <sabiya.d@mistralsolutions.com> wrote:
>> Hi Krzysztof,
>>
>> On Fri, Jan 20, 2023 at 4:03 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>> Hi Krzysztof,
>>>
>>> On 19/01/23 19:06, Krzysztof Kozlowski wrote:
>>>> On 19/01/2023 14:29, sabiya.d@mistralsolutions.com wrote:
>>>>> From: Dasnavis Sabiya <sabiya.d@ti.com>
>>>>>
>>>>> AM69 Starter Kit is a single board designed for TI AM69 SOC that
>>>>> provides advanced system integration in automotive ADAS applications,
>>>>> autonomous mobile robot and edge AI applications. The SOC comprises
>>>>> of Cortex-A72s in dual clusters, lockstep capable dual Cortex-R5F MCUs,
>>>>> Vision Processing Accelerators (VPAC) with Image Signal Processor (ISP)
>>>>> and multiple vision assist accelerators, Depth and Motion Processing
>>>>> Accelerators (DMPAC), Deep-learning Matrix Multiply Accelerator(MMA)
>>>>> and C7x floating point vector DSP
>>>>>
>>>>> AM69 SK supports the following interfaces:
>>>>>        * 32 GB LPDDR4 RAM
>>>>>        * x1 Gigabit Ethernet interface
>>>>>        * x3 USB 3.0 Type-A ports
>>>>>        * x1 USB 3.0 Type-C port
>>>>>        * x1 UHS-1 capable micro-SD card slot
>>>>>        * x4 MCAN instances
>>>>>        * 32 GB eMMC Flash
>>>>>        * 512 Mbit OSPI flash
>>>>>        * x2 Display connectors
>>>>>        * x1 PCIe M.2 M Key
>>>>>        * x1 PCIe M.2 E Key
>>>>>        * x1 4L PCIe Card Slot
>>>>>        * x3 CSI2 Camera interface
>>>>>        * 40-pin Raspberry Pi header
>>>>>
>>>>> Add initial support for the AM69 SK board.
>>>> Thank you for your patch. There is something to discuss/improve.
>>>>
>>>>> Design Files: https://www.ti.com/lit/zip/SPRR466
>>>>> TRM: https://www.ti.com/lit/zip/spruj52
>>>>>
>>>>> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/ti/Makefile       |   1 +
>>>>>  arch/arm64/boot/dts/ti/k3-am69-sk.dts | 180 ++++++++++++++++++++++++++
>>>>>  2 files changed, 181 insertions(+)
>>>>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am69-sk.dts
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>>>>> index e7c2c7dd0b25..04b1a7611096 100644
>>>>> --- a/arch/arm64/boot/dts/ti/Makefile
>>>>> +++ b/arch/arm64/boot/dts/ti/Makefile
>>>>> @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>>>>>
>>>>>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>>>>>
>>>>> +dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
>>>> I was told the order of entries here is "time of release". Is it
>>>> correct? This is the order you want to keep here and am69-sk was
>>>> released after j721s2-common-proc-board but before j784s4-evm?
>>>
>>> Unfortunately, files are not in any particular order at the moment.
>>>
>>> Currently, entries are grouped into a block based upon SoC present on
>>> them. Boards within the family block are sorted alphabetically. But the
>>> block of SoCs itself is arranged in no particular order.
>>>
>>> I would like to propose to cleanup this file such that board dtbs are
>>> grouped as per SoC present on them (like now), sort the group
>>> alphabetically. Also then sort alphabetically within the family (similar
>>> how boards appear in dt bindings)
>>>
>>> Will do that towards end of rc6 once these patches are queued up to
>>> avoid merge conflicts.
>>>
>> As per the approach mentioned by Vignesh, I have grouped the am69 sk into
>> the SoC block J784S4 and sorted the board in alphabetical order.
>> Please revert with your thoughts on this.

> Could you please let me know if the approach is acceptable?

I intend to queue this series as is if there are no further comments and
then send a cleanup patch to reorder entries as I described above.

Regards
Vignesh
