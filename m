Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491655FDB32
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJMNmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJMNlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:41:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5943B79681
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5C93617D9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F160C433C1;
        Thu, 13 Oct 2022 13:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665668508;
        bh=CgjVDRPLLDY0nzJJ73FalYoKdxZlMOPZptlSF0/G1gk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kr7eNSmpr9EyQ3F/OG7rju4f4oJAi/t7qxQPhGDk+NH6rXc0aIv5izvwPPXQe0e9z
         LDX9I8AGsXr+/OAMnEg5R2uwJLIuPZFIdwTSnzQwoexMPp++lXaOYpE3tXRIsvOJPr
         j+7Hhl7U/uuHhfuZ088WIQ4FTQI9FN8nJyTnaIEGrO8utF7nI5RnWGfAgEC2tLp7cx
         Y5seOxc1lt7AdOZTYiB4IWz+C3jNS463d6EWKbsTJFe/zs2I2n5CEZWYEyOz/s5zmw
         z51bRB9QntPEjXX5HFmD4/RZBsHsCqYL+NsgtN0AuzM5x9zozY3hwiRbAw13ePsX0T
         7esBhoQRolNdA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, Jiangshan Yi <13667453960@163.com>
Cc:     alsa-devel@alsa-project.org, k2ci <kernel-bot@kylinos.cn>,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>, lgirdwood@gmail.com
In-Reply-To: <20221009074816.2641162-1-13667453960@163.com>
References: <20221009074816.2641162-1-13667453960@163.com>
Subject: Re: [PATCH] ASoC: cx2072x: fix spelling typo in comment
Message-Id: <166566850637.143340.14997967171152371491.b4-ty@kernel.org>
Date:   Thu, 13 Oct 2022 14:41:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Oct 2022 15:48:16 +0800, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix spelling typo in comment.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cx2072x: fix spelling typo in comment
      commit: 29eb79a9a6283d661ea1f70ab012809fdbf057a7

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
