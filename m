Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1DD5EF94F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiI2Pms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiI2PmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:42:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BDED110EF1;
        Thu, 29 Sep 2022 08:41:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DB6615BF;
        Thu, 29 Sep 2022 08:41:36 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB29C3F792;
        Thu, 29 Sep 2022 08:41:27 -0700 (PDT)
Message-ID: <946d8ac2-6ff2-093a-ad3c-aa755e00d1dd@arm.com>
Date:   Thu, 29 Sep 2022 16:41:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 03/11] dt-bindings: pwm: rockchip: add
 rockchip,rk3128-pwm
Content-Language: en-GB
To:     Johan Jonker <jbx6244@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, u.kleine-koenig@pengutronix.de,
        linux-rockchip@lists.infradead.org, philipp.tomsich@vrull.eu,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, kever.yang@rock-chips.com,
        zhangqing@rock-chips.com, linux-kernel@vger.kernel.org,
        heiko@sntech.de
References: <20220909212543.17428-1-jbx6244@gmail.com>
 <f5dd0ee4-d97e-d878-ffde-c06e9b233e38@gmail.com>
 <1662821635.180247.34700.nullmailer@robh.at.kernel.org>
 <1c13181b-8421-69d8-21ee-9742dd5f55dd@gmail.com>
 <20220912162159.GA1397560-robh@kernel.org>
 <37fd8d4b-3a66-bc51-c2dc-76c9e756fed8@gmail.com> <YzQ3He2wyD2bgxz1@orome>
 <94d829a6-d8c2-2106-2d7d-91a8cd3875ae@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <94d829a6-d8c2-2106-2d7d-91a8cd3875ae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-29 11:26, Johan Jonker wrote:
> 
> 
> On 9/28/22 13:59, Thierry Reding wrote:
>> On Tue, Sep 13, 2022 at 04:38:32PM +0200, Johan Jonker wrote:
>>>
>>>
>>> On 9/12/22 18:21, Rob Herring wrote:
>>>> On Sat, Sep 10, 2022 at 09:48:04PM +0200, Johan Jonker wrote:
>>>>> Reduced CC.
>>>>>
>>>>> Hi Rob,
>>>>>
>>>>
>>>> Seemed like a simple enough warning to fix...
>>>
>>> Some examples for comment.
>>> Let us know what would be the better solution?
>>>
>>> ===========================================================================
>>>
>>> option1:
>>>
>>> 	combpwm0: combpwm0 {
>>> 		compatible = "rockchip,rv1108-combpwm";
>>> 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>>> 		#address-cells = <2>;
>>> 		#size-cells = <2>;
>>>
>>> 		pwm0: pwm@20040000 {
>>> 			compatible = "rockchip,rv1108-pwm";
>>> 			reg = <0x20040000 0x10>;
>>> 		};
>>>
>>> 		pwm1: pwm@20040010 {
>>> 			compatible = "rockchip,rv1108-pwm";
>>> 			reg = <0x20040010 0x10>;
>>> 		};
>>>
>>> 		pwm2: pwm@20040020 {
>>> 			compatible = "rockchip,rv1108-pwm";
>>> 			reg = <0x20040020 0x10>;
>>> 		};
>>>
>>> 		pwm3: pwm@20040030 {
>>> 			compatible = "rockchip,rv1108-pwm";
>>> 			reg = <0x20040030 0x10>;
>>> 		};
>>> 	};
>>>
>>> PRO:
>>> - Existing driver might still work.
>>> CON:
>>> - New compatible needed to service the combined interrupts.
>>> - Driver change needed.
>>>
>>> ===========================================================================
>>> option 2:
>>>
>>> 	combpwm0: pwm@10280000 {
>>> 		compatible = "rockchip,rv1108-pwm";
>>> 		reg = <0x10280000 0x40>;
>>> 		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
>>> 		#address-cells = <1>;
>>> 		#size-cells = <0>;
>>>
>>> 		pwm4: pwm-4@0 {
>>> 			reg = <0x0>;
>>> 		};
>>>
>>> 		pwm5: pwm-5@10 {
>>> 			reg = <0x10>;
>>> 		};
>>>
>>> 		pwm6: pwm-6@20 {
>>> 			reg = <0x20>;
>>> 		};
>>>
>>> 		pwm7: pwm-7@30 {
>>> 			reg = <0x30>;
>>> 		};
>>> 	};
>>>
>>> CON:
>>> - Driver change needed.
>>> - Not compatible with current drivers.
>>>
>>> ===========================================================================
>>>
>>> Current situation:
>>>
>>> 	pwm0: pwm@20040000 {
>>> 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
>>> 		reg = <0x20040000 0x10>;
>>> 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>>> 	};
>>>
>>> 	pwm1: pwm@20040010 {
>>> 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
>>> 		reg = <0x20040010 0x10>;
>>> 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>>> 	};
>>>
>>> 	pwm2: pwm@20040020 {
>>> 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
>>> 		reg = <0x20040020 0x10>;
>>> 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>>> 	};
>>>
>>> 	pwm3: pwm@20040030 {
>>> 		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
>>> 		reg = <0x20040030 0x10>;
>>> 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>>> 	};
>>>
>>> CON:
>>> - The property "interrupts 39" can only be claimed ones by one probe function at the time.
>>> - Has a fall-back string for rk3288, but unknown identical behavior for interrupts ???
>>
> 
>> To be honest, all three descriptions look wrong to me. From the above it
>> looks like this is simply one PWM controller with four channels, so it
>> should really be described as such, i.e.:
>>
>> 	pwm@20040030 {
>> 		compatible = "rockchip,rv1108-pwm";
>> 		reg = <0x20040030 0x40>;
>> 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>> 	};
>>
> 
> Each PWM channel has it's own pinctrl.
> Not all channel pins are always in use for PWM exclusively.
> Your proposal would not allow pins to be used for other functions.

Why would you think that? It would just mean moving the pinctrl 
selection down to the board level like for GPIOs - we manage just fine 
with a single DT node per GPIO bank, and semantically PWMs have no 
reason do be different. In fact on newer SoCs some PWM channels can be 
muxed to multiple pins, so pinctrl really has to be at the board level 
already in those casesa.

The TRMs seem pretty clear that the "new" PWM block from RK3288 onwards 
is a single module with 4 channels, not 4 independent controllers, so it 
seems to have been an unfortunate mistake not to create a new binding 
for it at that point. It would be a little fiddly, but far from 
impossible, to make the driver support both the existing binding and a 
new one (and I don't see how we could use the interrupt on newer SoCs 
*without* a binding change, given that the interrupt status register is 
outside any channel's current "reg"), but an old kernel with a new DT 
would be more problematic. If we kept the existing compatibles then an 
old driver would always use channel 0 regardless of what the consumer 
requested; using new compatibles as well means the old kernel loses PWM 
functionality entirely, which is arguably "safe", but I'm not sure if 
it's really better or worse :/

Robin.

> More ideas with this interrupt? Please advise.
> 
> ===
> 
> The SoCs PWM are configurable to operate in continuous mode (default mainline) or one-shot mode or capture mode.
> Is there any good example for one-shot mode interrupt use?
> 
> 
>> Looking through existing Rockchip SoC DTSI files, though, it looks like
>> this has been done the wrong way since the beginning, so not sure if you
>> still want to fix it up.
>>
>> This whole problem of dealing with a shared interrupt wouldn't be a
>> problem if this was described properly.
>>
>> Thierry
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
