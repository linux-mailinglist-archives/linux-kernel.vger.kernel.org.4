Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854756498FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 07:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiLLGcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 01:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiLLGcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 01:32:47 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFECE14;
        Sun, 11 Dec 2022 22:32:43 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7553E320077A;
        Mon, 12 Dec 2022 01:32:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 12 Dec 2022 01:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1670826757; x=
        1670913157; bh=Enl4ta4QMhU7nuukiZ1MRpoIAb2RdvDJEmhGxOJuA3M=; b=K
        0WFYUnX+7h4+lt+re56XKM8LEn6HJm8S1F5Ybpgn/i/TCDF8SniT2qdkJ+nZpdVq
        hlfPCPpnZCkiqOdav5gHhSmNVhlhQIyNABLBCqXDlLD24oilhZdqKw7CeYsD8z0G
        yriajJyEzJCRm6Fw0BD7+Ac0sPNymKo1rmqPoyU57UHtHcET4QPz7rQcOV1d26HW
        IbFa/7/plt2SOO/0+QPumrfbCdPWPTzKrGsNFQWS+IkQN0XKbCHuqSeheEFF29WY
        ojD4PRGZhAVCxkGEq4+ICGGz1oL39jbXwbNi21gs3a9wAf82aJ09KVi5y5dEHVpJ
        llkYlchdIFzAm9zktY7jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1670826757; x=
        1670913157; bh=Enl4ta4QMhU7nuukiZ1MRpoIAb2RdvDJEmhGxOJuA3M=; b=o
        t9ktCqVM1aXeOGcSM+0umcFKo4OigBkEe66ULHqllyj0Wpdo8IjU4xDEXG6r4pPv
        VzPczlLWx79s9DmYjP5WaK+6F93Q6oC8+4isl6zIUNNZYLoQfhihFHgWdyL78Nah
        iL1Tn0SESFkQB/d0XcesF5mJB5y0Q7yrGGUpslI1Cf8K5umShA+C1b/2FoEl6WZW
        pWujbvYlwGU51BBqEJTVQ4Ngcu5n/BWnXOX8viQNSRs0IIUKvsiDCEk5u13czWbb
        IrZsQkm64SCPeSV9NWstfZd4td+r5e7fCFqVN72y2h7xrK75IcJUy+ZBE7K5nuCW
        /IT1Ho5o9FJAmZfZM1Bew==
X-ME-Sender: <xms:A8uWY7HGy3f7CvRSNCcbI-c53HZ5k_da-gmFD-55K-3hm8fKKqgZEg>
    <xme:A8uWY4W7aAcenEWlAOzgcoKxCjpb5KQZ1bcOl3B-cMVFSJXoZ_6OR8rbgXwpI190D
    XZRyuh2yYdJkscZbg>
X-ME-Received: <xmr:A8uWY9KtDWyvkSH5GC39cnLHU3xRIYp2XZYlwPBT1ka4CsPZPZKVBnsmJPh9WZX8ZJzDdoh7EX1dAWvGD6sR2fkCKbyAsG51xhDulHOqfgu3KKVy4jXTnFy2dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjeeftddtvdegvdevkedvvdejledvieeuffekvedtiefggfekudeh
    vedukeeluddvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:A8uWY5Eaeeox-0bUJxq6HPFW4yaMaLCaPL90LK7aJYJyto3T7rZAFQ>
    <xmx:A8uWYxVaXhuHY_ls-Lrv7Uiol6vlhga0--IM7RRYK3YT6wcMshK-tw>
    <xmx:A8uWY0PVXS4lLlpmI1OP2VwXpFpvC0pYpnfSgz8XahdH4jSyRsd48Q>
    <xmx:BcuWY3oAc_Dg7AzNFmVFUldWNKbHOBtRyKeTmTDRUztSly6dVeLJhw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Dec 2022 01:32:32 -0500 (EST)
Message-ID: <48329048-880d-02d6-0384-abdfa4c61c46@sholland.org>
Date:   Mon, 12 Dec 2022 00:32:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
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
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 6/9] arm64: dts: allwinner: fix touchscreen reset GPIO
 polarity
