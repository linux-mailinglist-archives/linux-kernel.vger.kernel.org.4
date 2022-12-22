Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C56540DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbiLVMRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235910AbiLVMRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:17:00 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE4926100;
        Thu, 22 Dec 2022 04:14:12 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BMCDoVC013109;
        Thu, 22 Dec 2022 06:13:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671711230;
        bh=nFpV4RWFM7sAx+4Rmwc8V35IGaa6qoL6iAygW5uqUp4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=gyiUvV8E2kQPJB3iHj3gpOF/MOITuuTDOAwD+Qp62IBODNuG3snDZwl2dEyq6959I
         x8CvSOFZwsuHp8qG9YyRRK5bK9GOUJGBwIGQ5eAnOi9B9QAxYVhyAqtSQ/XJqVr0G5
         dGRjCHtsBAqgY/VKtZ6I6QZJ9eKGNmzmegJvKcOw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BMCDojl120108
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Dec 2022 06:13:50 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 22
 Dec 2022 06:13:50 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 22 Dec 2022 06:13:50 -0600
Received: from [10.250.234.78] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BMCDHlD109969;
        Thu, 22 Dec 2022 06:13:22 -0600
Message-ID: <baf09a74-ecf7-e60e-4a24-18f023a802f5@ti.com>
Date:   Thu, 22 Dec 2022 17:43:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [EXTERNAL] Re: [PATCH v2] arm64: dts: ti: k3-j721s2: Add support
 for ADC nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20221221055144.7181-1-b-kapoor@ti.com>
 <e21d15f9-10fa-671b-b49c-a9f748aae75d@linaro.org>
From:   Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <e21d15f9-10fa-671b-b49c-a9f748aae75d@linaro.org>
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


On 22/12/22 17:32, Krzysztof Kozlowski wrote:
> On 21/12/2022 06:51, Bhavya Kapoor wrote:
>> J721s2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
>> for 8 channel ADCs for J721s2 SoC.
>>
>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>> ---
>>
>> Changelog v1 -> v2:
>> 	- Updated Interrupt Values for tscadc
>>
>>   .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++
>>   .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 42 ++++++++++++++++++-
>>   2 files changed, 55 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> index a7aa6cf08acd..67593aa69327 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> @@ -309,3 +309,17 @@ &mcu_mcan1 {
>>   	pinctrl-0 = <&mcu_mcan1_pins_default>;
>>   	phys = <&transceiver2>;
>>   };
>> +
>> +&tscadc0 {
>> +	status = "okay";
>> +	adc {
>> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>> +	};
>> +};
>> +
>> +&tscadc1 {
>> +	status = "okay";
>> +	adc {
>> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>> +	};
>> +};
>> \ No newline at end of file
> Same errors as before.
>
> I don't know how many same patches we need to see - this is fourth. None
> of them seems to be correct...
>
> Best regards,
> Krzysztof
>
This is a v2 patch. Please read the changelog. Link to its v1 is 
https://lore.kernel.org/all/20221220101249.46450-1-b-kapoor@ti.com/

I mailed to drop other previous patch before this v1 -> 
https://lore.kernel.org/all/c61fb922-e4aa-8068-242b-f495e4fc4369@ti.com/

Regards

