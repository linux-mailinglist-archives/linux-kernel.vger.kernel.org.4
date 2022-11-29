Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9DD63C8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiK2ULn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiK2ULh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:11:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6EA5917E;
        Tue, 29 Nov 2022 12:11:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 938D6B818C0;
        Tue, 29 Nov 2022 20:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A651C433C1;
        Tue, 29 Nov 2022 20:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669752694;
        bh=dph3upGKfilqBGNmUDKpNEKohIKxkbco5kqQPpoV+SU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qpq4mLjJPieESlUEVylekdW2r+yklzQ+ZP7dGIz5UmOHHMsBK0XAai0h0gygR90kr
         c99uJI0dPFLRHtt4wp3Zawf+q/D3aj5aC4EY5DsiGHNDe2Ohgow8fAbbVjg8OBbdAp
         DOx4G+QdLTCeLRJhEZzPnpL8+rpuSvl0C1HpWoH0rwhMCcXOCdIDLXgLSOGjGyQoWK
         C6HH8sv7RLjIecl4cPy0qXwuVYUeJyGd1Le1bCNo7rrh6kYE5iFtBUWqNVoMDxyzlQ
         LSrrX7e1RPLWEOosIzhKQQvGY5A7xCXnCU6huLmykQDaPvL1ZDx0g+dI1MDnbGbZY+
         pXqgs9q2Y7NwA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221122152353.204132-1-xiujianfeng@huawei.com>
References: <20221122152353.204132-1-xiujianfeng@huawei.com>
Subject: Re: [PATCH] clk: visconti: Fix memory leak in visconti_register_pll()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, mturquette@baylibre.com,
        nobuhiro1.iwamatsu@toshiba.co.jp
Date:   Tue, 29 Nov 2022 12:11:30 -0800
User-Agent: alot/0.10
Message-Id: <20221129201134.3A651C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xiu Jianfeng (2022-11-22 07:23:53)
> @pll->rate_table has allocated memory by kmemdup(), if clk_hw_register()
> fails, it should be freed, otherwise it will cause memory leak issue,
> this patch fixes it.
>=20
> Fixes: b4cbe606dc36 ("clk: visconti: Add support common clock driver and =
reset driver")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---

Applied to clk-next
