Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938D3669870
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbjAMN0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241458AbjAMN0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:26:07 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDBB869E0;
        Fri, 13 Jan 2023 05:17:13 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y5so16152812pfe.2;
        Fri, 13 Jan 2023 05:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Mo3K/eJ+MOGHbzScK4gvAZcKJcl3HKiS2vGsLSsm5o=;
        b=RZb/oYVUHQr0QkBGuJCMAUQG/oHKZ83adLHe54LBsNcDcyrI9kxnFmQytvzgOUGJvn
         iEhnXpokKGKrgKQR2I56zW+qFCVxTw6eNOMyoiNoByah/UyeK7Xho8RoMKtIBa/RvyNw
         +jjDFl2+lXUs6mSUOq84smmffQQCjSycf8WZFIDn2+qlLig1GBOhe6QVjx9sd/ZsKLWn
         2jXJ9NMTg1aam5n97s0UZvhelsCztEtgWbEDbpeBl9faLSJW6nZvPegYFsrRSZnhuz6Z
         DJHNZgb4yT935cQ3EaWzSOikf/gMWOtmaZ61smDDm8WQ2dLT+XK0w1iAgyAlbjnhuJRg
         F8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Mo3K/eJ+MOGHbzScK4gvAZcKJcl3HKiS2vGsLSsm5o=;
        b=cLgOvf8diDwFSTJ2cD0y2tGaCdvRHduZdVGnpzgA36iOWKC2yxLagvNnrjZGoMnzNP
         R5fbPBF4y5K/8P4HNVTr0k2s3/mV44CtaiLgFzdibbkxHbZQBt5yfdCSLc0Qubaj6vgM
         CfSToR8O0cH/5ePj6gggQaYFyTbkRExbtFOYdUTb18Z1HIivo+z9WySXVRj7MUCHvBwk
         rzHRzO5wjXrAY/6f+RkONzE8gzawY96Um8l8+7i/4SBiyOJgQdpdjfcu83f/+tjfgVmT
         WbuJYXLlZBtmfTXfOMsknWqdIB2nvcVjwNYcOV6yF+iNhlym1ZURAhhD3EJ9RSmPgPip
         WKUQ==
X-Gm-Message-State: AFqh2krV9AnG71DreoKsJsX0vFhVn9Zfc1uOPUuAugE6j2oqOCGabLpf
        9iKWjR8xQS+Ok1FsZ/A7PbFKpEetLXG3KIcnt9xOgSK5800=
X-Google-Smtp-Source: AMrXdXumwJEytEx1P4rpyQVMzmY8+DFigwS5ZEJvLOHgMvDjPP5aOq+j5mfdHOQmLC4SLGQxConZMxxi8z6gZEV3FXE=
X-Received: by 2002:a05:6a00:1796:b0:58b:9f0a:f87f with SMTP id
 s22-20020a056a00179600b0058b9f0af87fmr705608pfg.81.1673615832252; Fri, 13 Jan
 2023 05:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20230104141245.8407-1-aford173@gmail.com> <CAMuHMdWuE4L6K4ULdVLZKeLwd3xYfzkyBNrf6s7Qc2kf9b-_Cg@mail.gmail.com>
 <CAHCN7xKJRE7mrRgpKiEEgpkH1NLR8uGcc3mr5Khp3sWjxEtbdQ@mail.gmail.com>
In-Reply-To: <CAHCN7xKJRE7mrRgpKiEEgpkH1NLR8uGcc3mr5Khp3sWjxEtbdQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 13 Jan 2023 07:17:00 -0600
Message-ID: <CAHCN7xLSgrzxL0W0ue7wi8DBCH-EB574QtS6wsyrVNpHDFiE6Q@mail.gmail.com>
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

On Wed, Jan 11, 2023 at 11:05 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Wed, Jan 11, 2023 at 10:29 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >
> > Hi Adam,
> >
> > On Wed, Jan 4, 2023 at 3:12 PM Adam Ford <aford173@gmail.com> wrote:
> > > The board used to originally introduce the Beacon Embedded
> > > RZ/G2[M/N/H] boards had a GPIO expander with address 20, but
> > > this was change when the final board went to production.
> > >
> > > The production boards changed both the part itself and
> > > the address.  With the incorrect address, the LCD cannot
> > > come up.  If the LCD fails, the rcar-du driver fails to come up,
> > > and that also breaks HDMI.
> > >
> > > Pre-release board were not shipped to the general public, so it
> > > should be safe to push this as a fix.  Anyone with a production
> > > board would have video fail due to this GPIO expander change.
> > >
> > > Fixes: a1d8a344f1ca ("arm64: dts: renesas: Introduce r8a774a1-beacon-rzg2m-kit")
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > Thanks for your patch!
> >
> > > --- a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
> > > @@ -437,20 +437,6 @@ wm8962_endpoint: endpoint {
> > >                 };
> > >         };
> > >
> > > -       /* 0 - lcd_reset */
> > > -       /* 1 - lcd_pwr */
> > > -       /* 2 - lcd_select */
> > > -       /* 3 - backlight-enable */
> > > -       /* 4 - Touch_shdwn */
> > > -       /* 5 - LCD_H_pol */
> > > -       /* 6 - lcd_V_pol */
> > > -       gpio_exp1: gpio@20 {
> > > -               compatible = "onnn,pca9654";
> > > -               reg = <0x20>;
> > > -               gpio-controller;
> > > -               #gpio-cells = <2>;
> > > -       };
> > > -
> > >         touchscreen@26 {
> > >                 compatible = "ilitek,ili2117";
> > >                 reg = <0x26>;
> > > @@ -482,6 +468,21 @@ hd3ss3220_out_ep: endpoint {
> > >                         };
> > >                 };
> > >         };
> > > +
> > > +       gpio_exp1: gpio@70 {
> > > +               compatible = "onnn,pca9654";
> >
> > According to the patch description, the actual part was changed, too?

After a bit of some investigation, the part was changed to
nxp,pca9538.  It appears to be the same driver and the same ".data"
structure is used.  This probably explains why I didn't see any issues
when I was testing this.  Unfortunately, the hardware engineer who
made this hardware change is not around to ask why the change was
made.    I'll do a V2 since, I don't see this in renesas-devel.

adam
>
> humm.. I was under the impression it was after talking with one of the
> hardware developers, but clearly it's using the same compatible name.
> I will investigate this further.  One way or the other, I'll redo the
> commit message.
>
> adam
> >
> > > +               reg = <0x70>;
> > > +               gpio-controller;
> > > +               #gpio-cells = <2>;
> > > +               gpio-line-names =
> > > +                       "lcd_reset",
> > > +                       "lcd_pwr",
> > > +                       "lcd_select",
> > > +                       "backlight-enable",
> > > +                       "Touch_shdwn",
> > > +                       "LCD_H_pol",
> > > +                       "lcd_V_pol";
> > > +       };
> > >  };
> >
> > The rest LGTM.
> >
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
