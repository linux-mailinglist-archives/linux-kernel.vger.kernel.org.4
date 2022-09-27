Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12F65EBFD0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiI0Ked (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiI0KeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880A1EEE85
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 250AE617B3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3863CC433C1;
        Tue, 27 Sep 2022 10:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664274862;
        bh=Owy1eL2zE7HjhpIKBG9ABMOlVvTMODzZLcYVa8P0yAg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LI+DMpEborBOpALwawGLrA7Gp6QTKN9vCaonpEbHUS3pywUfHGgbjEcLZVvOGuB24
         oCikCvvncq1xAOHSRShgaZ6wxdyjW5P+R6TGVLFNuyVPbzlJZTf2aXuJr6/bx8rnOI
         Rfz09p+BdnMsKCUr7OXgWFntqOCcEP/V9RAtcOdh/TfA+fMml7FIHaNFIYNfGNi2T6
         pVTHWOy8bnlEN+NiFxJQ/aNvqVKTFbkKlRyg7hzf1oVtGUQ65ZEspimTMYmEGh1/Mf
         1mZ/3uhLCUfEWzMTbWKrA0AZwxgYvCroGbmaPt38qNEfwOZ7iAggm57nihzPjI8e7H
         b19wcoTmMwgPA==
From:   Mark Brown <broonie@kernel.org>
To:     festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
        tiwai@suse.com, perex@perex.cz, shengjiu.wang@gmail.com,
        alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Xiubo.Lee@gmail.com
Cc:     linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1663928147-10106-1-git-send-email-shengjiu.wang@nxp.com>
References: <1663928147-10106-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [RESEND PATCH] ASoC: fsl_asrc_dma: fully initialize structs
Message-Id: <166427485994.60697.4779578506404492678.b4-ty@kernel.org>
Date:   Tue, 27 Sep 2022 11:34:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022 18:15:47 +0800, Shengjiu Wang wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The driver uses two statically ininitialized struct dma_slave_config,
> but only one of them is initialized to zero. Initialize config_be to
> zero as well to make sure that no fields are filled with random values.
> Let the compiler do this instead of explicitly calling memset() which
> makes it easier to read.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_asrc_dma: fully initialize structs
      commit: 1849a1505533501ea39ed0538c2d35eba4704baa

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
