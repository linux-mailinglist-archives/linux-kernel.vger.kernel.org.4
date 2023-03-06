Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFD56ABFCC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCFMpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCFMpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:45:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39992BEE6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:45:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74237B80DFA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418D6C433D2;
        Mon,  6 Mar 2023 12:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678106742;
        bh=M8Fca/wf+XTVeBzks1jMo/X3kmYpve3MqRuDj/MCnQU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KPylVtADQ1OYdqau4QxjVz4PV+nPFGoLT2985BYcf3qLeTde/xndLjzM5TxKQG8uk
         TNmw8pj/OSGD1Ia7mcO7tNV9/Z82FUGqIW9IApA/dDYEwm2XFhFyVVahX3V+DOFvzR
         yjkd5/++N4bASwz0AQuh2dWqjtIM28sUkdjkCZEz8PD4HZBAfyPcwhbDrHCzQEb6Ag
         amSo41Zz/YPl5y152vW2ZIlfWWfyXIJQCNNZeG6w8aBY3T+FyM9h38rB0QTMsklFr6
         jHnsvLsAeqRP/VSEkJINesGZ8PJdVHdImGZpHAsLPvUQolV76la4ftSGipf9ukyV+1
         ci9v03mAwtM4g==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230303093410.357621-1-luca.ceresoli@bootlin.com>
References: <20230303093410.357621-1-luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] ASoC: clarify that SND_SOC_IMX_SGTL5000 is the old
 driver
Message-Id: <167810673999.45838.8887941994878388460.b4-ty@kernel.org>
Date:   Mon, 06 Mar 2023 12:45:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Mar 2023 10:34:10 +0100, Luca Ceresoli wrote:
> Both SND_SOC_IMX_SGTL5000 and SND_SOC_FSL_ASOC_CARD implement the
> fsl,imx-audio-sgtl5000 compatible string, which is confusing. It took a
> little research to find out that the latter is much newer and it is
> supposed to be the preferred choice since several years.
> 
> Add a clarification note to avoid wasting time for future readers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: clarify that SND_SOC_IMX_SGTL5000 is the old driver
      commit: 03d0f97fdb45c99cf6f808832db8bd5534e22374

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

