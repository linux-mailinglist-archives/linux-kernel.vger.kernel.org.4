Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314D76EAEAD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjDUQGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDUQGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:06:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399A914473
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF85765192
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 16:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386C9C433EF;
        Fri, 21 Apr 2023 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682093198;
        bh=/fqu4LAO0rQXLeKMn7Vx1bIx9OQ+1oaeV/RoLW9avGk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OXKLQdiqyePGt+CuFBe+9QESkM1orGqaE2bDmsvJML8PVaXHr+veF9JVCHe6xvkXK
         ucaTsGelUQHYa6db1WLu1NXgMoaWwO7+huaFGjwv9m15IKVslIRILDRJ7fMnlMq5H0
         sbOC0GYuOkRdJ7phgapoyf26Te49jkJM3EkfhwL07O91J8TzH6oQ/ykvsK4Xg3QH9g
         l17SIY4CgAWjEwYgvsm/5vKGADnhjjUOm9Q21uJvYyWjNrgcpvJV13aJ7wbzifZXJm
         rzSHBKTGgbxxsh1QBb3On1hOp207JgfEJg0E++vg63xh5ZZmX4lnf+gHvQaAe1heoo
         O9ziRXudCzndA==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Simon Trimmer <simont@opensource.cirrus.com>
In-Reply-To: <20230420102043.1151830-1-rf@opensource.cirrus.com>
References: <20230420102043.1151830-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Remove duplicate mbox log messages
Message-Id: <168209319695.108546.10814021215571192009.b4-ty@kernel.org>
Date:   Fri, 21 Apr 2023 17:06:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00e42
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 11:20:43 +0100, Richard Fitzgerald wrote:
> cs35l56_mbox_send() logs a warning when sending a mbox command fails so
> the callers can be simplified.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Remove duplicate mbox log messages
      commit: a9e42d9e8b4be36a1e0dde0285a9ff36b2e06a46

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

