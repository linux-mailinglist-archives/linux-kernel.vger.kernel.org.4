Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD8072CC36
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjFLRQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjFLRPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:15:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A5410F2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:15:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AEA161F95
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 17:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C67C4339B;
        Mon, 12 Jun 2023 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686590142;
        bh=yD2tsCZxbwZxCWlazDu+u9Q5ZlcC2d4DUZrSTVr2Fa0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Te12Qg62lVjXjz+aV0LXP9H7kRbwUcKuDmWlC1Wp4GCEVMq2NfNryIh0jLTbSl4y6
         mJsSKH0Nn4kv7aWnyx5wumv3wKYzKR5dsgdc+5Pej4Vgc29JI3fMwx5GHrJ5sFL3aR
         tmvcGajdIjIq/lR9flUepFDEs7kCpYU10m5YQmUthnIg9ZV4tSpA7ZLlGk3NHJD92G
         6w+dyDSsYPOnzUR8g9zuqjjVVmzpSI1fmTNkge/OSdRFuCM5rbnySSobSgSJEHyU1d
         XDGybq1amU9o16bLC4y60+5IoRYJScfb6BkbGbJSBJTk0/AbOu6BXP4Y2c5o45rVtv
         Gfn/6tl0gMjYg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20230610-regcache-raw-kunit-v1-0-583112cd28ac@kernel.org>
References: <20230610-regcache-raw-kunit-v1-0-583112cd28ac@kernel.org>
Subject: Re: [PATCH 0/2] regmap: Provide basic test coverage for raw I/O
Message-Id: <168659014166.85655.16382748391005004859.b4-ty@kernel.org>
Date:   Mon, 12 Jun 2023 18:15:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jun 2023 14:25:01 +0100, Mark Brown wrote:
> Our existing coverage only deals with buses that provide single register
> read and write operations, extend it to cover raw buses using a similar
> approach with a RAM backed register map that the tests can inspect to
> check operations.  This coverage could be more complete but provides a
> good start.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: Provide a ram backed regmap with raw support
      commit: 65dd2f671875b1d97b6fa9bcf7677f5e1c55f776
[2/2] regmap: Provide basic KUnit coverage for the raw register I/O
      commit: 155a6bd6375b584c8bdbf963b8ddef672ff9aca3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

