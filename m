Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25B2742407
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjF2Kdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjF2Kdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F5A131
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F50761468
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CBAC433C0;
        Thu, 29 Jun 2023 10:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688034817;
        bh=ht1qNZF4KX3M/efdGnf/Az/pWW67R1VnaSPdNmW9sWA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qmfa99OM1nUjVvtw7qps2zR+MT/Y6HbfjSAIq9U8REWENtccwMfOmUOhTF7d2RYW0
         LaX1INcDg5R6MzqZO4kdKbw6sbt2B/0PMXb1iKcA1nuLmfj1c0rheUNGm7y0xXTRzZ
         9vxXFd6kuO+Hpsbk4LUE8xFrx57VVXYR5IuFfl6CxIpCTEdZvKRgTK9yJ9y8s6a+Ru
         6hIT3hrNhjcwoEIRyyOEu7MSOZ2pXmJ5KmZeqJTjQhmNXqSubUU/H5cEOLoXXHe8vF
         rXyOF2r5pqm+SP9xEKd6pXI3nH6jVSmkXOyerqMC6CVGRz0RUXLg9EBVRxXeIT7nKB
         sbZT4XOHBuQvA==
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230626105356.2580125-1-Vijendar.Mukunda@amd.com>
References: <20230626105356.2580125-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 1/6] ASoC: amd: ps: add comments for DMA irq bits
 mapping
Message-Id: <168803481518.25247.6406644921534849889.b4-ty@kernel.org>
Date:   Thu, 29 Jun 2023 11:33:35 +0100
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

On Mon, 26 Jun 2023 16:23:49 +0530, Vijendar Mukunda wrote:
> Add comments for DMA stream id and IRQ bit mapping in
> ACP_EXTERNAL_CNTL & ACP_EXTERNAL_CNTL1 registers for
> SDW0 and SDW1 manager instances.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: amd: ps: add comments for DMA irq bits mapping
      commit: 7beda6a256ed10e74dc00fcd0fc8da0ad8fea78d
[2/6] ASoC: amd: ps: add fix for dma irq mask for rx streams for SDW0 instance
      commit: 322a163ea6a38f63555d824c5b66c7df5a595c2d
[3/6] ASoC: amd: ps: fix for position register set for AUDIO0 RX stream
      commit: f15f6b294dde506bd4902db3262e9b4ab7e9e5a9
[4/6] ASoC: amd: ps: add comments for DMA register mapping
      commit: 46b50e514b191ae15789cccabace5b6040c9278e
[5/6] ASoC: amd: ps: fix byte count return value for invalid SoundWire manager instance
      commit: 68a653ab864ccf7874fe622f3af20fe7345c39be
[6/6] ASoC: amd: acp: fix for invalid dai id handling in acp_get_byte_count()
      commit: 85aeab362201cf52c34cd429e4f6c75a0b42f9a3

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

