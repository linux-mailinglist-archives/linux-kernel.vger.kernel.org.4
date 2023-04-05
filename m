Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AB76D8693
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjDETMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDETMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:12:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72664ED2;
        Wed,  5 Apr 2023 12:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E7FF62B29;
        Wed,  5 Apr 2023 19:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E91C433EF;
        Wed,  5 Apr 2023 19:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680721961;
        bh=f6Za8lkRKG4F7M3+X7pyY5YOrHQRCTJaJ7vE+LTT95s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nvLCAzQ1nsjrckSeCd6yLxKqowcUMYhXDCpw22tS4g75ARQGcZCKvTjyZZxqLnDGd
         3zH6E1nen/7mYLe9k8UxWVpVEi/du/W7duYogiVcB2aSvYuuoAQocTxp9uLnJVeQZL
         W4EkgK2i8R+QI6aiHhrSpLvBQ9KdF2nizxiHaCly6nbm/rWbSQBSNKufgnYrbfmX0P
         a25+MuxBvcOqfrmp55phrzH1pTGfFQ1knV4AfxGAh4evLibgieMEY0EPFMwpM2NY5b
         S1eHh+U7dHT69vhZURefgBZyl2lEzV9OWDF4FtnnVn8nob7wzvCqXS5bS0fzTRA8G6
         5Qpbj7XIKQOug==
Message-ID: <a934cd700d03416b386245c1d91502ae.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <680357e5acb338433bfc94114b65b4a4ce2c99e2.1680423909.git.christophe.jaillet@wanadoo.fr>
References: <cover.1680423909.git.christophe.jaillet@wanadoo.fr> <680357e5acb338433bfc94114b65b4a4ce2c99e2.1680423909.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 4/4] clk: Remove mmask and nmask fields in struct clk_fractional_divider
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        abelvesa@kernel.org, festevam@gmail.com, heiko@sntech.de,
        kernel@pengutronix.de, linux-imx@nxp.com, mturquette@baylibre.com,
        peng.fan@nxp.com, s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Wed, 05 Apr 2023 12:12:39 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2023-04-02 02:42:07)
> All users of these fields have been removed.
> They are now computed when needed with [mn]shift and [mn]width.
>=20
> This shrinks the size of struct clk_fractional_divider from 72 to 56 byte=
s.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next
