Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658A96E2EF4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 06:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDOEKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 00:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDOEKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 00:10:30 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9DC55A4;
        Fri, 14 Apr 2023 21:10:29 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33F4AFo9100286;
        Fri, 14 Apr 2023 23:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681531815;
        bh=dslg9uFniCIR+qxHa2T1VzYHiExAU99uAOFzP7FzTnY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=DTfGExgzdYZHW6hety/9DkYd+Xmm4Wrmlj9eepWxPirxg1ZaDETJ0bF5ZfM7rUCl3
         Ux2evJgXbdoOwVoHC3gAFojcPFD3+he1xZo9Eb2mZ6CQiRvtP1IF2/uodfVPOQEBhY
         UBYnrOIYZVdbOuc+jeC+ZgKcpk6D793d0eEtzNKQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33F4AFN9017891
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 23:10:15 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 23:10:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 23:10:14 -0500
Received: from [10.249.130.34] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33F4AAvL014091;
        Fri, 14 Apr 2023 23:10:11 -0500
Message-ID: <20bbb3f0-ac79-9d98-9c99-7062581b163f@ti.com>
Date:   Sat, 15 Apr 2023 09:40:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j7200: Fix physical address of pin
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <bb@ti.com>,
        <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, J Keerthi <j-keerthy@ti.com>
References: <20230414181434.2046049-1-u-kumar1@ti.com>
 <20230414181434.2046049-2-u-kumar1@ti.com>
 <20230414182638.watc555ihi2hgkuv@slinging>
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230414182638.watc555ihi2hgkuv@slinging>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth

On 4/14/2023 11:56 PM, Nishanth Menon wrote:
> On 23:44-20230414, Udit Kumar wrote:
>> Fixes: 9ae21ac445e9 ("arm64: dts: ti: k3-j7200: Fix wakeup pinmux range")
> In the wrong place.


will address in v2


>> wkup_pmx splits into multiple regions. Like
>>
>>      wkup_pmx0 -> 13 pins (WKUP_PADCONFIG 0 - 12)
>>      wkup_pmx1 -> 2 pins (WKUP_PADCONFIG 14 - 15)
>>      wkup_pmx2 -> 59 pins (WKUP_PADCONFIG 26 - 84)
>>      wkup_pmx3 -> 8 pins (WKUP_PADCONFIG 93 - 100)
>>
>> With this split, pin offset needs to be adjusted to
>> match with new pmx for all pins above wkup_pmx0.
>>
>> Example a pin under wkup_pmx1 should start from 0 instead of
>> old offset(0x38 WKUP_PADCONFIG 14 offset)
>>
>> J7200 Datasheet (Table 6-106, Section 6.4 Pin Multiplexing) :
>>              https://www.ti.com/lit/ds/symlink/dra821u.pdf
> Drop the preceding whitespace.

ok

>> Signed-off-by: J Keerthi <j-keerthy@ti.com>
> Spell check name please, I think he usually goes with:
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
>
> If this patch is from Keerthy, the patch should have a "From:"

ok.

git apply on original patch didn't worked , so i applied and committed.

will fix in patch itself before posting, Keerthi as author


>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>>   .../dts/ti/k3-j7200-common-proc-board.dts     | 28 +++++++++----------
>>   1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> index 0d39d6b8cc0c..63633e4f6c59 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> @@ -83,25 +83,25 @@ vdd_sd_dv: gpio-regulator-TLV71033 {
>>   &wkup_pmx2 {
>>   	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
>>   		pinctrl-single,pins = <
>> -			J721E_WKUP_IOPAD(0x0068, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
>> -			J721E_WKUP_IOPAD(0x006c, PIN_INPUT, 0) /* MCU_RGMII1_RX_CTL */
>> -			J721E_WKUP_IOPAD(0x0070, PIN_OUTPUT, 0) /* MCU_RGMII1_TD3 */
>> -			J721E_WKUP_IOPAD(0x0074, PIN_OUTPUT, 0) /* MCU_RGMII1_TD2 */
>> -			J721E_WKUP_IOPAD(0x0078, PIN_OUTPUT, 0) /* MCU_RGMII1_TD1 */
>> -			J721E_WKUP_IOPAD(0x007c, PIN_OUTPUT, 0) /* MCU_RGMII1_TD0 */
>> -			J721E_WKUP_IOPAD(0x0088, PIN_INPUT, 0) /* MCU_RGMII1_RD3 */
>> -			J721E_WKUP_IOPAD(0x008c, PIN_INPUT, 0) /* MCU_RGMII1_RD2 */
>> -			J721E_WKUP_IOPAD(0x0090, PIN_INPUT, 0) /* MCU_RGMII1_RD1 */
>> -			J721E_WKUP_IOPAD(0x0094, PIN_INPUT, 0) /* MCU_RGMII1_RD0 */
>> -			J721E_WKUP_IOPAD(0x0080, PIN_OUTPUT, 0) /* MCU_RGMII1_TXC */
>> -			J721E_WKUP_IOPAD(0x0084, PIN_INPUT, 0) /* MCU_RGMII1_RXC */
>> +			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
>> +			J721E_WKUP_IOPAD(0x0004, PIN_INPUT, 0) /* MCU_RGMII1_RX_CTL */
>> +			J721E_WKUP_IOPAD(0x0008, PIN_OUTPUT, 0) /* MCU_RGMII1_TD3 */
>> +			J721E_WKUP_IOPAD(0x000c, PIN_OUTPUT, 0) /* MCU_RGMII1_TD2 */
>> +			J721E_WKUP_IOPAD(0x0010, PIN_OUTPUT, 0) /* MCU_RGMII1_TD1 */
>> +			J721E_WKUP_IOPAD(0x0014, PIN_OUTPUT, 0) /* MCU_RGMII1_TD0 */
>> +			J721E_WKUP_IOPAD(0x0020, PIN_INPUT, 0) /* MCU_RGMII1_RD3 */
>> +			J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0) /* MCU_RGMII1_RD2 */
>> +			J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0) /* MCU_RGMII1_RD1 */
>> +			J721E_WKUP_IOPAD(0x002c, PIN_INPUT, 0) /* MCU_RGMII1_RD0 */
>> +			J721E_WKUP_IOPAD(0x0018, PIN_OUTPUT, 0) /* MCU_RGMII1_TXC */
>> +			J721E_WKUP_IOPAD(0x001c, PIN_INPUT, 0) /* MCU_RGMII1_RXC */
> nice catch.
>
>>   		>;
>>   	};
>>   
>>   	mcu_mdio_pins_default: mcu-mdio1-pins-default {
>>   		pinctrl-single,pins = <
>> -			J721E_WKUP_IOPAD(0x009c, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
>> -			J721E_WKUP_IOPAD(0x0098, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
>> +			J721E_WKUP_IOPAD(0x0034, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
>> +			J721E_WKUP_IOPAD(0x0030, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
>>   		>;
>>   	};
>>   };
>> -- 
>> 2.34.1
>>
