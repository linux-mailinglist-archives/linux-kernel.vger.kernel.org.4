Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D102702B20
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241258AbjEOLKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241209AbjEOLJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:09:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40AE1716
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:09:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90ABA6229D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4E8C433EF;
        Mon, 15 May 2023 11:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684148988;
        bh=Dvh9tI9Xl3uzM2jJ1Xep2xAC6Nc/oaoWIoRatlpPUfE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=a8nilyUvosgWLYfZFkc00NkLieMjNhu0fdDIXucxn4MZjLLAzSkjY1MBHmVls528O
         bw6Pce54LlBfFJAtCnN6qzksCr3wFKj/3oZ/ywXCiqaCO7nHsusv/WiVh8JvYafmmD
         DfU+MMGLUhJKxzSYoXkTKSZxZvTI4RhZDRbY5mIoJihG4/+vs0XRV98R40a+GtxgFu
         hnpSrES89Jv9zT9M0F8B6M+v0m4jxQ5WFOhUydaz7YqMQPkl0/9nfJBNK8md5Wm2eG
         9UQf7g95XLVOmRgDpyJepSyBEVy+SWZBGrabXMQ/10uG6HIMTQpYUz1poUyV0sO1Mi
         EOGwUz7HfoPNg==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Simon Trimmer <simont@opensource.cirrus.com>
In-Reply-To: <20230512144237.739000-1-rf@opensource.cirrus.com>
References: <20230512144237.739000-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Prevent unbalanced pm_runtime in
 dsp_work() on SoundWire
Message-Id: <168414898656.394037.4680314609233066357.b4-ty@kernel.org>
Date:   Mon, 15 May 2023 20:09:46 +0900
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

On Fri, 12 May 2023 15:42:37 +0100, Richard Fitzgerald wrote:
> Flush the SoundWire interrupt handler work instead of cancelling it.
> 
> When a SoundWire interrupt is triggered the pm_runtime is held
> until the work has completed. It's therefore unsafe to cancel
> the work, it must be flushed.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Prevent unbalanced pm_runtime in dsp_work() on SoundWire
      commit: 17082e09b94cfe60bf39088f3d37c1f10e6c5928

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

