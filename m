Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E347633A53
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiKVKm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiKVKk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:40:58 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D2B17E20
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:35:49 -0800 (PST)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 027F53F336
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 10:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669113346;
        bh=5zJKgeVGZmLVAXevDGlsNfSshltWSGYw3d8eMnb+lIA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pR0iPF1enR7Jq9/RDdOxOf1jYD5l1wvWmsz16U0qqUWVlmHvYzZFC7bX0hqNHpJqU
         Y/VowcpNaADz6osxPwpWFyfkxgKZGW714yr+ot64/jNj81HUTDOpKSsKR48Bq3W0cZ
         +yaIh05OJdtTnzF8sPx0D0kOd6aAZHA/5nWHNSB8YVm1KV3TLH2EjYp0r4EIceX/2a
         HHdAllHgPpSrSmGFISjsk8p47ZiIat+FxcyiMaLbNt3woCGIQfLdto4MfoLr1Y6GUR
         L7lXKSPfg1z3FQFTX5dWiNNXMvqw3lEt4hK/fqA7e+BHCrMvP1EO5kgCKf25e6qOyP
         YZVe6IbAZ3F9A==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-349423f04dbso137759927b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zJKgeVGZmLVAXevDGlsNfSshltWSGYw3d8eMnb+lIA=;
        b=reEg+qM1RujhW5n6ALi0ppjHORR4gYVqv2/qKTc0dOdSDJK6OBCmwoGrMSQ+g4WpTD
         xNe1VrmOJuHs0Gd3vG462BMtZ+n2hcFA1M494gneYiojbAQCmXBT7OGtY7rbfJCM6hGF
         9U/tgex8IAq4WgRYsU8jtl4w2sNi9sQK7Oyk1cTT7Ht4e8epR0lRjZBpHYHc8sMUm36J
         IesLKCmbHPB4F0gIFfaXeA44OPBUKm/gI45HOxTf8ubnufYl4SK09k32bWfQqhJUdkG3
         U1ZwZ7WDP0D97NlzJUpUwMZAr13mxPwTvmzKQb0YEEQ2WLmwHcu6fDh/++W2ix71RfNj
         zRUw==
X-Gm-Message-State: ANoB5pl9yNvBBuJIkYlbdFyu/fZKY1BjoSsQGikLxn/JHyTRnq7/kRgh
        islJYZX10VfkkL98oVaa8SmaDWO8GCVWRatXXZ372qVg4lntJ2eqYk5GPBbVyJAqRosIMxKzlA+
        Sc4xuXaNw2eGox+ySL7amQO7p59h2gRQIN2/GPngqlNwStS5NMZTGWu+tXg==
X-Received: by 2002:a81:4ed0:0:b0:39b:2705:501 with SMTP id c199-20020a814ed0000000b0039b27050501mr6707279ywb.326.1669113344954;
        Tue, 22 Nov 2022 02:35:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5vKLtUztzm9gaB/lzhK2k8U2ZuZGMCv5M6kPMPlh1R0C7N1egHiQAH8o2IMhW9OMm3sahzXcklxwXcPjKUzns=
X-Received: by 2002:a81:4ed0:0:b0:39b:2705:501 with SMTP id
 c199-20020a814ed0000000b0039b27050501mr6707261ywb.326.1669113344732; Tue, 22
 Nov 2022 02:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-5-hal.feng@starfivetech.com> <Y3duiJguYE6VrVLP@spud>
 <Y3dvCPP1g0LzzHFO@spud> <a5193e23-efe1-fa65-15de-d53b80b87d63@starfivetech.com>
 <Y3yRTuo69JUsfLqk@wendy> <0f9e423e-37c0-a838-bf25-f9b6784a31d0@starfivetech.com>
 <Y3yd+tfFl4yvXOx6@wendy> <b57bdf1c-19f4-3d70-7618-16817669abc5@starfivetech.com>
In-Reply-To: <b57bdf1c-19f4-3d70-7618-16817669abc5@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 22 Nov 2022 11:35:28 +0100
Message-ID: <CAJM55Z-aQfvUZXNtaorAk4acpbbVsj-f-8TQn6uZXQosD=MORA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] dt-bindings: sifive,ccache0: Support StarFive
 JH7110 SoC
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 at 11:16, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> On Tue, 22 Nov 2022 10:01:30 +0000, Conor Dooley wrote:
> > On Tue, Nov 22, 2022 at 05:55:57PM +0800, Hal Feng wrote:
> > > On Tue, 22 Nov 2022 09:07:26 +0000, Conor Dooley wrote:
> > > > On Tue, Nov 22, 2022 at 04:40:23PM +0800, Hal Feng wrote:
> > > > > On Fri, 18 Nov 2022 19:39:52 +0800, Conor Dooley wrote:
> > > > > > On Fri, Nov 18, 2022 at 11:37:50AM +0000, Conor Dooley wrote:
> > > > > > > On Fri, Nov 18, 2022 at 09:17:10AM +0800, Hal Feng wrote:
> > > > > > > > From: Emil Renner Berthing <kernel@esmil.dk>
> > > > > > > >
> > > > > > > > This cache controller is also used on the StarFive JH7110 SoC.
> > > > > > >
> > > > > > > "... and configured identically to that of the FU740"?
> > > > > > > Anyways,
> > > > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > >
> > > > > > Actually, after looking at the next patch - why can you not fall back to
> > > > > > the fu740 one since you appear to have the same configuration as it?
> > > > >
> > > > > Right, I will drop this patch and use "sifive,fu740-c000-ccache" as
> > > > > compatible in dts.
> > > >
> > > > Uh, that's not quite what I was suggesting. Rather than using that one
> > > > in isolation, you can do the following in your dt:
> > > > "starfive,jh7110-ccache", "sifive,fu740-c000-ccache"
> > > >
> > > > And then in the driver we need to make no changes - unless down the line
> > > > we find some sort of issue that requires special handling etc. There's
> > > > no harm in having a "starfive,jh7110-ccache" IMO.
> > >
> > > Just like what microchip did as blow?
>
> below
>
> > >
> > > Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml:
> > > properties:
> > >   compatible:
> > >     oneOf:
> > >       - items:
> > >           - enum:
> > >               - sifive,ccache0
> > >               - sifive,fu540-c000-ccache
> > >               - sifive,fu740-c000-ccache
> > >               - starfive,jh7110-ccache
> > >           - const: cache
> > >       - items:
> > >           - const: microchip,mpfs-ccache
> > >           - const: sifive,fu540-c000-ccache
> > >           - const: cache
> >
> > No, I don't think this is correct either. You'd do something like:
> >
> > >       - items:
> > >           - const: starfive,jh7110-ccache
> > >           - const: sifive,fu740-c000-ccache

For the record I don't think the line above should be there. The
fu7400-c000 is a specific tapeout and pretending the JH7110 is that
tapeout is not right. Especially when there is already the
"sifive,ccache0" string for the generic IP.

> > >           - const: cache
>
> Yeah, this is what I mean. Thanks.
>
> Best regards,
> Hal
>
> >
> > And then the driver needs no changes.
>
