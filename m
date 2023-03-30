Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A08C6D0D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjC3RpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjC3RpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:45:07 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D46DBD1;
        Thu, 30 Mar 2023 10:45:06 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32UHiuPt113059;
        Thu, 30 Mar 2023 12:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680198296;
        bh=jviOJ9W6akJAPfpX1T4+6yfoFwBwyAfr/XjPPdT+TYc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ZPR4O1mco+7Z3c9+VJzFmyE5GcV7WnaJ7EcnBKGsmyF6h8OduoldyEpH5RXqTHDIM
         uXyEurDEOMpYe6xwbupili1Cswn7kwdckgN16FJFQ/Xc3lSMKl1THNBNqxM4vlCslD
         HJ1Eap7DROq5/1elDcPtoBM+HP1RCB5tl/xJkqdU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32UHiuC8014141
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Mar 2023 12:44:56 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 30
 Mar 2023 12:44:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 30 Mar 2023 12:44:56 -0500
Received: from [10.249.138.125] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32UHiqgq015758;
        Thu, 30 Mar 2023 12:44:53 -0500
Message-ID: <8f4e8265-da64-1e53-e1ed-b925e0326cad@ti.com>
Date:   Thu, 30 Mar 2023 23:14:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-evm: Add eMMC mmc0 support
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     Apurva Nandan <a-nandan@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Kumar, Udit" <u-kumar1@ti.com>
References: <20230327083100.12587-1-a-nandan@ti.com>
 <f3be8f20-fe56-489e-440c-53ca66f00508@ti.com>
 <20230330152406.fmpri7nnzybf7uqh@jubilance>
From:   Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20230330152406.fmpri7nnzybf7uqh@jubilance>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/03/23 20:54, Nishanth Menon wrote:
> On 11:50-20230330, Bhavya Kapoor wrote:
>> On 27/03/23 14:01, Apurva Nandan wrote:
>>> Add support for eMMC card connected to main sdhci0 instance.
>>>
>>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> Reviewed-by: Bhavya Kapoor <b-kapoor@ti.com>
>>
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> index 7480f37e89e8..1622a01a4667 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>> @@ -21,6 +21,7 @@ chosen {
>>>
>>>   	aliases {
>>>   		serial2 = &main_uart8;
>>> +		mmc0 = &main_sdhci0;
>>>   		mmc1 = &main_sdhci1;
>>>   		i2c0 = &main_i2c0;
>>>   	};
>>> @@ -225,6 +226,14 @@ exp2: gpio@22 {
>>>   	};
>>>   };
>>>
>>> +&main_sdhci0 {
>>> +	/* eMMC */
>>> +	status = "okay";
>>> +	non-removable;
>>> +	ti,driver-strength-ohm = <50>;
>>> +	disable-wp;
>>> +};
>>> +
>>>   &main_sdhci1 {
>>>   	/* SD card */
>>>   	status = "okay";
>>> --
>>> 2.34.1
>> Looks correct to me.
>
> Don't you need pinmux?
>
Hi Nishanth, pinmux is not needed since there is no mux options for emmc pins (mmc0) in datasheet.

 -> Kindly refer to datasheet for same : https://www.ti.com/lit/ds/symlink/tda4vh-q1.pdf?ts=1680197698102&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FTDA4VH-Q1%253FkeyMatch%253DTDA4VH%2BDATASHEET


Regards

~B-Kapoor

