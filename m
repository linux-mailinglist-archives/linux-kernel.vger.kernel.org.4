Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159C96116CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiJ1QFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJ1QEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:04:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17C663B9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50CD3627FC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C60C433D7;
        Fri, 28 Oct 2022 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666972973;
        bh=wNXKotwuuxgi6yUVKqYwBdPAK78kh9kgseKN/VlZMsQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QoMxNCkbqCrOrhXaqnGoLA1VvcD3H75wwfwDf4OmM04KM6glN09KDgQGZ12VkVQVW
         DL+lkbzixjKEznebXjDlvZtDbvqWfHPChXvnNfsQokZPKiB/wg9z0EAZ/GcAeWvTE5
         ySAgSvhMx8cATgMQ3GT/8UMaFY0q3usVtI3roTXE5Un6D21+Ny0cZUDFhLJ3JLP+XU
         5sc0suRcC57UX4gv45jaHbE1WVkH5UN81F+xxVhy2mTRtU/NwE+FJ/wGTVooHxJnaL
         Kw1W3b9ac5bff3ZNOX9/KOwbj4mNNVxaufY5KHuEJMgVtjXHPLemjuDMJbhNzR+dZU
         RMNwt01hsnRLA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        Xiubo.Lee@gmail.com, shengjiu.wang@gmail.com,
        alsa-devel@alsa-project.org, perex@perex.cz
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1666940627-7611-1-git-send-email-shengjiu.wang@nxp.com>
References: <1666940627-7611-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: Add Counter registers
Message-Id: <166697297135.717517.11089794085800695281.b4-ty@kernel.org>
Date:   Fri, 28 Oct 2022 17:02:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 15:03:47 +0800, Shengjiu Wang wrote:
> These counter registers are part of register list,
> add them to complete the register map
> 
> - DMAC counter control registers
> - Data path Timestamp counter register
> - Data path bit counter register
> - Data path bit count timestamp register
> - Data path bit read timestamp register
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: Add Counter registers
      commit: 107d170dc46e14cfa575d1b995107ef2f2e51dfe

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
