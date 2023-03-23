Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4516C7343
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjCWWor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjCWWon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:44:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79FE2C660;
        Thu, 23 Mar 2023 15:44:42 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w4so248639plg.9;
        Thu, 23 Mar 2023 15:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679611482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX7i4P/cWmqUniG+8xL8cNI3XhCF093RCNESzVKDb0A=;
        b=dQkLuYEpa7s0h3TaUBxv9m6Ucygj+a8FsX5lzpXeuoN9PL511lSHsNaZiabf6OtQQb
         qp+W0ks0GLvi0vHVHE7e5dU9e/vlkks3ModBfGTjAAAlCiB4GVfeEromMn+idenPZtez
         aeL9urERSfmMY9Hqvngprt4PxPPvzduzWaIOpQIxg0Jv0K53UwRUHnpeIn2+k+CkSkYG
         +NZiNRy2/JYZRFHEeumFdL+8AefFaQSWCL3xTezzgid27GGou97db6FlBtqKU9LDLMzQ
         k/He3D5JsaNT5vM3UJoenWHbjlbg8EMaH6WogJpCRtpLlCjak8YY2MaCNOy/r1YKeIwN
         np3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679611482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rX7i4P/cWmqUniG+8xL8cNI3XhCF093RCNESzVKDb0A=;
        b=mIqIvjh4wx48jba4B6psHZcmCPlSSNJmPu7Y95OXqNqOz+WQ+QjLnXZKOkC4qIqBU/
         HBIT9m4XqHYhhKdyWSyOD8A7qqGNh7tG+hTDPF3RETXhDQeJmrFpga1zmVJiWfRg+PjX
         HEo5lfDDQ9wqcFRR22UTKrnTjgNdaEEiFLNKo+ESva/dL9Rb3ggZTpWsfgrYTdBQrOo6
         FnSXCcDSnCdXZZ1YO968VWZ78i3cnB5MMrgCoTiRahRQJLN+pJd1UnBP88/e9r2IL2Vy
         VjObc14xiKcZx/RBKYH7RlEhMH01a7R4h/rrclBtxSpvH2p9sPRobhLnI05x1L8YfDbj
         V/Sg==
X-Gm-Message-State: AAQBX9fENcXRaEisNjrVb1wFRw6yth+XcDJyFFmN4r4rNJn0APe4Yj28
        hoL2T8FgfZWKHU5dT3rqyV3M18b+7Z9D8o1LaFQ=
X-Google-Smtp-Source: AKy350YSQ6Kedkw3gldGNpnVngrHkVDCbGBsXqSGRU+NfAOtVC/H3Q90bGzTn4tNg16veyahxXbBq0a3bbfu+EgOekg=
X-Received: by 2002:a17:902:7881:b0:19a:fdca:e3f1 with SMTP id
 q1-20020a170902788100b0019afdcae3f1mr192688pll.3.1679611481962; Thu, 23 Mar
 2023 15:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230321023136.57986-1-aford173@gmail.com> <CAOMZO5B9odY1-EnKcAi=TQgzb5mwnPRXDtCdGNj+t=3wOyeAjw@mail.gmail.com>
In-Reply-To: <CAOMZO5B9odY1-EnKcAi=TQgzb5mwnPRXDtCdGNj+t=3wOyeAjw@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 23 Mar 2023 17:44:33 -0500
Message-ID: <CAHCN7xJaR=ORrRg=9S0sx8DKQpYdk_iU0_DwYwr_=QCEGi+GRA@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] clk: imx: Improve imx8mm/imx8mn LCDIF clocks
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-clk@vger.kernel.org, aford@beaconembedded.com,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 5:31=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Mon, Mar 20, 2023 at 11:31=E2=80=AFPM Adam Ford <aford173@gmail.com> w=
rote:
> >
> > Both the i.MX8M Mini and Nano have a video_pll which can be used
> > to source a clock which feeds the lcdif interface.  This interface
> > currently fixes video_pll and divides down the clock feeding LCDIF.
> > However, when connected to an HDMI bridge chip that supports a
> > variety of video resolutions and refresh rates, the only settings
> > that properly sync are ones that evenly divide from the video_pll_out
> > clock.
> >
> > This series adds the ability for the clk-compolsite-8m to
> > request a better parent clock rate if the proper clock flag is
> > enable and sets that flag in the corresponding imx8mm and
> > imx8mn video_pll clocks to increase the number of resolutions
> > and refresh rates timings that the LCDIF can produce.
> >
> > This also has a side benefit of allowing the video-pll to run
> > at a lower clock speed which can potentially save some power
> > depending on the requested resolution and refresh rate.
> >
> > V2:  Split off the new imx8m_clk_hw_composite_flags definition
> >      into its own patch and re-order to fix build error.
> >
> > Adam Ford (3):
> >   clk: imx: composite-8m: Add support to determine_rate
> >   clk: imx8mm: Let IMX8MM_CLK_LCDIF_PIXEL set parent rate
> >   clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate
>
> For the series:
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>
Thanks!

> Should drivers/clk/imx/clk-imx8mp.c also be adjusted in the same way?

The LVDS and the DSI clocks are shared from a common parent, so I am
not sure of the impact of this.  I have an IMX8MP and I have it
working with DSI->HDMI and the LVDS, but I was waiting on the DSI
series from Jagan to get applied first and I wanted to make sure this
series gets accepted before I started work on the 8MP.

I will be traveling to Thailand for the next 3 weeks, so I'm hoping to
review the 8MP when I return.

adam
