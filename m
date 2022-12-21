Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D20652C76
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiLUFmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLUFmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:42:35 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDB51AF2E;
        Tue, 20 Dec 2022 21:42:34 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BL5gQQN087003;
        Tue, 20 Dec 2022 23:42:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671601346;
        bh=St/d0ulWbFggoydGDrSQv9HID53vETKPZujxz9/cCa0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=xQF9r2LGSFvLQwq/dWLIrR3FznjcuWowJPdzWJUs1ZKWoqH66CWUXU8Ft91yer+R4
         mQ3/cCRV1MK5S8PsBkCfP93NUe8Syv/W/VFwGbgTNmfLHKtyZPGP3AkVIwj6JH02XG
         ptfysA232Lq5UMrwXGZS9/XciuxwOZUHMr7xgGhA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BL5gQLS022740
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Dec 2022 23:42:26 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 20
 Dec 2022 23:42:26 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 20 Dec 2022 23:42:26 -0600
Received: from [10.250.234.60] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BL5gGTa012775;
        Tue, 20 Dec 2022 23:42:19 -0600
Message-ID: <a4d11974-eb97-bfa2-790f-3016950ea961@ti.com>
Date:   Wed, 21 Dec 2022 11:12:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: dts: ti: k3-j721s2: Add support for
 ADC nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>
References: <20221220101249.46450-1-b-kapoor@ti.com>
 <ff5b09db-4900-0b5b-e821-fa05b8d907a4@linaro.org>
From:   Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <ff5b09db-4900-0b5b-e821-fa05b8d907a4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/12/22 16:20, Krzysztof Kozlowski wrote:
> On 20/12/2022 11:12, Bhavya Kapoor wrote:
>> J721s2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
>> for 8 channel ADCs for J721s2 SoC.
>>
>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>> ---
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
> This is a friendly reminder during the review process.
>
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
>
> Thank you.
>
> Best regards,
> Krzysztof

Hi , I thought i did addressed the feedback since tscadc is just a 
wrapper node.

The actual adc node is inside of tscadc node.
