Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5136D9498
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDFLAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbjDFLAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:00:45 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7331C7AA0;
        Thu,  6 Apr 2023 04:00:42 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 336B0SXx094982;
        Thu, 6 Apr 2023 06:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680778828;
        bh=6bbdy1sOJ7iE1WXluAkOlGMzShdZRbyZBjiPoABbSRA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=m66Q7Qm502Or78WbE/hrE+yMfNxZJ1l50o5eekaN3phmvhj338rncGqIMKEUuhwCv
         TsI2NZqbjdOgDyDB628PdySTr3nGHYDucixaCZP1U9GwZAFFWkpOWaNmaFKi4zsR2a
         UNOEQ7JMkTxVu8srr9RC2TetalA7l1PAPJPoZFqc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 336B0SPO007572
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Apr 2023 06:00:28 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 6
 Apr 2023 06:00:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 6 Apr 2023 06:00:28 -0500
Received: from [172.24.145.25] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 336B0Orx082012;
        Thu, 6 Apr 2023 06:00:25 -0500
Message-ID: <174f5554-2dea-0ec7-18ee-b8bd093c99fe@ti.com>
Date:   Thu, 6 Apr 2023 16:30:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/6] arm64: dts: ti: k3-j784s4-*: Add DSS node
To:     Andrew Davis <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230405111412.151192-1-j-choudhary@ti.com>
 <20230405111412.151192-5-j-choudhary@ti.com>
 <e38ea0b2-5e51-05d6-50fc-c7ef3d4b8698@ti.com>
Content-Language: en-US
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <e38ea0b2-5e51-05d6-50fc-c7ef3d4b8698@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On 05/04/23 22:07, Andrew Davis wrote:
> On 4/5/23 6:14 AM, Jayesh Choudhary wrote:
>> From: Rahul T R <r-ravikumar@ti.com>
>>
>> Add DSS node for J784S4 SoC. DSS IP in J784S4
>> is same as DSS IP in J721E, so same compatible is
>> being used.
>> Also add assigned clks for DSS
>>
>> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 11 +++++
> 
> 
> The changes to `k3-j784s4-evm.dts` in this patch and the next all
> need moved to the last patch in this series. All these changes
> needed to enable the display in the EVM work together and so
> should be one atomic step.
> 
> Andrew

Okay. Will fix this in v2.

-Jayesh

> 
>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 55 ++++++++++++++++++++++
>>   2 files changed, 66 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts 
>> b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> index b1445b7c2aa8..ccbfca76e9ae 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> @@ -305,3 +305,14 @@ &main_cpsw1_port1 {
>>   &serdes_refclk {
>>       clock-frequency = <100000000>;
>>   };

[...]
