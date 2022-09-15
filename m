Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F285B9CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIOOKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIOOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:10:20 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3627F12B;
        Thu, 15 Sep 2022 07:10:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id l65so18167138pfl.8;
        Thu, 15 Sep 2022 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZvbZ+uPDGtfELhlz8EprIDJKCOAE+6YrSNuARaSiQ60=;
        b=av/hQgpTDcsFs+Z8k5t2eaHxi3bGBOUsRyU0BLYKtdwXWMR3S3L9HR/AU75Zg2gQL2
         EDhVEZ/UnS5tpcNfkDJi4lITV670wrskyUdQCPvK+uloW+sgchaUt0F3HJxdvRCCc1Vn
         0NiNrA47CSxUr66dTCN+Fg3ORXLhZiaTrVsgYwz4WcbinEU+BaQnDMhtOAVWx7k9vfY4
         kI5JlK+QwEV9/adrYPgrdwzwAP9l8Vt/HG76FMngkVtS0YUdQt3oyrdTQWvDrIfa1+0u
         +xseOIMjz3VofGWz3g7xQuEyOT8SHGP1KA1qetkbUN31I3uQYP0ep2sZyo7QCXTcJ2b1
         BVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZvbZ+uPDGtfELhlz8EprIDJKCOAE+6YrSNuARaSiQ60=;
        b=E52qngSlGPsCBAmCwBeU6fPVC6lubDUE/jsQVDva/pJlUFtf6etl/iX5570TuY/MpR
         a8VKtacEEd/HFfQpUL35cjGXcQwoxt1BIMuxZN1SOzbApVHHTu8sol0Q+LFowKNb64pP
         6effi6Kq7APuIbEHIZUSSDmQfzcAGiYU16dTa4f7Gm7bEyGOSocoT71yYt1S/YYEO4pF
         Jthcwh3dKAzpBPWTNZDiHKQ8cuW/GBK+uv9GYtaeJjTWg3N4BP3wxY5eVC+HRZ8FES8V
         5LV3dnZmDm0ms6x1TMZpgMK9K+9X1TcJ4jr/7a5jW/gOOg/9HJFMbG9paDzNGD4cAVkx
         9+9Q==
X-Gm-Message-State: ACrzQf2QBBpCwCoKv3FVmDLvdHr5rkb7Lg3peTzMg2UhWXlLlyoFtMbz
        uX74JoUggNKZFtp3d24L4YGloB9M4bIGviq6Mfs=
X-Google-Smtp-Source: AMsMyM7URSulhQIaqX+CGpMlGSVONRaTeXhuXJ/2zWvENhJ1JJWqDIXOwQwa+fQw4ZasPYWRztjlKYSHx8KfaVrTZ10=
X-Received: by 2002:aa7:915a:0:b0:549:e8ac:c933 with SMTP id
 26-20020aa7915a000000b00549e8acc933mr2021861pfi.72.1663251018018; Thu, 15 Sep
 2022 07:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220914201049.3508104-1-han.xu@nxp.com> <CAOMZO5AGxXqF8Q6jhfr7vbZmQd6MU4SzFpj5XQG7cPtmdFrFVQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AGxXqF8Q6jhfr7vbZmQd6MU4SzFpj5XQG7cPtmdFrFVQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 15 Sep 2022 11:10:06 -0300
Message-ID: <CAOMZO5CfokeopsZuf2j905hzsU7cJ4x5iEyzujnFXr+EjD7nEg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: imx6sx: remove the SET_RATE_PARENT flag for
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

Hi Han Xu,

On Wed, Sep 14, 2022 at 5:51 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Han Xu,
>
> On Wed, Sep 14, 2022 at 5:11 PM Han Xu <han.xu@nxp.com> wrote:
> >
> > There is no dedicate parent clock for QSPI so SET_RATE_PARENT flag
> > should not be used. For instance, the default parent clock for QSPI is
> > pll2_bus, which is also the parent clock for quite a few modules, such
> > as MMDC, once GPMI NAND set clock rate for EDO5 mode can cause system
> > hang due to pll2_bus rate changed.
>
> Thanks a lot for your patch.
>
> This fixes the kernel hang issue on a custom imx6sx board with NAND without the
> need of using the workaround found in the NXP kernel:
>
> https://source.codeaurora.org/external/imx/linux-imx/commit/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c?h=lf-5.15.y&id=d03eb99c393f8732f70a1d7d29a3b9c42cccbe48
>
> Tested-by: Fabio Estevam <festevam@denx.de>

