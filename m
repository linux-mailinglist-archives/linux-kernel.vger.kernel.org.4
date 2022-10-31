Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6199F613DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJaS7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiJaS7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:59:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2C9271F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:59:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A62C6139D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D831C433D6;
        Mon, 31 Oct 2022 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667242789;
        bh=EUan7w4Lh3vkM5N6lp0/PKwFmfPibbJ8z8DWzSwPcdk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=byZuPJ+fTf1MB85zdbYO64I2eNR/g5Le0sH0k13Owhx/xk26iSZE0Ud9rDMd4+EQk
         52KfXSwq80fBcmHNXnp7GFYZ2Gltt1hrVjS2HHVWJhgbJNd+G/m2QxQaR+tAYZGRaT
         UMT0XsuEFA7BSyA1U37LAfgrRJIqYr8IjaFDhXF+YUDlxefm8mOfj0S9lc4GWzBUOv
         z8D5kXUytwX4l15oH/SASizRtZima6yhig2XBPHu7nQMM7AEgmpqqjRoqfYAQrU6so
         bVV0eD7Y2MMmk+4xDqZPppqi4XrjovtSyr5tTe04DlGzvDv3L8KTo1X94HL65lc/dd
         BPZ3xzJ5HiIgA==
From:   Mark Brown <broonie@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com
In-Reply-To: <20221031134031.256511-1-chenzhongjin@huawei.com>
References: <20221031134031.256511-1-chenzhongjin@huawei.com>
Subject: Re: [PATCH] ASoC: soc-utils: Remove __exit for snd_soc_util_exit()
Message-Id: <166724278811.784642.2068517227197226449.b4-ty@kernel.org>
Date:   Mon, 31 Oct 2022 18:59:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022 21:40:31 +0800, Chen Zhongjin wrote:
> snd_soc_util_exit() is called in __init snd_soc_init() for cleanup.
> Remove the __exit annotation for it to fix the build warning:
> 
> WARNING: modpost: sound/soc/snd-soc-core.o: section mismatch in reference: init_module (section: .init.text) -> snd_soc_util_exit (section: .exit.text)
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-utils: Remove __exit for snd_soc_util_exit()
      commit: 06ba770a799fab51e42c34fd62b742d60084d8b1

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
