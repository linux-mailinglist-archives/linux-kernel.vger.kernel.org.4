Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EA065EEE9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjAEOit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjAEOin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:38:43 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF685933E;
        Thu,  5 Jan 2023 06:38:42 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B05A13200921;
        Thu,  5 Jan 2023 09:38:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 05 Jan 2023 09:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672929520; x=
        1673015920; bh=0tRpqumuzD4A8ScE1T7chaSBsFg3IHBj12rmSPS7UQk=; b=d
        4XVP0hfu/F6/aqVt3l7KnXcKsYzGCyPkegPh5cMb6DGQjil4x5jP/7hc8l4l/ZYr
        dmW6ZFITa0tZjR4/RMJk2iVJQ/CwzSINlKcXCmiXdin90n2cK8pnCanUi0MD24Be
        zcl0lb4i82jOmJ3e85hZigrGZoBe+t5jwX33lNdmBA+YnzNufMNu7XmeIbGhYU0f
        c/XinqxdlpWh5ln3p+G+ikkrZ5px+5fkskZ4yXSc/sCI3CLR1ZIvENpADgRXltBn
        hLzwEaWUGw/lpLASPwL6GWgdsG0X6zodJ+DX4iBGKyCE0Zc1JTid/+VkP+KA5Xrk
        9JZVID+ykBC4TgsdGk9qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672929520; x=
        1673015920; bh=0tRpqumuzD4A8ScE1T7chaSBsFg3IHBj12rmSPS7UQk=; b=Q
        mQFZigQXsGb4r6btUJAczAkvrtBumokULURZYr9BGtsdKHGAhQuRmIsGKhhnbvC+
        LjhBx/EnM5c1+Ov0HfGPAD2Mz8/6SPy0zV69+M7LDAr/n9H1dhINb5cQ5CrrL+4r
        y1b+a8UCf/oFhnf832zSQcFvRKwGLXCjq9yi0vRlNA0IYVHfojbfw9DlqVO4b0SB
        T6YI5eKHwcttLLGw6nIiT8JZ15cxtT4SgC32TXlFEU0lDlhb6BSWja79zAwMEqHe
        gt9z8iWjSka1bTuLTQ8lk5aEQOd+ak+5EAaZBlEv3z6xka+1eGCOepNq+2ySMXLc
        PIyaqHsm9Ss57ukPytCqw==
X-ME-Sender: <xms:7-C2Y5pDpDdwzZ9i1c8ziDXeBnxnpPMJEv30DfLvp6tDjYJQIrNvQw>
    <xme:7-C2Y7pAm2sM3PGdZZXvzn8WrKomMEc-zUSYuMvCvo4A9vc1OKr4HvfHTNfqNf4PC
    1pUnki5hMqTbkAxEA>
X-ME-Received: <xmr:7-C2Y2MDGjw_4EF4JjqLYeISZ9wH4Pz46PsKY12SANCHdYIiSDeZC45ei0IXcnNMzSoKN47vArjirjMi6kgFpv1Sw7iUUfh9KHGHC0GOleWUO0h1T2hrH8byEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeekgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
    tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:7-C2Y07PRTSiCseNNHcdHN-fhBrwQUshcyconVZGhlx2XWYqiFxH8Q>
    <xmx:7-C2Y44cJfaJdZEI7LHg5qIGEmGoOBe5DWlejR7aihYkkRlkrfS9GA>
    <xmx:7-C2Y8hYQx225tPwiImxWhzHqlmVmoFMQ15_h04c-vsnwMmjY9xH-w>
    <xmx:8OC2Y1O802ea8_p3G5yF6B-Pb7YVl7CFQQl1QE3UHG0IC2NxFoQd_g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jan 2023 09:38:37 -0500 (EST)
Message-ID: <3b6ec431-70ac-cf68-6f46-9dc0affb1e68@sholland.org>
Date:   Thu, 5 Jan 2023 08:38:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 4/4] riscv: dts: allwinner: d1: Add video engine node
Content-Language: en-US
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev
References: <20221231164628.19688-1-samuel@sholland.org>
 <20221231164628.19688-5-samuel@sholland.org> <Y7aiZdjI8L5h1Ca3@aptenodytes>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <Y7aiZdjI8L5h1Ca3@aptenodytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 1/5/23 04:11, Paul Kocialkowski wrote:
> On Sat 31 Dec 22, 10:46, Samuel Holland wrote:
>> D1 contains a video engine which is supported by the Cedrus driver.
> 
> Does it work "outside the box" without power domain management?
> If not, it might be a bit confusing to add the node at this point.

Yes, it does. All of the power domains are enabled by default. However,
if the PPU series is merged first, I will respin this to include the
power-domains property from the beginning.

Regards,
Samuel

>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
>> index dff363a3c934..4bd374279155 100644
>> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
>> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
>> @@ -34,6 +34,17 @@ soc {
>>  		#address-cells = <1>;
>>  		#size-cells = <1>;
>>  
>> +		ve: video-codec@1c0e000 {
>> +			compatible = "allwinner,sun20i-d1-video-engine";
>> +			reg = <0x1c0e000 0x2000>;
>> +			interrupts = <SOC_PERIPHERAL_IRQ(66) IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_VE>,
>> +				 <&ccu CLK_VE>,
>> +				 <&ccu CLK_MBUS_VE>;
>> +			clock-names = "ahb", "mod", "ram";
>> +			resets = <&ccu RST_BUS_VE>;
>> +		};
>> +
>>  		pio: pinctrl@2000000 {
>>  			compatible = "allwinner,sun20i-d1-pinctrl";
>>  			reg = <0x2000000 0x800>;
>> -- 
>> 2.37.4
>>
> 