Just noticed the build error. I manually applied it to 5.15, so that's
why I didn't notice the problem
with your original patch. It is missing the closing parenthesis:


--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -280,13 +280,13 @@ static void __init imx6sx_clocks_init(struct
device_node *ccm_node)
        hws[IMX6SX_CLK_SSI3_SEL]           =
imx_clk_hw_mux("ssi3_sel",         base + 0x1c,  14,     2,
ssi_sels,          ARRAY_SIZE(ssi_sels));
        hws[IMX6SX_CLK_SSI2_SEL]           =
imx_clk_hw_mux("ssi2_sel",         base + 0x1c,  12,     2,
ssi_sels,          ARRAY_SIZE(ssi_sels));
        hws[IMX6SX_CLK_SSI1_SEL]           =
imx_clk_hw_mux("ssi1_sel",         base + 0x1c,  10,     2,
ssi_sels,          ARRAY_SIZE(ssi_sels));
-       hws[IMX6SX_CLK_QSPI1_SEL]          =
imx_clk_hw_mux_flags("qspi1_sel", base + 0x1c,  7, 3, qspi1_sels,
ARRAY_SIZE(qspi1_sels), CLK_SET_RATE_PARENT);
+       hws[IMX6SX_CLK_QSPI1_SEL]          =
imx_clk_hw_mux("qspi1_sel", base + 0x1c,  7, 3, qspi1_sels,
ARRAY_SIZE(qspi1_sels));
        hws[IMX6SX_CLK_PERCLK_SEL]         =
imx_clk_hw_mux("perclk_sel",       base + 0x1c,  6,      1,
perclk_sels,       ARRAY_SIZE(perclk_sels));
        hws[IMX6SX_CLK_VID_SEL]            = imx_clk_hw_mux("vid_sel",
         base + 0x20,  21,     3,      vid_sels,
ARRAY_SIZE(vid_sels));
        hws[IMX6SX_CLK_ESAI_SEL]           =
imx_clk_hw_mux("esai_sel",         base + 0x20,  19,     2,
audio_sels,        ARRAY_SIZE(audio_sels));
        hws[IMX6SX_CLK_CAN_SEL]            = imx_clk_hw_mux("can_sel",
         base + 0x20,  8,      2,      can_sels,
ARRAY_SIZE(can_sels));
        hws[IMX6SX_CLK_UART_SEL]           =
imx_clk_hw_mux("uart_sel",         base + 0x24,  6,      1,
uart_sels,         ARRAY_SIZE(uart_sels));
-       hws[IMX6SX_CLK_QSPI2_SEL]          =
imx_clk_hw_mux_flags("qspi2_sel", base + 0x2c, 15, 3, qspi2_sels,
ARRAY_SIZE(qspi2_sels), CLK_SET_RATE_PARENT);
+       hws[IMX6SX_CLK_QSPI2_SEL]          =
imx_clk_hw_mux("qspi2_sel", base + 0x2c, 15, 3, qspi2_sels,
ARRAY_SIZE(qspi2_sels));
        hws[IMX6SX_CLK_SPDIF_SEL]          =
imx_clk_hw_mux("spdif_sel",        base + 0x30,  20,     2,
audio_sels,        ARRAY_SIZE(audio_sels));
        hws[IMX6SX_CLK_AUDIO_SEL]          =
imx_clk_hw_mux("audio_sel",        base + 0x30,  7,      2,
audio_sels,        ARRAY_SIZE(audio_sels));
        hws[IMX6SX_CLK_ENET_PRE_SEL]       =
imx_clk_hw_mux("enet_pre_sel",     base + 0x34,  15,     3,
enet_pre_sels,     ARRAY_SIZE(enet_pre_sels));
