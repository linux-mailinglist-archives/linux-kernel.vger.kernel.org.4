Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9049651E39
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiLTJ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiLTJ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:57:22 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772CB63D7;
        Tue, 20 Dec 2022 01:56:44 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BK9uRkI033305;
        Tue, 20 Dec 2022 03:56:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671530187;
        bh=OnsEHsFL7EEgrc+lnGoktys9OkbTsxNg5h+5DqqylI8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=tp17laKP9yOh7rI81/aew0U+KqBzfvCRhBvIj1OsDW1KinwdBNRbUi+BbOlnRnlz+
         lmBsgFxWaePzgwPuPcgISN/bKYf9BOM+kE1W+/b8Zj3XST6wUALLHfn9EJAr4wfWOO
         yq0Q49QQjcu5jtOWDXHcNZ6TA1yd+I1AofMF4uGo=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BK9uQm0071961
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Dec 2022 03:56:27 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 20
 Dec 2022 03:56:26 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 20 Dec 2022 03:56:26 -0600
Received: from [10.250.234.60] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BK9uKXj026828;
        Tue, 20 Dec 2022 03:56:21 -0600
Message-ID: <c61fb922-e4aa-8068-242b-f495e4fc4369@ti.com>
Date:   Tue, 20 Dec 2022 15:26:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: dts: ti: k3-j721s2: Add support for
 ADC nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <piyali_g@ti.com>
References: <20221108073231.35008-1-b-kapoor@ti.com>
 <f70346da-228e-79d2-7284-6c64cda7eda0@linaro.org>
From:   Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <f70346da-228e-79d2-7284-6c64cda7eda0@linaro.org>
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

Hi, please drop this patch since the interrupt values supplied for 
tscadc are incorrect.

On 08/11/22 23:48, Krzysztof Kozlowski wrote:
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
>
> Best regards,
> Krzysztof
>
