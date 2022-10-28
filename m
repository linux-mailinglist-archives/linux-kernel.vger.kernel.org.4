Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF1F611A48
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJ1SlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJ1SlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:41:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D091E747A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98EEC62990
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 18:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12E0C433B5;
        Fri, 28 Oct 2022 18:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666982458;
        bh=J63xDN385WkYcttUjIeqnREI32txKyEasspmaUYdsLE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=p3SAEcPxoYii2PMtDoxWHkXSmxMSQ42EndrIJ+V1qS7V3g+XgalhhtkRA8t+YUzN+
         zVp+7s8aX5Gm7Umru3MbNqmKEpwlPCJzumgA/KCVBuATMMoUoYk357IelsbXZm5ejc
         yhWAulR6D21cFOYk4sIPJJ2bXhbZXabilQeNsrCY3tGHzrLUB37ydCuoVl/2gtYHFo
         Ka0WSNpoQx2pK/EmlutLS2eu2jjhCPER0dl7VPuznOefX5h+DipU57BJ2JX7mNMxev
         ChrsfLJWz9W6xGe4XWBi/BLhxpRAsSyiHaUZh4/i1Z6R4rx+gXvwZ1DqpEqjxTp3Ft
         2pfA2DUDXUNxQ==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Maarten Zanders <maarten.zanders@mind.be>,
        Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20221028141129.100702-1-maarten.zanders@mind.be>
References: <20221028141129.100702-1-maarten.zanders@mind.be>
Subject: Re: [PATCH] ASoC: fsl_asrc fsl_esai fsl_sai: allow CONFIG_PM=N
Message-Id: <166698245564.1295082.1282154196218067970.b4-ty@kernel.org>
Date:   Fri, 28 Oct 2022 19:40:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 16:11:28 +0200, Maarten Zanders wrote:
> When CONFIG_PM=N, pm_runtime_put_sync() returns -ENOSYS
> which breaks the probe function of these drivers.
> 
> Other users of pm_runtime_put_sync() typically don't check
> the return value. In order to keep the program flow as
> intended, check for -ENOSYS.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_asrc fsl_esai fsl_sai: allow CONFIG_PM=N
      commit: 6a564338a23cefcfc29c4a535b98402d13efdda6

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
