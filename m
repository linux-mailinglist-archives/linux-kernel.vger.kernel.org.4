Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352986F3377
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjEAQSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 12:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjEAQSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:18:02 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78402E4;
        Mon,  1 May 2023 09:18:00 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51f1b6e8179so1713994a12.3;
        Mon, 01 May 2023 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682957880; x=1685549880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qk+9QkkonRjQxXkPE3ppsEbfc37j1jKoaFU3DPo9GLo=;
        b=UZznBRMPjdb0UxnL0J5rsYVgsEDywc3ZLIjknqudXR4IO24FkAQn6QHq9HOJDqXzUf
         D0FhF8xqaKu2DPao4TkQqAV3Xn6F5zD+ohrsOLMc39LXmaZ8f1BcKEcdOq/9BYE7Umsu
         J1C4u3A/kpkHUHKqYstjvpZcj3iqsiqQgmtXA7Q2kWpBp5oRv3VheBVryQkrm8nmYkwf
         YEGbpAOsEeNzzzS0AT8EqDcRTIofl+1ZTlDGtwZe4HkayXE4tG4fZiDljEq3eQKvnyyP
         qcWN4LcG1MIqyV1BfRZM7xML8q2GIG+/f5bYOhErfGFQDJezDG83Yhr68hRGZpuG3gin
         Tf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682957880; x=1685549880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qk+9QkkonRjQxXkPE3ppsEbfc37j1jKoaFU3DPo9GLo=;
        b=E74G1I7k/v0cnWVof0re8c6quk3XdGObQex3T2CmucDilNLwiVFC1IDVRBt6yKb8GW
         oCQNmLbB6l3jVkHPuStykIeggFGQxomiOq4atQfLIgPnQCowQgIyqNMqjb+PlgRz/igt
         y6j2GeNr8K1q0R2KjGCev+KcvhlwxBMEbiHcsoqcBEHVqM0tEtsFW2tK0h1i59tXFxaQ
         VT4EuaAJgYgmqzcNshdCtC84Pz4RHf0FeQUhhnyvZFz6mIMXYxcP8lVjqLA1qHnAzP8d
         PoDsYZLSbcRCp2jUy2UfrP3yY+Bhi9gX+IyGGZyi3X1apka1AlgfMuKBuAjW5uIYxS/g
         6a5w==
X-Gm-Message-State: AC+VfDxY9OEU7uGZcEtRb91doYnj7HPyksyuEvvCIN3dG7Iz5AbMF5P2
        ZIal+S0yZrbyiPOrUILwgwxM91lrHOpUbuhsq9g=
X-Google-Smtp-Source: ACHHUZ4J0yGW5Pp7kdvK7YAjRQgLn/EdRmN2Ens4poOcMXDuiITwrbiSunLGNaJQTvrE+33RCSAqrcaHDzIWjtq7TIQ=
X-Received: by 2002:a17:90a:bc45:b0:24c:c75:2531 with SMTP id
 t5-20020a17090abc4500b0024c0c752531mr15257019pjv.37.1682957879849; Mon, 01
 May 2023 09:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230423123828.1346511-1-aford173@gmail.com> <DU0PR04MB9417FF20BEDB110DE49FB7F388679@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417FF20BEDB110DE49FB7F388679@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 1 May 2023 11:17:48 -0500
Message-ID: <CAHCN7x+A+=mYKLTX6JedQM=oBz=HmM=E_Sv5VxqWqyyjQeFDcQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "clk: imx: composite-8m: Add support to determine_rate"
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "aford@beaconembedded.com" <aford@beaconembedded.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Sun, Apr 23, 2023 at 8:43=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: [PATCH] Revert "clk: imx: composite-8m: Add support to
> > determine_rate"
> >
> > This reverts commit 156e96ff2172518b6f83e97d8f11f677bc668e22.
> >
> > This patch was found to cause some division issues on the i.MX8MP which
> > causes the video clocks to not properly divide when division was greate=
 than
> > 8.  This causes video failures on disp1_pix and disp2_pix clocks.
> >
> > Until a better solution is found, we'll have to revert this.
> >

Abel / Stephen,

Is there a way we can get this applied and put in for RC1?  When I
originally did this, I only tested with Nano and some brief testing
with Mini, but  it wasn't until I tested with Plus that I found
issues.

thanks

adam
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Indeed we already see issue in NXP local CI with the previous patch.
>
> Acked-by: Peng Fan <peng.fan@nxp.com>
>
> >
> > diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-
> > composite-8m.c
> > index 6883a8199b6c..cbf0d7955a00 100644
> > --- a/drivers/clk/imx/clk-composite-8m.c
> > +++ b/drivers/clk/imx/clk-composite-8m.c
> > @@ -119,17 +119,10 @@ static int
> > imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
> >       return ret;
> >  }
> >
> > -static int imx8m_clk_divider_determine_rate(struct clk_hw *hw,
> > -                                   struct clk_rate_request *req)
> > -{
> > -     return clk_divider_ops.determine_rate(hw, req);
> > -}
> > -
> >  static const struct clk_ops imx8m_clk_composite_divider_ops =3D {
> >       .recalc_rate =3D imx8m_clk_composite_divider_recalc_rate,
> >       .round_rate =3D imx8m_clk_composite_divider_round_rate,
> >       .set_rate =3D imx8m_clk_composite_divider_set_rate,
> > -     .determine_rate =3D imx8m_clk_divider_determine_rate,
> >  };
> >
> >  static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw)
> > --
> > 2.39.2
>
