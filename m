Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D304666168
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbjAKRIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjAKRHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:07:36 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66259B1EF;
        Wed, 11 Jan 2023 09:06:04 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r18so10958048pgr.12;
        Wed, 11 Jan 2023 09:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=89cPBXwaJNynsskh4m7BBUzu+Ax6lIerSdHhopU5dxk=;
        b=K5e90OPR1LfeCr9JYTKvd1ajs9xoUHo10GXimFniYQfciBZNVkj66gf6Ys+7wglXPB
         fxAvXzznPPz6eRgWbGPQgAVbFcodfNFuF5V45qXBCzlM1SJHTb4dyMF1wC0l6BlZ1zwf
         qxNjhpCTDfeN95NVKIq8QQZIn+NWyI1+w8GsXmMHAm/uwg4y7CM2/ei2xqfgUmj1dgxL
         4l20VsfYHST/NBdSMmMoK2oEMYbfu5Fs1LPQnj01h8p/ldcvOkfWL7cy5mKO0Qfasrmd
         kicc/mIAzZZCKLrhFIh6w9b1ogMICO18TA8b1OVI1GdhS8vcQL7TyVAcG8rK3nfEo+u6
         wIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89cPBXwaJNynsskh4m7BBUzu+Ax6lIerSdHhopU5dxk=;
        b=UfaWMR3BLN/BHW1GemY8i+liaCgYUFbQGFNrl2qbIrMx5YIslNpppNwTnjtZu8kSDT
         46fsWw8X/9R0VBVmyZWAxCVLugMkhI6puEEUmw5wWIGVLJARjMsAxWzY9d5PUhi/3kAA
         CoEp2/r323YztHZ354IKOk3nbqdPW1bsRUQmWiQhbx0BoakDxc58Wr5JT+PqlVgq/ZTn
         FMK854tt5Y8IBoCqs00Amp9NxhCoib4jVj0hLvlbrz1tmSiMZ3srv0yBV24R7ybJpMnr
         3Z/JzAhHVPDMcuwrtEtmmU/Cq5yyGU4j4VfsrX05Am90VZvEiswNw4UlPHAymvpY5YiB
         wuKg==
X-Gm-Message-State: AFqh2kpvmnSmiyot2n1j1r3v5Mzq9EZvGDkH9HPRdHcqcshD8aUb5f4k
        k1WnJvJQTlAi8YX4PU1DqsQ4Gms87k49SyeMMjdAoId1
X-Google-Smtp-Source: AMrXdXv8z9But+pBFKWpmxeQSj4lB0fBgWddes8q1HNbe8wxWPXiNaSvrxPlQbIelQhpzi0gQ87Er4q4e4nQtINeNRA=
X-Received: by 2002:a05:6a00:1796:b0:58b:9f0a:f87f with SMTP id
 s22-20020a056a00179600b0058b9f0af87fmr11061pfg.81.1673456763592; Wed, 11 Jan
 2023 09:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20230104141245.8407-1-aford173@gmail.com> <CAMuHMdWuE4L6K4ULdVLZKeLwd3xYfzkyBNrf6s7Qc2kf9b-_Cg@mail.gmail.com>
In-Reply-To: <CAMuHMdWuE4L6K4ULdVLZKeLwd3xYfzkyBNrf6s7Qc2kf9b-_Cg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 11 Jan 2023 11:05:52 -0600
Message-ID: <CAHCN7xKJRE7mrRgpKiEEgpkH1NLR8uGcc3mr5Khp3sWjxEtbdQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: beacon-renesom: Fix gpio expander reference
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org, aford@beaconembedded.com,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 10:29 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Adam,
>
> On Wed, Jan 4, 2023 at 3:12 PM Adam Ford <aford173@gmail.com> wrote:
> > The board used to originally introduce the Beacon Embedded
> > RZ/G2[M/N/H] boards had a GPIO expander with address 20, but
> > this was change when the final board went to production.
> >
> > The production boards changed both the part itself and
> > the address.  With the incorrect address, the LCD cannot
> > come up.  If the LCD fails, the rcar-du driver fails to come up,
> > and that also breaks HDMI.
> >
> > Pre-release board were not shipped to the general public, so it
> > should be safe to push this as a fix.  Anyone with a production
> > board would have video fail due to this GPIO expander change.
> >
> > Fixes: a1d8a344f1ca ("arm64: dts: renesas: Introduce r8a774a1-beacon-rzg2m-kit")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Thanks for your patch!
>
> > --- a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
> > @@ -437,20 +437,6 @@ wm8962_endpoint: endpoint {
> >                 };
> >         };
> >
> > -       /* 0 - lcd_reset */
> > -       /* 1 - lcd_pwr */
> > -       /* 2 - lcd_select */
> > -       /* 3 - backlight-enable */
> > -       /* 4 - Touch_shdwn */
> > -       /* 5 - LCD_H_pol */
> > -       /* 6 - lcd_V_pol */
> > -       gpio_exp1: gpio@20 {
> > -               compatible = "onnn,pca9654";
> > -               reg = <0x20>;
> > -               gpio-controller;
> > -               #gpio-cells = <2>;
> > -       };
> > -
> >         touchscreen@26 {
> >                 compatible = "ilitek,ili2117";
> >                 reg = <0x26>;
> > @@ -482,6 +468,21 @@ hd3ss3220_out_ep: endpoint {
> >                         };
> >                 };
> >         };
> > +
> > +       gpio_exp1: gpio@70 {
> > +               compatible = "onnn,pca9654";
>
> According to the patch description, the actual part was changed, too?

humm.. I was under the impression it was after talking with one of the
hardware developers, but clearly it's using the same compatible name.
I will investigate this further.  One way or the other, I'll redo the
commit message.

adam
>
> > +               reg = <0x70>;
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +               gpio-line-names =
> > +                       "lcd_reset",
> > +                       "lcd_pwr",
> > +                       "lcd_select",
> > +                       "backlight-enable",
> > +                       "Touch_shdwn",
> > +                       "LCD_H_pol",
> > +                       "lcd_V_pol";
> > +       };
> >  };
>
> The rest LGTM.
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
