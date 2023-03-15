Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F8F6BA5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 05:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjCOEDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 00:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCOEDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 00:03:21 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D480346A0;
        Tue, 14 Mar 2023 21:03:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32F432C4062250;
        Tue, 14 Mar 2023 23:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678852982;
        bh=qlQUxniJ6i66+BGGVI0UwvibIVfhqDScGE+wexyMUsI=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=D6Z9T23rY2dviD7KqEFDajwav6eYi0QT2DH+wlmkRhXuTIDDFJyVWHZzNbQ/p269d
         h5cfyFz2X93GMciafNeqFlxlGprnfefflVRTn5PMfWIgr0VQcVGykthDEQQKHwNvZ6
         tROIEHE0hPcSqbuL7DBmnolJDylwoY0mkVxQXQeY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32F4324m043826
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 23:03:02 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 23:03:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 23:03:01 -0500
Received: from [172.24.145.61] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32F42vVi021513;
        Tue, 14 Mar 2023 23:02:58 -0500
Message-ID: <32f57c8a-61a4-13ec-a4ce-e1f5d45e45d7@ti.com>
Date:   Wed, 15 Mar 2023 09:32:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j784s4-evm: Enable MCU CPSW2G
To:     Andrew Davis <afd@ti.com>
References: <20230314104055.1475054-1-s-vadapalli@ti.com>
 <20230314104055.1475054-3-s-vadapalli@ti.com>
 <88e8617c-7b88-238d-2097-bfc25c0f9bf7@ti.com>
Content-Language: en-US
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <88e8617c-7b88-238d-2097-bfc25c0f9bf7@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Hello Andrew,

On 15/03/23 03:40, Andrew Davis wrote:
> On 3/14/23 5:40 AM, Siddharth Vadapalli wrote:
>> Add device tree support to enable MCU CPSW with J784S4 EVM.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 47 ++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> index 8cd4a7ecc121..05db64ed0706 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> @@ -140,6 +140,32 @@ J784S4_IOPAD(0x020, PIN_INPUT, 7) /* (AJ35)
>> MCAN15_RX.GPIO0_8 */
>>       };
>>   };
>>   +&wkup_pmx0 {
>> +    mcu_cpsw_pins_default: mcu-cpsw-pins-default {
>> +        pinctrl-single,pins = <
>> +            J784S4_WKUP_IOPAD(0x094, PIN_INPUT, 0) /* (A35) MCU_RGMII1_RD0 */
>> +            J784S4_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (B36) MCU_RGMII1_RD1 */
>> +            J784S4_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C36) MCU_RGMII1_RD2 */
>> +            J784S4_WKUP_IOPAD(0x088, PIN_INPUT, 0) /* (D36) MCU_RGMII1_RD3 */
>> +            J784S4_WKUP_IOPAD(0x084, PIN_INPUT, 0) /* (B37) MCU_RGMII1_RXC */
>> +            J784S4_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (C37) MCU_RGMII1_RX_CTL */
>> +            J784S4_WKUP_IOPAD(0x07c, PIN_OUTPUT, 0) /* (D37) MCU_RGMII1_TD0 */
>> +            J784S4_WKUP_IOPAD(0x078, PIN_OUTPUT, 0) /* (D38) MCU_RGMII1_TD1 */
>> +            J784S4_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (E37) MCU_RGMII1_TD2 */
>> +            J784S4_WKUP_IOPAD(0x070, PIN_OUTPUT, 0) /* (E38) MCU_RGMII1_TD3 */
>> +            J784S4_WKUP_IOPAD(0x080, PIN_OUTPUT, 0) /* (E36) MCU_RGMII1_TXC */
>> +            J784S4_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (C38)
>> MCU_RGMII1_TX_CTL */
>> +        >;
>> +    };
>> +
>> +    mcu_mdio_pins_default: mcu-mdio-pins-default {
>> +        pinctrl-single,pins = <
>> +            J784S4_WKUP_IOPAD(0x09c, PIN_OUTPUT, 0) /* (A36) MCU_MDIO0_MDC */
>> +            J784S4_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (B35) MCU_MDIO0_MDIO */
>> +        >;
>> +    };
>> +};
>> +
>>   &main_uart8 {
>>       status = "okay";
>>       pinctrl-names = "default";
>> @@ -194,3 +220,24 @@ &main_sdhci1 {
>>   &main_gpio0 {
>>       status = "okay";
>>   };
>> +
>> +&mcu_cpsw {
>> +    status = "okay";
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
> 
> Move the mcu_mdio_pins_default pinctrl to the mdio node below.

Thank you for reviewing the patch. I will fix it and post the v2 patch.

Regards,
Siddharth.
