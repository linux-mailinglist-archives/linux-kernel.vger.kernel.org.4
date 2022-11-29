Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058BA63C5A7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbiK2Qve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbiK2QvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:51:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A0370452
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:47:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC81AB816E9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61BEC433C1;
        Tue, 29 Nov 2022 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669740368;
        bh=1uxPxaTClnycnzo3WdqTQKtEilfHzKefuhdmzFy6SZs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VkW60Dr0nyNUwHnvurYS0HvZDysnA4i98pTdxZdX9o+LVhf5uPZI3WdvoE0OZGrV5
         f8bM8O7syCqRA/u+Bq/V2SFrc7rbjAzgnRpkACH/dM/Nudi0pIy2MoiMydVlNjmlES
         DFyq3DoWq7Xo6fiFtq8gYpN+qG+Iww/lIHw9qtM4PAOBKXlh/6jM5YxtOqcDM5D1xC
         rDMDa/YGUJmMjpgx15BiPQgoSxunb8sj1LuoDxp41c0rl2E2PMm6qTBYcGMj6ULqr5
         x55nmXzRsb+K+JpV/dBvCFYWvoualztH7ZphBfIaC1c2U4XLVgVZxBkU2nILrwkETk
         39hPbT7gH6jRA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20221124-da9211-v1-0-a54549aa6d3b@chromium.org>
References: <20221124-da9211-v1-0-a54549aa6d3b@chromium.org>
Subject: Re: [PATCH v1 0/1] regulator: da9211: Fix crash when irqs are pre-enabled
Message-Id: <166974036738.313894.8241146715693014720.b4-ty@kernel.org>
Date:   Tue, 29 Nov 2022 16:46:07 +0000
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

On Thu, 24 Nov 2022 17:45:30 +0100, Ricardo Ribalda wrote:
> If the system does not come from reset (like when it is kexec()), the
> regulator might have an IRQ waiting for us.
> 
> If we enable the IRQ handler before its structures are ready, we crash.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9211: Use irq handler when ready
      commit: 02228f6aa6a64d588bc31e3267d05ff184d772eb

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
