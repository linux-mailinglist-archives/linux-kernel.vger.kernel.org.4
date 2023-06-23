Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4173ADF1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjFWAtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjFWAtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:49:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C722107
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:49:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 678616194A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 00:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DB6C433C8;
        Fri, 23 Jun 2023 00:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687481381;
        bh=oJHJEMY/Tw4oHZ3YcvE0+KStZz9Rx02eJWvCCGe1ao4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=L9ibKQDOSYOvHCUs7vTYVlJjtEyjqdYm2dfNqkvnG95BBpbDsLHi1xX0BPl94kn50
         Z0JY5dHu+LZgZpQXfKq1HsGGp4wtyPt/WXTFwj5D2dpjzlHKjP1QXk1OHH+iobfggM
         PaoEKDtPLjqBTL6Bo7YHUORNd0kA7HA2ScyQ8xjjAaiPzf4oGec7+/ydYC3VLB4Xj3
         NroBDQtXM+KypK2rVF42Z01GOhKOSWbchmGSn7l5d/lFcxsAGty1ADf3tEJMMWzhR5
         FooWAciyx7oQES5HJOyg41nFy1T/R3IkKwnyTyO1vQ3HXlTj6tEYFmeGrkgKPLdjny
         I66nHhJZ8gy3A==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
Subject: Re: [PATCH 01/12] ASoC: amd: acp: clear pdm dma interrupt mask
Message-Id: <168748137822.337790.12159310582328534204.b4-ty@kernel.org>
Date:   Fri, 23 Jun 2023 01:49:38 +0100
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

On Thu, 22 Jun 2023 20:53:38 +0530, Syed Saba Kareem wrote:
> Clear pdm dma interrupt mask in acp_dmic_shutdown().
> 
> 'Fixes: c32bd332ce5c9 ("ASoC: amd: acp: Add generic support for
> PDM controller on ACP")'
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/12] ASoC: amd: acp: clear pdm dma interrupt mask
        commit: ad60672394bd1f95c58d3d9336902f47e05126fc
[02/12] ASoC: amd: acp: remove acp poweroff function
        commit: 3eb96217c16cb7be0fe6e1d416ff4fe47f686bea
[03/11] ASoC: amd: acp: add acp i2s master clock generation for rembrandt platform
        (no commit info)
[04/12] ASoC: amd: acp: add acp i2s master clock generation for rembrandt platform
        (no commit info)
[05/11] ASoC: amd: acp: store platform device reference created in pci probe call
        (no commit info)
[06/11] ASoC: amd: acp: add pm ops support for acp pci driver
        (no commit info)
[07/12] ASoC: amd: acp: add pm ops support for acp pci driver
        (no commit info)
[08/11] ASoC: amd: acp: export config_acp_dma() and config_pte_for_stream() symbols
        (no commit info)
[09/11] ASoC: amd: acp: store the pdm stream channel mask
        (no commit info)
[10/12] ASoC: amd: acp: store the pdm stream channel mask
        (no commit info)
[11/12] ASoC: amd: acp: move pdm macros to common header file
        (no commit info)
[12/12] ASoC: amd: acp: add pm ops support for rembrandt platform
        (no commit info)

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

