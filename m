Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0FD735F45
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 23:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjFSVgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 17:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFSVgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:36:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9BF8F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 14:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 998F960EFB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 21:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0051C433C8;
        Mon, 19 Jun 2023 21:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687210571;
        bh=y1eg8BxSOqP4cS0OVkBPc81ArwvMce+5/skfF/ml9h0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oMx7+0jpjCd/IE1T6e91aS7CyJrAnGwY5Ixy0VXpJqWJ8Pm1VU7hXSNhoKpBakoQl
         saZ9RtQ6xHRM6Bgkjqt+o5+tkXll4H7o2fklRtxrKyi4Bb22NfLVQKvBeUWTyyrwzy
         PxbhgS/OM2SUpO2Kve99Bh745ITWv60DTSSIJekkRfOjTlR0I2E5QLrV+jgT7q+VYW
         2thmuFtKnfAZaGS2YnuWlHEdkKwsWHc4lXKl9RTqZZiI5L/pA/QXWTuPKEAAPffg6J
         aS8Ez80IWtLFG+L8hhzkdBRow6WUCHozZ2YqZrgyzzEExrpWsQXMpHJaokMd5BgOiF
         lZ3UTmaDyWH6A==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230609-regulator-ltc-maple-v1-0-08c15181f8b2@kernel.org>
References: <20230609-regulator-ltc-maple-v1-0-08c15181f8b2@kernel.org>
Subject: Re: [PATCH 0/2] regulator: Convert Linear Technologies driver to
 maple tree cache
Message-Id: <168721056947.193647.3533248531398274287.b4-ty@kernel.org>
Date:   Mon, 19 Jun 2023 22:36:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2023 14:59:52 +0100, Mark Brown wrote:
> There are a couple of Linear Technologies devices which can only do
> single register reads and writes so don't benefit from using the rbtree
> register cache rather than the more modern maple tree cache, update them
> to use maple tree.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: ltc3589: Use maple tree register cache
      commit: 29890a15865deaf7f446119bcb5617b0cc76be03
[2/2] regulator: ltc3676: Use maple tree register cache
      commit: ce44a03db73f7ce7cca152e07bd9cbfc3c10a0ba

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

