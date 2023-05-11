Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CD56FEC5D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbjEKHII convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 May 2023 03:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbjEKHHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:07:39 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F194B65A0;
        Thu, 11 May 2023 00:07:37 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so39813077276.0;
        Thu, 11 May 2023 00:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788857; x=1686380857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsAz4959ASyLH7I3o6usz1e8SUod/Uv6RBV6dCds1Mc=;
        b=Z1n32LyULtXwk+dijqJqRPOFQgGnc83LPYYaUZdAB4q2MnhQlIOY6u1XBEM4LKGUoz
         brrafF5A8RTs8S3BR4oxcB7/GxF/43A33pI+JbcDQ6S/NF/F5rKBa7NK+/bVCr78H/p0
         OltKxSI16wUMXMzKMdfnSvT9q8VvlCsH7A7CwTML3UVBx1v1I4ueIjHVJm3iHXD98pr6
         IlEM60TzolZX5RO2I3eaKJ38dD4A4XemfXOdOlnODDTzICSfVCuzBYY0E5VbZ2Hnn7Ie
         26vnIAQ6GkLCEB1xxHiQOhhu4IfFR7V89EUxOHY3hPXBD93RlOnoS1dZGqjHzXx94MTL
         eg9A==
X-Gm-Message-State: AC+VfDy+9iowsm345SRanQzAT4QflvFFmlnhzDxpb8JNEhzzEfjoy5QQ
        l+0EC5ItJcUvUzufsYSyJ7ZBraXL3J7wyw==
X-Google-Smtp-Source: ACHHUZ5RoQCMP8AYzaLKQJc36sKIhPxpMZo+xXyDii+CPKdXLYXKuSLN49NDomX4XldF3Eh1lbysOg==
X-Received: by 2002:a25:4ac9:0:b0:ba1:6bad:9270 with SMTP id x192-20020a254ac9000000b00ba16bad9270mr22602848yba.27.1683788856699;
        Thu, 11 May 2023 00:07:36 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id 7-20020a250a07000000b00b9dcd17cc2dsm4241467ybk.46.2023.05.11.00.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 00:07:36 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so39746388276.1;
        Thu, 11 May 2023 00:07:35 -0700 (PDT)
X-Received: by 2002:a25:c086:0:b0:b9e:67ab:4f36 with SMTP id
 c128-20020a25c086000000b00b9e67ab4f36mr21664777ybf.10.1683788855509; Thu, 11
 May 2023 00:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <40ff1fc7f5220db7d527c57ac4bad16c3945ae08.1683725179.git.geert+renesas@glider.be>
 <20230510-headsman-deskwork-6826f9f174df@spud>
In-Reply-To: <20230510-headsman-deskwork-6826f9f174df@spud>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 May 2023 09:07:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVKES1dgTMrLwNA3t37m-wscYETejRBM2aroB_ZF-pbaw@mail.gmail.com>
Message-ID: <CAMuHMdVKES1dgTMrLwNA3t37m-wscYETejRBM2aroB_ZF-pbaw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: sifive,clint: Clean up compatible
 value section
To:     Conor Dooley <conor@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Wed, May 10, 2023 at 6:02 PM Conor Dooley <conor@kernel.org> wrote:
> On Wed, May 10, 2023 at 03:27:24PM +0200, Geert Uytterhoeven wrote:
> > Replace the sentences in the description listing some supported variants
> > by comments on the individual compatible values, to ease future
> > maintenance.  While at it, restore alphabetical sort order.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  .../bindings/timer/sifive,clint.yaml          | 21 +++++++------------
> >  1 file changed, 8 insertions(+), 13 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > index 94bef9424df1bc6a..34a81510678134eb 100644
> > --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > @@ -29,11 +29,11 @@ properties:
> >      oneOf:
> >        - items:
> >            - enum:
> > -              - sifive,fu540-c000-clint
> > -              - starfive,jh7100-clint
> > -              - starfive,jh7110-clint
> > -              - canaan,k210-clint
> > -          - const: sifive,clint0
> > +              - canaan,k210-clint       # Canaan Kendryte K210
> > +              - sifive,fu540-c000-clint # SiFive FU540
> > +              - starfive,jh7100-clint   # StarFive JH7100
> > +              - starfive,jh7110-clint   # StarFive JH7110
> > +          - const: sifive,clint0        # SiFive CLINT v0 IP block
> >        - items:
> >            - enum:
> >                - allwinner,sun20i-d1-clint
> > @@ -45,14 +45,9 @@ properties:
> >          description: For the QEMU virt machine only
> >
> >      description:
> > -      Should be "<vendor>,<chip>-clint" and "sifive,clint<version>".
> > -      Supported compatible strings are -
> > -      "sifive,fu540-c000-clint" for the SiFive CLINT v0 as integrated
> > -      onto the SiFive FU540 chip, "canaan,k210-clint" for the SiFive
> > -      CLINT v0 as integrated onto the Canaan Kendryte K210 chip, and
> > -      "sifive,clint0" for the SiFive CLINT v0 IP block with no chip
> > -      integration tweaks.
> > -      Please refer to sifive-blocks-ip-versioning.txt for details
>
> > +      Should be "<vendor>,<chip>-clint", followed by "sifive,clint<version>"
> > +      when compatible with a SiFive CLINT.  Please refer to
> > +      sifive-blocks-ip-versioning.txt for details regarding the latter.
>
> Does this section actually add any value at all?
> By nature of oneOf structure above, such an ordering is required for
> existing entries. For something not here, should we instead be noting
> that sifive,clint0 is to be used when compatible with the SiFive/RISC-V
> clint, rather than doing a sifive-blocks-ip-versioning.txt dance?

I considered removing the paragraph.  But I kept it, just not to loose
the reference to sifive-blocks-ip-versioning.txt, which someone might
find useful.

> As it stands though, patch is an improvement, so:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
