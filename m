Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82F5EE43B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiI1SUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiI1SUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B41CB07D4;
        Wed, 28 Sep 2022 11:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E614461F78;
        Wed, 28 Sep 2022 18:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41880C433D6;
        Wed, 28 Sep 2022 18:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664389237;
        bh=tsUzsDLvNMrNl/WX8swyUROVgGbJNAP/UA66NR2AIis=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JwMM6+/J4W+Yp4SjAIqo11CnhzBuYiAK6rdqc682IYFSA2lX8oNlh7Cb+QKRVGJ2G
         cDcsh8RFmqczZp+ARE3sUbnsw2/lORF/e5ZnyUaDxqJri9n65Lc5Rd8wc3e3kru034
         eaHHmAkWBlbJ8Lo6i+9RUt78dCJ59RIJq/o1yrJJrfjfvfuNNuLfoxVRdBSda5h2xe
         CW5ptePlYsTC52ieKS40CNp9lU7o2iDwkUVv8n+p0ZsWWhMXD86E/kz41C6De+v1+S
         bz5x1uyvUZkGjbG0qHIW5EZn9KKQjq+PDLumji2/xT6/IAsp7Z5KY02wN1XAADaoqr
         MwlE4joexgKTg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220915150959.3646702-1-han.xu@nxp.com>
References: <20220915150959.3646702-1-han.xu@nxp.com>
Subject: Re: [PATCH v2] clk: imx: imx6sx: remove the SET_RATE_PARENT flag for QSPI clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        han.xu@nxp.com
To:     Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, Han Xu <han.xu@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 28 Sep 2022 11:20:35 -0700
User-Agent: alot/0.10
Message-Id: <20220928182037.41880C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Han Xu (2022-09-15 08:09:59)
> There is no dedicate parent clock for QSPI so SET_RATE_PARENT flag
> should not be used. For instance, the default parent clock for QSPI is
> pll2_bus, which is also the parent clock for quite a few modules, such
> as MMDC, once GPMI NAND set clock rate for EDO5 mode can cause system
> hang due to pll2_bus rate changed.
>=20
> Fixes: f1541e15e38e ("clk: imx6sx: Switch to clk_hw based API")
> Signed-off-by: Han Xu <han.xu@nxp.com>
>=20
> ---

Applied to clk-fixes
