Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595596882D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjBBPj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjBBPjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:39:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7792A5CE66
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:38:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D809261BD2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18B1C4339B;
        Thu,  2 Feb 2023 15:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675352246;
        bh=Py0H+lR98VdNfeq5TJiyrbOPlLPA72osn5rSa82lGpo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DfelU0cWLmnpu9pmhBNkE5BnsH4UoUpyeNEeW8/bszy/AIWZueG8cyAsePHLMS8XM
         +JtnYJ7QRIBH+6Imxqb1xXgtmdCQ6SkMCPbdvX97KqJG2w+2dlwCETLiOTU8hSx0yf
         UqXmyFP+xZnLqn8yCgiDqI6+B1gfZTlhe2GmkuCAlQdqutBPgdJ/F/J4jGLSx4ppLh
         4wkdXxs5TSsDEpy32cACPy47CzSTJTOHpH+C1lQQIZOP0EgWiuBTtEUf+wARCqjCff
         JtfkxmJ/lE8RGn7M1CIDQRIwkQxMt9ceYtewKh60tFZRoRVl4h2MX4yUXRNwC+xVpO
         9Nfze4ubFqg6g==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <jkysela@redhat.com>,
        Mukunda Vijendar <Vijendar.Mukunda@amd.com>,
        Saba Kareem Syed <Syed.SabaKareem@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230131184653.10216-1-mario.limonciello@amd.com>
References: <20230131184653.10216-1-mario.limonciello@amd.com>
Subject: Re: [PATCH v3 0/6] Fix default DMIC gain on AMD PDM drivers
Message-Id: <167535224445.408582.16811199790062194600.b4-ty@kernel.org>
Date:   Thu, 02 Feb 2023 15:37:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 12:46:46 -0600, Mario Limonciello wrote:
> It's been reported that a number of laptops have a low volume
> level from the digital microphone compared to Windows.
> 
> AMD offers a register that can adjust the gain for PDM which is not
> configured at maximum gain by default.
> 
> To fix this change the default for all 3 drivers to raise the gain
> but also offer a module parameter. The module parameter can be used
> for debugging if the gain is too high on a given laptop.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: amd: yc: Adjust the gain for PDM DMIC
      commit: 6d6f62c868a8ad9c451c22f9f20f08a6149f8487
[2/6] ASoC: amd: yc: Add a module parameter to influence pdm_gain
      commit: 02ea45d10fab99040c87d0267656930accb91e3c
[3/6] ASoC: amd: renoir: Adjust the gain for PDM DMIC
      commit: 47dc601a067d9a79989310c8a1f93ea390ae9ead
[4/6] ASoC: amd: renoir: Add a module parameter to influence pdm_gain
      commit: b7d8d4ec80ee380a82d6748c1d4e9fd89ce6e595
[5/6] ASoC: amd: ps: Adjust the gain for PDM DMIC
      commit: 99ecc7889bee68fdf377f328c21ad0f953f8b05e
[6/6] ASoC: amd: ps: Add a module parameter to influence pdm_gain
      commit: 5579a966229c3365d0e2c91e9a96fc40e293dffa

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

