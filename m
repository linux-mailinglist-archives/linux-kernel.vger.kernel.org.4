Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14396C0508
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCSUzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCSUzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:55:43 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E952CDC3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:55:41 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id j7so10836191ybg.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679259340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac/NF/X3Ce1vR1hDDyKBTJ707og2BXuZP/lMQW+OCrs=;
        b=H/USSk17Fu5IdWFmU2HYEVwZ92SC2T/aL/5nOvlVpJeD0L0do87jcAsTliaBEz0MCA
         mMqeZBU9urZirZ7zxW11auSX7+tkHYp0K9XThAE/wLNlnvSVJ8GdNjd8zqxEnyfC6R+S
         bF0GNyNi0+l9Pp7ASmve9a2w4hwTf3i3d+4y1vux+85gQW4f0GI7kaHZLVj6jXu3zltE
         7jVl7Q6CBsq+1I5qhe0Ga3XfgMounIvMwgwAAF156gYYGaIPQ8+xRHnk/kIV9uZT6MuK
         aofXXYTTc5isXyhzb02mMH9GFNLJv1AQNxp4DslX98DqL+NC2qt8ieSTjsvVDSUikCvp
         WBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679259340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ac/NF/X3Ce1vR1hDDyKBTJ707og2BXuZP/lMQW+OCrs=;
        b=RfUHBESwgrWOmuUqjdHzIls9sKcrh0Jb+6fOjWsPXc7IGO8eNqnlnDONGs9V39ZrQ5
         CqKU8uO72LoUblNWqV9Gc11kp7UHLfL+BLU/cg09RL+2kN4j3mV47OsjdlPM9bgxVOGs
         I/HpRbaXw8mYe5LKVuLKenSP7xv5gsdA+AccEfDbTCM9uTPRF3A80EuVX6COCYUkhQj5
         xgaJeT6HVQFg8uM79WV5juRhY+wtbYsNqCA0EMIYnpUztCaqBwSLFfuG1st6z1ukVrJ9
         34k/p20Xti+TiYiJb3AmaEHxpnh2NtWM9SYGkzww4ekZyxz+1gD4tt/AJwLTMhoozLLb
         GUNQ==
X-Gm-Message-State: AO0yUKWVPyGTY4j/+2wxIgNVpOj+Pi2olFHEaqsy/2++qZPSWbVmkkmW
        ZZeeaNTqIFRfhXefkFkz9oRAiFGg1hLSk34a8UL26w==
X-Google-Smtp-Source: AK7set96jMMXsU1lpAmC3W40A6khl6vhFPSlLdYAPpPspd35ltaJhYbiXGg5BwG99gy+Dk9b8AqTCwMdTjF2Un45KI0=
X-Received: by 2002:a05:6902:110e:b0:b26:47f3:6cb with SMTP id
 o14-20020a056902110e00b00b2647f306cbmr3222772ybu.4.1679259340445; Sun, 19 Mar
 2023 13:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144721.1544669-1-robh@kernel.org> <CAMuHMdUaeyHs9fQxS+16F62uHaifJYMXKJpL2-xi-SL5HCrTHQ@mail.gmail.com>
 <CAMuHMdX1=+WwWjfiWDYOjSzTjcYBEY+QR=XKuU+o5_SCyU7rag@mail.gmail.com>
In-Reply-To: <CAMuHMdX1=+WwWjfiWDYOjSzTjcYBEY+QR=XKuU+o5_SCyU7rag@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 19 Mar 2023 21:55:29 +0100
Message-ID: <CACRpkdaw7TodD0hr3vD8cGB80k0qtEiaC1ne-ivCj6YEefi44w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Use of_property_present() for testing DT
 property presence
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh@kernel.org>, Sean Wang <sean.wang@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-renesas-soc@vger.kernel.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 12:00=E2=80=AFPM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Mar 13, 2023 at 10:00=E2=80=AFAM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Fri, Mar 10, 2023 at 3:56=E2=80=AFPM Rob Herring <robh@kernel.org> w=
rote:
> > > It is preferred to use typed property access functions (i.e.
> > > of_property_read_<type> functions) rather than low-level
> > > of_get_property/of_find_property functions for reading properties. As
> > > part of this, convert of_get_property/of_find_property calls to the
> > > recently added of_property_present() helper when we just want to test
> > > for presence of a property and nothing more.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/pinctrl/renesas/pinctrl.c
> > > +++ b/drivers/pinctrl/renesas/pinctrl.c
> > > @@ -125,8 +125,8 @@ static int sh_pfc_dt_subnode_to_map(struct pinctr=
l_dev *pctldev,
> > >          * inside a subnode nor across subnodes.
> > >          */
> > >         if (!pmx->func_prop_name) {
> > > -               if (of_find_property(np, "groups", NULL) ||
> > > -                   of_find_property(np, "pins", NULL)) {
> > > +               if (of_property_present(np, "groups")||
> > > +                   of_property_present(np, "pins")) {
> > >                         pmx->func_prop_name =3D "function";
> > >                         pmx->groups_prop_name =3D "groups";
> > >                         pmx->pins_prop_name =3D "pins";
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > This check is used to auto-detect if the standard property names
> > should be used, or the "renesas,"-prefixed ones.
> > As the last users of the latter were removed from DTS in v4.10,
> > perhaps I should just remove these checks instead?
>
> Sent a patch just doing that, so you can drop this chunk.
> https://lore.kernel.org/linux-renesas-soc/ff9c14781110bbf19b56b45dd1f01e6=
da90319ad.1678704441.git.geert+renesas@glider.be

So I need a new version of this patch before I can apply it
I guess, or there will be conflict with Reseas stuff?

Yours,
Linus Walleij
