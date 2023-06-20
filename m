Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEB8736E97
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjFTOZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjFTOZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:25:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16026A6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:25:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A663261224
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F965C433C8;
        Tue, 20 Jun 2023 14:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687271103;
        bh=VQUuqZzDE2bMAu2mfG1pwbFRF7YDI40BoAxg5JVo8dM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XlDtEw5hxtjv8YY+vU5lcy+5eiblbutYHhOKrvo3GER7uMQ0Qgde0OBu6rcjTWlkN
         pv2WnoCiLXtsCMe5Pv9Wg6mW7yr7z4jgyvkK6SJS60oPe+pTcQNKWX+43AG4ZC6EO6
         Wqr5QdonbmTgTvKvDjMGJr6C5wbXdgOoe/shnTX3ncAkdwKxZY1aXN1yLBdEiZ9zim
         389+a4gLEIiAu4grYz860X0iIWu1S1+kk8r7UZPlkUIK91q5sDQol/u3iWOgWIrWi5
         o3sczMqI9Jjzik6rCUvsQH4DB4jmD1j6MUVQ7mZAijk45AT7h5MBOs7ZZ3+IIN/UBl
         vAIDLPmyyFd2g==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Maxim Kochetkov <fido_max@inbox.ru>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613191552.724748-1-fido_max@inbox.ru>
References: <20230613191552.724748-1-fido_max@inbox.ru>
Subject: Re: [PATCH 1/1] ASoC: dwc: don't assign addr_width for dt configs
Message-Id: <168727110123.80037.14165724082437733133.b4-ty@kernel.org>
Date:   Tue, 20 Jun 2023 15:25:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 22:15:51 +0300, Maxim Kochetkov wrote:
> For proper DMA operation addr_width must corresponds with audio format
> (S16, S24, S32, etc). Proper bus width calculations is performed by
> snd_hwparams_to_dma_slave_config(). So drop wrong addr_width asignment
> for dt configs and let snd_hwparams_to_dma_slave_config() do the job.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dwc: don't assign addr_width for dt configs
      commit: 6f80197f40515853814d0f22e5209d53f899ab91

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

