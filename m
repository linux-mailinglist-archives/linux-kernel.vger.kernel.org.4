Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FA7602A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiJRL22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJRL2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:28:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEACB2D84
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 04:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FF946152A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E67C433D7;
        Tue, 18 Oct 2022 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666092498;
        bh=2czOyIDBUB3CqMOzovdj6UL0X06QQPgmsW5la3PM4HY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PARvKbJCr2B9vqFO9qnriu1DL9JcO9i02A/Q1PdcxaTJgm3oPxGT2aUFlFoQcpbut
         +tT7jjZCRWAHL81E3rNybcUnqt4j1ATy/p4VU6hfJwOjw/BjdRDtD41lWF7qnJhHVH
         WOQ/XUZB9E2v8PWurOAWr7sxUgMFyZxWBEpM2/2hjUHuIoAxZqjujZUNFoYhHleAa0
         pWaM4D2Y8AWiOqEPg+cF0PNbbA3lVMTb9xN9SstZTdc1vEOj19EldZlSkgLqEawmsL
         kLyUc8UrZSZ+AScO6hJ/aunjFkGPm2V5DQjG11yfmUWFjqaFb/1R4USvWcN0dSbibr
         ZGlOb8vbpAojQ==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, tiwai@suse.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        viorel.suman@nxp.com, p.zabel@pengutronix.de
Cc:     shengjiu.wang@gmail.com
In-Reply-To: <1665664611-21350-1-git-send-email-shengjiu.wang@nxp.com>
References: <1665664611-21350-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: ak4458: add optional reset control to instead of gpio
Message-Id: <166609249692.155136.3225600630322648338.b4-ty@kernel.org>
Date:   Tue, 18 Oct 2022 12:28:16 +0100
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

On Thu, 13 Oct 2022 20:36:51 +0800, Shengjiu Wang wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> Add optional reset control instead of GPIO to manage codec
> PDN pin.
> 
> As there is reference counter for reset control, so need
> to remove one ak4458_reset in runtime resume to make the
> reference counter balance.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ak4458: add optional reset control to instead of gpio
      commit: 8a0de73cf9dc044d65ad40112fd00025e225bc83

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
