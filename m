Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D7B604C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJSPya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiJSPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:53:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A3E18F25B;
        Wed, 19 Oct 2022 08:51:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B399B61943;
        Wed, 19 Oct 2022 15:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EB3C433D7;
        Wed, 19 Oct 2022 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666194615;
        bh=wScyHxczwHL75RmoXOfql5d13NwOHcmOL0uKxW2svyU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=D/ZLocZFqh2oVDNt4qIJijuw6psZZCGYbZq/vMqTpVdAHmJab5OKwDkNJa9FZhS+R
         6U9yEV97Zoz/IEcwhoeRgpoyVELIlzUiofWUpEDoeO/xfuI2W+6opBwCt/2eiA8TLG
         J1a9DdqVaTC1bmqmtJ0hkDgvAe6LBA79wEeuPfrl0em6jFFkI/z+cmjhPouDLSSs/R
         htcs8QqrN7D7r8PspZR8YmDpa+M/VWwrBoaqVICPdvAOs1sLzRPmLKOBMWkTlCZKex
         C+kvGspb0YsLZxErffHZPmGRcPApRb7YMk7FD6zo8S59GfxMd6L9lo8sWLVpu0kL37
         uJEHAzB105RvQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Paul Cercueil <paul@crapouillou.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Colin Ian King <colin.i.king@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20221019071639.1003730-1-colin.i.king@gmail.com>
References: <20221019071639.1003730-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next][V2] ASoC: codecs: jz4725b: Fix spelling mistake "Sourc" -> "Source", "Routee" -> "Route"
Message-Id: <166619461311.884966.9257209469691313865.b4-ty@kernel.org>
Date:   Wed, 19 Oct 2022 16:50:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 08:16:39 +0100, Colin Ian King wrote:
> There are two spelling mistakes in codec routing description. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: jz4725b: Fix spelling mistake "Sourc" -> "Source", "Routee" -> "Route"
      commit: df496157a5afa1b6d1f4c46ad6549c2c346d1e59

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
