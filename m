Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAD86B9813
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjCNOfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjCNOfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:35:30 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFA5664D0;
        Tue, 14 Mar 2023 07:35:28 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32EEZGNk092841;
        Tue, 14 Mar 2023 09:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678804517;
        bh=L5/zGgUxjjME0dckJN91YKQn8hM7/NY/ZCwMlIsSkB4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ttCOaj5Xhxf6CVF4Q4CXGJ5R0lTM3o4WqpD4SVsVxuUiWLKVaXbZbKMZrnRiNFXZ7
         Zoc2o16Q9vaCJ7ZAmhjPO8Pk9unL5uecSLaqSPppFjZ2aYnLNRGuzs0LyHhcza5RJq
         Md3u4C2p0cv0qVKYAd9JqebNe5rzTaw0IZdG8KPI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32EEZG2q097822
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 09:35:16 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 09:35:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 09:35:16 -0500
Received: from [172.24.145.215] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32EEZCor097950;
        Tue, 14 Mar 2023 09:35:13 -0500
Message-ID: <ee4dbb15-30c3-259b-3ae7-4f7ad4898d33@ti.com>
Date:   Tue, 14 Mar 2023 20:05:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j784s4-mcu-wakeup: Add device id
 property for mcu_navss
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20230314104055.1475054-1-s-vadapalli@ti.com>
 <20230314104055.1475054-2-s-vadapalli@ti.com>
 <20230314132922.ejbutfxt7z7xhqgm@danger>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20230314132922.ejbutfxt7z7xhqgm@danger>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/03/23 18:59, Nishanth Menon wrote:
> On 16:10-20230314, Siddharth Vadapalli wrote:
>> The "ti,sci-dev-id" property used to indicate the Device ID is missing
>> for mcu_navss device-tree node. Add it.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
>> index 93952af618f6..52311da15579 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
>> @@ -212,6 +212,8 @@ mcu_navss: bus@28380000{
>>   		dma-coherent;
>>   		dma-ranges;
>>   
>> +		ti,sci-dev-id = <323>;
>> +
>>   		mcu_ringacc: ringacc@2b800000 {
>>   			compatible = "ti,am654-navss-ringacc";
>>   			reg = <0x00 0x2b800000 0x00 0x400000>,
>> -- 
>> 2.25.1
>>
> 
> Looks like
> https://lore.kernel.org/all/20230313104721.407071-2-j-choudhary@ti.com/
> is another part of the Fixup?
> 
> Why not squash the two as a missing ti,sci-dev-id for j784s4?

Okay I will add this to my series and re-roll v2.

-Jayesh

> 
> 
