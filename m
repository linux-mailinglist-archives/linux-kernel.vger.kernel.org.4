Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922A370D254
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjEWDXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjEWDXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:23:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3936BF;
        Mon, 22 May 2023 20:22:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25355609a04so5251314a91.0;
        Mon, 22 May 2023 20:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684812178; x=1687404178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flrKSz8wj7uBPovX7y+XUIJRT3fF/6yUn+0B3i6QKLQ=;
        b=qMRvLgPaqR4txaUrf5nU0xI9zLcmfjZV20W9G7tOlAJnOALWFU4kZaBYjLUfsXWr6/
         8WywItsot2a3wd3NETDp9+VWK7bH44iinPMenyhjnWtg1yFy43h+u/6H1LjaRKftURic
         JE4vdmXHvnSplemzQOzwkwi0pP7uBWLi7LavbDwCcJZYHLz4ZXmRx3/5pf+46dqSXl4b
         QSFkb6go880G+6On5eeUkiAwqT244pRa4Jzg/O3EBbZj4nthNgS9qOHxxyw9D2B1LA6q
         y8JBFOzeKTh6a+pLfEI6LhpLyAC2O7skz0z433pP10qaDtpSpx6DdqVJOvZS5hND7pW5
         csSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684812178; x=1687404178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flrKSz8wj7uBPovX7y+XUIJRT3fF/6yUn+0B3i6QKLQ=;
        b=OvZxGwVri16jXCzfdn1p1CO8c89uRYPzBEWjOa0mjMmG2Hb5KcVdgX8CNNblx1EmSn
         Bo4ZtEZmDUGAIZpnwb/7u4a9hmbTyLCOJ3cj84RzRvl6NhhSuEWRwH6CaxCZnGdIYlcX
         J3zRZd1cpXvEdNwRxP1QjsRYvTA/iD/KH3EKxu1uMDIe8CIxyQnYvowo7LLiT+WinASu
         tTc8KZVg6/xb0HuK4H2lXQT+bQW6E9Nkg9zSld+NUQoHUSxMvCC1FaEejTXNV05TeQGQ
         WrR/Nx5ZhEAe4FBGimfGJsKkYxrzbWpYgIqKCAqGT4KIdCUx72+fHxQMaH4/Me9zaJ+5
         Qf8Q==
X-Gm-Message-State: AC+VfDwcH1G2PkaadvNqF5mbHCBcje4gVHszFp9gWvHSburddmtj2QuX
        cUkztjuar+tthIpYhoxUiXLRk6uvTH/yDz0EyJA=
X-Google-Smtp-Source: ACHHUZ7z1WDZBaYSaTHU5IxjZOGjsVGkql682gndzZa3dcPcYMqiCcl4QqztD/zczGZbTNK4uUXOIa7CHSy497kFm/M=
X-Received: by 2002:a17:90a:5303:b0:24e:4b1c:74d2 with SMTP id
 x3-20020a17090a530300b0024e4b1c74d2mr12181474pjh.32.1684812178107; Mon, 22
 May 2023 20:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230506195325.876871-1-aford173@gmail.com> <02e4e072-a2bb-8455-304d-49552ce9c866@oss.nxp.com>
In-Reply-To: <02e4e072-a2bb-8455-304d-49552ce9c866@oss.nxp.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 22 May 2023 22:23:16 -0500
Message-ID: <CAHCN7x+pFM7_yAWxVaUCKyLQ1A_5-F4sQ_t2k2iug7DdD9PwmQ@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: composite-8m: Add imx8m_divider_determine_rate
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     linux-clk@vger.kernel.org, aford@beaconembedded.com,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
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

On Mon, May 22, 2023 at 9:33=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.com> wro=
te:
>
>
>
> On 5/7/2023 3:53 AM, Adam Ford wrote:
> > Caution: This is an external email. Please take care when clicking link=
s or opening attachments. When in doubt, report the message using the 'Repo=
rt this email' button
> >
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
>
> Not all clocks has pre/post div both.
>
> If CLK_SET_RATE_PARENT not set, would there be any issues for
> other clocks?

I did a dump of the clk_summary for Mini, Nano and Plus, and I found
no changes to any clock other than the video_pll, and most of the
clocks do not have CLK_SET_RATE_PARENT set, so from what I could tell
it seemed harmless.

>
> Regards,
> Peng.
>
> >
> > Before:
> > video_pll              594000000
> >    video_pll_bypass     594000000
> >      video_pll_out      594000000
> >        disp_pixel       31263158
> >          disp_pixel_clk 31263158
> >
> > Variance =3D -236842 Hz
> >
> > After this patch:
> > video_pll               31500000
> >    video_pll_bypass      31500000
> >      video_pll_out       31500000
> >        disp_pixel        31500000
> >          disp_pixel_clk  31500000
> >
> > Variance =3D 0 Hz
> >
> > All other clocks rates and parent were the same.
> > Similar results on imx8mm were found.
> >
> > Fixes: 690dccc4a0bf ("Revert "clk: imx: composite-8m: Add support to de=
termine_rate"")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V2:  Fix build warning found by build bot and fix prediv_value
> >       and div_value because the values stored are the divisor - 1,
> >       so we need to add 1 to the values to be correct.
> >
> > diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-c=
omposite-8m.c
> > index cbf0d7955a00..7a6e3ce97133 100644
> > --- a/drivers/clk/imx/clk-composite-8m.c
> > +++ b/drivers/clk/imx/clk-composite-8m.c
> > @@ -119,10 +119,41 @@ static int imx8m_clk_composite_divider_set_rate(s=
truct clk_hw *hw,
> >          return ret;
> >   }
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
> >   static const struct clk_ops imx8m_clk_composite_divider_ops =3D {
> >          .recalc_rate =3D imx8m_clk_composite_divider_recalc_rate,
> >          .round_rate =3D imx8m_clk_composite_divider_round_rate,
> >          .set_rate =3D imx8m_clk_composite_divider_set_rate,
> > +       .determine_rate =3D imx8m_divider_determine_rate,
> >   };
> >
> >   static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw)
> > --
> > 2.39.2
> >
