Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6E06466EE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLHC1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHC0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:26:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148158E599;
        Wed,  7 Dec 2022 18:26:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95A5461D22;
        Thu,  8 Dec 2022 02:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E436DC433D6;
        Thu,  8 Dec 2022 02:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670466413;
        bh=EEXv31EHijcWe+oAPW/O/oSGFu1i6dgrthd8lpIk1JE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QFRj0NUJc2P+g/jO+Akg9dD4y0vBw9PBp0aq/ExBHu2lvdDF3AKdeZnsMsxvP9V33
         iVXkDdFaXObf7ow9tCK11q8FiBY1SIiTpnWf0Vq1UfcsM1NTJyrGZlMmHuU7P6f8uZ
         mmFulhQ+1JmrU9q4yfE6FNyvpbgivu7DIoxzHfnLFux+SlauCZUyelJYD6q8QnheMh
         iy8nY6xV1Er2EhVpw2CezbfFLBNGT9nG8hBrqApl8HMdvdqbnfHZtbe6vkfKQccWLz
         SW3ITzzEvA2KmobEM4NC5Nfz+jz8pAb4ea9ymRUWD2vAkSkOYnbrChpy3M34vDc21S
         xmhqGvv+3/7Eg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221123032015.63980-1-xiujianfeng@huawei.com>
References: <20221123032015.63980-1-xiujianfeng@huawei.com>
Subject: Re: [PATCH] clk: samsung: Fix memory leak in _samsung_clk_register_pll()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, alim.akhtar@samsung.com,
        cw00.choi@samsung.com, dianders@chromium.org,
        krzysztof.kozlowski@linaro.org, mturquette@baylibre.com,
        mturquette@linaro.org, s.nawrocki@samsung.com,
        tomasz.figa@gmail.com, yadi.brar@samsung.com
Date:   Wed, 07 Dec 2022 18:26:50 -0800
User-Agent: alot/0.10
Message-Id: <20221208022652.E436DC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xiu Jianfeng (2022-11-22 19:20:15)
> If clk_register() fails, @pll->rate_table may have allocated memory by
> kmemdup(), so it needs to be freed, otherwise will cause memory leak
> issue, this patch fixes it.
>=20
> Fixes: 3ff6e0d8d64d ("clk: samsung: Add support to register rate_table fo=
r samsung plls")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---

Applied to clk-next
