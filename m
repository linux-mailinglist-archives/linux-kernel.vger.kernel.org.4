Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5113750696
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjGLLrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjGLLr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:47:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFE41999
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8782861794
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7F8C433C9;
        Wed, 12 Jul 2023 11:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162428;
        bh=ENkcW96EGy+1LPYBYZW3/JRK1Q9huG6TFa9pKV63ocU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lxPf5Cy3tZid05IKGZsXeaJYEleuf6zbFdpLUGMhB1SXgyVnOypsbRyfTzv6PVsBK
         G27PUZZOr8MlOQdo/FBujM4ypCA2LFStN0hLER7rVFPtK4XrmmQT3QnD0E7VSz32Yg
         NK+RifmfGCoA7HJmIF/E7Wgku52fXUBvy4L4cbo1ZO83IkJEhERDSeznSbucp1nc+K
         enPOVA9IqLNGScZcvR95/nigiZ0+9tm4yZAYFREpa7BFy/aSMWLzVlIMEyO47l2i2l
         MLL3+fwbY446AFTDhpa6dwAnLD+QA3ZAMIyCJZEUuJk3t8q2tvtq/9JYM/XCC2afx3
         hbtQSlb1uXC5g==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20230630172155.83754-1-andriy.shevchenko@linux.intel.com>
References: <20230630172155.83754-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/4] ASoC: rt5677: Refactor GPIO and use
 device_get_match_data()
Message-Id: <168916242630.46574.7633971537485557226.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 12:47:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 20:21:51 +0300, Andy Shevchenko wrote:
> The code can be simplified with refactored GPIO parts and with use of
> device_get_match_data(). Besides that couple of additional changes,
> one for maintenance and one for making IRQ domain agnostic (not being
> pinned to OF).
> 
> Changelog v2:
> - refactored GPIO code in (a new) patch 1
> - fixed compilation error in patch 2 (LKP)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: rt5677: Refactor GPIO support code
      commit: 5512ffd9f39832f312b7f903703ac39d6367fe8a
[2/4] ASoC: rt5677: Use agnostic irq_domain_create_linear()
      commit: c3d42d7baf6b4032171270e3df001fb946493452
[3/4] ASoC: rt5677: Use device_get_match_data()
      commit: 043bb9c012ee7d092a477159cc66dbdf62fd2666
[4/4] ASoC: rt5677: Sort headers alphabetically
      commit: ea1c1019a88d88cf0a7d6892f594b72ddb3b8c0b

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

