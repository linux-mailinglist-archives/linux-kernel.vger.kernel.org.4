Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47629633CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiKVMrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiKVMrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:47:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7773B5BD47;
        Tue, 22 Nov 2022 04:47:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C9BE1FB;
        Tue, 22 Nov 2022 04:47:12 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AED973F73B;
        Tue, 22 Nov 2022 04:47:01 -0800 (PST)
Message-ID: <916a6953-d9b4-c257-c08b-f5277ead71af@arm.com>
Date:   Tue, 22 Nov 2022 12:46:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH RFC v2 5/7] arm64: dts: imx: fix touchscreen reset GPIO
 polarity
Content-Language: en-GB
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20221103-upstream-goodix-reset-v2-0-2c38fb03a300@theobroma-systems.com>
 <20221103-upstream-goodix-reset-v2-5-2c38fb03a300@theobroma-systems.com>
 <CAOMZO5BzWsHAy7KjZe+KEiXVq-Mfpggqjk0vswuzx7nkups3gA@mail.gmail.com>
 <20221122081851.6cb762d8@erd992>
 <907b9321-14dc-dc99-80fc-e1a20ee33a1e@theobroma-systems.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <907b9321-14dc-dc99-80fc-e1a20ee33a1e@theobroma-systems.com>
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

On 2022-11-22 09:58, Quentin Schulz wrote:
> Hi David,
> 
> Thanks Fabio for the Cc.
> 
> On 11/22/22 08:18, David Jander wrote:
>> On Mon, 21 Nov 2022 15:18:32 -0300
>> Fabio Estevam <festevam@gmail.com> wrote:
>>
>>> [Adding Angus and David]
>>
>> Thanks. This was apparently necessary ;-)
>>
>>> On Mon, Nov 21, 2022 at 3:12 PM Quentin Schulz 
>>> <foss+kernel@0leil.net> wrote:
>>>>
>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>
>>>> The reset line is active low for the Goodix touchscreen controller so
>>>> let's fix the polarity in the Device Tree node.
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>> ---
>>>>   arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts         | 2 +-
>>>>   arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 2 +-
>>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts 
>>>> b/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
>>>> index 9fbbbb556c0b3..df7e5ae9698e1 100644
>>>> --- a/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
>>>> @@ -107,7 +107,7 @@ touchscreeen@5d {
>>>>                  interrupt-parent = <&gpio1>;
>>>>                  interrupts = <8 IRQ_TYPE_NONE>;
>>>>                  irq-gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
>>>> -               reset-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
>>>> +               reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
>>
>> NACK!
>>
>> The PRT8MM has an inverter in the reset line. The reason for that is 
>> that the
>> reset line needs to be inactive when the driving side is unpowered.
>> The DT was correct, this change will break it.
>>
> 
> The DT was correct. The implementation in the driver is changed (the 
> polarity is swapped) in this patch series, therefore the DT isn't 
> correct anymore, hence this patch.

I'm not sure it's quite that simple... FWIW I'm using an add-on LCD 
module with a GT9271[1] (and I won't be the only one - Raspberry Pi and 
other SBC users using DT overlays or custom-built DTBs are a whole other 
can of worms here), where GPIO_ACTIVE_LOW is correctly specified per the 
schematics, thus "wrong" for the current driver behaviour, yet it *is* 
working OK as-is. I guess that's because /RSTB ends up driven low for 
long enough between the current "deassertion" by 
gpiod_direction_output(1) and gpiod_direction_input() allowing the 
external pull-up to take it high again.

Robin.

[1] 
https://www.friendlyelec.com/index.php?route=product/product&path=81&product_id=230

> 
> See 
> https://lore.kernel.org/linux-input/20221103-upstream-goodix-reset-v2-0-2c38fb03a300@theobroma-systems.com/ for the whole patch series.
> 
> This DT patch alone is obviously incorrect, but the context around it 
> matters. I could/should have made it all into one big patch, the 
> question is then how this big tree-crossing patch would be merged into 
> Linux (if there's consensus). We're not there yet.
> 
> For some additional background on the discussion that was had in the v1:
> https://lore.kernel.org/all/267de96a-0129-a97d-9bf6-e1001b422a1a@theobroma-systems.com/
> I messed up the Cc list in the v1, apologies for the missing context in 
> the archived mails, I think one should be able to understand the 
> important bits by reading the answers in-mail. There, Dmitry, Hans and I 
> discussed the meaning of the active level of GPIOs/reset lines and I 
> expressed the reasons for such a change (which are also listed in the 
> cover letter of this patch series).
> 
> As stated in v1 cover letter, no implementation will satisfy every one. 
> We either make the DT binding implementation specific (which is what it 
> shouldn't be), or we swap the polarity in the Linux implementation and 
> thus the DT but then break DT backward compatibility.
> 
> Cheers,
> Quentin
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
