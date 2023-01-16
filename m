Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0ED466BA3D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjAPJ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjAPJ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:26:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568AA166C7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:26:48 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1pHLlG-0007IW-CX; Mon, 16 Jan 2023 10:26:38 +0100
Message-ID: <e492a90c-147c-a50b-80aa-86f47306cff0@pengutronix.de>
Date:   Mon, 16 Jan 2023 10:26:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: imx6qdl: support child mfd cells for the
 reset controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bastian Krause <bst@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230113-syscon-child-mfd-v1-0-0dd31b7de373@pengutronix.de>
 <20230113-syscon-child-mfd-v1-2-0dd31b7de373@pengutronix.de>
 <392f6e9d-b7c2-37df-2067-f7d967a20f10@linaro.org>
 <12080bf5-2cc4-e215-555e-5438ed1bd851@pengutronix.de>
 <1b5613ad-6d0d-0979-ddd0-4677ade7beb9@linaro.org>
Content-Language: en-US
In-Reply-To: <1b5613ad-6d0d-0979-ddd0-4677ade7beb9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.23 10:14, Krzysztof Kozlowski wrote:
> On 16/01/2023 09:27, Ahmad Fatoum wrote:
>> Hello Krzysztof,
>>
>> On 16.01.23 09:20, Krzysztof Kozlowski wrote:
>>> On 13/01/2023 18:32, Bastian Krause wrote:
>>>> The actual syscon-reboot-mode child node can be added by a board
>>>> device-tree or fixed up by the bootloader. For the child node to be
>>>> probed, the compatible needs to include simple-mfd. The binding now
>>>> specifies this, so have the SoC dtsi adhere to it.
>>>>
>>>> Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>>> Signed-off-by: Bastian Krause <bst@pengutronix.de>
>>>> ---
>>>>  arch/arm/boot/dts/imx6qdl.dtsi | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
>>>> index ff1e0173b39be..b16be39458aa6 100644
>>>> --- a/arch/arm/boot/dts/imx6qdl.dtsi
>>>> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
>>>> @@ -865,7 +865,8 @@ epit2: epit@20d4000 { /* EPIT2 */
>>>>  			};
>>>>  
>>>>  			src: reset-controller@20d8000 {
>>>> -				compatible = "fsl,imx6q-src", "fsl,imx51-src";
>>>> +				compatible = "fsl,imx6q-src", "fsl,imx51-src",
>>>> +					     "syscon", "simple-mfd";
>>>
>>> You need children here. Otherwise simple-mfd does not make sense. If you
>>> expect something else to add children (I don't understand why, usually
>>> reboot capability is fixed per SoC and only sometimes extended with some
>>> other means), then this "else" will also change compatible.
>>
>> It's about syscon-reboot-mode, not syscon-reboot. Such modes are board-
>> not soc-specific. 
> 
> syscon-reboot-mode is also mostly SoC specific. What exactly would
> differ on different boards? Register offsets of SoC component? Register
> values used by SoC power management unit?

The modes supported. Let's say you want a bootloader mode that drops
the board's bootloader into a fastboot gadget mode. You'd add a
syscon-reboot-mode pointing at one of the non-volatile registers and
you would define a magic value to indicate fastboot, both in the
bootloader and Linux.

In theory, the reboot mode could also talk to the bootrom[1] to change
the bootsource. This is also not board-agnostic, because it may not
make sense to have a spinor reboot mode if your board doesn't have one.

We have this scheme for STM32MP1 already and that's why I suggested
Bastian to do it likewise for i.MX as he needs this functionality:
https://lore.kernel.org/all/20201021102855.18026-1-a.fatoum@pengutronix.de/
https://elixir.bootlin.com/barebox/latest/source/arch/arm/dts/stm32mp151.dtsi#L44

Here's the barebox documentation for reboot modes btw:
https://www.barebox.org/doc/latest/user/reboot-mode.html

[1]: The i.MX bootrom samples two registers to determine boot mode
     override. The upstream syscon-reboot-mode binding supports only
     one 32-bit value and thus can be used as-is only for communicating
     with the "user" bootloader.


> Anyway, the binding is then not correct - it does not allow
> syscon-reboot-mode child. I'll comment there.
> 
> 
> Best regards,
> Krzysztof
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

