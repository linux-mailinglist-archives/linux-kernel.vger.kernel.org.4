Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8A86E8134
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDSSZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDSSZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:25:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4AFD2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 368FA64166
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADE1C433EF;
        Wed, 19 Apr 2023 18:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681928745;
        bh=2P38Dw70hIslqESCsP4xROGp7y6M/3NfsY5sjrm73kc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CDQvHa098OUr1TV+UYmGrjfxifLo/RGveTTYnTeR6EbI4whpre6POiH8WZIEoYCUs
         SbKSYpcb7j0Ovj8KoEu2B/SQcXoRCQxCvJE9OlhofYZEMW4Ov0km+NRxLoGAZm9Sh3
         L0S7b2F0fH1KvR692twl6VSdpPcnJo5Fa7mQHGrxhLoXsLDXFjvynHtGSqDPqo3s9o
         xIV5+PwIaZM9bKV7S/r0c28xMBBLGgW44usD9vNJHeTKlTLhNC/mYXtngjQBTGOFwU
         2zinwSVQbf5Higgr0d7Gr+wkVA1CWh8RbyBjwgziBfRYOltTtMJ60clU3rOGcUABFK
         9i7F+w/0JL5ug==
From:   Mark Brown <broonie@kernel.org>
To:     kuninori.morimoto.gx@renesas.com, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <1681900158-17428-1-git-send-email-shengjiu.wang@nxp.com>
References: <1681900158-17428-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] Revert "ASoC: fsl: remove unnecessary
 dai_link->platform"
Message-Id: <168192874180.115075.9783971012630228095.b4-ty@kernel.org>
Date:   Wed, 19 Apr 2023 19:25:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00e42
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 18:29:18 +0800, Shengjiu Wang wrote:
> This reverts commit 33683cbf49b5412061cb1e4c876063fdef86def4.
> 
> dai_link->platform is needed. The platform component is
> "snd_dmaengine_pcm", which is registered from cpu driver,
> 
> If dai_link->platform is not assigned, then platform
> component will not be probed, then there will be issue:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Revert "ASoC: fsl: remove unnecessary dai_link->platform"
      commit: 09cda705860125ffee1b1359b1da79f8e0c77a40

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

