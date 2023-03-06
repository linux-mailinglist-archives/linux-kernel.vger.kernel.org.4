Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4380C6ACE1F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCFTas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCFTap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:30:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B81F38004;
        Mon,  6 Mar 2023 11:30:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE972B810C6;
        Mon,  6 Mar 2023 19:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BB4C433D2;
        Mon,  6 Mar 2023 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678131038;
        bh=y2LTQiZFTAycrk7HmfcrNSsVpGXsaOa8A/dbm5J1ayY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ie3nQYJsv+RzZ1NZ+BDULCYZn8GB/e9JROMtiMVzWYrNPU1zpVkQi5HJLmBZAdqPL
         iuM97EkjQUaMZjHzeUJJ7NzfkzOKvZRFae8oHDZTI6YLC6iLb4pM410EteMs9qm9vH
         pQLsVPoMgEYO8QA3uAvE77q8jUy+z/9MnGoTxoaj8aRtr7Epgz8iCMjqx4hblPQE0X
         MMfoeZ8PF6aPtPgUhpuS5hySkAfBvuoiQRjw2b2o0axcB5ZgJDF7HNzrg9Xsa0QiDr
         yvTLF16iw6j/kdZBSfALao4x57KdH7CkiU8UhvcVCgohJb5lSD0nFh0PAXXqFv6HPz
         QGs/OxX2cbXBw==
Message-ID: <d97ab14301c65d775cd69c1efebedb37.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230226053953.4681-3-rdunlap@infradead.org>
References: <20230226053953.4681-1-rdunlap@infradead.org> <20230226053953.4681-3-rdunlap@infradead.org>
Subject: Re: [PATCH 2/8] clk: HI655X: select REGMAP instead of depending on it
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Riku Voipio <riku.voipio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Date:   Mon, 06 Mar 2023 11:30:36 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Randy Dunlap (2023-02-25 21:39:47)
> REGMAP is a hidden (not user visible) symbol. Users cannot set it
> directly thru "make *config", so drivers should select it instead of
> depending on it if they need it.
>=20
> Consistently using "select" or "depends on" can also help reduce
> Kconfig circular dependency issues.
>=20
> Therefore, change the use of "depends on REGMAP" to "select REGMAP".
>=20
> Fixes: 3a49afb84ca0 ("clk: enable hi655x common clk automatically")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Riku Voipio <riku.voipio@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-clk@vger.kernel.org
> ---

Applied to clk-fixes
