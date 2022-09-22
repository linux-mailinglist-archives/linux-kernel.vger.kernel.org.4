Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF915E6109
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiIVLaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiIVLaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:30:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3714020F55
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:30:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C797A62C28
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9D7C433D6;
        Thu, 22 Sep 2022 11:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663846199;
        bh=vPHa1RwfeSex5KtAHQa+yTSSsZHDEtOtWKVO9DzRPto=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GGuQbAQCYysTxYOcTOH090QGAg/99pXkYsIkcNAib3vcM8xSPeFd7YWJptJXM/Liv
         FmR9cQVxq6xbX3yzpTvv53y7jkEg++PSiD35zMn5Z3RUnMNqvviVF+5XmGMTeq/npt
         sC1bEaQXxw+ODjeyeZm8OdaC/WzAAHWBAEUkaYxE7bCR66I4tL7j4OZm5GxiWhaA/M
         1giGCdcGhmm6SGuVHDJF8+lvni1QhcicR2LcnzZ7n7A5kcqN9+RSJAysQ0liAuPCzG
         oPyocLexpRtOgRD4iq92g1z14d/uu5pmot1nFDZWs87VwcTBsq/xCqRrHiCiFF3Aqz
         fiH2cV9GOp16w==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        angelogioacchino.delregno@collabora.com,
        Chunxu Li <chunxu.li@mediatek.com>, daniel.baluta@nxp.com,
        peter.ujfalusi@linux.intel.com
Cc:     yc.hung@mediatek.com,
        project_global_chrome_upstream_group@mediatek.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220921120239.31934-1-chunxu.li@mediatek.com>
References: <20220921120239.31934-1-chunxu.li@mediatek.com>
Subject: Re: [PATCH] ASoC: SOF: mediatek: add pcm_pointer callback for mt8186
Message-Id: <166384619411.629460.11107464039277326622.b4-ty@kernel.org>
Date:   Thu, 22 Sep 2022 12:29:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 20:02:39 +0800, Chunxu Li wrote:
> add pcm_pointer callback for mt8186 to support read
> host position from DSP
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: add pcm_pointer callback for mt8186
      commit: a921986f445ad611b441c8ee7749dc6dfc770481

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
