Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C216E7CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjDSOfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjDSOfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:35:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF15CE;
        Wed, 19 Apr 2023 07:35:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F35FF6238A;
        Wed, 19 Apr 2023 14:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2F1C433D2;
        Wed, 19 Apr 2023 14:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681914914;
        bh=sBYbUiJ6GlCWj4lYqLlaskm6OAopEbc4bQC5luPU9Tg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OKKeavw9KAKCyJMFID/gsexph94AvBnlqXJYcXH8ScMbhtZRBm/XzDjUamvrscn/t
         lANg4Ig3Te4XIhTywIcanyOf0gdNLui07r9YSDxXwHHcizz7wYdUMimUisEQPCW/23
         WUB3ETEuam2/O71qFvPHRLhTZpJpYqDEQxCDZiaaCGn3tPN954phonD8c/xtOLzIru
         vs1kpvSYFr0JcIH5xwQRmgs7lkDCW4I9qVMuMupi6bq0UnxRcLK2urzhE69QvPoZ5u
         stDFtMNvNMyomVbDSe/XFbJmTDRhtP6RaMFYB1M2xewMzPslHBcyl+kEtV/lmE+CLn
         9a/JSMhue0uTA==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <c167c16a535049d56f817bbede9c9f6f0a0f4c68.1681626553.git.christophe.jaillet@wanadoo.fr>
References: <c167c16a535049d56f817bbede9c9f6f0a0f4c68.1681626553.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: fsl: Simplify an error message
Message-Id: <168191491177.87831.11926959447891085887.b4-ty@kernel.org>
Date:   Wed, 19 Apr 2023 15:35:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Apr 2023 08:29:34 +0200, Christophe JAILLET wrote:
> dev_err_probe() already display the error code. There is no need to
> duplicate it explicitly in the error message.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: Simplify an error message
      commit: 574399f4c997ad71fab95dd875a9ff55424f9a3d

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

