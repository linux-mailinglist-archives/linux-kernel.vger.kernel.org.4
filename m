Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790D96EF628
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbjDZOR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZORz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:17:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39C85255;
        Wed, 26 Apr 2023 07:17:53 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33QEHiRc110427;
        Wed, 26 Apr 2023 09:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682518664;
        bh=utbT1a8OkKfzWoc3ajqqMNPrGUYid+tOYtIa5CFUjv4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Gal5mLGybULjD6OkYX88yFVHrfN5Qj7loyMUZIbkAfn8n/2+7LPKBsw7COuFy6pop
         +SU1LkidLH2ZBhfCO/pPZ+lmrbXI8LDBGcmbJbCd0JxFtwXsUbHdhnnejnkt5+YB6B
         Sz9m6xpd44UWndUYBkGqMDUpdt8ttgMeFErWlYlI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33QEHiiR120127
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 09:17:44 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 26
 Apr 2023 09:17:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 26 Apr 2023 09:17:44 -0500
Received: from [10.249.130.34] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33QEHeRh024216;
        Wed, 26 Apr 2023 09:17:41 -0500
Message-ID: <e7ce0120-7843-b029-21cc-97d82abc19d9@ti.com>
Date:   Wed, 26 Apr 2023 19:47:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/5] arm64: dts: ti: k3-j7200: main_pmx0 clean up
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <m-chawdhry@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>
References: <20230426103219.1565266-1-u-kumar1@ti.com>
 <20230426103219.1565266-4-u-kumar1@ti.com>
 <20230426125145.wb6qbhb3c7igx45j@seldom>
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230426125145.wb6qbhb3c7igx45j@seldom>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 4/26/2023 6:21 PM, Nishanth Menon wrote:
> On 16:02-20230426, Udit Kumar wrote:
>> This patch removes duplicated define of main_i2c0
>> and adds main_uart0 pin mux.
>>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> index 63633e4f6c59..37eb24d69924 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> @@ -107,10 +107,12 @@ J721E_WKUP_IOPAD(0x0030, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
>>   };
>>   
>>   &main_pmx0 {
>> -	main_i2c0_pins_default: main-i2c0-pins-default {
> nice catch, but We should clean up the reference in
> common-proc-board.dts, which would make it it's own patch. Also
> indicate that the definition is already present in som.dtsi
>
thanks , will make a patch for its own


>> +	main_uart0_pins_default: main_uart0_pins_default {
>>   		pinctrl-single,pins = <
>> -			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
>> -			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
>> +			J721E_IOPAD(0xb0, PIN_INPUT, 0) /* (T16) UART0_RXD */
>> +			J721E_IOPAD(0xb4, PIN_OUTPUT, 0) /* (T17) UART0_TXD */
>> +			J721E_IOPAD(0xc0, PIN_INPUT, 2) /* (W3) SPI0_CS0.UART0_CTSn */
>> +			J721E_IOPAD(0xc4, PIN_OUTPUT, 2) /* (U5) SPI0_CS1.UART0_RTSn */
>>   		>;
>>   	};
>>   
>> @@ -163,6 +165,8 @@ &main_uart0 {
>>   	status = "okay";
>>   	/* Shared with ATF on this platform */
>>   	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&main_uart0_pins_default>;
>>   };
>>   
>>   &main_uart1 {
>> -- 
>> 2.34.1
>>
