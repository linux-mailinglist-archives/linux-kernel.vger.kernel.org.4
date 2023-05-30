Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83638716B49
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjE3Rkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjE3Rka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:40:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A67BA3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:40:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1FE062BF4
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCDEC4339B;
        Tue, 30 May 2023 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685468428;
        bh=Z6D/5uzYpSL70zHtKS1o/zAljvJP+MVPP/cIfYT7yO0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JQLSs2d/iWlceF7dw4Q9zQVSkH4EeyTsiPJfLlcqU7iMj0FmSS1wVGVyzMnFPpcWy
         JyamttMKEK5LiTrCCyMW+68+YK6jlTQdtLLpBKu6gF4MWbC23aY/xPKBZ5ydBkZVHX
         0ckJ9xjRKA4Fh9WTvnNy2TcDgWGgp9ox2jZuU2bwD+8nbIp9C04uaMnwZJKx3foAQR
         TjfyhLc3Sc+GN7L1DY5EjRcHUZBawW7S2v7q22KMDJnp+sXu0BSSBPqJxlHZzYfdeQ
         /+5MHeu0yvBYDp7fsEvv+UrfnLkKkPILnQJdMGQoKO88qwjBb646Ep1kQ6K7wkmx+l
         596V4Ry1LBuZA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     vsujithkumar.reddy@amd.com, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        ssabakar@amd.com, akondave@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230530110802.674939-1-venkataprasad.potturu@amd.com>
References: <20230530110802.674939-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASoC: amd: vangogh: Add check for acp config flags in
 vangogh platform
Message-Id: <168546842506.690777.17939601844913832559.b4-ty@kernel.org>
Date:   Tue, 30 May 2023 18:40:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 16:37:58 +0530, Venkata Prasad Potturu wrote:
> We have SOF and generic ACP support enabled for Vangogh platform
> on some machines. Since we have same PCI id used for probing,
> add check for machine configuration flag to avoid conflict with
> newer pci drivers. Such machine flag has been initialized via
> dmi match on few Vangogh based machines. If no flag is
> specified probe and register older platform device.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: vangogh: Add check for acp config flags in vangogh platform
      commit: e89f45edb747ed88e97a5771dd6d3dd1eb517873

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

