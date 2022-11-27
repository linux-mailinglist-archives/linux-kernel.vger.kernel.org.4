Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF525639C96
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 20:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiK0TWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 14:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiK0TWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 14:22:47 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884A16250;
        Sun, 27 Nov 2022 11:22:45 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 32F7732000E5;
        Sun, 27 Nov 2022 14:22:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 27 Nov 2022 14:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669576959; x=
        1669663359; bh=0jMUEpo9JimXNn+v7TVsbXYdn84QOpQaKl0V3SQQP3g=; b=g
        T/oVnyecJr+stbTekHEMS8yHJnIVB6uhKhCFrzjI1Z7IxtoJK4aHLBTF1BJfr0w8
        wQuxaZHB8HkcGIXm/RBlSqcHulG2Ss7Q7m5XH6xwrX0Y/Wx7ylFDIiBvfPWcNx9p
        Vf1Fbpcap5FFkt3i7h/h50I2jzjdvxU27J2rL42MqGmp/QwTEXS2a685kC75INPw
        Ar3j+FZST/3FSQj9dQ+ZxQaKbVhk7kcbfdRWUR4ewzMW47umEsm5mlK1pPEN4dhM
        TB5BEiRqvXcmUejEJib0Qk+TXrB8Qkq/9Ue5lkEY4En9cX5Qzc+Uqx1LGLB2OPCZ
        771eACuAifm3fp2mJyw1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669576959; x=
        1669663359; bh=0jMUEpo9JimXNn+v7TVsbXYdn84QOpQaKl0V3SQQP3g=; b=B
        QZcfRCS9NujwMM5Ljbnc58fkuA4sxndQQQU1zbYiclEI2pzyvqwCHjMUTs5E0G+7
        yddRBYnp07SxOJbj2hOfz/KP59lPxVcdw6rwYYxCFvy659+LNn80gQe0COyL+5Um
        R7Aa2dr7NK70CZXmm2/IcabkDpvwcu1nEMDYOkVyDioHL4XB2g2HSHfdKILlyjCm
        H3fhDRiY9Ll4Tc6OIHqnrYkGbcmLUZGWCn4H6TemYZrfzkJJ5nDRGs0FL6/qwlha
        qu/HOvBBtZTfPqogbLIaXovGvr7IWyPFaIl/CQB+flCxtLDNJ1NpVvxvkEA9VgJg
        oMAX3NawjXSf1G8C6jdVw==
X-ME-Sender: <xms:_riDY2SHbQBHTp8qWGyur0ZszfyQzUu30yoJxrmrNy_HdPSVcKNR3Q>
    <xme:_riDY7yZbGZtSU2mcoqvJIxuVnYy9i0aCNiy77A0b_qKls84kMI-WeS41j2L2OglT
    ozairSgtJuBsa2aZQ>
X-ME-Received: <xmr:_riDYz21DOfysA--wT_og_TGW7tt8PmaFhmkxPOM_ryap5b6xSkg42NPPU4isE9E9sPB3V_O8BVaDgMonjt2D4wpUzg_vHa7kpclZMhMk784FbXC8Eahqjql5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedtgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejgfffhfdujeeftdeuudeguedttefgieetffffheejuefguedv
    heejteeftdfftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:_riDYyBlXQpFUjVq9C0zcJpdy92w-BDPOtna2_U7a878evR4G77clQ>
    <xmx:_riDY_iSYojtZbwNNQVLxB5ldKROCz5fVibMAvwRuRFgSDjtx-agog>
    <xmx:_riDY-r_ia9uEzs7PkjzrDWq1vjpxaHlCQwKby_j4qBw73dm0DFOBA>
    <xmx:_7iDY6QjTpGfHZ0SUVpa7BRmIZh51iZNF-t71_KHSUjH6fQTHZrhHg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Nov 2022 14:22:36 -0500 (EST)
Message-ID: <f277a900-422d-cf14-af8c-c173916aaa0b@sholland.org>
Date:   Sun, 27 Nov 2022 13:22:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
References: <20221125234656.47306-1-samuel@sholland.org>
 <20221125234656.47306-5-samuel@sholland.org>
 <20221127174107.66e6630f@slackpad.lan>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 04/12] riscv: dts: allwinner: Add the D1/D1s SoC
 devicetree
