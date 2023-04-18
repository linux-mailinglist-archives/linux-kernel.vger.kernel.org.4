Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E3F6E6BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjDRSJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDRSJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:09:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6594D1FE4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E76666377A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 18:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76ADFC433EF;
        Tue, 18 Apr 2023 18:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681841342;
        bh=CXOYtsBMCLdNP3Hr98JNrBWJGbiewjsk+S8BD+mS85w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Tyfty+zDc4kXnAqvKvkA+n/AjbVCGCJBktGil2MiU6a0E5K6uiIoQeHuwZ3G2a+YV
         0tCsrYa34bWNk15dIF7wN5ifK/RYwBbT3HrKArO92aHxTfxYoYYsSP+HeRSVYbmSe8
         zaOehVV8miW7CzrAVgYnmXT3D1POfyF8xHiz6WreZ0ERE3oV7sOzWPdZFVYmFSpzT8
         /Ccn3xLl9O2WOYjuQMDrPJImxp2BiQRDe7IkGVMW2ojR0hjOpR6YNpCEgt1qPTS/zz
         hnK2pXUrtHV+B0ZFqecFpmw9YNvst6r4dX6kRQ2oaRVW7WC10/kGvXbe2HWnelnwl2
         mzfj2bw5a+G6g==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230418144309.1100721-1-rf@opensource.cirrus.com>
References: <20230418144309.1100721-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/4] ASoC: cs35l56: Updates for B0 silicon
Message-Id: <168184134118.119808.12469329412185790363.b4-ty@kernel.org>
Date:   Tue, 18 Apr 2023 19:09:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 15:43:05 +0100, Richard Fitzgerald wrote:
> These patches make some small changes to align with the B0
> silicon revision.
> 
> Richard Fitzgerald (4):
>   ASoC: cs35l56: Update comment on masking of EINT20 interrupts
>   ASoC: cs35l56: Remove SDW1 TX5 and TX6
>   ASoC: cs35l56: Remove SDW2RX1 mixer source
>   ASoC: cs35l56: Rename mixer source defines for SoundWire DP1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: cs35l56: Update comment on masking of EINT20 interrupts
      commit: 16e5fc8ae793947d7dd0de63c7a613798f75c237
[2/4] ASoC: cs35l56: Remove SDW1 TX5 and TX6
      commit: 5ab28c78a125a724684958f4caf8210127d3f528
[3/4] ASoC: cs35l56: Remove SDW2RX1 mixer source
      commit: d3a4efb334e5f6cbb3f2741fa07a873a2a78b016
[4/4] ASoC: cs35l56: Rename mixer source defines for SoundWire DP1
      commit: d29a966b72fb370128096393961f2c456ff24e3d

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

