Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F2A64886B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLIS02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLIS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:26:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B88379F2;
        Fri,  9 Dec 2022 10:26:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25F6AB828D3;
        Fri,  9 Dec 2022 18:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04ACC433EF;
        Fri,  9 Dec 2022 18:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670610382;
        bh=8dddKZ57UrjQDLb/S1ZbfLF3qt/bQhuZsCMUNXqyJko=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bVu1ndMVjwY0sf/bOz+KpWk5in5Jhk2RnpamkR2d7UFZ3zu/SNdLcKVN/gW0gpk/I
         vQF2wU7mgmPxs1fR1D+EY/GMAgoctymOStuhbROTn3EapJTfPlSFUogn/bXnrEF8ew
         WSqhdVt5vshb+XBQwxGfZH7TaSxLOEBZ2jnH61CaIY6w4q/LPSHB6y4cqFF0P1acdE
         HohV9zOi4PvAmuvmgvu7Zoqf9CgzI5clqzsUCQ0eLjNu1l+d6hS+UzMDow+TXG88Ep
         3QI7jpdSIihFHdCMoiU7BLY07Vm7UZW93ApHOpUevD4pjaxD/ZU5GtS84C01lzr4lM
         Cnija2Gkr14Iw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221209002016.14776-1-rdunlap@infradead.org>
References: <20221209002016.14776-1-rdunlap@infradead.org>
Subject: Re: [PATCH] clk: nomadik: correct struct name kernel-doc warning
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Date:   Fri, 09 Dec 2022 10:26:20 -0800
User-Agent: alot/0.10
Message-Id: <20221209182622.A04ACC433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Randy Dunlap (2022-12-08 16:20:16)
> Use the correct struct name for the kernel-doc notation to prevent
> a kernel-doc warning:
>=20
> clk-nomadik.c:148: warning: expecting prototype for struct clk_pll1. Prot=
otype was for struct clk_pll instead
>=20
> Fixes: ef6eb322ce57 ("clk: nomadik: implement the Nomadik clocks properly=
")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> ---

Applied to clk-next
