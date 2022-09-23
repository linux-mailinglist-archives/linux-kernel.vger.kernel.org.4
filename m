Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1465E81B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbiIWSV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIWSVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:21:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125D0113B51
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A000F621B8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 18:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6EDC433D6;
        Fri, 23 Sep 2022 18:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663957314;
        bh=nHs2AfrvtEk1XxvpH+aLNwlJHpGH5OeAB5BjgaRdNn8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Y7dXJdughMertrvwxRUGuz8LzjWUTBvV5X48hlDNnHdB1j7npK5z+KTRictpFfUrL
         84VLE38m3G0bW06zvrH4NKm8KuscGbXgmkvR834NV/RuvG9XWmmGj26gWdnmdXYrFr
         a775kFaLzRN+IiXdgDSL3iU2Q03MRLvU93oadp6SNz+iUiL/HaDa23sNB/daKo+ka7
         R01XG81lq9Bhp4sllixfmqsKK/M2/GZrcduG2bzmo4O2tHSI1rxoqOgHxaVOtBmH+T
         cJY3/yEG/SRyqzJ/w/vksueuKOy4TNZbcAi7m12zQ7aL5tPc0eUJIfnSNo7LvhtP9/
         UzP1anJQ9lcBw==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>, tiwai@suse.com,
        nicoleotsuka@gmail.com, festevam@gmail.com, Xiubo.Lee@gmail.com,
        perex@perex.cz, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1662446961-20799-1-git-send-email-shengjiu.wang@nxp.com>
References: <1662446961-20799-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] Revert "ASoC: fsl_audmix: make clock and output src write only"
Message-Id: <166395731156.751793.9528112393184864154.b4-ty@kernel.org>
Date:   Fri, 23 Sep 2022 19:21:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 14:49:21 +0800, Shengjiu Wang wrote:
> This reverts commit 944c517b8c838832a166f1c89afbf8724f4a6b49.
> 
> There is error after making clock and output src write only
> 
> $amixer -c imxaudmix cset numid=1 1
> amixer: Cannot read the given element from control sysdefault:3
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Revert "ASoC: fsl_audmix: make clock and output src write only"
      commit: 086ceada2107b482df437d76f581062b547eb7f2

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
