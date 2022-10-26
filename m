Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5224260DC11
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbiJZH3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiJZH3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:29:09 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CB7B8C37;
        Wed, 26 Oct 2022 00:29:09 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id a5so9955784qkl.6;
        Wed, 26 Oct 2022 00:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5m59W7ETiWbAx79mryLE4tSpYnn+RzXpvnV18OsjtU=;
        b=bY0+o/EriSjklpvLfCtxL4UtkKnTdSZTrzhX35amBYtsjGRyRCRxNGLnmKzJDn5Dfe
         nCuCDqlAWFv2QS7yFCP91rqwA871OH7fPuFL/WPBDyqR+3VUpgUBpKPRwCi85COpfHuF
         In2WyYbV+5cEsyyaOfqK/FL9EnN74yAULGJIJzThF7j2EuiR3sS/NWcYMGqrbxls6tZf
         yOOzoPluJZjcwnKg3H6glOckpB/Bs1co3HYqTk6lA0hWi1TvYZ0LkBAEi/+QqqgSlfWV
         zfsC+XhOos61+ED7QtOY4KFlIQsPl02nkNhrLKiZ4Cr8EhRBS0m6qLDxuu+ds1TNBvmI
         sONg==
X-Gm-Message-State: ACrzQf0VFwL/lBNHIvop3fkPmButmvvfWstHW0cLrWTZ5hgPOH0ApvhX
        8HRWbP6LSKQyLJ3e/gn0kE3xN6C81f8j+g==
X-Google-Smtp-Source: AMsMyM5VIePux2m3QepPlT7MWBQbMbHlejiXM5fOjcH+PJoAiKfAGf4ufY51GAOBtMLVb3UZHgjfPQ==
X-Received: by 2002:a37:8981:0:b0:6f1:1560:ac7d with SMTP id l123-20020a378981000000b006f11560ac7dmr16157125qkd.659.1666769347955;
        Wed, 26 Oct 2022 00:29:07 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id f14-20020a05620a280e00b006eec09eed39sm3534288qkp.40.2022.10.26.00.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 00:29:07 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-369426664f9so138742927b3.12;
        Wed, 26 Oct 2022 00:29:07 -0700 (PDT)
X-Received: by 2002:a81:5a57:0:b0:353:6de6:3263 with SMTP id
 o84-20020a815a57000000b003536de63263mr37779589ywb.358.1666769347215; Wed, 26
 Oct 2022 00:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220915165256.352843-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915165256.352843-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVJ4gp=kT2S+5bhjdZACSbEX=3pP7mmmi_GEbeAOxtHGw@mail.gmail.com> <CA+V-a8sidwGQVSb7UV56opqE9ViS_y7nVPWx8Krx7t6P1BExCg@mail.gmail.com>
In-Reply-To: <CA+V-a8sidwGQVSb7UV56opqE9ViS_y7nVPWx8Krx7t6P1BExCg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Oct 2022 09:28:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWkg-k2efZoy=U+j-xji0Agp38qRy-8cjb7K7QiJrL-ZQ@mail.gmail.com>
Message-ID: <CAMuHMdWkg-k2efZoy=U+j-xji0Agp38qRy-8cjb7K7QiJrL-ZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: rzg2ul-smarc: Add
 /omit-if-no-ref/ to pinmux
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Wed, Oct 26, 2022 at 12:39 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Tue, Oct 25, 2022 at 9:13 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Sep 15, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > In preparation to re-use the RZ/G2UL SMARC SoM and carrier DTS/I with the
> > > RZ/Five add /omit-if-no-ref/ keyword to pinmux entries as the support for
> > > RZ/Five SMARC EVK will be gradually added.
> > >
> > > Once we have full blown support for RZ/Five SMARC EVK we can get rid of
> > > the /omit-if-no-ref/ keyword.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > I finally had a deeper look at this...
> >
> > Why do you want to disable these nodes? While they are indeed not
> > used yet on RZ/Five, they are valid hardware descriptions for the
> > RZ/Five SMARC EVK, and their presence doesn't harm anything.
> >
> > I do see a valid use case for marking pin control subnodes with
> > /omit-if-no-ref/: you can provide all possible configurations as a
> > convenience for the user, so the user no longer has to look up the
> > numeric parameters of the RZG2L_PORT_PINMUX() macros.
> > But IMHO those would belong in the SoC-specific .dtsi, not in a
> > board .dtsi.  See e.g. the massive use of /omit-if-no-ref/ in sunxi
> > and rockchip .dtsi files.
> >
> > Am I missing something?
> >
> My intention was to keep the DTB as minimal as possible so that it
> includes just the required pinmuxes which were enabled on the RZ/Five.
> For example [0], [1] we do delete the pinctrl for the nodes which are
> marked as disabled. Do you think we should drop it?

You mean

    /delete-property/ pinctrl-0;
    /delete-property/ pinctrl-names;

?
These do not delete pinctrl subnodes, but pinctrl properties in disabled
device nodes pointing to pinctrl subnodes.  The actual pinctrl subnodes
are still present.

> But now that things are falling in place for RZ/Five we can ignore this patch.

Agreed.

> [0] arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
> [1] arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
