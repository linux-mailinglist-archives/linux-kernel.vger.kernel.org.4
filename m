Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB69C6A5E81
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjB1SBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjB1SBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:01:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E472232E5A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:00:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B7FEB80E1C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C570AC4339C;
        Tue, 28 Feb 2023 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677607235;
        bh=OEe2wAjAN5Wk3+/Gr8WAFlMWCXBu8whw25LrAQEArjE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fUlCaCrme1FbHiY+4s3OeDrWTDvt7fHBRl0xaqaILYRrDLdhpn62iLCwpX0Oh9206
         Ct1GeeXawus4QVZYYiHmMMdLF+xK4pmRH+zVFh9K+F7kuZ+Ap1W+evafNlck9QXwsp
         YlTHeccnaa96QFRp4Id+YULbn7dTGg2WMH+91yHb7oYCmnNlf72rkOlBIEjfF0frvU
         b5Xwte7IR9Cn/kMnvv3Tggtj0cXiSYKSe2Uh308K8VmCMrhiRSJegdg+nPm6tjaXsQ
         6QK0CexD+vrAVnKmX9MHf2HnkbIMNtLmJkCrecSFo00kMscjEiMBpTSrr5Dqi/PoEr
         dbDoSeqUwRffw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230224-asoc-mt8183-quick-fixes-v1-0-041f29419ed5@kernel.org>
References: <20230224-asoc-mt8183-quick-fixes-v1-0-041f29419ed5@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: mt8183: Fixes from an initial glance at a
 kselftest run
Message-Id: <167760723351.68866.5282074700831903370.b4-ty@kernel.org>
Date:   Tue, 28 Feb 2023 18:00:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Feb 2023 12:49:55 +0000, Mark Brown wrote:
> This is a collection of fixes I came up after glancing through an
> initial test run with the snappily named Kukui Jacuzzi SKU16 Chromebook
> on KernelCI.  There are more issues flagged, this is just what I fixed
> thus far.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mt8183: Remove spammy logging from I2S DAI driver
      commit: d71ed1c8f0f458ae6852fdab055790fe1d9d19b6
[2/2] ASoC: mt8183: Fix event generation for I2S DAI operations
      commit: 18f51ed09888c8e48bd377d1715d4ff807b4c805

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

