Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AE77184E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbjEaO1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbjEaO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:26:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237421B0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:26:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF1D162D99
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 14:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04F6C433EF;
        Wed, 31 May 2023 14:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685543198;
        bh=uZrecblMyFP3eudphYm0KjVCQrjhgwqr75yaoD6auEc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ZfJXgOnttHUiKqjYtLk8ldIUuyeZAQw1z9o2Bh+OW9frmPTAw2QDsQrn1tRKpby64
         njcuDgN1TCjVm5i80RVq4BZLomYD2/sJkL2IW6cTkrpnL2y/IZiOGznYHub3syK4OE
         7kALI0kIzjOAKM1nHY/+TQKux0vYXyNCl6Ru/exT7eMKV1AgwHFd13BMjmKk4ayBsv
         Y1lusZSNYPWnTM5NhKh0q3UZ3f/f+NDg4jKWa1SKgfGs6ICzbuqD1hXNNxDgAhbKMe
         AqlzGD6tIUA5u9ZR690ev0CeXJEidq7jOwUv30P8PgCx+dlf4towWShf7qDIYSXvGr
         ASYThJsOxYqgQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sicong Jiang <kevin.jiangsc@gmail.com>
In-Reply-To: <20230531090635.89565-1-kevin.jiangsc@gmail.com>
References: <20230531090635.89565-1-kevin.jiangsc@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add Thinkpad Neo14 to quirks list for
 acp6x
Message-Id: <168554319655.98519.9217752703548854880.b4-ty@kernel.org>
Date:   Wed, 31 May 2023 15:26:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 21:06:35 +1200, Sicong Jiang wrote:
> Thinkpad Neo14 Ryzen Edition uses Ryzen 6800H processor, and adding to
> quirks list for acp6x will enable internal mic.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add Thinkpad Neo14 to quirks list for acp6x
      commit: 57d1e8900495cf1751cec74db16fe1a0fe47efbb

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

