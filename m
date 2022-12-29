Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D335565898B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 06:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiL2FaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 00:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiL2FaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 00:30:18 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0B211C2A;
        Wed, 28 Dec 2022 21:30:17 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 14FD15C008D;
        Thu, 29 Dec 2022 00:30:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 29 Dec 2022 00:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672291815; x=
        1672378215; bh=LZQmgbwDcpKr9IztEIOfeJw0O3qCcf74sTNpf+LXgos=; b=Z
        Ep9fH6QEx3q3eh1kAPLaG7WOCUmUSj4djncvkt6t7TzdAA7PI7bBi+j9/Se4Yihg
        k69nhBofuttI/ccLbplcLL4fBcit6uy3bqgk8gxB9ehDDBzTa8dcUZ8wKXsR6j6G
        8z/cwlt+K5ktdSTP3b89OAB7VgINTJTRtlkjfnlg+X5wmuUNxSy9z4+tEqx3gQrZ
        1/lWcZpKKRqlb/TU1uEzsxeZs8rWbol3iPQyfJGnl3X7TfP3yhnjwoZBVY81V/Bj
        /4rtG9BwCdjtl/raYR72vtVu6zXn+IeMc3IvdmkjztajD5CpIqnGH3HWyP8JbpIp
        ZFgXYibsAZPJG01AMP7/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672291815; x=
        1672378215; bh=LZQmgbwDcpKr9IztEIOfeJw0O3qCcf74sTNpf+LXgos=; b=G
        p2GOSGJs7uMlZYlVicY5yUAHZCwX11Hf22bOCPmXdMFi0TcaNoPu9fNPAowTBy8D
        u80wu7jKSdw1UQfb874xR5VsBI0ld7Su3lGkf18PDsTlWWjufYivjg5DFJks5aek
        D1oABkLWRk6rhWiobDyHj8zQ3mUgfEUZiMNe3sSVllaD3rucOvHWYKro5qkCJ1S6
        q1ikDodA0eL0AnECP1zepahBk4oq3DwutLxPDR91FkvSBH3XDn9zoAbYOgk1/jKT
        hNtbtIW1R/Pkyo5UEVApB4BnbJoKB0FXoYB8B30y6WvMB3DXS58PwRa5qCe//6ce
        UXZudapmiWDtqHT/kaiAg==
X-ME-Sender: <xms:5iWtY_cMVrIgn_b0ptD6RQsCHqtjNIitTBYlAsqfmQe1YO1QjWJBbQ>
    <xme:5iWtY1OL86u14UakICqTOct5HDUK46n7-EAQ5Xx1IvGUmIPRVwBNm7392-VG3Bwhr
    lqJHGPDownzLtx32A>
X-ME-Received: <xmr:5iWtY4g8w2dZB2xEH8Ongq_B51OvhoDHsNXA-s67Sa2LfyMHl8spGQKVRPV3fSDVLp7oJT5g7IzMkhl-5HgcAWn9_UsgT1JI73Y8ubfEKzQKXTA5HgiGsWc2jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieefgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfdtgfelffekveelvdeuteetfefgleelhfejteeiuefhheetueef
    fefgheefveefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:5iWtYw9ixpi-6shEc5oKqsZPkG4b-uDHBtMBUdjpKpiGD8aYrMK6bg>
    <xmx:5iWtY7v-qOzGguswCIEjO8_OCIprKh-hPRmCLNuL7tRWWwGHRW5WAQ>
    <xmx:5iWtY_ETGxiljIAGRTyoMMI2hxp9XoJp9ps9Hll4f0Nzz6zFrrJrtg>
    <xmx:5yWtY0-Q8sNfFn0J1DYMstEvf-gd1HlI7iCLMv0JLHWnzDP8Nz2xWA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 00:30:14 -0500 (EST)
Message-ID: <81ec4472-1aa8-deb4-d060-0b6b340103ab@sholland.org>
Date:   Wed, 28 Dec 2022 23:30:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] clk: sunxi-ng: h3/h5: Model H3 CLK_DRAM as a fixed clock
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20221229042230.24532-1-samuel@sholland.org>
 <58b64e74466a572d472a13515dd481600dd2c63d.camel@icenowy.me>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <58b64e74466a572d472a13515dd481600dd2c63d.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/22 23:22, Icenowy Zheng wrote:
> 在 2022-12-28星期三的 22:22 -0600，Samuel Holland写道：
>> The DRAM controller clock is only allowed to change frequency while
>> the
>> DRAM chips are in self-refresh. To support this, changes to the
>> CLK_DRAM
>> mux and divider have no effect until acknowledged by the memory
>> dynamic
>> frequency scaling (MDFS) hardware inside the DRAM controller. (There
>> is
>> a SDRCLK_UPD bit in DRAM_CFG_REG which should serve a similar
>> purpose,
>> but this bit actually does nothing.)
>>
>> However, the MDFS hardware in H3 appears to be broken. Triggering a
>> frequency change using the procedure from similar SoCs (A64/H5) hangs
>> the hardware. Additionally, the vendor BSP specifically avoids using
>> the
>> MDFS hardware on H3, instead performing all DRAM PHY parameter
>> updates
>> and resets in software.
>>
>> Thus, it is effectively impossible to change the CLK_DRAM
>> mux/divider,
>> so those features should not be modeled. Add CLK_SET_RATE_PARENT so
>> frequency changes apply to PLL_DDR instead.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-
>> ng/ccu-sun8i-h3.c
>> index d3fcb983c17c..bfebe8dbbe65 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>> @@ -434,8 +434,13 @@ static SUNXI_CCU_GATE(usb_ohci2_clk,       "usb-
>> ohci2",    "osc24M",
>>  static SUNXI_CCU_GATE(usb_ohci3_clk,   "usb-ohci3",    "osc24M",
>>                       0x0cc, BIT(19), 0);
>>  
>> -static const char * const dram_parents[] = { "pll-ddr", "pll-
>> periph0-2x" };
>> -static SUNXI_CCU_M_WITH_MUX(dram_clk, "dram", dram_parents,
>> +/* H3 has broken MDFS hardware, so the mux/divider cannot be
>> changed. */
>> +static CLK_FIXED_FACTOR_HW(h3_dram_clk, "dram",
>> +                          &pll_ddr_clk.common.hw,
>> +                          1, 1, CLK_SET_RATE_PARENT |
>> CLK_IS_CRITICAL);
> 
> Should we do some sanity check on the values when probing CCU?

It is not necessary, because the register value is ignored. The register
is interpreted as if it contains 0x80000000, regardless of what you
write to it. So the parent/divider listed here will always be correct.

Regards,
Samuel

