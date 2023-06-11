Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A10572B2F0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 19:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjFKRC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 13:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFKRCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 13:02:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD046E63;
        Sun, 11 Jun 2023 10:02:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2565a9107d2so2156160a91.0;
        Sun, 11 Jun 2023 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686502974; x=1689094974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoCFwrEB0vvlfmLLlOSHa+piSHoEJ5gC+VXcVkiTQ0k=;
        b=krayJ6uwWRTtbE+7Im6rE8BILvjlU83+RJsF2E+i5TO24DrKvzg4cLPYe6UAVudvJ8
         Be2XUpr50dZfqxq+LOLvv9voaaTYvIsg6bkamBtggLW6ii/ugONs6LrjqwErtfpqOTZa
         PiwTlhvtsVOkTwGOF95n9BTuGmVuZ/MJq/BI0R7GDa/sBKqzfdgtfXydrZvP3/bSh3u+
         0SQ3KVrZjregxi2kG0glbTc0ncBKCVBt96zHMk/rfQELMGG2OuroUJPWcS7u2VpQfCpu
         rqn2MzxuGIhhukFWNxv8pKJQVHYExePFXwlDLZAHqGcqOa0kTkw7dis8k8fXXqDk+HNd
         VrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686502974; x=1689094974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoCFwrEB0vvlfmLLlOSHa+piSHoEJ5gC+VXcVkiTQ0k=;
        b=cLxtBtVvbT+KYE7u6g+mKG2Re60ZMiS/vmpxv2falcbPESBqjXXfkwAVM6fq81BNZN
         GqUT233km3758bdAeGduHwBpdi1aQjNA9Qb7ORN3eK6Ellm0khzlO5KX6OHBdZf+xHbM
         mk9k1L6PXb7HUd9v2fXUaH80JPdz9ZE/Dgk+UtecgPJmzVCutGZfzFq5kfarHtSJUGQm
         sOj9CAwJcLxPVyj8MpPEnbAY1fGU+LEmKOqrj+bG08M4Oi1p0JNAWvHMjG+lLZrW3+b6
         Q27cIbQq2RedKz0vbsRfJ4b5Q2ZqYKnoWfqbDsQUdD+g3P/nGmploh2PUwsjYhTKIZAt
         dKKA==
X-Gm-Message-State: AC+VfDwoPaeqrytsT1Qb+ADCsUfrcpnuCysK4vSaj5Fe0YTwnPqa/t/+
        uRsWlavSNOtwY5zXePUDGHptTCrlft7hDb7X/VI=
X-Google-Smtp-Source: ACHHUZ7l+4TR3OHAvJEjzr3koYOCUElOXrpQlwUfhbtqoGZqePk86Nn0jhaQ0PWxIazQbuM4n3xcpXjQwvLY4Nidj6c=
X-Received: by 2002:a17:90a:7565:b0:25b:ba0c:ab7c with SMTP id
 q92-20020a17090a756500b0025bba0cab7cmr3444582pjk.27.1686502974159; Sun, 11
 Jun 2023 10:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230506195325.876871-1-aford173@gmail.com> <CAOMZO5AwixYybR1am=V4m1AnTkum+0Wn0xegU_y6Po9Y--G0mA@mail.gmail.com>
In-Reply-To: <CAOMZO5AwixYybR1am=V4m1AnTkum+0Wn0xegU_y6Po9Y--G0mA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 11 Jun 2023 12:02:42 -0500
Message-ID: <CAHCN7xLPKa2hrBMC1kaJkxVL9NC+c1TWgcQHMBPefnvxGPTCwQ@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: composite-8m: Add imx8m_divider_determine_rate
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-clk@vger.kernel.org, aford@beaconembedded.com,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
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

On Tue, Jun 6, 2023 at 1:45=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> On Sat, May 6, 2023 at 4:53=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
> >
> > Currently, certain clocks are derrived as a divider from their
> > parent clock.  For some clocks, even when CLK_SET_RATE_PARENT
> > is set, the parent clock is not properly set which can lead
> > to some relatively inaccurate clock values.
> >

+ Maxime

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
> > Fixes: 690dccc4a0bf ("Revert "clk: imx: composite-8m: Add support to de=
termine_rate"")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>

Peng / Abel,

Any suggestions on how we can move this forward?  Looking at the
clk-composite-8m driver, imx8m_clk_composite_compute_dividers uses the
max values which is basically what my patch does.  There was some
discussion about making determine_rate mandatory for muxes[1] and this
patch should help with this in addition to making it easier to sync
more video resolutions on the 8m Mini and Nano.

adam
[1] - https://www.spinics.net/lists/alsa-devel/msg157914.html


> This works fine on my imx8mm-evk, so:
>
> Tested-by: Fabio Estevam <festevam@gmail.com>
