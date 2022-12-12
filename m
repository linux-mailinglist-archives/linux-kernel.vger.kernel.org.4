Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D23E64A038
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiLLNWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiLLNVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:21:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21D62B7D6;
        Mon, 12 Dec 2022 05:21:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35A961FB;
        Mon, 12 Dec 2022 05:22:29 -0800 (PST)
Received: from [10.57.88.235] (unknown [10.57.88.235])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C6EA3F71E;
        Mon, 12 Dec 2022 05:21:43 -0800 (PST)
Message-ID: <cdb13df6-5180-47b3-d61c-c2eb9aa50e31@arm.com>
Date:   Mon, 12 Dec 2022 13:21:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 6/9] arm64: dts: allwinner: fix touchscreen reset GPIO
 polarity
To:     Samuel Holland <samuel@sholland.org>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Angus Ainslie <angus@akkea.ca>,
        Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Andy Gross <agross@kernel.org>,
        Aleksei Mamlin <mamlinav@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        David Jander <david@protonic.nl>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221103-upstream-goodix-reset-v3-0-0975809eb183@theobroma-systems.com>
 <20221103-upstream-goodix-reset-v3-6-0975809eb183@theobroma-systems.com>
 <a0c767d5-eb55-3479-c4bc-1029809027f5@sholland.org>
 <cdfb3f44-4400-1386-42cb-0fb7b30e45db@theobroma-systems.com>
 <48329048-880d-02d6-0384-abdfa4c61c46@sholland.org>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <48329048-880d-02d6-0384-abdfa4c61c46@sholland.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-12 06:32, Samuel Holland wrote:
