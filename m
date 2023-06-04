Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC077214AC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 06:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjFDEqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 00:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFDEqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 00:46:42 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B938DE;
        Sat,  3 Jun 2023 21:46:40 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3544kNjJ018247;
        Sat, 3 Jun 2023 23:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685853983;
        bh=CNi+Dk2hAYJ+e9/O02ntWYvZX3Xf/9uL14fO+Exnfws=;
        h=Date:From:Subject:To:CC:References:In-Reply-To;
        b=wNwLPIDbqrM9oNe9GhRLYbe5nZU/xfiQ79nmCP64GLbbMJxvOqFJbbQBbg4NCVYQD
         t0bwR2Jy0taNuE3M49Kz2LD9oqpu/nSWfJ5qDq0reOpb8HjDZf+xS7ZBei66w6qVFZ
         7CtquWGl45iRS3gU2pakSzffZO74KbrRT0tTQCHo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3544kNsa100241
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 3 Jun 2023 23:46:23 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 3
 Jun 2023 23:46:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 3 Jun 2023 23:46:22 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3544kJtD098363;
        Sat, 3 Jun 2023 23:46:20 -0500
Message-ID: <dc340ad4-b6ab-0d38-af9d-697b396395c9@ti.com>
Date:   Sun, 4 Jun 2023 10:16:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   "Kumar, Udit" <u-kumar1@ti.com>
Subject: Re: [PATCH v2 3/5] arm64: dts: ti: k3-j7200-common-proc-board:
 main_pmx0 clean up
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <conor+dt@kernel.org>, <m-chawdhry@ti.com>, <n-francis@ti.com>
References: <20230601093744.1565802-1-u-kumar1@ti.com>
 <20230601093744.1565802-4-u-kumar1@ti.com>
 <20230601104527.luzqw4m2aidsuw4x@booting>
Content-Language: en-US
In-Reply-To: <20230601104527.luzqw4m2aidsuw4x@booting>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks

On 6/1/2023 4:15 PM, Nishanth Menon wrote:
> On 15:07-20230601, Udit Kumar wrote:
>> Add main_uart0 pin mux in board common file
> $subject is a bit misleading.. I think the intent is to mux the console
> explicitly rather than a pinmux cleanup itself.

oops, missed to changed subject of this patch after split.

Will address in v3.


>> Signed-off-by: Udit Kumar<u-kumar1@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> index 0cc0e1dc40c5..02d2e4b36b18 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> @@ -113,6 +113,15 @@ J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
>>   		>;
>>   	};
>>   
>> +	main_uart0_pins_default: main_uart0_pins_default {
>> +		pinctrl-single,pins = <
>> +			J721E_IOPAD(0xb0, PIN_INPUT, 0) /* (T16) UART0_RXD */
>> +			J721E_IOPAD(0xb4, PIN_OUTPUT, 0) /* (T17) UART0_TXD */
>> +			J721E_IOPAD(0xc0, PIN_INPUT, 2) /* (W3) SPI0_CS0.UART0_CTSn */
>> +			J721E_IOPAD(0xc4, PIN_OUTPUT, 2) /* (U5) SPI0_CS1.UART0_RTSn */
>> +		>;
>> +	};
>> +
>>   	main_i2c1_pins_default: main-i2c1-pins-default {
>>   		pinctrl-single,pins = <
>>   			J721E_IOPAD(0xdc, PIN_INPUT_PULLUP, 3) /* (U3) ECAP0_IN_APWM_OUT.I2C1_SCL */
>> @@ -162,6 +171,8 @@ &main_uart0 {
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
