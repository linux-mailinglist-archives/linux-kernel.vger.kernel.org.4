Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263EE697ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjBOLcJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Feb 2023 06:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjBOLcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:32:08 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1773346C;
        Wed, 15 Feb 2023 03:32:06 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id di14so8409864qvb.12;
        Wed, 15 Feb 2023 03:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9O+F4kNHWRbRQrTLIpt2WL53jefsE2I6zT13GRRhI70=;
        b=dOXeActpVpgb1JlaI4hPYkSxPsAxBkLUUIZ7RTslwWulZjvHGdF/tc8FgG5aSuxQ3z
         nNauIcH/GTmRaaV3Rmb61T5sCodIYqXH3aeBCCCHFGeNQTBW9YtKgHZronHKVbgK/XDo
         376xajy9Poes1QwcS9/FV36IEqm0qkxUj2sSuc2UuVyWVTLlhNhQxU8hOwtJvORyD00O
         FvLMHtRGm3Ru3B/nKOepHpyCNNBTPV4hQ6CaD34nNONLZ1rd++Z0JiA4/FuKlbmnTOAH
         7X2UxC/tWRsqToamMio4PCUxS/CEtXj4vvtGv4HaDJTMS1Guz7ll1xhiJy2yuuUN7Glu
         frwg==
X-Gm-Message-State: AO0yUKXqRGNyGlKdYpcAovbQbqyJtkVpdPAzEXXq2zD/8mOl5OFQ8n8z
        xEqPn31uNEff5XUWIwjhwlVO5xUfxXpKrA==
X-Google-Smtp-Source: AK7set+ohg8neTD8YjkbLq9QqPavUBA+WeZqtpl/Dh4o3dZTKo5ozxcDu9CICDuzt09Q0+4ghnDMjQ==
X-Received: by 2002:ad4:5fcb:0:b0:56e:8f5e:d96d with SMTP id jq11-20020ad45fcb000000b0056e8f5ed96dmr3065560qvb.34.1676460725598;
        Wed, 15 Feb 2023 03:32:05 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id b1-20020a378001000000b0073b597ce5f8sm3286338qkd.120.2023.02.15.03.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 03:32:05 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-530b9a0a789so33265147b3.13;
        Wed, 15 Feb 2023 03:32:04 -0800 (PST)
X-Received: by 2002:a0d:f347:0:b0:4fc:962d:7dc1 with SMTP id
 c68-20020a0df347000000b004fc962d7dc1mr220614ywf.301.1676460724637; Wed, 15
 Feb 2023 03:32:04 -0800 (PST)
MIME-Version: 1.0
References: <20230209133507.150571-1-clement.leger@bootlin.com>
 <20230209133507.150571-3-clement.leger@bootlin.com> <CAMuHMdWUorkDYXZvsd-9rjwEkeJYC_FMfexZHaGYHDry=9Yjdg@mail.gmail.com>
 <20230215092933.2f71ece0@fixe.home> <20230215115441.361aed53@fixe.home>
In-Reply-To: <20230215115441.361aed53@fixe.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Feb 2023 12:31:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVhGFyrWx6oD-K9WhZRtYT_xJ_kWRA+vhdvB_JubFk8YA@mail.gmail.com>
Message-ID: <CAMuHMdVhGFyrWx6oD-K9WhZRtYT_xJ_kWRA+vhdvB_JubFk8YA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: r9a06g032: add r9a06g032-rzn1d400-eb
 board device-tree
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clément,

On Wed, Feb 15, 2023 at 11:52 AM Clément Léger
<clement.leger@bootlin.com> wrote:
> Le Wed, 15 Feb 2023 09:29:33 +0100,
> Clément Léger <clement.leger@bootlin.com> a écrit :
> > Le Tue, 14 Feb 2023 17:25:14 +0100,
> > Geert Uytterhoeven <geert@linux-m68k.org> a écrit :
> > > On Thu, Feb 9, 2023 at 2:32 PM Clément Léger <clement.leger@bootlin.com> wrote:
> > > > The EB board (Expansion board) supports both RZ/N1D and RZ-N1S. Since this
> > > > configuration targets only the RZ/N1D, it is named r9a06g032-rzn1d400-eb.
> > > > It adds support for the 2 additional switch ports (port C and D) that are
> > > > available on that board.
> > > >
> > > > Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- /dev/null
> > > > +++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts

> > > > +       pinctrl-0 = <&pins_eth1>, <&pins_eth2>, <&pins_eth3>, <&pins_eth4>,
> > > > +                   <&pins_mdio1>;
> > > > +
> > > > +       mdio {
> > > > +               /* CN15 and CN16 switches must be configured in MDIO2 mode */
> > > > +               switch0phy1: ethernet-phy@1 {
> > > > +                       reg = <1>;
> > > > +                       marvell,reg-init = <3 16 0 0x1010>;
> > >
> > > marvell,reg-init is not documented in any DT bindings document?
> >
> > Indeed, this is not somethiong that should be made available here. It's
> > only inverting the LED polarity but supported by some internal patch.
> > I'll remove that.

> I actually was confused by a property I added in another device-tree but
> marvell,reg-init exists, is handled by the marvell phy driver and used
> in a few device-trees. Strangely, it is not documented anywhere. So I
> can either remove that (and the LED won't work properly) or let it live
> depending on what you prefer.

In that case, please keep it.
But the property really should be documented, one day...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