> Hi Quentin,
> 
> On 12/6/22 05:11, Quentin Schulz wrote:
>> On 12/6/22 01:26, Samuel Holland wrote:
>>> On 12/5/22 07:40, Quentin Schulz wrote:
>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>
>>>> The reset line is active low for the Goodix touchscreen controller so
>>>> let's fix the polarity in the Device Tree node.
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>> ---
>>>>    arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts       |
>>>> 2 +-
>>>>    arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts |
>>>> 2 +-
>>>>    arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi          |
>>>> 2 +-
>>>>    arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts             |
>>>> 2 +-
>>>>    4 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git
>>>> a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>>>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>>>> index 8233582f62881..5fd581037d987 100644
>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>>>> @@ -122,7 +122,7 @@ touchscreen@5d {
>>>>            interrupt-parent = <&pio>;
>>>>            interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
>>>>            irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;    /* CTP-INT: PH4 */
>>>> -        reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;    /* CTP-RST:
>>>> PH8 */
>>>> +        reset-gpios = <&pio 7 8 GPIO_ACTIVE_LOW>;    /* CTP-RST: PH8 */
>>>
>>> You are changing the DT binding here, in a way that breaks backward
>>> compatibility with existing devicetrees. NACK.
>>>
>>
>> Yes.
>>
>> Some boards will get their DT binding broken, there's no way around it
>> sadly.
>>
>> We know already that the PRT8MM DT binding was written with a different
>> understanding than for other boards. There are some board schematics I
>> don't have access to so maybe the same applies to those.
>>
>> A reminder that even if you got your polarity wrong, it could still work
>> in some cases (timings right today but nothing guaranteed it'll stay
>> this way forever).
>>
>> with the current driver, what I assume we should get for an "incorrect"
>> polarity (with GPIO_ACTIVE_LOW) is:
>>              ___________________
>> INT _______|                   |___________
>>
>>      ____________           __________________
>> RST             |_________|
>>
>>     ^
>>     L__ pull-up on RST so high by default
>>          ^
>>          L___ gpiod_direction_output(0) (deassert GPIO active-low, so high)
>>             ^
>>             L____ goodix_irq_direction_output
>>                  ^
>>                  L___ gpiod_direction_output(1) (assert GPIO active-low,
>> so low)
>>                            ^
>>                            L____ gpiod_direction_input() (floating,
>> pull-up on RST so high)
>>
>> This works because of the pull-up on RST and that what matters is that
>> the INT lane is configured 100µs before a rising edge on RST line (for
>> at least 5ms). However, the init sequence is not properly followed and
>> might get broken in the future since it is not something that we
>> explicitly support.
> 
> We as platform DT/binding maintainers explicitly support compatibility
> with existing devicetrees, whether those devicetrees are "correct" or
> not. If a new version of Linux does not work with an old DT, that is a
> regression in Linux.
> 
>> With the proposed patch:
>>              ___________________
>> INT _______|                   |___________
>>
>>      ____         __________________
>> RST     |_______|
>>
>>     ^
>>     L__ pull-up on RST so high by default
>>          ^
>>          L___ gpiod_direction_output(1) (assert GPIO active-low, so low)
>>             ^
>>             L____ goodix_irq_direction_output
>>                  ^
>>                  L___ gpiod_direction_output(1) (deassert GPIO
>> active-low, so high)
>>                            ^
>>                            L____ gpiod_direction_input() (floating,
>> pull-up on RST so high)
>>
>> This should work too and does not rely on some side effects/timings and
>> should be future-proof.
> 
> Thanks for the explanation. So the reset sequence happens to work with
> either GPIO polarity because the pin is set to high impedance before and
> afterward. I tested this patch (no driver changes) on a PinePhone, and
> indeed Linux's touchscreen driver still loads and works fine.
> 
>> The other option would be to only fix known "broken" boards (e.g.
>> PRT8MM, maybe others) and specify in the DT binding documentation that
>> the reset-gpios polarity is "inverted" (that is, the reset is asserted
>> when the reset-gpios as specified in the DT is deasserted). This makes
>> the DT binding documentation **implementation specific** which is
>> everything the DT binding is trying to avoid.
> 
> Not really, the binding just encodes existing practice. New boards must
> invert the polarity relative to the datasheet because existing boards
> did the same thing previously. The board devicetrees drive the binding;
> Linux is only a consumer of it. So the binding is still not Linux-specific.

No, the whole point of a binding is to define a contract between 
producers and consumers. It is a specification, not a consensus.

(I see up-thread there was some use of "binding" to refer to DTS 
producers, so maybe there's a bit of confusion in play here)

The goodix.yaml binding does not state that any polarity flag in the 
"reset-gpios" specifier should be ignored, therefore consumers are 
objectively wrong to ignore it, and producers are objectively wrong to 
specify a polarity that does not represent the underlying hardware.

> In fact, here you rely on the "implementation specific" behavior of the
> Linux driver to claim that this a non-breaking change. If some other DT
> consumer has a driver which leaves the reset line as an output, this
> patch would be a breaking change for them. And it turns out that such a
> driver exists:

As discussed previously, there are already established DTBs in use that 
*correctly* specify both active-low and active-high (hardware-inverted) 
polarities here, so that would mean Zephyr is already broken in general. 
However, since it looks like they've chosen to maintain their own 
project-specific bindings and DTS files, if they do also have the 
equivalent bug then it would seem to be entirely in their own hands.

Thanks,
Robin.

> https://github.com/zephyrproject-rtos/zephyr/commit/17089a2e14acb0428502
> https://github.com/zephyrproject-rtos/zephyr/pull/48927
> 
>> Something needs to be done, and no solution will make everyone happy.
> 
> I am happy as long as the change does not create any DT compatibility
> issues, either between OSes or between OS versions. You demonstrated
> that Linux was fine, and the BSDs don't have appear to have a driver for
> this hardware. So from an Allwinner platform perspective, I am fine with
> this patch.
> 
> But you should ensure the Zephyr folks are okay with making the same
> change to their driver and devicetrees, since it is a breaking change
> for them.
> 
> Regards,
> Samuel
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
