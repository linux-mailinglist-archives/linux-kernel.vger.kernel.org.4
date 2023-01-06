Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E2766053F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjAFRFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjAFREv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:04:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32927A38F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:04:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C1DA61E63
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8866EC433D2;
        Fri,  6 Jan 2023 17:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673024689;
        bh=TGkLPAmTHI5beVTILN8LxRcgzvniy8G4IAn2VJlDzyA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=f9NxORnQR6/ut/Ch2IGD/2R76unIwu7QF65ukKZLaXVfb1xS0w1Egp25zgaiLoie6
         NYUWt8SVopKDC+K5ZkTNK7+YCpxZ+VEFHRjXOlLXoU6AEq3K+zqLbXvBNpDtd/W48x
         q9Wq3AMzB/axbdkXMj4q8H4W32rRJJq21sT/ZufIopm7NoihEkewyebt8zJ4FrFDRS
         355N70kyyXV3ChAjWGCJ3i+hcevyJ/SbJ/63YjGM9E2cb3qSjp5/rZP7MYRQtK6FS3
         /ZHJi8D0r18hGgv+QG1vRD10Y+iSeCKjZ9mL0bszhFLyFGnX0xYVmDsGUwH43WPKgm
         hnDaNseS5KrQg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, syed.sabakareem@amd.com,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
        basavaraj.hiregoudar@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230104055435.321327-1-Vijendar.Mukunda@amd.com>
References: <20230104055435.321327-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/3] ASoC: amd: ps: add mutex lock for accessing common registers
Message-Id: <167302468725.215080.6874492373066173949.b4-ty@kernel.org>
Date:   Fri, 06 Jan 2023 17:04:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-214b3
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jan 2023 11:24:29 +0530, Vijendar Mukunda wrote:
> Add mutex lock for accessing ACP common registers across different
> modules.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: amd: ps: add mutex lock for accessing common registers
      commit: f763fb2fc93065d33f17fe9c5adeac8dec7713dc
[2/3] ASoC: amd: ps: use acp_lock to protect common registers in pdm driver
      commit: 45aa83cb93885d406c178498623b01cf128ca233
[3/3] ASoC: amd: ps: remove unused variable
      commit: 948f317fac06f8c0e2dea8c37f5ae5ee10514034

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
