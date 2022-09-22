Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993C05E5B68
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIVGaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIVGav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:30:51 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D70B028D;
        Wed, 21 Sep 2022 23:30:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 3C5BD2B05A35;
        Thu, 22 Sep 2022 02:30:49 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 22 Sep 2022 02:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663828248; x=1663831848; bh=pc9XPISpbS
        GrSKClTsjUCQ3s2OvkC6s9yKH7w3Lu38w=; b=miw7MxLGEJQDH02KamYjGaBbiA
        emyhzmC2EjDpet3ByxNekE7xindVb/WHDb3wTpbOC9YIZR7qEarMip0ihFkqsWNU
        8HSI7RyowUNdY9FsYjflIHm9DkmYuY/BK/fHDxkisX/5iBedQh3en2LmJl2WUY5f
        U+c7Z6A2DhcC5OJ9/EP+Xh/Pm3/Sd6x2x6/tjzlPWR1CAb/DyhUaKYnGx5A0N5LD
        NvH9Z+TREmWr3XKKM8SHxd50nGe++IEy/zDh41rK5HhuTAFDo5P+ZMm6KhGkVhOD
        +7rlumViEP5y/M4IbNs9nppV1sc2UyFHRs7PLXswCr1vsYlvn1aXzCmWplJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663828248; x=1663831848; bh=pc9XPISpbSGrSKClTsjUCQ3s2Ovk
        C6s9yKH7w3Lu38w=; b=guIp/zmwVEwZGVF57nii8FIBbPPPFdH0hWSewC8RF/GD
        CfBFXRipj5CPq+WVz7t/UNjtpHKOExLG30qkdYRjV02SW43mlzZIEbvPOscHjVzt
        XXIYsiNQgMjk1yTf5WNfwH5Zqqewa2LbK1JJKIenSG+A1l3ARsFr5AViqPlmJg77
        XkGoaxF4MhDOxHW3WZiaPQCiBapN0vKkcR5fnkRxDzdNnIvFEKCxrT8NEXRJiWVe
        niHVCMyuV0xwkBaWwND+hrc1rOQV3LD6SYhUQoVlX4WSZFw2pauqMqho8EVpW7xX
        6BMGD5rDz9w9ERVZpZeGDigIU46MeZq/tEu9Sjfi/w==
X-ME-Sender: <xms:FwEsY8wj6vcZG2cZDpk9ULz2v63SZgfdnGDoiCnwrR7dGjXN3WQU3Q>
    <xme:FwEsYwSi4BpZZc1RI6iZHgW6ljYPysQmKfnZ7vFzEXuevzMDXedTUOfjNPQKQukdj
    biP8-q2T2JqNrch9ok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:FwEsY-XrRA58tJ8ZrxzyCNW0BhiniHqVZjChIBGai3aCiuHaAS4dZg>
    <xmx:FwEsY6iaR1GGHoetlcdSHzJ45bbZkfuMk82tWolbwT8k6svlQUs89w>
    <xmx:FwEsY-CNk2_xOfMsErQ0RAtKvRN1vDrTf8wsnUGoEyUctsEz38NKOg>
    <xmx:GAEsY6x2sBKkcrwzCCQKH5y37jmHkKdWmErZZ6bKGJ4-eLFh6xUmm4Q5fj8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C0B47B60086; Thu, 22 Sep 2022 02:30:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <0603b2a5-6253-4c4b-8b30-aa0253ed0480@www.fastmail.com>
In-Reply-To: <45d2e6c2-3b4b-5720-0431-002c74b1f9cc@arm.com>
References: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
 <45d2e6c2-3b4b-5720-0431-002c74b1f9cc@arm.com>
Date:   Thu, 22 Sep 2022 08:30:26 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Robin Murphy" <robin.murphy@arm.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Cc:     "Andre Przywara" <andre.przywara@arm.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        "Chris Paterson" <Chris.Paterson2@renesas.com>,
        "Atish Patra" <atishp@atishpatra.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Similar SoCs with different CPUs and interrupt bindings
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022, at 11:20 AM, Robin Murphy wrote:
> On 2022-09-21 08:46, Geert Uytterhoeven wrote:
>>          Hi Rob, Krzysztof,
>> 
>> This is a topic that came up at the RISC-V BoF at Plumbers, and it was
>> suggested to bring it up with you.
>> 
>> The same SoC may be available with either RISC-V or other (e.g. ARM) CPU
>> cores (an example of this are the Renesas RZ/Five and RZ/G2UL SoCs).
>> To avoid duplication, we would like to have:
>>    - <riscv-soc>.dtsi includes <base-soc>.dtsi,
>>    - <arm-soc>.dtsi includes <base-soc>.dtsi.
>> 
>> Unfortunately RISC-V and ARM typically use different types of interrupt
>> controllers, using different bindings (e.g. 2-cell vs. 3-cell), and
>> possibly using different interrupt numbers.  Hence the interrupt-parent
>> and interrupts{-extended} properties should be different, too.
>> 
>> Possible solutions[1]:
>>    1. interrupt-map
>> 
>>    2. Use a SOC_PERIPHERAL_IRQ() macro in interrupts properties in
>>       <base-soc>.dtsi, with
>>         - #define SOC_PERIPHERAL_IRQ(nr, na) nr          // RISC-V
>>         - #define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI na  // ARM
>>       Note that the cpp/dtc combo does not support arithmetic, so even
>>       the simple case where nr = 32 + na cannot be simplified.
>> 
>>    3. Wrap inside RISCV() and ARM() macros, e.g.:
>> 
>>          RISCV(interrupts = <412 IRQ_TYPE_LEVEL_HIGH>;)
>>          ARM(interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;)
>> 
>>       Cfr. ARM() and THUMB() in arch/arm/include/asm/unified.h, as used
>>       to express the same operation using plain ARM or ARM Thumb
>>       instructions.
>
> 4. Put all the "interrupts" properties in the SoC-specific DTSI at the 
> same level as the interrupt controller to which they correspond. Works 
> out of the box with no horrible mystery macros, and is really no more or 
> less error-prone than any other approach. Yes, it means replicating a 
> bit of structure and/or having labels for everything (many of which may 
> be wanted anyway), but that's not necessarily a bad thing for 
> readability anyway. Hierarchical definitions are standard FDT practice 
> and should be well understood, so this is arguably the simplest and 
> least surprising approach :)

FWIW, approaches 1, 2 and 4 all seem reasonable to me, but I don't
like number 3 if this is only about the IRQ definitions.

It sounds like we're already converging on #2, so just one more
idea from me: we could fold the IRQ type into the macro, and
make it just take a single argument for extra flexibility:

#define SOC_PERIPHERAL_IRQ_LEVEL_HIGH(nr) \
        GIC_SPI (nr + offset) IRQ_TYPE_LEVEL_HIGH

If all the irqs on the chip have the same type, the name
can be shorter of course.

Either way, some variation of the macro sounds like a good enough
approach to me.

     Arnd
