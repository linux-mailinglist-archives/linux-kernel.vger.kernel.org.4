Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8654D6D63AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbjDDNps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbjDDNp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:45:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F014F4C3C;
        Tue,  4 Apr 2023 06:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 742ED6342B;
        Tue,  4 Apr 2023 13:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35227C433EF;
        Tue,  4 Apr 2023 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680615915;
        bh=QbKOfwkYmEZxqJrLdeZwqiVVRzEx/YEVnqeq1gCUNSk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tKx5Pde08Zpmg8iF4kGQif6ZA2f1mKakatyGHkxdyYv6RYyMf7G+Ve6nx9qcDKHr1
         hPmgeUm2981qdUbGjZTRPfFuDPWuxU+Y9Dgv/q+TgwFZCFRIpbJ9tYDZ7XG7PS3a9K
         rX40k2hUqZOuvRaNRQGYHiKuM1iUPfHasCdIoBcqzWHfXJuC56wkWMir9YHr04XZBy
         jk1WVuJb9XVNcskPSkWHVVnRNN4W1gLL0NLTVFt0Fv4XnFAg6TKYYTvfRO1h0y2XLs
         2PLoyeunKd8CC5OJcGky1s5D23tbnJevA8MiqJof0qYhckwx8jgoEOBvyA9gEPtNTR
         diHuqaBT1wjmQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zihao Wang <u202012060@hust.edu.cn>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dan Carpenter <error27@gmail.com>, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230404084622.1202-1-u202012060@hust.edu.cn>
References: <20230404084622.1202-1-u202012060@hust.edu.cn>
Subject: Re: [PATCH] ASoC: tegra20_ac97: Add missing unwind goto in
 tegra20_ac97_platform_probe()
Message-Id: <168061591290.45547.6311977910704491174.b4-ty@kernel.org>
Date:   Tue, 04 Apr 2023 14:45:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Apr 2023 16:46:22 +0800, Zihao Wang wrote:
> Smatch Warns:
> 	sound/soc/tegra/tegra20_ac97.c:321 tegra20_ac97_platform_probe()
> 	warn: missing unwind goto?
> 
> The goto will set the "soc_ac97_ops" and "soc_ac97_bus" operations to
> NULL.  But they are already NULL at this point so it is a no-op.
> However, just for consistency, change the direct return to a goto.  No
> functional change.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra20_ac97: Add missing unwind goto in tegra20_ac97_platform_probe()
      commit: 194f8692302cbf31d8072f3fc2710fb04720d8a0

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

