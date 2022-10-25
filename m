Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2FF60D73D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiJYWjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJYWjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:39:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD006B152;
        Tue, 25 Oct 2022 15:39:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fy4so16600995ejc.5;
        Tue, 25 Oct 2022 15:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DXGyyU/EtDoBqiMPzZf3JshDG4DtDWGTdQClBxCBOus=;
        b=T3/t/qgpl8gvFR8QoBRQHWVdF6vL8P748OP1/U6ZZDBrEWoi9ICOUlbQemoFFh44yH
         vRTBnQ592VEQcnN5DfOLSy5uiW3gMPF2l3/QncC2JAE96V17JCBv5RA6hIxB5LR1b7Xp
         IuigW696YylH2WKQaBNEysjIhpUZ8bRp+5FskHzwgAwoajrxk3Omy5+5x+ciNWxSP6ch
         wT0jZmMNrabQJU6PsA21lu56wUD7AD7y858R+VN5dNFFbbs2/gz0BSK+YLa8Gzj0LcN2
         XiEVxmATdU40lVYoI+yeH8Cg8zOf8mAow2mnn1zHT7ZkmZpXJ3hVJygbB/0OEraA/S2k
         y+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXGyyU/EtDoBqiMPzZf3JshDG4DtDWGTdQClBxCBOus=;
        b=hNZcCbTHh1dfN2+UAcpaqpkxErH8pRlxqu6ufBgZd0n02pFOwcAO8T8rlDVXK+lEft
         T3KTKRHcTvyu911NVjpMcQ68sHwq+AmqOsqOT7nU3RCOdU4r8RGQSLmXoRCBCj7hLACC
         UuRnvUpTqoGxJMTO6aJdKLmk/i0/JBK4rbdejAdjzwW8oMp/RjsBplgVO07/bcsh6W6g
         ZSKIlBHNBfGs1pcBR/9ae+RnWWPe7s/jf7474CM78s2gLngJPNTjsZmVsAMuO5ay3LXE
         O5WIA4SIZpCwBd6RYZL/oE4yXI1bCqOR732MXZ8ocfn6yzUimiga2ZRs3aCzB8s3ZX//
         vl9w==
X-Gm-Message-State: ACrzQf2atnlfkEgoG1AdG2wpyNTQU9MkaZtVjR4MOa8CFzdM3YshvDjG
        6MZdu5SQqR8HEetmn4pXZTI5K2k0+JAPb53QNnc=
X-Google-Smtp-Source: AMsMyM6zJ3KqdgzyaaWt58d2LFCL8i+EV02a7Lroi5S+VhlGd1aRozxKThF3lgyvX6Z2KpEhfkJMYGlsan+zJBhY1/s=
X-Received: by 2002:a17:906:5a4b:b0:78d:4e5a:d101 with SMTP id
 my11-20020a1709065a4b00b0078d4e5ad101mr33741777ejc.196.1666737543066; Tue, 25
 Oct 2022 15:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220915165256.352843-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915165256.352843-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVJ4gp=kT2S+5bhjdZACSbEX=3pP7mmmi_GEbeAOxtHGw@mail.gmail.com>
In-Reply-To: <CAMuHMdVJ4gp=kT2S+5bhjdZACSbEX=3pP7mmmi_GEbeAOxtHGw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 25 Oct 2022 23:38:36 +0100
Message-ID: <CA+V-a8sidwGQVSb7UV56opqE9ViS_y7nVPWx8Krx7t6P1BExCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: rzg2ul-smarc: Add
 /omit-if-no-ref/ to pinmux
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Tue, Oct 25, 2022 at 9:13 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Sep 15, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > In preparation to re-use the RZ/G2UL SMARC SoM and carrier DTS/I with the
> > RZ/Five add /omit-if-no-ref/ keyword to pinmux entries as the support for
> > RZ/Five SMARC EVK will be gradually added.
> >
> > Once we have full blown support for RZ/Five SMARC EVK we can get rid of
> > the /omit-if-no-ref/ keyword.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> I finally had a deeper look at this...
>
> Why do you want to disable these nodes? While they are indeed not
> used yet on RZ/Five, they are valid hardware descriptions for the
> RZ/Five SMARC EVK, and their presence doesn't harm anything.
>
> I do see a valid use case for marking pin control subnodes with
> /omit-if-no-ref/: you can provide all possible configurations as a
> convenience for the user, so the user no longer has to look up the
> numeric parameters of the RZG2L_PORT_PINMUX() macros.
> But IMHO those would belong in the SoC-specific .dtsi, not in a
> board .dtsi.  See e.g. the massive use of /omit-if-no-ref/ in sunxi
> and rockchip .dtsi files.
>
> Am I missing something?
>
My intention was to keep the DTB as minimal as possible so that it
includes just the required pinmuxes which were enabled on the RZ/Five.
For example [0], [1] we do delete the pinctrl for the nodes which are
marked as disabled. Do you think we should drop it?

But now that things are falling in place for RZ/Five we can ignore this patch.

[0] arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
[1] arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi

Cheers,
Prabhakar

> > --- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
> > @@ -12,12 +12,14 @@ &pinctrl {
> >         pinctrl-0 = <&sound_clk_pins>;
>                         ^^^^^^^^^^^^^^
> >         pinctrl-names = "default";
> >
> > +       /omit-if-no-ref/
> >         can0_pins: can0 {
> >                 pinmux = <RZG2L_PORT_PINMUX(1, 1, 3)>, /* TX */
> >                          <RZG2L_PORT_PINMUX(1, 2, 3)>; /* RX */
> >         };
> >
> >  #if (SW_ET0_EN_N)
> > +       /omit-if-no-ref/
> >         can0-stb-hog {
> >                 gpio-hog;
> >                 gpios = <RZG2L_GPIO(2, 2) GPIO_ACTIVE_HIGH>;
>
> > @@ -94,11 +103,13 @@ sd1_mux_uhs {
> >                 };
> >         };
> >
> > +       /omit-if-no-ref/
> >         sound_clk_pins: sound_clk {
>
> FTR, this one is always referenced.
>
> >                 pins = "AUDIO_CLK1", "AUDIO_CLK2";
> >                 input-enable;
> >         };
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
