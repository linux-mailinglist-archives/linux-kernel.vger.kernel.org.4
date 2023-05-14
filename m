Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6A5701B80
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 06:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjENEXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 00:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjENEXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 00:23:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9291BEF;
        Sat, 13 May 2023 21:23:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so78945275ad.3;
        Sat, 13 May 2023 21:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684038196; x=1686630196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Zp/9b1VdAA+ssxLZiJ214NeBi4l5ENlrua84d31TRE=;
        b=Ws5yoXtKXitkR4CaOcAY9yc/0aTpRh4kKmOJk136xWrNsQEUenYsQ7mq+ryskdmPNd
         i/93nQAgqG/kSOuV8Joiaort3uJaaOxGf1N2uFLuSJiswyT/zsadBiAyYDUQibSikicy
         wkqGYP/QATH4LqMAXjjNYlOe3vapJihCVzYW5e9M/srHkdp0CBfGSWemrDxuWM5Pfc2V
         E0WTJSwA9DOsqZlF8Q8R0DIWBO3oqEellqGkrcpzGlTyi/AYhTgWAiu6iZcLWyStdcM2
         JFPwtuRt3XNKIMJ0WpHeWmZxbtW7JIvTCD5xlNiFNFHJehliFDqH27qAjMsavaxZr2EA
         iDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684038196; x=1686630196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Zp/9b1VdAA+ssxLZiJ214NeBi4l5ENlrua84d31TRE=;
        b=fS9pKzu5G65gz56FChlyesieoJqyU+p4GLuZE1gKkbFu9SOelawDzA5VYwWllrENQm
         NWP2yzqTGPC0l0WFFXreUhHfptFk6tmqqIlf0e46rKsynjBlLjZ9HZzIx7MbOSOi02HM
         v+O1lheiSNhKVPw+U5XuWuoXZdNFCKDVQvQdQO8TS1oeGG2QXD7kNTMQMmtJ7KxBynWY
         ahG+eG1gqHrvet5R5/A8/rUU9k5knzl3rfDx+UXz2a/AnnRYu79kGvR9TvTCrycR9gBd
         FS5WTBlDS6lAWCh/WiDmPaK7LCvRrVgAO2h90YpXvwpgTb6UNgblxxittQC/RuQ01Jpp
         LlCw==
X-Gm-Message-State: AC+VfDwgjy8z3ec1s5BGmCQnzqZviFIaeo8A6DBf82bdE96KH1LiwTzm
        aaqnRAc5qvkbzd8vHgnRvZ6JB2EMua9tSrXuk823b0aC
X-Google-Smtp-Source: ACHHUZ7EtQOkRCTkq9y0VkJ8t4dAlWdtQLc+ji3+/piFv76tw7DzYFrZK0ExHLZ1ECIiAqyumi83LmCgY9CvaS5VHWE=
X-Received: by 2002:a17:903:484:b0:1ab:267e:2f2d with SMTP id
 jj4-20020a170903048400b001ab267e2f2dmr28549605plb.48.1684038195944; Sat, 13
 May 2023 21:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230423123513.1346323-1-aford173@gmail.com> <20230514035806.GR727834@dragon>
In-Reply-To: <20230514035806.GR727834@dragon>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 13 May 2023 23:23:04 -0500
Message-ID: <CAHCN7x+evo1mJaBUdx5pe5rnG2A8dkmf4myXJcK7mas7nZMwxg@mail.gmail.com>
Subject: Re: [PATCH V2] arm64: dts: imx8mn: Fix video clock parents
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, May 13, 2023 at 10:58=E2=80=AFPM Shawn Guo <shawnguo@kernel.org> wr=
ote:
>
> On Sun, Apr 23, 2023 at 07:35:13AM -0500, Adam Ford wrote:
> > There are a few clocks whose parents are set in mipi_dsi
> > and mxsfb nodes, but these clocks are used by the disp_blk_ctrl
> > power domain which may cause an issue when re-parenting, resuling
> > in a disp_pixel clock having the wrong parent and wrong rate.
> >
> > Fix this by moving the assigned-clock-parents as associate clock
> > assignments to the power-domain node to setup these clocks before
> > they are enabled.
> >
> > Fixes: d825fb6455d5 ("arm64: dts: imx8mn: Add display pipeline componen=
ts")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Is it a fix for v6.4-rc or material for -next?

The Samsung DSI driver for Nano is in 6.4, and an attempt was made to
setup the device tree in 6.4.  While I don't think there are users of
this yet, if people try to add DT entries in their boards, they might
struggle getting the video working if this isn't applied since the
disp1_pix clock may be stuck at 24MHz which likely won't sync much if
any displays.

adam
>
> Shawn
