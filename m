Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0395B8FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 22:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiINUvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 16:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiINUva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 16:51:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AE46C752;
        Wed, 14 Sep 2022 13:51:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s18so10370031plr.4;
        Wed, 14 Sep 2022 13:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dlyCVmQYKvV9dtFJPrSziTcD5W40HZ0uDRKK1oXcTjY=;
        b=nQ2uU+3R3PULyzrTap/XMmm6mJFph0hl/rwnZDVw4fHif64LfKbHO5rnhHo7ZBGOhY
         Y+K6cgM4AMO5ADpYIlPnp0jr65QZdHHyYjxW3ZqMKO0iLcGO0nCwAHDEI3uBPvfrcl2j
         49PHNjtCegfj1qk5vtGsD9x6EtUsobJDjYldgWkP8TeMOTJuNuXjCl3smhpkRV8//W9n
         JZycJBfXGmUQJvbuV7hICwvCZYZNe39ycv/ITCW0Vu9F0iL+aJ5R386WELsGIzJjwDDp
         81xNJ26VgXtES9YHUSfP0fRtEDxe2rjAbaQJ0oFLWXGODCW0tM2h8ClQBwclicg1Uuba
         I+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dlyCVmQYKvV9dtFJPrSziTcD5W40HZ0uDRKK1oXcTjY=;
        b=CemdFBYWe45swy+IwXrCcX8OKXbtUqPwnh9FKZ8yzY5v3JRSAoMg0A/MagtkLrKZsU
         gZirmqElYoQl0KnesYuI5ABt2ZLKQQnKYoAIHjZ9d5Ke1/giDvsAKzXqnhykWNZsgNAc
         ph1+/+5fCF3xrmqm0vqwJOfPlhmOgVLCmiSq3re+K2VFdPaQe10SyjMcGQgdiSpFCW2L
         9le797sfINPkRCR15uFUoHjUnY3Q3uzFLfcb87qfi+hX0j+nJqrbLTqzkDMMlokse6EE
         ZwzM4ildaDVzONEN/ShyAvJHh6H3PlEUyxU9LOwGEHaOZGXwNp9+91OxgCGj0uwGoVdZ
         E7PA==
X-Gm-Message-State: ACrzQf1WTAbp1TzeCVgbnbEFZaog00asq1aqnxbsNjtC7yRXpx7rme3u
        rCgut6l3QricJPx+bTpreljvOpBNgeTv3L7cIKM=
X-Google-Smtp-Source: AMsMyM4KjrM0IM3832iUKTWtgifnk8PV7Aeeje1iXgE7szIfUB5EJlsMpXz2Wp+mJmuo+laDp3uhoy2nfimJMACoQmc=
X-Received: by 2002:a17:90b:17cf:b0:202:95a2:e310 with SMTP id
 me15-20020a17090b17cf00b0020295a2e310mr7000218pjb.76.1663188687895; Wed, 14
 Sep 2022 13:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220914201049.3508104-1-han.xu@nxp.com>
In-Reply-To: <20220914201049.3508104-1-han.xu@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 14 Sep 2022 17:51:16 -0300
Message-ID: <CAOMZO5AGxXqF8Q6jhfr7vbZmQd6MU4SzFpj5XQG7cPtmdFrFVQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Han Xu,

On Wed, Sep 14, 2022 at 5:11 PM Han Xu <han.xu@nxp.com> wrote:
>
> There is no dedicate parent clock for QSPI so SET_RATE_PARENT flag
> should not be used. For instance, the default parent clock for QSPI is
> pll2_bus, which is also the parent clock for quite a few modules, such
> as MMDC, once GPMI NAND set clock rate for EDO5 mode can cause system
> hang due to pll2_bus rate changed.

Thanks a lot for your patch.

This fixes the kernel hang issue on a custom imx6sx board with NAND without the
need of using the workaround found in the NXP kernel:

https://source.codeaurora.org/external/imx/linux-imx/commit/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c?h=lf-5.15.y&id=d03eb99c393f8732f70a1d7d29a3b9c42cccbe48

Tested-by: Fabio Estevam <festevam@denx.de>
