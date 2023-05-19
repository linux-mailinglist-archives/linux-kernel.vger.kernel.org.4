Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF26170A2A6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjESWE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjESWEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:04:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FAEE4D;
        Fri, 19 May 2023 15:04:15 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-24e25e2808fso3509859a91.0;
        Fri, 19 May 2023 15:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684533854; x=1687125854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdZ68oUc3H7SB6Qm6IW5KKphTlw7I2zDsq2qS2mOj/8=;
        b=rYfgINwR3urYVNTEe+KfUUjGgM/8J8nTfMFyL08QMLuyg5zs1EbbsbAPaj1OFXdkbO
         B0r0s+IHkSozRPT246lSrZEX4mTJPLXXE3TpjM8Q24Xe293vRqXkzBXzHpDIdBJmCYDR
         tDrTarTEUclvu51G5Shm7r205D86m7XiCf8rqA1o+2AMpAasR92xJo57Z4MSxWVb8HTz
         P4iCkDVWUMMBhYtowdFNM0askwsFdnoY29Jm21D1KWQlvPZbd0nJyhSdbYVrkgf+QubP
         FEXpsqptoeuj8HIjwAe9Ljbl/PEgZmWMh9NNJrQ5k2M/gwBYf8qffKz1BIEqvyvdqa1S
         vSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684533854; x=1687125854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdZ68oUc3H7SB6Qm6IW5KKphTlw7I2zDsq2qS2mOj/8=;
        b=MdKG0uxD7Fp4Zi3719374pam7X3cI7MzLteNwn5wResTzKCLBIISa98c1n3mDrDaST
         6rFFVRYNSnOJjWSD9VbE/djyeJxSJgbSUPCIf/xQgx7wCRPWLz6c3XLL50hU54Kcr0Am
         KMOxBJcAgTdsRae7szOcDgNrgut8ux3NhyDI9/UIiy9oNI+ZNgOgroqO2ktzJgc08Cdn
         pix743uw8SLPJsZgqozUD8c76O9NIQ9d/caGsLiVwHWYCB102J38dqM722Kq6KGwqRBs
         yJOPdrvHaNBBbk5kGgQBNO4iYYe0AFs1w3gPhpRFLVSzk0OiIfDILVmLfbj3boCqRVHE
         U+TA==
X-Gm-Message-State: AC+VfDzq//51GARL9QVK87TGn4VOY/xJbUlzn01994ndj4Cv8B3wrxIw
        BhhrTZEjjUQRRoubMLPdlE0Ksf34LKOVLRTU6MsCXOhN
X-Google-Smtp-Source: ACHHUZ7Huu5zh0PplEq4pYaCX5efGavs4vWgv29aBI63xl0HIs0/bUcafgDG52nAQM3MspUvXzLAAoEw0xbxmVWO9yE=
X-Received: by 2002:a17:90a:4ce5:b0:24e:3bb3:ea0c with SMTP id
 k92-20020a17090a4ce500b0024e3bb3ea0cmr3364626pjh.10.1684533853854; Fri, 19
 May 2023 15:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230506195325.876871-1-aford173@gmail.com> <CAHCN7xLfh6Ttoi29d6Vn1Hw75GEA8hd-XGec08ofeC176thkPg@mail.gmail.com>
