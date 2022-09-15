Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53225B9F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIOPtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiIOPts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:49:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC4D13F00;
        Thu, 15 Sep 2022 08:49:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id y11so1250814pjv.4;
        Thu, 15 Sep 2022 08:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=o8GIMFSFfJaC+NseNm4sPm6vviClb1WTiOKE9g6u8d0=;
        b=Kpb4UPsyc0fBVJ1kG8S0WqzJBoKaa0B0H4jZg2t5WRgA5DK0eem2whcmCniUqCAhze
         M4BMsNzAKvR12z9CTEwk046L8BqoPCrCt+S7i3rNECUmvWiRzaQJESAvYfSoQ4CtKSLR
         XZuUIXijfiAfM4syb6THz0NNKlyV0zjM7H/hAWwAOZp6UqvpgZn+QJEEs2xwc5H7LVSz
         87KBcABZUDOufMToZFbqYjj50T7bh8YAkVoPYCT5NnuUE/CGlydVy3n5G0nQrrw3xTqv
         YYeAyjpwTHedndwxgNcrZxCJ4OUbl57ohiu2V4vD4lYgOHP8mw27/Jk3aHUNDX40kIsa
         D6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=o8GIMFSFfJaC+NseNm4sPm6vviClb1WTiOKE9g6u8d0=;
        b=n3FsSqaao5Rj2i1sFIsYMGXT5Q137uRCPt1ACesLtXyZm9F0r7REBueuzsSZlvYcP4
         GkAUQVR6twhsVeN7JusjGIW4pkosnI5cb2zqetglDRAFJXbUW+g6PhjY3hdddGDevWl6
         J2lBcVFW91dhgPMYVA8A3UtUR66NlIWcwMYKeIOnGqfP/UJ4N5Izh47/FK1kPpfiq5yw
         fbvpMOvZpgy87+zAVI6L5+UJaM9YPjVV1Ywwr9BlNgL4f6RLLVF0RcMA7DLwvUiIDN5V
         CXw7xk0h2eyAQFGlsEgrt45HW6awRGBXrdlbMq+toR1k8mlyBnrlXS5ZywBLqNng1k1r
         Gx0A==
X-Gm-Message-State: ACrzQf3tVt/O+WiLkGxsfB1DiPSl0DAcyZsXh+OcSOBaeW/cxAcSAJoZ
        CUiDBpFa9DZSA28qZxYVZBr8CxVtEsZ3Rvc78Ek=
X-Google-Smtp-Source: AMsMyM4wChBybAsL7iXfbCcR1cc7DTRSZVNv+umTCL/5uSKEZkSGTle1Cc9DUNgAD8N2inzbz5TuUu+5890Jpf7iGXI=
X-Received: by 2002:a17:902:f782:b0:173:1206:cee0 with SMTP id
 q2-20020a170902f78200b001731206cee0mr96463pln.130.1663256986323; Thu, 15 Sep
 2022 08:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220915150959.3646702-1-han.xu@nxp.com>
In-Reply-To: <20220915150959.3646702-1-han.xu@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 15 Sep 2022 12:49:34 -0300
Message-ID: <CAOMZO5CPLUCdxrZa7T8E=ic8WN_sAKZbNZZdTaGQ-1ZZ9pJBVA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: imx: imx6sx: remove the SET_RATE_PARENT flag for
 QSPI clocks
To:     Han Xu <han.xu@nxp.com>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:NXP i.MX CLOCK DRIVERS" <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 12:10 PM Han Xu <han.xu@nxp.com> wrote:
>
> There is no dedicate parent clock for QSPI so SET_RATE_PARENT flag
> should not be used. For instance, the default parent clock for QSPI is
> pll2_bus, which is also the parent clock for quite a few modules, such
> as MMDC, once GPMI NAND set clock rate for EDO5 mode can cause system
> hang due to pll2_bus rate changed.
>
> Fixes: f1541e15e38e ("clk: imx6sx: Switch to clk_hw based API")
> Signed-off-by: Han Xu <han.xu@nxp.com>

Tested-by: Fabio Estevam <festevam@denx.de>
