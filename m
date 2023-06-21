Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C080738913
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjFUP3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjFUP3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:29:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EFC19F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:29:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 735256159B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69059C433C8;
        Wed, 21 Jun 2023 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687361350;
        bh=8sWjYA4N+fAraCJGgq/hNuwy2uwuyh5U7Ae9A1i5Soo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WR6NpiobZ/y7MqNA6DkkgIbDms6UHEZ/RkHeaaDm1xDhA4B12AM631tMtqXeax47V
         KOf3pFJojygW1W3H+0PbJJ+K3N8a3FbVtnLd3UWZyP7SJwaFX2X64dZ09xFaPNS/m9
         iMzwZCBIv0gjChdTWzGgqOJd1IN0NGGLAql/3PXYQUeMy7m8JOmyriYiwb+WbdReMC
         Md0eutFCUySEBItiAujtPE1QvQDgbvrwlr4Ptkd6Fe+SK21ygXkNNh0G6LtrKat0XO
         ffCpSSHaQJ7c0WaWLBl9i11+K+7oKwpEJ6hkJ5M7UzHW0g7BFpYK/wW62M4kmkREYX
         HvRVb4chSgdJg==
From:   Mark Brown <broonie@kernel.org>
To:     vkoul@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, yixuanjiang <yixuanjiang@google.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230619033127.2522477-1-yixuanjiang@google.com>
References: <20230619033127.2522477-1-yixuanjiang@google.com>
Subject: Re: [PATCH] ASoC: soc-compress: Fix deadlock in soc_compr_open_fe
Message-Id: <168736134915.407715.9511058115081614816.b4-ty@kernel.org>
Date:   Wed, 21 Jun 2023 16:29:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023 11:31:27 +0800, yixuanjiang wrote:
> Modify the error handling flow by release lock.
> The require mutex will keep holding if open fail.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-compress: Fix deadlock in soc_compr_open_fe
      commit: 2222214749a9969e09454b9ba7febfdfb09c1c8d

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

