Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA56763C59B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiK2QuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbiK2Qtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:49:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8436DFF7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:46:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B0A7B816EA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA99C433D6;
        Tue, 29 Nov 2022 16:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669740369;
        bh=jRR+eWZ9p80Q5CZbH9ER0A4R3XYNLWrNlOrh/BtfvQM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Refjrf4/qiBWdxm9YcXAbP5nG2gIFIBIPB+E+12XlyUXfNfqTQBXOU182lYoVZw/A
         VYEVmcl358niTOJImmdGADVpUYswDdJ1zPwq8kzNvCfl/bgPorg/lb5oauWwDjab/m
         wCzflO+9PRyTU3fHl8jkobvGtfNoh5hb44azU0T8dj0o4lyfyxJF6GvN3pe+1z9x8X
         MN/e5Oba+dg655KAuET3B5aTZ1LrLxbLFD+9LG/tydr2dV8iQ++NjEPc3RLdq5H5iL
         GERMMpV4WGkaaa56uwu3+QNLORcJYvE1lxEQ/tk4F86FDeEhXx/2zPUPt8haqzgXFv
         0hBp2jcosxWpw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20221124-da9211-v2-0-1779e3c5d491@chromium.org>
References: <20221124-da9211-v2-0-1779e3c5d491@chromium.org>
Subject: Re: [PATCH v2] regulator: da9211: Use irq handler when ready
Message-Id: <166974036870.313894.7159003190851344255.b4-ty@kernel.org>
Date:   Tue, 29 Nov 2022 16:46:08 +0000
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

On Sun, 27 Nov 2022 22:06:02 +0100, Ricardo Ribalda wrote:
> If the system does not come from reset (like when it is kexec()), the
> regulator might have an IRQ waiting for us.
> 
> If we enable the IRQ handler before its structures are ready, we crash.
> 
> This patch fixes:
> 
> [...]

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
