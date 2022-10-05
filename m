Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE045F553E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJENUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJENU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:20:26 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846D9205DB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 06:20:24 -0700 (PDT)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4CF0F420E5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664976023;
        bh=jBaHquY2gPRnyppqdq61kZ2fwJdv7V+rcZ7lwJtbiaA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QPuBcoXxKCNE9La7nxehD8hidPF7mJY6FJUWNdO//RQmuvoQOaEeRGpgLVFsIztQS
         ly3sGy6blFKmN36bb62iu/jtcwrmaoygTFD64bf6C4H8LvRWD9xEFj6/0bRkOQy9WF
         tHrm7ySi0WAtWg3W4l+Q8R1Gg+z9mP0qnodavXqbJ7Q586+TmX0i4Po7mo5y/0snKE
         U2OC/EYmlrGJZ9xIZ8e55+PDTM82REPmydLQMTJMoG8dUMgEHHzHI6IhlGVuk5SQ/+
         Zn3bXdKD9xIVYnIFCEKa1/zD77S9jdKo6UbAXCv3fCoxXhyMGtnGVnSvHBGVrrdWQ8
         p1hZB2i8RjhNw==
Received: by mail-qt1-f199.google.com with SMTP id s21-20020a05622a1a9500b0035bb9e79172so11403991qtc.20
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 06:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jBaHquY2gPRnyppqdq61kZ2fwJdv7V+rcZ7lwJtbiaA=;
        b=z4eOxNmHg6cxsFfZQzxt9RoQcHeDgTJ2wzm+vMWDnEmiHFSNZhS1cnnRSTdEI6RyIv
         PTeN5FRPzdi6A2rPTuKCYV3z1YiznNAo3tN5GH4MoFW/xW+ujvy5JRnQFGXZcTtbShwq
         Nu4uhyTINqwD8kjLuD7ORNKbE1aJxzICsus7OwS0Lojy0K02iA/Pd1m9xc1uNk1G9Qpf
         Vxx3RGKGMpQ4XrJy3ujLZCyQtt9XvqEWtxjlUGItXAURLYuO/0CDxMtX95mt4Lha7krk
         PEk8s/SclBZCC5OVo9e0aK2qvssazJ+SgNaN1cnXklmHiBSUbXZ1A3MRGN2uQvo7vd2U
         W6uw==
X-Gm-Message-State: ACrzQf13ZqIVmyk9bScmLOmWAK5HAGmz/D2MWf1N+w38/YvTdN34bMD6
        8peDwfS/IrRlSujyTX2zFmXeYSXVIzY+kmUxO0GOg3gQ/akY7EXHI1Vg6JfA9vAf2iwImVYJGIe
        KzKsuFN5MGDF0zq5++G7HrnFIjpr/PmeYmNTYX9w1sFpKpE7LKWc8LKYBrw==
X-Received: by 2002:a05:622a:13c6:b0:35b:a742:28ae with SMTP id p6-20020a05622a13c600b0035ba74228aemr23012774qtk.435.1664976022209;
        Wed, 05 Oct 2022 06:20:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7VzygNfGaHRADBYYItL4bS/N9idRpjVZehxb+NwhHmc/VMzKXudAwOZgLbL+u1dtE/kkYiOhO7QFkR6EckAi4=
X-Received: by 2002:a05:622a:13c6:b0:35b:a742:28ae with SMTP id
 p6-20020a05622a13c600b0035ba74228aemr23012768qtk.435.1664976022002; Wed, 05
 Oct 2022 06:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929143225.17907-10-hal.feng@linux.starfivetech.com> <20220930204905.GA903203-robh@kernel.org>
In-Reply-To: <20220930204905.GA903203-robh@kernel.org>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 5 Oct 2022 15:20:06 +0200
Message-ID: <CAJM55Z8ikNucTv4VjoEHwK5C_-nnvFNtn_2_U2E0QgbJKP97fg@mail.gmail.com>
Subject: Re: [PATCH v1 09/30] reset: starfive: jh7100: Move necessary
 properties to device tree
To:     Rob Herring <robh@kernel.org>
Cc:     Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sept 2022 at 22:51, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 29, 2022 at 10:32:04PM +0800, Hal Feng wrote:
> > Store the necessary properties in device tree instead of .c file,
> > in order to apply this reset driver to other StarFive SoCs.
> >
> > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> > ---
> >  .../bindings/reset/starfive,jh7100-reset.yaml | 20 ++++++++
> >  arch/riscv/boot/dts/starfive/jh7100.dtsi      |  3 ++
> >  drivers/reset/reset-starfive-jh7100.c         | 50 +++++++++++++------
> >  3 files changed, 57 insertions(+), 16 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml b/Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
> > index 300359a5e14b..3eff3f72a1ed 100644
> > --- a/Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
> > +++ b/Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
> > @@ -20,19 +20,39 @@ properties:
> >    "#reset-cells":
> >      const: 1
> >
> > +  starfive,assert-offset:
> > +    description: Offset of the first ASSERT register
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  starfive,status-offset:
> > +    description: Offset of the first STATUS register
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  starfive,nr-resets:
> > +    description: Number of reset signals
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> >  required:
> >    - compatible
> >    - reg
> >    - "#reset-cells"
> > +  - starfive,assert-offset
> > +  - starfive,status-offset
> > +  - starfive,nr-resets
>
> Adding required properties is a red flag. You can't add required
> properties to an existing binding. That breaks the ABI unless the OS
> deals with the properties being absent. If the OS has to do that, then
> why add them in the first place? All this should be implied by the
> compatible string.

Indeed. I really don't understand why this is even necessary. As
mentioned in my reply to the clock driver my original code just had a
combined driver for the whole CRG (clock and reset generator I
presume), and then you just need a simple node like this:

syscrg: clock-controller@13020000 {
    compatible = "starfive,jh7110-syscrg";
    reg = <0x0 0x13020000 0x0 0x10000>;
    clocks = <&osc>, <&gmac1_rmii_refin>,
             <&gmac1_rgmii_rxin>,
             <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
             <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
             <&tdm_ext>, <&mclk_ext>;
    clock-names = "osc", "gmac1_rmii_refin",
                  "gmac1_rgmii_rxin",
                  "i2stx_bclk_ext", "i2stx_lrck_ext",
                  "i2srx_bclk_ext", "i2srx_lrck_ext",
                  "tdm_ext", "mclk_ext";
    #clock-cells = <1>;
    #reset-cells = <1>;
};

/Emil
