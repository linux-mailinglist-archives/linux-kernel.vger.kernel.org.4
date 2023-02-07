Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7173B68DA19
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjBGOGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjBGOGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:06:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8442F93DE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:06:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EAB46144D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 14:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBEAC433EF;
        Tue,  7 Feb 2023 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675778784;
        bh=h6Asegb3UosZ64SLaFl7xxcR07djTQ+PvmszvRBil6w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=p93Ap3nummMzTCFrhTuIZj/pRJupCaGKWU2886vJi7VYMArbOWawjy7df6+SgP6ar
         fmjWTVRM+c7pgNSFVvFCOFnmSjnxgWEXrcqX8H2zpEkPl0Lgu7ThM+wLFGO8dW0WYv
         6CrKIqz1fGb2Or7NvZdHzkI1rLD9ZvD4EUbMNmIqxf5wAQsV5tQqrAs5EbUyZAAjKh
         pqvu1AmoB37Z+S5Jg6UCdUSBLz3dbXY88k1ub18XXWClIekN8tSOpusycWYxTcGykR
         8ldPt5g+CdT1PdhbfQD2HiY8xHTQGPsgukFWx6ahPE0MURRHv5p9EOT2M+rUl/86f4
         QYXoHwKWQT03w==
From:   Mark Brown <broonie@kernel.org>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1675760664-25193-1-git-send-email-shengjiu.wang@nxp.com>
References: <1675760664-25193-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: fix getting version from VERID
Message-Id: <167577878194.133259.5914289862792868772.b4-ty@kernel.org>
Date:   Tue, 07 Feb 2023 14:06:21 +0000
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

On Tue, 07 Feb 2023 17:04:24 +0800, Shengjiu Wang wrote:
> The version information is at the bit31 ~ bit16 in the VERID
> register, so need to right shift 16bit to get it, otherwise
> the result of comparison "sai->verid.version >= 0x0301" is
> wrong.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: fix getting version from VERID
      commit: 29aab38823b61e482995c24644bd2d8acfe56185

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

