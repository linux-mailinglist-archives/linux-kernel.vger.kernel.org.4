Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB936EE1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjDYMhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjDYMhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:37:12 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE1CD32E;
        Tue, 25 Apr 2023 05:37:06 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33PCaowv026583;
        Tue, 25 Apr 2023 07:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682426210;
        bh=LBfwTxbidWZ0or12s36XuGswyWTtxWPU3nU7gxW9OEM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=a+Uy9OQ8gAEyv2rCjjUEt/M8s5zvGRwk9iukj8fDFxY1ZEzj7gg8+urtwT/JTzXIk
         RUBl9ykXKT82kZdfYfWiCmTA6K5bW+lYvllHND7kRFmzrFlfocDJPleJwj4IxrPWTh
         t1p+Ro1idWtbaags2aFDk9hbDmHWgBeOz+iGiLMY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33PCanBL068406
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Apr 2023 07:36:50 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 25
 Apr 2023 07:36:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 25 Apr 2023 07:36:49 -0500
Received: from [10.24.69.79] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33PCajGM000377;
        Tue, 25 Apr 2023 07:36:46 -0500
Message-ID: <57b41394-fdc4-b185-94c9-9daac7a9b89b@ti.com>
Date:   Tue, 25 Apr 2023 18:06:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v14 5/8] arm64: dts: ti: k3-j721s2-common-proc-board: Add
 USB support
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, <nm@ti.com>, <afd@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-vadapalli@ti.com>,
        <vaishnav.a@ti.com>, ravi Gunasekaran <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230331090028.8373-1-r-gunasekaran@ti.com>
 <20230331090028.8373-6-r-gunasekaran@ti.com>
 <efe734a5-8d6f-b597-c4fd-bdf0879ed9c4@kernel.org>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <efe734a5-8d6f-b597-c4fd-bdf0879ed9c4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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



On 25/04/23 5:31 pm, Roger Quadros wrote:
> 
> 
> On 31/03/2023 12:00, Ravi Gunasekaran wrote:
>> From: Aswath Govindraju <a-govindraju@ti.com>
>>
>> The board uses lane 1 of SERDES for USB. Set the mux
>> accordingly.
>>
>> The USB controller and EVM supports super-speed for USB0
>> on the Type-C port. However, the SERDES has a limitation
>> that up to 2 protocols can be used at a time. The SERDES is
>> wired for PCIe, eDP and USB super-speed. It has been
>> chosen to use PCIe and eDP as default. So restrict
>> USB0 to high-speed mode.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> Signed-off-by: Matt Ranostay <mranostay@ti.com>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>> I had reviewed this patch in the v5 series [0].
>> Since I'm taking over upstreaming this series, I removed the self
>> Reviewed-by tag.
>>

[...]

>> * No change
>>
>>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 23 +++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> index 1afefaf3f974..5c4ffb8124ca 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>> @@ -147,6 +147,12 @@
>>  			J721S2_IOPAD(0x020, PIN_INPUT, 7) /* (AA23) MCAN15_RX.GPIO0_8 */
>>  		>;
>>  	};
>> +
>> +	main_usbss0_pins_default: main-usbss0-pins-default {
>> +		pinctrl-single,pins = <
>> +			J721S2_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AG25) TIMER_IO1.USB0_DRVVBUS */
> 
> What about USB0_ID pin?
> 

The pin (AC9) for USB0_ID signal is not multiplexed with any other signals.
Please see Page 51 in [0].

>> +		>;
>> +	};
>>  };
>>  

[...]

>> +
>> +&usb0 {
>> +	dr_mode = "otg";
>> +	maximum-speed = "high-speed";
> 
> Why is super-speed not possible?
> I understood that SERDES lane 1 can be used for USB super-speed.

The SerDes on J721S2 can simultaneously support only two protocols.
By default PCIe and DP will be supported. Due to this, USB is configured
in high-speed and this does not require any SerDes lane configuration.

> 
>> +};
>> +
>>  &mcu_mcan0 {
>>  	status = "okay";
>>  	pinctrl-names = "default";
> 
> cheers,
> -roger

[0] https://www.ti.com/lit/gpn/TDA4AL-Q1 

-- 
Regards,
Ravi