In-Reply-To: <CAHCN7xLfh6Ttoi29d6Vn1Hw75GEA8hd-XGec08ofeC176thkPg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 19 May 2023 17:04:01 -0500
Message-ID: <CAHCN7xKHHKQgjtzS+KSHE9w++_udRJ1PRVcse=rD6-tZGVGcdQ@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: composite-8m: Add imx8m_divider_determine_rate
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Abel Vesa <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 10:03=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
>
> On Sat, May 6, 2023 at 2:53=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
> >
> > Currently, certain clocks are derrived as a divider from their
> > parent clock.  For some clocks, even when CLK_SET_RATE_PARENT
> > is set, the parent clock is not properly set which can lead
> > to some relatively inaccurate clock values.
> >
> > Unlike imx/clk-composite-93 and imx/clk-divider-gate, it
> > cannot rely on calling a standard determine_rate function,
> > because the 8m composite clocks have a pre-divider and
> > post-divider. Because of this, a custom determine_rate
> > function is necessary to determine the maximum clock
> > division which is equivalent to pre-divider * the
> > post-divider.
> >
> > With this added, the system can attempt to adjust the parent rate
> > when the proper flags are set which can lead to a more precise clock
> > value.
> >
> > On the imx8mplus, no clock changes are present.
> > On the Mini and Nano, this can help achieve more accurate
> > lcdif clocks. When trying to get a pixel clock of 31.500MHz
> > on an imx8m Nano, the clocks divided the 594MHz down, but
> > left the parent rate untouched which caused a calulation error.
> >
> > Before:
> > video_pll              594000000
> >   video_pll_bypass     594000000
> >     video_pll_out      594000000
> >       disp_pixel       31263158
> >         disp_pixel_clk 31263158
> >
> > Variance =3D -236842 Hz
> >
> > After this patch:
> > video_pll               31500000
> >   video_pll_bypass      31500000
> >     video_pll_out       31500000
> >       disp_pixel        31500000
> >         disp_pixel_clk  31500000
> >
> > Variance =3D 0 Hz
> >
> > All other clocks rates and parent were the same.
> > Similar results on imx8mm were found.
> >
>
> Peng / Abel,
>
> I was curious if either of you might have time to review this attempt
> at enabling determine_rate on the 8m's.  I tested this on the 8mm,
> 8mn, and 8mp, and found no regressions.

Gentle nudge.

It's been several weeks since the initial post and the DSI driver is
now available for Mini and Nano, so having this in Mini and Nano will
really help it sync various video sources.

thanks,

adam

>
> adam
> > Fixes: 690dccc4a0bf ("Revert "clk: imx: composite-8m: Add support to de=
termine_rate"")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V2:  Fix build warning found by build bot and fix prediv_value
> >      and div_value because the values stored are the divisor - 1,
> >      so we need to add 1 to the values to be correct.
> >
> > diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-c=
omposite-8m.c
> > index cbf0d7955a00..7a6e3ce97133 100644
> > --- a/drivers/clk/imx/clk-composite-8m.c
> > +++ b/drivers/clk/imx/clk-composite-8m.c
> > @@ -119,10 +119,41 @@ static int imx8m_clk_composite_divider_set_rate(s=
truct clk_hw *hw,
> >         return ret;
> >  }
> >
> > +static int imx8m_divider_determine_rate(struct clk_hw *hw,
> > +                                     struct clk_rate_request *req)
> > +{
> > +       struct clk_divider *divider =3D to_clk_divider(hw);
> > +       int prediv_value;
> > +       int div_value;
> > +
> > +       /* if read only, just return current value */
> > +       if (divider->flags & CLK_DIVIDER_READ_ONLY) {
> > +               u32 val;
> > +
> > +               val =3D readl(divider->reg);
> > +               prediv_value =3D val >> divider->shift;
> > +               prediv_value &=3D clk_div_mask(divider->width);
> > +               prediv_value++;
> > +
> > +               div_value =3D val >> PCG_DIV_SHIFT;
> > +               div_value &=3D clk_div_mask(PCG_DIV_WIDTH);
> > +               div_value++;
> > +
> > +               return divider_ro_determine_rate(hw, req, divider->tabl=
e,
> > +                                                PCG_PREDIV_WIDTH + PCG=
_DIV_WIDTH,
> > +                                                divider->flags, prediv=
_value * div_value);
> > +       }
> > +
> > +       return divider_determine_rate(hw, req, divider->table,
> > +                                     PCG_PREDIV_WIDTH + PCG_DIV_WIDTH,
> > +                                     divider->flags);
> > +}
> > +
> >  static const struct clk_ops imx8m_clk_composite_divider_ops =3D {
> >         .recalc_rate =3D imx8m_clk_composite_divider_recalc_rate,
> >         .round_rate =3D imx8m_clk_composite_divider_round_rate,
> >         .set_rate =3D imx8m_clk_composite_divider_set_rate,
> > +       .determine_rate =3D imx8m_divider_determine_rate,
> >  };
> >
> >  static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw)
> > --
> > 2.39.2
> >
