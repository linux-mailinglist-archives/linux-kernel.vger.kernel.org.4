Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AA26DFBBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjDLQsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjDLQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:48:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4DD72A9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27AEA63590
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D2BC4339B;
        Wed, 12 Apr 2023 16:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681317974;
        bh=BxX3A3+QcMTgiJrOfxOMYktRoDe9+HI8F2/cJ/qvsKk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ulib6p0zEHSchuyxnKbhSdO2Vd89+JgYsU28UNpL3nGuZriS8UAXETwu8+6T5nNnI
         sMwuI7n+I954JXtvYrF2dwuNFgnlPPKGL8VcXvQUfL806IWRXQA9sICQjxaY6t0pVu
         Ds7TErf6+TvE+8c5aK6sC19A3LBanf7OXYozfQwSeqZ7YJnFW1cvCIA2MXjIYE2rNB
         aqKG4UNrCtyEkAnmbWGjmxFdGxgR5F8yR6BFLRoW5kh4RgOydzeXyqXq7EgSVvZqFF
         2TcPDDj/6s7UnJDejTEdm/VZQfepcDjwafpO0oSd8LjVfSWE8bFq5tR1apMoReTzia
         XI/3KMJGF4mKg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
        vsujithkumar.reddy@amd.com, ssabakar@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230412091638.1158901-1-Syed.SabaKareem@amd.com>
References: <20230412091638.1158901-1-Syed.SabaKareem@amd.com>
Subject: Re: [PATCH] ASoC: amd: Add check for acp config flags
Message-Id: <168131797043.93781.9548675938995241210.b4-ty@kernel.org>
Date:   Wed, 12 Apr 2023 17:46:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 14:46:16 +0530, Syed Saba Kareem wrote:
> We have SOF and generic ACP support enabled for Rembrandt and
> pheonix platforms on some machines. Since we have same PCI id
> used for probing, add check for machine configuration flag to
> avoid conflict with newer pci drivers. Such machine flag has
> been initialized via dmi match on few Chrome machines. If no
> flag is specified probe and register older platform device.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Add check for acp config flags
      commit: bddcfb0802eb69b0f51293eab5db33d344c0262f

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

