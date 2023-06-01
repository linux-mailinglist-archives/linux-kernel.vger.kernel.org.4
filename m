Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9999719F4A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjFAOMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjFAOMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:12:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E97FC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D205A63A3A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E41C4339B;
        Thu,  1 Jun 2023 14:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685628749;
        bh=dtgREO1rMn6LkUwpPKQhnN0y9K6Zffo816EVEew9pHQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Fb3putoiBUseFxJkwI+s9QSkuvasX8/A5gDmxQ/w+TyYMG/Llp8B7QBEANUoL3TVf
         3KTFmwfVkMp6gdOD6qu/yIyW3otXaK3GSmzcZHIZ78D22dYUBZiyvVbvhYNwQBB+Q8
         /7LFB3TfGtd6w2fCNPxg0sDfgWxq8xY/eXxGHZwvLeJhCbxj5YUwdFLfeVCFG8q6SP
         rqQJ6mQoJkHMx9+ciFXdNxltmvar6WyiIO2K/rfAdIHwWLYJksfL7pOmDow5tH5Pmp
         L7OqQZXGNbn/AW1Pzsu/79pnsKVx93OBf/Z1fDVMLaS6vtL++NK14gemju4XYvG1SB
         XhNTl8argwSCA==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, lgirdwood@gmail.com, tiwai@suse.com,
        perex@perex.cz, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     yc.hung@mediatek.com, tinghan.shen@mediatek.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230601034939.15802-1-trevor.wu@mediatek.com>
References: <20230601034939.15802-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH v3 0/1] ASoC: SOF: add mt8188 audio support
Message-Id: <168562874539.66708.811919351455149149.b4-ty@kernel.org>
Date:   Thu, 01 Jun 2023 15:12:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 11:49:38 +0800, Trevor Wu wrote:
> This series adds mt8188 audio support and dbg_dump callback for
> mt8186 and mt8188.
> 
> Changes since v2:
>   - resend the correct patch for adsp debug dump
> 
> Changes since v1:
>   - fix typo
>   - adopt reviewer's suggestion
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: add adsp debug dump
      commit: 089adf33701426869dd50d1b8b8a4abd25ae39ae

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

