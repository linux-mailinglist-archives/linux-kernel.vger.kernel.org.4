Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A628773EF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 01:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjFZXoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 19:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjFZXoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:44:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDE012D;
        Mon, 26 Jun 2023 16:44:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF99060FAF;
        Mon, 26 Jun 2023 23:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3A8C433C0;
        Mon, 26 Jun 2023 23:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687823043;
        bh=wDPuD5tceCznUvsGtJ87sCyudHQPlKFSy0TdJ+Qhg+g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=I61lKLiUTsHbU6jmL1lkc3VdOEsin+EPdLLP7GXS5FbmykF488OLwy+Ob3pChfRiu
         LeodBSLTr1dtni8QS/CH0FIEnSk+QPFh7ROVRxM659bJSvOn9M2Wf3kYm35TolTkwe
         qzRO1kCO3q9U7vNtOrEGlkBM5c1oK6a430UHoz4Zm2WwmxGcoA7aBLNKsYmq/teQl6
         IBOB+dkn7Bax5OIhDNu6tnfWsOvrKTmRxHlWtQnQYKr4sFXHOmu7SiQO1aIou2DidP
         B3cH4KmvK2VPS5q4rFl9DAKl0qVS2XO0vsj6I54DD8ytcxCJbxgc3CMukvDnbt/Vxp
         fLTv+3tn6Y9og==
Message-ID: <3a843f15dda68375870c622869836e5c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230623071948.3254789-1-arnd@kernel.org>
References: <20230623071948.3254789-1-arnd@kernel.org>
Subject: Re: [PATCH] clk: imx: Drop inclusion of unused header <soc/imx/timer.h>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Arnd Bergmann <arnd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Mon, 26 Jun 2023 16:44:00 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2023-06-23 00:19:19)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> After removing this header in the clocksource tree, the clk drivers no
> longer build:
>=20
> drivers/clk/imx/clk-imx1.c:13:10: fatal error: 'soc/imx/timer.h' file not=
 found
> drivers/clk/imx/clk-imx27.c:11:10: fatal error: 'soc/imx/timer.h' file no=
t found
>=20
> This patch was originally posted as part of a three-patch series, but only
> patches 1 and 3 got applied.
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Fixes: 9e9d7570485d7 ("clocksource/drivers/imx-gpt: Fold <soc/imx/timer.h=
> into its only user")
> Link: https://lore.kernel.org/all/20230328100531.879485-2-u.kleine-koenig=
@pengutronix.de/
> Signed-off-by: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
