Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1056F57BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjECMQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjECMQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:16:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C465597;
        Wed,  3 May 2023 05:16:19 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 343CGCRd027335;
        Wed, 3 May 2023 07:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683116172;
        bh=yxvXld7ipziPs58UNC838TKUfUNu88KPeyoDk1IG0Fw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=llUbpnhktEKDuGzZ1Blyln1bRhjBkCyInhZ/iFJepRBfrjVQ4GEjA1tDO0nkRJriQ
         uDz0x7UL3q+2oPNp3uCZ1hGeuovmO1uTK28X8GPoAaYb/9AWnJhhnpr1cQ096FnjLQ
         nNS0Syrq1I2iZNXDqSwakuFhGMC9Yrk4Gil/AArU=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 343CGC8Y007164
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 May 2023 07:16:12 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 May 2023 07:16:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 May 2023 07:16:11 -0500
Received: from [172.24.145.195] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 343CG8bg068196;
        Wed, 3 May 2023 07:16:09 -0500
Message-ID: <eb6530ac-a999-fc03-5f11-e1cba6be504d@ti.com>
Date:   Wed, 3 May 2023 17:46:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/3] arm64: dts: ti: k3-j721e: Add ESM support
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <u-kumar1@ti.com>
References: <20230503093310.85779-1-n-francis@ti.com>
 <20230503093310.85779-3-n-francis@ti.com>
 <20230503114827.lutd2ebygxczvali@argue>
 <82a39b8e-96ad-faa2-714f-c8c6bfbcc5d6@ti.com>
 <20230503120200.4xqylyoiczx43esu@gradation>
From:   Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230503120200.4xqylyoiczx43esu@gradation>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth

On 03/05/23 17:32, Nishanth Menon wrote:
> On 17:25-20230503, Neha Malcom Francis wrote:
>> Hi Nishanth,
>>
>> On 03/05/23 17:18, Nishanth Menon wrote:
>>> On 15:03-20230503, Neha Malcom Francis wrote:
>>>> Add address entry mapping ESM on J721E.
>>>>
>>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>>> ---
>>>>    arch/arm64/boot/dts/ti/k3-j721e.dtsi | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
>>>> index b912143b6a11..52bcde601eb8 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
>>>
>>> Why is'nt esm node introduced here?
>>>
>>
>> As it stands esm node is already in
>> arch/arm/dts/k3-j721e-r5-common-proc-board.dts in u-boot and since this
>> patch is motivated to keep the u-boot and kernel dts in sync, I haven't
>> added it here.
>>
>> Although... I could add it here similar to j7200 and take action to move to
>> the same in u-boot... maybe that is better route.
> 
> The core problem we have is that part of the hardware description is in
> u-boot and a large part is in kernel. That is wrong. eventually, we will
> drop u-boot.dtsi and r5-xyz.dts files.. This cleanup journey is towards
> that action.
> 
> we want kernel to be the canonical description of the hardware. which
> means u-boot or zephyr or something else will eventually just copy the
> kernel dts and it has information enough about the hardware to be able
> to boot.
> 
> each of the dependent ecosystems (u-boot, zephyr etc..) have a little
> bit of their own binding extensions (such as binman for u-boot), which
> is maintained in their own repos. But, the SoC hardware description,
> entirely should be available in kernel device tree.
> 
> So, please ensure esm is completely described as well.
> 

Right got it, will add the node in v5, thanks!

-- 
Thanking You
Neha Malcom Francis
