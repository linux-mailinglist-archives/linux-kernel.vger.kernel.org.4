Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E126D3A40
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 22:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjDBUUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 16:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDBUUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 16:20:14 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935F54C3B;
        Sun,  2 Apr 2023 13:20:12 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pj4BE-0002YN-3t; Sun, 02 Apr 2023 22:20:00 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     mturquette@baylibre.com, sboyd@kernel.org, abelvesa@kernel.org,
        peng.fan@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 4/4] clk: Remove mmask and nmask fields in struct
 clk_fractional_divider
Date:   Sun, 02 Apr 2023 22:19:44 +0200
Message-ID: <13622701.uLZWGnKmhe@diego>
In-Reply-To: <680357e5acb338433bfc94114b65b4a4ce2c99e2.1680423909.git.christophe.jaillet@wanadoo.fr>
References: <cover.1680423909.git.christophe.jaillet@wanadoo.fr>
 <680357e5acb338433bfc94114b65b4a4ce2c99e2.1680423909.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 2. April 2023, 11:42:07 CEST schrieb Christophe JAILLET:
> All users of these fields have been removed.
> They are now computed when needed with [mn]shift and [mn]width.
> 
> This shrinks the size of struct clk_fractional_divider from 72 to 56 bytes.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


