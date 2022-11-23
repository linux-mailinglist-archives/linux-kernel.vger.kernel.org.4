Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E3D63600D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbiKWNhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbiKWNgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:36:43 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EB51DA6D;
        Wed, 23 Nov 2022 05:23:02 -0800 (PST)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 23 Nov
 2022 21:23:00 +0800
Message-ID: <3bdaa648-c607-a79c-f6bb-c75baa1e8509@amlogic.com>
Date:   Wed, 23 Nov 2022 21:23:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V5 4/4] arm64: dts: meson: add S4 Soc Peripheral clock
 controller in DT
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <kelvin.zhang@amlogic.com>
References: <20221123021346.18136-1-yu.tu@amlogic.com>
 <20221123021346.18136-5-yu.tu@amlogic.com>
 <ae43fadf-9255-7db7-8b5e-01200e02a2c6@linaro.org>
 <9858039f-e635-2749-80a2-75072d6e9cea@amlogic.com>
 <8dbb3ce2-c8d9-70be-d1de-ed875de0ea1b@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <8dbb3ce2-c8d9-70be-d1de-ed875de0ea1b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/23 21:02, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 23/11/2022 12:27, Yu Tu wrote:
>> Hi Krzysztof,
>> 	
>> On 2022/11/23 18:10, Krzysztof Kozlowski wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On 23/11/2022 03:13, Yu Tu wrote:
>>>> Added information about the S4 SOC Peripheral Clock controller in DT.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>> ---
>>>>    arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 26 +++++++++++++++++++++++
>>>>    1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>>> index bd9c2ef83314..e7fab6e400be 100644
>>>> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>>> @@ -6,6 +6,8 @@
>>>>    #include <dt-bindings/interrupt-controller/irq.h>
>>>>    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>    #include <dt-bindings/gpio/gpio.h>
>>>> +#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
>>>> +#include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>>>>    
>>>>    / {
>>>>    	cpus {
>>>> @@ -100,6 +102,30 @@ clkc_pll: clock-controller@8000 {
>>>>    				#clock-cells = <1>;
>>>>    			};
>>>>    
>>>> +			clkc_periphs: clock-controller {
>>>> +				compatible = "amlogic,s4-peripherals-clkc";
>>>> +				reg = <0x0 0x0 0x0 0x49c>;
>>>
>>> This is broken... did you check for warnings?
>> Yes, i do.
>> You can have a look at the results of my test, as follows.
>>
>> total: 0 errors, 0 warnings, 0 checks, 38 lines checked
>>
>> ../patch_clk_v5_1122/0004-arm64-dts-meson-add-S4-Soc-Peripheral-clock-controll.patch
>> has no obvious style problems and is ready for submission.
>>
> 
> This is a checkpatch output. I am talking about DTS broken. dtc should
> warn you.

Do you mean I will have wraning in compiling?
I actually compiled without warning.
ccf$ make ARCH=arm64 dtbs -j12
   DTC     arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb

> 
> Best regards,
> Krzysztof
> 
> .
