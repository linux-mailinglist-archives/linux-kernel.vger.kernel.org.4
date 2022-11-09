Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8604622413
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 07:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiKIGsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 01:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIGsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 01:48:03 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F38E1CFE2;
        Tue,  8 Nov 2022 22:48:02 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A96ltvH032399;
        Wed, 9 Nov 2022 00:47:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667976475;
        bh=1Hn0eSk6OyN5lL5cDqWJi5Os4rxljA5PAuJM4IPMRr8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=v2DHvz6r+V2m8Bco5xP5voIAKT3B48hqPXHouKMqvf8XlHn0MaMi8K7pK+V3Ua+G4
         KpGhu099kjNwPFZ8BTJFgxFYMonAGOuP4hTAUEx31nSjOR0SY3ENvLD0eUSqmKv3xo
         QWvLOzNApbiT7rR5JTQWa+Tghndj6sEsEs+GYbVA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A96ltDk022891
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Nov 2022 00:47:55 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 9 Nov
 2022 00:47:55 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 9 Nov 2022 00:47:55 -0600
Received: from [10.250.234.28] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A96lpiL083212;
        Wed, 9 Nov 2022 00:47:52 -0600
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: dts: ti: k3-j721s2: Add support for
 ADC nodes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <piyali_g@ti.com>
References: <20221108073231.35008-1-b-kapoor@ti.com>
 <f70346da-228e-79d2-7284-6c64cda7eda0@linaro.org>
From:   Bhavya Kapoor <b-kapoor@ti.com>
Message-ID: <63f0841c-c268-957d-30a1-f1da29125870@ti.com>
Date:   Wed, 9 Nov 2022 12:17:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <f70346da-228e-79d2-7284-6c64cda7eda0@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/22 11:48 PM, Krzysztof Kozlowski wrote:
> On 08/11/2022 08:32, Bhavya Kapoor wrote:
>> J721S2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
>> for 8 channel ADCs for J721S2.
>>
>> Enable ADCs present on J721S2 soc.
>>
>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>> ---
>>   .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++
>>   .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 40 +++++++++++++++++++
>>   2 files changed, 54 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> index b210cc07c539..de9cb40273be 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> @@ -429,3 +429,17 @@
>>   &main_mcan17 {
>>   	status = "disabled";
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
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>> index 4d1bfabd1313..47a7a6b500c2 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
>> @@ -299,4 +299,44 @@
>>   			ti,cpts-periodic-outputs = <2>;
>>   		};
>>   	};
>> +
>> +	tscadc0: tscadc@40200000 {
> Node names should be generic, so "adc"
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

tscadc is just a wrapper node. The actual adc node is inside of tscadc node.

>
> Best regards,
> Krzysztof
>
Regards

BK

