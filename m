Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC055BA5A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 06:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIPEQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 00:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIPEQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 00:16:51 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE339F747;
        Thu, 15 Sep 2022 21:16:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B3D845C0082;
        Fri, 16 Sep 2022 00:16:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 16 Sep 2022 00:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1663301809; x=
        1663388209; bh=hjMcp89C2jkXIYsBxRnx/xoB4u1WmalrxLV/Xe3flCk=; b=m
        DBiIIiCyDyFeVeQm3ja9dS8EX6NCDF9tzHhW8DHE09A7U3kAckcnhqzJicrEhrrt
        8vv7t7QuSRe/U1OTpQWipnepf/O9GA+6tNblM8XGeQaxyU0eZa+PZZqvmTVQsxeL
        k2kVgGikUoWx10lU1UOmd4wrUeQXGGuN0Rd9wjmT+G30KzjRKlBDP3XEaLr/2zCb
        tho4/T47Y7J2TtT1SB/Vy8yAzd6zIHeSBVBRzL108Gg9r2kUvmC3sI/pZWt+Sztc
        /lTvzc5SJuVYhnXjnqsvSD2bL7QNjNmCghLOdCTSIyn+sQQH1KwnG6dr9PDHV6yN
        PGJMUz8XQam13QdK7Q5UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663301809; x=
        1663388209; bh=hjMcp89C2jkXIYsBxRnx/xoB4u1WmalrxLV/Xe3flCk=; b=C
        CYWWIVEE4m7VNW7jhFBd1UIjfS1EslnN1EGBqP4+EgN4Z9hGnYPeKhiBAimVwVkW
        r8mbXSfdg2aFESQ9CpvZ3G1GGHKoeEPxbCuhBEaIj0xoT1oPI9G38cTLmg14VUqn
        X+hO4XoBd0+op2WAj7yqtRVMl9Q0UyNOrO1Ez7FeH6pAKftfwRWjvtVt8shqriUw
        yXj0uz+qiZ0j/B58Nvs0Ib+YIYqMDVHcLy7Or+YHDfKcNSftldjHwVROafz5DicP
        IoF0pJO74a6/I2Cpw1c1pwTeUJ+em3BRXqtnPVEIKRAHfYl9CvedWXN+cw0rFXG9
        lW0G4oDobqJZBxK7SbJvQ==
X-ME-Sender: <xms:sfgjYz4e7MZ42PmEBnedXq5TxML7oaZ6LgnllFHVIQTfH4176evBUg>
    <xme:sfgjY46w0sLpfSkfwbYQIA3bZa5Idxc2wtLsnKyQqJF3017ntC5hv69Yp8un8a7bt
    nGn1hRN5-R8rYxXpg>
X-ME-Received: <xmr:sfgjY6cYnRyoKYgZm3LEvcMJNuP-9m7reDw_SasGJ5AAptkCGmswBkVxG4L3QXU4Kwq8R1zzcbS1bDWaiUNKvr1DnaM9pcTQ4i7oNSnEOdpUrC9Za4jPbn-kzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduledgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejgfffhfdujeeftdeuudeguedttefgieetffffheejuefguedv
    heejteeftdfftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:sfgjY0L14CMoVti6SmIHeVX1vQ0b4zYnofIgkJl4I5UN1q8ZcwzhLQ>
    <xmx:sfgjY3J9PfR1sng34eJL-iSZJDiO9FGZEakjIJsJB6SMzv2lXyngcg>
    <xmx:sfgjY9xx4T7iVJ82LzvUP1sLynnc5puuVLAEcIEz38B-eBdV9UyDIQ>
    <xmx:sfgjY4XqBd3fnHIM93wJlm0XJYToap_wV12HbzBvrh6iZSZ3c9GQFw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Sep 2022 00:16:48 -0400 (EDT)
Message-ID: <4358760c-92b1-f77e-9bed-42e647afbc3e@sholland.org>
Date:   Thu, 15 Sep 2022 23:16:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     wens@csie.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
References: <20220621034224.38995-1-samuel@sholland.org>
 <20220621034224.38995-5-samuel@sholland.org>
 <CAGb2v64Mrn88+w5kCbMn7Z23-UdyrTG-Q2cboPswMj=9z4HgrQ@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 4/4] ARM: dts: axp22x/axp809: Add GPIO controller nodes
In-Reply-To: <CAGb2v64Mrn88+w5kCbMn7Z23-UdyrTG-Q2cboPswMj=9z4HgrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/22 08:03, Chen-Yu Tsai wrote:
> On Tue, Jun 21, 2022 at 11:42 AM Samuel Holland <samuel@sholland.org> wrote:
>>
>> These PMICs all contain a GPIO controller. Now that the binding is
>> documented, wire up the controller in the device tree.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>> (no changes since v1)
>>
>>  arch/arm/boot/dts/axp22x.dtsi | 18 ++++++++++++++++++
>>  arch/arm/boot/dts/axp809.dtsi | 19 +++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
>> index a020c12b2884..5c233c84be92 100644
>> --- a/arch/arm/boot/dts/axp22x.dtsi
>> +++ b/arch/arm/boot/dts/axp22x.dtsi
>> @@ -67,6 +67,24 @@ battery_power_supply: battery-power {
>>                 status = "disabled";
>>         };
>>
>> +       axp_gpio: gpio {
>> +               compatible = "x-powers,axp221-gpio";
>> +               gpio-controller;
>> +               #gpio-cells = <2>;
>> +
>> +               /omit-if-no-ref/
>> +               gpio0_ldo: gpio0-ldo-pin {
>> +                       pins = "GPIO0";
>> +                       function = "ldo";
>> +               };
>> +
>> +               /omit-if-no-ref/
>> +               gpio1_ldo: gpio1-ldo-pin {
>> +                       pins = "GPIO1";
>> +                       function = "ldo";
>> +               };
>> +       };
>> +
> 
> We have
> 
>     reg_ldo_io0: ldo-io0 {
>             pinctrl-names = "default";
>             pinctrl-0 = <&gpio0_ldo>;
>             /* Disable by default to avoid conflicts with GPIO */
>             ...
>     }
> 
> in axp81x.dtsi . Should we add it here and for axp803.dtsi as well?

Actually, I don't think these pinctrl nodes should exist at all. The
regulator already sets the pinmux, because that is the only way to turn
the regulator on/off. So I think we should leave it alone here.

Regards,
Samuel

> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

