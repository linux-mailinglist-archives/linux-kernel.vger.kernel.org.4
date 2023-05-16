Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08A1704862
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjEPJBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjEPJBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:01:44 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592AA2702;
        Tue, 16 May 2023 02:01:43 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34G91VMP097753;
        Tue, 16 May 2023 04:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684227691;
        bh=ra50So9VFNEcy1Z0p1DCVHr3DVoWJ18jRC5LGpgjuOk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=IA5ZyolEiUYXZFzvGJ9GAvzJuC3akAad/hdvFyhZlJ6SxhnkmUmAlRy7rAMzTenRX
         B7hPfO5vavI4DvlQdpNkgdQZNJHdH1ujzSUGJYoTPYOf2arUuAq03b42BOsQegZwSm
         AIl4ZwrhHXGNwQf3bTOMZoRqlKxkqznZwTB8aAKQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34G91VWm031111
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 04:01:31 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 04:01:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 04:01:30 -0500
Received: from [172.24.217.19] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34G91QtQ110237;
        Tue, 16 May 2023 04:01:27 -0500
Message-ID: <215913ae-dfd2-aaff-86b1-9def30648155@ti.com>
Date:   Tue, 16 May 2023 14:31:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: correct num-lanes requested for
 PCIe
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Achal Verma <a-verma1@ti.com>
References: <20230516062212.2635948-1-a-verma1@ti.com>
 <728c0165-3caa-de09-2493-e7225a78b77a@ti.com>
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <728c0165-3caa-de09-2493-e7225a78b77a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/2023 12:03 PM, Siddharth Vadapalli wrote:
> Achal,
> 
> On 16/05/23 11:52, Achal Verma wrote:
>> From: Matt Ranostay <mranostay@ti.com>
>>
>> J7200 has a limited 2x support for PCIe, and the properties should be
>> updated as such.
> 
> According to J7200 Datasheet at [0], the SoC supports up to x4 PCIe lanes. Could
> you please clarify where the lanes are documented to be 2x?
> 
> [0]: https://www.ti.com/lit/ds/symlink/dra821u-q1.pdf

Yes, this patch should be dropped.
No need to change lanes.

Regards,
Achal Verma
> 
>>
>> Signed-off-by: Matt Ranostay <mranostay@ti.com>
>> Signed-off-by: Achal Verma <a-verma1@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> index ef352e32f19d..5e62b431d6e8 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> @@ -729,7 +729,7 @@ pcie1_rc: pcie@2910000 {
>>   		device_type = "pci";
>>   		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
>>   		max-link-speed = <3>;
>> -		num-lanes = <4>;
>> +		num-lanes = <2>;
>>   		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
>>   		clocks = <&k3_clks 240 6>;
>>   		clock-names = "fck";
>> @@ -757,7 +757,7 @@ pcie1_ep: pcie-ep@2910000 {
>>   		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
>>   		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
>>   		max-link-speed = <3>;
>> -		num-lanes = <4>;
>> +		num-lanes = <2>;
>>   		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
>>   		clocks = <&k3_clks 240 6>;
>>   		clock-names = "fck";
> 
