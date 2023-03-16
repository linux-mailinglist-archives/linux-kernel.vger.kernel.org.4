Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EAE6BC77F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCPHmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCPHma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:42:30 -0400
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 00:42:29 PDT
Received: from wrqvtbkv.outbound-mail.sendgrid.net (wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5526A9E6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=s1; bh=ZWwGTHexF6h20HWK4/YZaywEOo9OIk01UmuCZ40Dnr0=;
        b=AC/8Lf21I8hh2e+1LlOiZsfEQJdSnnRFdU+qOunRG0NfscVXCnB0F4IGSuqCV1DHQUAE
        uFwcKBIB5FuyFySW5kIY182bv+W7F1b/EoMCe+1izR4m4NSyzBbS0S5+cCuRRB0Q/reI8A
        n8LLC4QCxjEklcCHCifOeMTWfKKlOCrfeOtbCm/xOzDYqBfa2K/EviXLUc8NiJ2R/NfZAV
        WfqDpP9uBRqWl36Fna/SZVx9dZLmNEXZEy8qUVAgD2qH2VEe0Y63cB09OKlrohqDq33QIe
        /xQn0tNPNGwWiM5YCcv9REagYEgyXc4gSSwj1qLLH2HBfPNflUJfWoRnzhx/aTWg==
Received: by filterdrecv-7946957d94-r22tt with SMTP id filterdrecv-7946957d94-r22tt-1-6412C72D-2B
        2023-03-16 07:37:18.137528517 +0000 UTC m=+1929878.570872038
Received: from [192.168.1.50] (unknown)
        by geopod-ismtpd-5 (SG) with ESMTP
        id cGqmaXWQSM-1ucf0-jjlAQ
        Thu, 16 Mar 2023 07:37:17.573 +0000 (UTC)
Message-ID: <71b16513-49b1-d9b3-b0b9-4c47e68563ba@kwiboo.se>
Date:   Thu, 16 Mar 2023 07:37:18 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/5] arm64: dts: rockchip: fix gmac support for NanoPi R5S
References: <20230315160228.2362-1-cnsztl@gmail.com>
 <20230315160228.2362-5-cnsztl@gmail.com>
 <CA+E=qVei7T4T0FWhdUFnr5JbCWSgFbGLcmU2OHxx54yvnNR6mw@mail.gmail.com>
 <CAOP2_TiU815F528jVGvDbcg3kSG+ykepU-ZYz7VWMO84GgcwMg@mail.gmail.com>
Content-Language: en-US
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAOP2_TiU815F528jVGvDbcg3kSG+ykepU-ZYz7VWMO84GgcwMg@mail.gmail.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h8fP5Wx2WYJ38D5dU?=
 =?us-ascii?Q?wcR+6Srt3JMfPlR6UGX3NWLrZR0xg25ke7YP8l7?=
 =?us-ascii?Q?a57FER1y1AHZBnD4zO+alVSlLkO7N5AfHJkJjWq?=
 =?us-ascii?Q?un4zVTJWoOhCVicYkSRQToOZx5MZ2SI60PgnnlJ?=
 =?us-ascii?Q?lApu5uPxEI2jVw1ZYXhVySx8TObO1bg1XCG191?=
To:     Tianling Shen <cnsztl@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tianling,
On 2023-03-16 06:34, Tianling Shen wrote:
> Hi Vasily,
> 
> On Thu, Mar 16, 2023 at 8:16 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>>
>> On Wed, Mar 15, 2023 at 9:02 AM Tianling Shen <cnsztl@gmail.com> wrote:
>>>
>>> - Changed phy-mode to rgmii.
>>>
>>> - Fixed pull type in pinctrl for gmac0.
>>>
>>> - Removed duplicate properties in mdio node.
>>>   These properties are defined in the gmac0 node already.
>>>
>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts | 7 ++-----
>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
>>> index e9adf5e66529..2a1118f15c29 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
>>> @@ -57,7 +57,7 @@
>>>         assigned-clock-rates = <0>, <125000000>;
>>>         clock_in_out = "output";
>>>         phy-handle = <&rgmii_phy0>;
>>> -       phy-mode = "rgmii-id";
>>> +       phy-mode = "rgmii";
>>>         pinctrl-names = "default";
>>>         pinctrl-0 = <&gmac0_miim
>>>                      &gmac0_tx_bus2
>>> @@ -79,9 +79,6 @@
>>>                 reg = <1>;
>>>                 pinctrl-0 = <&eth_phy0_reset_pin>;
>>>                 pinctrl-names = "default";
>>> -               reset-assert-us = <10000>;
>>> -               reset-deassert-us = <50000>;
>>> -               reset-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
>>
>> Hmm, I don't see RK_PC4 being used anywhere else. gmac0 has RK_PC5 as
> 
> Yes, it's a typo, it should be RK_RC5.
> 
>> snsp,reset-gpio. So it essentially drops reset for the PHY. Is it
>> expected?
> 
> snsp,reset-gpio defined reset already, so we don't need to set it here again.
> 
> ---
> 
> snsp,reset-gpio is the legacy binding, but I still have no idea why
> reset-gpios doesn't work,
> the dwmac driver will fail to lookup phy:
> 
> [   10.398514] rk_gmac-dwmac fe2a0000.ethernet eth0: no phy found
> [   10.399061] rk_gmac-dwmac fe2a0000.ethernet eth0: __stmmac_open:
> Cannot attach to PHY (error: -19)
> 
> Any ideas would be appreciated.

Generic ethernet phy driver is not resetting the phy in the same way
that snsp,reset-gpio does, please see top two commits at [1].

I have been meaning to send that out as an RFC but I got stuck in a
u-boot rabbit hole, and I also do not know what the correct way to fix
this would be, so I played with both device tree and code changes.
Will prioritize this and send out a RFC later today.

[1] https://github.com/Kwiboo/linux-rockchip/commits/rk3568-eth-phy-reset

Regards,
Jonas

> 
> Thanks,
> Tianling.
> 
>>
>>>         };
>>>  };
>>>
>>> @@ -115,7 +112,7 @@
>>>  &pinctrl {
>>>         gmac0 {
>>>                 eth_phy0_reset_pin: eth-phy0-reset-pin {
>>> -                       rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;
>>> +                       rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_up>;
>>>                 };
>>>         };
>>>
>>> --
>>> 2.17.1
>>>