In-Reply-To: <cdfb3f44-4400-1386-42cb-0fb7b30e45db@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On 12/6/22 05:11, Quentin Schulz wrote:
> On 12/6/22 01:26, Samuel Holland wrote:
>> On 12/5/22 07:40, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>
>>> The reset line is active low for the Goodix touchscreen controller so
>>> let's fix the polarity in the Device Tree node.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>> ---
>>>   arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts       |
>>> 2 +-
>>>   arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts |
>>> 2 +-
>>>   arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi          |
>>> 2 +-
>>>   arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts             |
>>> 2 +-
>>>   4 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git
>>> a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>>> b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>>> index 8233582f62881..5fd581037d987 100644
>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
>>> @@ -122,7 +122,7 @@ touchscreen@5d {
>>>           interrupt-parent = <&pio>;
>>>           interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
>>>           irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;    /* CTP-INT: PH4 */
>>> -        reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;    /* CTP-RST:
>>> PH8 */
>>> +        reset-gpios = <&pio 7 8 GPIO_ACTIVE_LOW>;    /* CTP-RST: PH8 */
>>
>> You are changing the DT binding here, in a way that breaks backward
>> compatibility with existing devicetrees. NACK.
>>
> 
> Yes.
> 
> Some boards will get their DT binding broken, there's no way around it
> sadly.
> 
> We know already that the PRT8MM DT binding was written with a different
> understanding than for other boards. There are some board schematics I
> don't have access to so maybe the same applies to those.
> 
> A reminder that even if you got your polarity wrong, it could still work
> in some cases (timings right today but nothing guaranteed it'll stay
> this way forever).
> 
> with the current driver, what I assume we should get for an "incorrect"
> polarity (with GPIO_ACTIVE_LOW) is:
>             ___________________
> INT _______|                   |___________
> 
>     ____________           __________________
> RST             |_________|
> 
>    ^
>    L__ pull-up on RST so high by default
>         ^
>         L___ gpiod_direction_output(0) (deassert GPIO active-low, so high)
>            ^
>            L____ goodix_irq_direction_output
>                 ^
>                 L___ gpiod_direction_output(1) (assert GPIO active-low,
> so low)
>                           ^
>                           L____ gpiod_direction_input() (floating,
> pull-up on RST so high)
> 
> This works because of the pull-up on RST and that what matters is that
> the INT lane is configured 100µs before a rising edge on RST line (for
> at least 5ms). However, the init sequence is not properly followed and
> might get broken in the future since it is not something that we
> explicitly support.

We as platform DT/binding maintainers explicitly support compatibility
with existing devicetrees, whether those devicetrees are "correct" or
not. If a new version of Linux does not work with an old DT, that is a
regression in Linux.

> With the proposed patch:
>             ___________________
> INT _______|                   |___________
> 
>     ____         __________________
> RST     |_______|
> 
>    ^
>    L__ pull-up on RST so high by default
>         ^
>         L___ gpiod_direction_output(1) (assert GPIO active-low, so low)
>            ^
>            L____ goodix_irq_direction_output
>                 ^
>                 L___ gpiod_direction_output(1) (deassert GPIO
> active-low, so high)
>                           ^
>                           L____ gpiod_direction_input() (floating,
> pull-up on RST so high)
> 
> This should work too and does not rely on some side effects/timings and
> should be future-proof.

Thanks for the explanation. So the reset sequence happens to work with
either GPIO polarity because the pin is set to high impedance before and
afterward. I tested this patch (no driver changes) on a PinePhone, and
indeed Linux's touchscreen driver still loads and works fine.

> The other option would be to only fix known "broken" boards (e.g.
> PRT8MM, maybe others) and specify in the DT binding documentation that
> the reset-gpios polarity is "inverted" (that is, the reset is asserted
> when the reset-gpios as specified in the DT is deasserted). This makes
> the DT binding documentation **implementation specific** which is
> everything the DT binding is trying to avoid.

Not really, the binding just encodes existing practice. New boards must
invert the polarity relative to the datasheet because existing boards
did the same thing previously. The board devicetrees drive the binding;
Linux is only a consumer of it. So the binding is still not Linux-specific.

In fact, here you rely on the "implementation specific" behavior of the
Linux driver to claim that this a non-breaking change. If some other DT
consumer has a driver which leaves the reset line as an output, this
patch would be a breaking change for them. And it turns out that such a
driver exists:

https://github.com/zephyrproject-rtos/zephyr/commit/17089a2e14acb0428502
https://github.com/zephyrproject-rtos/zephyr/pull/48927

> Something needs to be done, and no solution will make everyone happy.

I am happy as long as the change does not create any DT compatibility
issues, either between OSes or between OS versions. You demonstrated
that Linux was fine, and the BSDs don't have appear to have a driver for
this hardware. So from an Allwinner platform perspective, I am fine with
this patch.

But you should ensure the Zephyr folks are okay with making the same
change to their driver and devicetrees, since it is a breaking change
for them.

Regards,
Samuel

