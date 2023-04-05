Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148336D8699
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjDETNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjDETNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:13:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100019B2;
        Wed,  5 Apr 2023 12:13:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F88062B5A;
        Wed,  5 Apr 2023 19:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6472C433EF;
        Wed,  5 Apr 2023 19:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680721981;
        bh=TfdA32qkhTaC65VE89dlgg3nhsFidvoOwThd1sNOR1I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dyjwqrcLO1f+Fq/oOQISj2jtc9W6s9F+A5lK2cH2HWcsPB52VwBK9D9StB+MDFGB3
         8oUEXK4pUGiXU0w/hIohdgXjVCtxIp01GUIsoalcrYpjidKN8RqMWxkiV+p62GX+xf
         zNeJJCGja1S7Zl6VA1r7p8TQy7DLj2M+ysOcEqz9IT3xjhACWn6DXaKKp6JMnHIb49
         NPHBwlxlfQG1Qr5u3ci+fgAy/o8B7sKDZ+5RABt5AcL9yeF6obCiM5TpRJBqWmAOrM
         M7gKn8R8M/vcWHbPoqr3e6p3ed7Cj4T2oiNg0cIQ68h2nMfyYncO0NWzvwFttcD0oS
         PdAHL2dHnwD5w==
Message-ID: <0cbe45046219218f1c52f22f70004826.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <187a2266c3a034a593a151d6e5e6b21118043b5d.1680423909.git.christophe.jaillet@wanadoo.fr>
References: <cover.1680423909.git.christophe.jaillet@wanadoo.fr> <187a2266c3a034a593a151d6e5e6b21118043b5d.1680423909.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 2/4] clk: imx: Remove values for mmask and nmask in struct clk_fractional_divider
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        abelvesa@kernel.org, festevam@gmail.com, heiko@sntech.de,
        kernel@pengutronix.de, linux-imx@nxp.com, mturquette@baylibre.com,
        peng.fan@nxp.com, s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Wed, 05 Apr 2023 12:12:59 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2023-04-02 02:42:05)
> Now that fractional_divider clk computes mmask and nmask when needed, the=
re
> is no more need to provide them explicitly anymore.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next
