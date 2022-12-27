Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA38656A22
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiL0L5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiL0L5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:57:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B995AE65
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:57:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BCDDB80F9F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33125C433EF;
        Tue, 27 Dec 2022 11:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672142240;
        bh=Tp797qKymqBv9WjfLeXEP16pI60mkQzwoax0c7aWd4w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=h5PqXQt+1dOSdfqT0sUbOR6JLvDmP4bByJjBGkaFm75wKOFpxrJzF7nc4Dr7JAWFI
         fKusaXiCtsWq9WS3gWWr7EmLaiCyxKc7Vc5DfdIc6qpaA8go4rtlaDLFU5CuCuin9h
         QjqH0PWpSB+zbTNrLS/Nwz0fs+0A6cu1+qWfm1fvc1vnWl/VYchGh5/NIxVC50Euyp
         elnh+wER6z/eexITr9fGXBat1jYnR9XPc51xhHRdXD9JjmVjMIsBMl8oxAk9PtRiHV
         FjQO9BNm7Iu1jygJKsKUBbHI9IpqmfjEfQojTW7Yo9qHCprSxZ7dWlkjDEBZ9PuMny
         YYWell7aWyiTA==
From:   Mark Brown <broonie@kernel.org>
To:     YC Hung <yc.hung@mediatek.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chunxu Li <chunxu.li@mediatek.com>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Curtis Malainey <cujomalainey@chromium.org>
In-Reply-To: <20221215061046.16934-1-yc.hung@mediatek.com>
References: <20221215061046.16934-1-yc.hung@mediatek.com>
Subject: Re: [PATCH] ASoC: SOF: mediatek: mt8195: remove a redundant
 comparison of sram
Message-Id: <167214223584.82924.11453521857555977092.b4-ty@kernel.org>
Date:   Tue, 27 Dec 2022 11:57:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 14:10:46 +0800, YC Hung wrote:
> DSP SRAM is not used for audio shared buffer between host and DSP so
> TOTAL_SIZE_SHARED_SRAM_FROM_TAIL is zero. Remove the definition and
> redundant comparison to fix coverity "unsigned compared against 0".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: mt8195: remove a redundant comparison of sram
      commit: 3f58ff6b53c11773b1bd564082fae37d48e0cc40

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
