Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C626D8696
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjDETM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjDETMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:12:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9285FFB;
        Wed,  5 Apr 2023 12:12:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E17062B4A;
        Wed,  5 Apr 2023 19:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B04C433D2;
        Wed,  5 Apr 2023 19:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680721971;
        bh=vwktBVYIyMUDS46F4u5pTUeYWYOR6Pcpn0ycUeUxRC4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=doRDD5ie6KpJ+VMDSEGNVYXm/DoI1xphMtnhX3W9t92M9UhnfSKL+aKsh1FlWUpGj
         rcPnmd5A8X+xcAIeLwRzH7QDkkjZT27QweULCrd7lOqN7QzPX1sdsG0U1/3pRwie7b
         8A3694ypCAxR8ZL4eAAG9XZzFUs+txDrGzx3ZBFULo5QaIGcTAXeB8fk807I53GbCn
         uTdf87qCCx0xRf+l3W29UqFLjcc9PDVimCV+OP3UcNjErUIMKzzXyK5BxjtbekQv6+
         XwRwkNN1QwiBAtAGi+rgE8E6Yi38eaJ0Bg95JVxkw1yJxgSHw5nLz65xsHTPWC8x67
         M2aYtU8eOHsvA==
Message-ID: <07ad7dc2a1fd51e73c4ee4cc5ae450ae.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <58e1950566e40e2fbb31004baee57a164ca6a390.1680423909.git.christophe.jaillet@wanadoo.fr>
References: <cover.1680423909.git.christophe.jaillet@wanadoo.fr> <58e1950566e40e2fbb31004baee57a164ca6a390.1680423909.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 3/4] clk: rockchip: Remove values for mmask and nmask in struct clk_fractional_divider
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        abelvesa@kernel.org, festevam@gmail.com, heiko@sntech.de,
        kernel@pengutronix.de, linux-imx@nxp.com, mturquette@baylibre.com,
        peng.fan@nxp.com, s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Wed, 05 Apr 2023 12:12:49 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2023-04-02 02:42:06)
> Now that fractional_divider clk computes mmask and nmask when needed, the=
re
> is no more need to provide them explicitly anymore.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next
