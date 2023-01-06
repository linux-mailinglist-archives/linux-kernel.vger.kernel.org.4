Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B2F65FEFA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 11:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjAFKaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 05:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjAFK35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:29:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 654FD736C7;
        Fri,  6 Jan 2023 02:28:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFDEB11FB;
        Fri,  6 Jan 2023 02:28:50 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DCF83F23F;
        Fri,  6 Jan 2023 02:28:07 -0800 (PST)
Date:   Fri, 6 Jan 2023 10:28:03 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        =?UTF-8?B?QW5kcsOhcyBTemVtesO2?= <szemzo.andras@gmail.com>,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: arm: sunxi: document MangoPi MQ-R
 board name
Message-ID: <20230106102803.3e905d1c@donnerap.cambridge.arm.com>
In-Reply-To: <4d6aec55-c53e-0aba-1168-8a9a80a3b598@linaro.org>
References: <20230106010155.26868-1-andre.przywara@arm.com>
        <20230106010155.26868-4-andre.przywara@arm.com>
        <4d6aec55-c53e-0aba-1168-8a9a80a3b598@linaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2023 10:21:04 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 06/01/2023 02:01, Andre Przywara wrote:
> > The MangoPi MQ-R board is a close relative to its Allwinner D1/D1s
> > siblings, but features two Arm Cortex-A7 cores instead of a RISC-V core.
> > 
> > Add the board/SoC compatible string pair to the list of known boards.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > index 3ad1cd50e3fe0..ce445c5ed81c8 100644
> > --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> > +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > @@ -843,6 +843,11 @@ properties:
> >            - const: wexler,tab7200
> >            - const: allwinner,sun7i-a20
> >  
> > +      - description: MangoPi MQ-R board
> > +        items:
> > +          - const: widora,mangopi-mq-r  
> 
> Not documented vendor prefix.

Yes, after sending I realised that I forgot to mention that this
series relies on Samuel's D1/D1s DT series[1], which adds the basic .dtsi
this builds on, but also adds this vendor string[2].
Functionality-wise this also relies on the R528/T113-s clock series[3].

Cheers,
Andre

[1]
https://lore.kernel.org/linux-arm-kernel/20221231233851.24923-1-samuel@sholland.org/
[2]
https://lore.kernel.org/linux-arm-kernel/20221231233851.24923-3-samuel@sholland.org/
[3]
https://lore.kernel.org/linux-arm-kernel/20221231231429.18357-1-samuel@sholland.org/
