Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBA372CB15
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjFLQLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFLQLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:11:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ADB1A5;
        Mon, 12 Jun 2023 09:11:33 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-543ae674f37so2359785a12.1;
        Mon, 12 Jun 2023 09:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686586292; x=1689178292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIiNp/+XnyYlFBhx16pJwnV+pMJsdKM6JDpF0smN2gs=;
        b=F44Q+3WTqR3Bl1u8BnHfFuJt+/g9Jsl4jsZOGfD1UgeN9naLB1TcSqIyOT9ZUm4lEy
         V1MFxJk04D7y3h5G+xUO0TV13T6bQE07WcnGtJydU3G36ErmxevlXF7oa1PPiLJ9pSJZ
         dIwr5wtozJ3mkxO+GY0qPF4bNe+hR4Jql/pw4gnVkIHsS/KfCk2p37yOd7tKoY7rTVoj
         xaeQbwaOj6KQpeKm3VIQwBL0+paQWbmIADJLL3kBqA+tuK3+ibIJD+WTPz1/Tmv0fIJN
         d7k8CcwRn5QO8kJEslBrQ24Z0Y1oh1ts2nOFEI23qddUni7p94gNRanxAC5rzxvrMGO1
         iwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686586292; x=1689178292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIiNp/+XnyYlFBhx16pJwnV+pMJsdKM6JDpF0smN2gs=;
        b=E/NUGSoFtJk+UOcikGW/rXwHeAgf6TUxGiWIEEelA5CRS1S09fAPOB+Yhl6yCF9q6Q
         xdE+mDFOpXa04vr7/0OlTNA3j4AHAJsPC25l+9eG0xb3gk55/5I9CdYzOQGYrRsUstTy
         x4AuIGKWG8es8fDsXDvnl9kJIXdejhjLoYnPGfp6BPAeMbCfp+DxiEiTxfCC4/wNi6RN
         jHrWRaXw8OF23kaquQEjyAtPuXbxoDLG8dNuCnexR6D7iXBHnO1MfO9MHfEOao77XuxL
         8M4Ak+eNoKnNidEAiH1KsoUzbXDp2M3grVNHXgTyY1VNhroEXAzl58A1wLTOpn/8j0vk
         7fKg==
X-Gm-Message-State: AC+VfDybqOYNFe+onoJLqs/iRityWTNfdBM8ydvrkmLJ5+RBAChzjECZ
        wYpktuzGJM7eVOoMYJHvDUtmPdlFwlFuep1aVis=
X-Google-Smtp-Source: ACHHUZ7WLTrxppr7vC0si1shhvGOTg9CsAODLt3Q5C+PKf5QhoiQABoz12Hw5WHk7+8ABCq4Uqy9EyZvuzv1lhcl7BQ=
X-Received: by 2002:a17:90b:4b91:b0:258:c780:479e with SMTP id
 lr17-20020a17090b4b9100b00258c780479emr8073092pjb.13.1686586292374; Mon, 12
 Jun 2023 09:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230506195325.876871-1-aford173@gmail.com> <CAOMZO5AwixYybR1am=V4m1AnTkum+0Wn0xegU_y6Po9Y--G0mA@mail.gmail.com>
 <CAHCN7xLPKa2hrBMC1kaJkxVL9NC+c1TWgcQHMBPefnvxGPTCwQ@mail.gmail.com> <jlcpkn3pewnvdpugwmsrb277u4fzcns5eodnoxhlbkwtaf7pyc@u6vozmm7zl62>
In-Reply-To: <jlcpkn3pewnvdpugwmsrb277u4fzcns5eodnoxhlbkwtaf7pyc@u6vozmm7zl62>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 12 Jun 2023 11:11:21 -0500
Message-ID: <CAHCN7xKuvkBHuDBiprsXg3hX+P6Y+ciKSZMcauU=5Y-REwjE=A@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: composite-8m: Add imx8m_divider_determine_rate
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
        aford@beaconembedded.com, Abel Vesa <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
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

On Mon, Jun 12, 2023 at 11:08=E2=80=AFAM Maxime Ripard <maxime@cerno.tech> =
wrote:
>
> On Sun, Jun 11, 2023 at 12:02:42PM -0500, Adam Ford wrote:
> > On Tue, Jun 6, 2023 at 1:45=E2=80=AFPM Fabio Estevam <festevam@gmail.co=
m> wrote:
> > >
> > > On Sat, May 6, 2023 at 4:53=E2=80=AFPM Adam Ford <aford173@gmail.com>=
 wrote:
> > > >
> > > > Currently, certain clocks are derrived as a divider from their
> > > > parent clock.  For some clocks, even when CLK_SET_RATE_PARENT
> > > > is set, the parent clock is not properly set which can lead
> > > > to some relatively inaccurate clock values.
> > > >
> >
> > + Maxime
> >
> > > > Unlike imx/clk-composite-93 and imx/clk-divider-gate, it
> > > > cannot rely on calling a standard determine_rate function,
> > > > because the 8m composite clocks have a pre-divider and
> > > > post-divider. Because of this, a custom determine_rate
> > > > function is necessary to determine the maximum clock
> > > > division which is equivalent to pre-divider * the
> > > > post-divider.
> > > >
> > > > With this added, the system can attempt to adjust the parent rate
> > > > when the proper flags are set which can lead to a more precise cloc=
k
> > > > value.
> > > >
> > > > On the imx8mplus, no clock changes are present.
> > > > On the Mini and Nano, this can help achieve more accurate
> > > > lcdif clocks. When trying to get a pixel clock of 31.500MHz
> > > > on an imx8m Nano, the clocks divided the 594MHz down, but
> > > > left the parent rate untouched which caused a calulation error.
> > > >
> > > > Before:
> > > > video_pll              594000000
> > > >   video_pll_bypass     594000000
> > > >     video_pll_out      594000000
> > > >       disp_pixel       31263158
> > > >         disp_pixel_clk 31263158
> > > >
> > > > Variance =3D -236842 Hz
> > > >
> > > > After this patch:
> > > > video_pll               31500000
> > > >   video_pll_bypass      31500000
> > > >     video_pll_out       31500000
> > > >       disp_pixel        31500000
> > > >         disp_pixel_clk  31500000
> > > >
> > > > Variance =3D 0 Hz
> > > >
> > > > All other clocks rates and parent were the same.
> > > > Similar results on imx8mm were found.
> > > >
> > > > Fixes: 690dccc4a0bf ("Revert "clk: imx: composite-8m: Add support t=
o determine_rate"")
> > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > >
> >
> > Peng / Abel,
> >
> > Any suggestions on how we can move this forward?  Looking at the
> > clk-composite-8m driver, imx8m_clk_composite_compute_dividers uses the
> > max values which is basically what my patch does.  There was some
> > discussion about making determine_rate mandatory for muxes[1] and this
> > patch should help with this in addition to making it easier to sync
> > more video resolutions on the 8m Mini and Nano.
>
> Those patches have been queued by Stephen for 6.6 :)

One of the patches in the older series was reverted, but this was to
address the patch that was reverted.

adam
>
> Maxime