In-Reply-To: <20221127174107.66e6630f@slackpad.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/22 11:41, Andre Przywara wrote:
> On Fri, 25 Nov 2022 17:46:48 -0600
> Samuel Holland <samuel@sholland.org> wrote:
> 
>> D1 (aka D1-H), D1s (aka F133), R528, and T113 are a family of SoCs based
>> on a single die, or at a pair of dies derived from the same design.
>>
>> D1 and D1s contain a single T-HEAD Xuantie C906 CPU, whereas R528 and
>> T113 contain a pair of Cortex-A7's. D1 and R528 are the full version of
>> the chip with a BGA package, whereas D1s and T113 are low-pin-count QFP
>> variants.
>>
>> Because the original design supported both ARM and RISC-V CPUs, some
>> peripherals are duplicated. In addition, all variants except D1s contain
>> a HiFi 4 DSP with its own set of peripherals.
>>
>> The devicetrees are organized to minimize duplication:
>>  - Common perhiperals are described in sunxi-d1s-t113.dtsi
> 
> So I compared all the reg and interrupts properties against the T113
> manual, they match, as far as they are described there. The undocumented
> rest matches what we already have in other SoCs.
> 
> I noticed two things, though, mentioned inline below:
> 
> [...]
>
>> +		display_clocks: clock-controller@5000000 {
> 
> The clocks and the two mixers are not children of a bus node anymore,
> IIUC correctly this was to manage the SRAM control. Is that now handled
> differently, or does the D1 generation not require this anymore?

The D1 family uses the DSP SRAM for extra space during early boot --
this applies even to D1s, where the DSP is fused off. Since the DE SRAM
is not used for this purpose, the "SRAM C" aka "boot mode" bit in the
SRAM controller is cleared by default, thus mapping the DE SRAM to the
peripheral. So the DE works without touching the syscon registers.

However, if I set the SRAM C bit, the DE stops working. So having the
bus node would make some sense. But I do not know any address for the
SRAM -- there is no "boot" address, and the "peripheral" address may not
even be accessible to the CPU. So it is not possible to represent this
with a mmio-sram node like the binding requires.

So I suppose we should either change the binding to allow a child
allwinner,sun50i-a64-sram-c node with no address (the driver should work
fine with this); or leave out the bus, and people who go poking around
in the syscon registers get to keep the pieces. :)

>> +			compatible = "allwinner,sun20i-d1-de2-clk",
>> +				     "allwinner,sun50i-h5-de2-clk";
>> +			reg = <0x5000000 0x10000>;
>> +			clocks = <&ccu CLK_BUS_DE>, <&ccu CLK_DE>;
>> +			clock-names = "bus", "mod";
>> +			resets = <&ccu RST_BUS_DE>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +		};
>> +
>> +		mixer0: mixer@5100000 {
>> +			compatible = "allwinner,sun20i-d1-de2-mixer-0";
>> +			reg = <0x5100000 0x100000>;
>> +			clocks = <&display_clocks CLK_BUS_MIXER0>,
>> +				 <&display_clocks CLK_MIXER0>;
>> +			clock-names = "bus", "mod";
>> +			resets = <&display_clocks RST_MIXER0>;
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				mixer0_out: port@1 {
>> +					reg = <1>;
>> +
>> +					mixer0_out_tcon_top_mixer0: endpoint {
>> +						remote-endpoint = <&tcon_top_mixer0_in_mixer0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		mixer1: mixer@5200000 {
>> +			compatible = "allwinner,sun20i-d1-de2-mixer-1";
>> +			reg = <0x5200000 0x100000>;
>> +			clocks = <&display_clocks CLK_BUS_MIXER1>,
>> +				 <&display_clocks CLK_MIXER1>;
>> +			clock-names = "bus", "mod";
>> +			resets = <&display_clocks RST_MIXER1>;
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				mixer1_out: port@1 {
>> +					reg = <1>;
>> +
>> +					mixer1_out_tcon_top_mixer1: endpoint {
>> +						remote-endpoint = <&tcon_top_mixer1_in_mixer1>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		dsi: dsi@5450000 {
>> +			compatible = "allwinner,sun20i-d1-mipi-dsi",
>> +				     "allwinner,sun50i-a100-mipi-dsi";
>> +			reg = <0x5450000 0x1000>;
>> +			interrupts = <SOC_PERIPHERAL_IRQ(92) IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_MIPI_DSI>,
>> +				 <&tcon_top CLK_TCON_TOP_DSI>;
>> +			clock-names = "bus", "mod";
>> +			resets = <&ccu RST_BUS_MIPI_DSI>;
>> +			phys = <&dphy>;
>> +			phy-names = "dphy";
>> +			status = "disabled";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port {
>> +				dsi_in_tcon_lcd0: endpoint {
>> +					remote-endpoint = <&tcon_lcd0_out_dsi>;
>> +				};
>> +			};
>> +		};
>> +
>> +		dphy: phy@5451000 {
>> +			compatible = "allwinner,sun20i-d1-mipi-dphy",
>> +				     "allwinner,sun50i-a100-mipi-dphy";
>> +			reg = <0x5451000 0x1000>;
>> +			interrupts = <SOC_PERIPHERAL_IRQ(92) IRQ_TYPE_LEVEL_HIGH>;
> 
> This is the same interrupt number as for the DSI controller above. Is
> that correct, and can the drivers handle that?

Yes, it is correct. Currently, neither driver uses the interrupt, so we
will just need to keep the sharing in mind if/when that happens.

Regards,
Samuel

