Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968F8602A20
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiJRL2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiJRL2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DF0B7EF8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 04:28:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F7C26152E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706DCC433B5;
        Tue, 18 Oct 2022 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666092503;
        bh=t7x/A8HbCw3ENFEa0NBFmoMvgPlcglz9IsJ2LAmequw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ozVGQfH0HK6rhGMYDfgkvZ7uDwIlPojVdg/p4xZ88I8W+do/H21R2wJAEFCQdBmYl
         zGLhNAWispSleNoCgX4JpVq/95Igt4iaxVg2o76xaBTPcYGQ7gfxgPVW8xoZ6DKfEZ
         663qNLqrKCTr1+Dv6nviBSf6nlm2PyRBXPRjAKxKkAl3jI2gGCkVaWNBPpcRzL1zi8
         kIi7dTe//g7Pf5n40tCRdWDfIbPUs07wmbNCcWFGl7gOHv5PUdTQNRwbxtsj2bXIAY
         vG1Lb19RpFPIlfgSagsfXJiunqgcB0MGGT1J1QzoRaho1MtY/jO6VKSt8kLhgvFBqd
         w+bQSKsm+Feug==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com,
        tiwai@suse.com, shengjiu.wang@gmail.com, nicoleotsuka@gmail.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        festevam@gmail.com, perex@perex.cz
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1663925494-9941-1-git-send-email-shengjiu.wang@nxp.com>
References: <1663925494-9941-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: Add Hardware Voice Activity Detector support
Message-Id: <166609250118.155136.1014438138123181100.b4-ty@kernel.org>
Date:   Tue, 18 Oct 2022 12:28:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022 17:31:34 +0800, Shengjiu Wang wrote:
> The Hardware Voice Activity Detector (HWVAD) is a block
> responsible for detect voice activity in a channel selected
> by the user. It can be configured in Envelope-based or
> Energy-based mode.
> 
> There are additional two interrupts for HWVAD, one is event
> interrupt, another is error interrupt.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_micfil: Add Hardware Voice Activity Detector support
      commit: 29dbfeecab85fc998d8c5c29473da33d272d0c85

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
