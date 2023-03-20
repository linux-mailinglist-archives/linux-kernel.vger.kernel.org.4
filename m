Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298596C23A6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCTV2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCTV2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C67FAD17;
        Mon, 20 Mar 2023 14:27:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1372261811;
        Mon, 20 Mar 2023 21:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6391FC433D2;
        Mon, 20 Mar 2023 21:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679347544;
        bh=E0a55P+RyXdkQBGe9esmwlAZYuCtloLp8FGR7H5aZQY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=agH6755/zCYq7YE7FvkeGpqEbWa1sRTwqUOEAlSl7G1m4+0+rVeyjXf5f9jc01Hw6
         /v9Ed3DNOjtOdjkm1a/XkEmQu14lNuFA+FDLBvWA18E2BdQyXn5KGrmraAozyiqD1G
         J2XWrqUDjPCHQ7it4z7BQkC88xVKQSF7R84kebd2uJoIEtdtbQQ/wX0FV9WTazn43N
         0fR+2u8jZUDm7EG9Z0T/jol+6kZP9Oz7kc8YQzhuuAnzubGALiTdnO8/YiHrhqEro8
         ewoCyfXH4csbw4tM4zjaWHbidoB4hXGH41tM8vC/NJX6vnnT9+TGkwti5tnW0SwnBx
         QZgS6U34MvIOA==
Message-ID: <cd802cf4347e571d7ba85c4161c10dc2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230310164523.534571-1-o.rempel@pengutronix.de>
References: <20230310164523.534571-1-o.rempel@pengutronix.de>
Subject: Re: [PATCH v1] clk: imx6ul: fix "failed to get parent" error
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Mon, 20 Mar 2023 14:25:42 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Oleksij Rempel (2023-03-10 08:45:23)
> On some configuration we may get following error:
> [    0.000000] imx:clk-gpr-mux: failed to get parent (-EINVAL)
>=20
> This happens if selector is configured to not supported value. To avoid
> this warnings add dummy parents for not supported values.
>=20
> Fixes: 4e197ee880c2 ("clk: imx6ul: add ethernet refclock mux support")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Applied to clk-fixes
