Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AD45BEEB6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiITUqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiITUqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:46:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5265F7696C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A1C78CE1B7B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AF3C433D6;
        Tue, 20 Sep 2022 20:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663706800;
        bh=HYli6/cvxotMBPYQELJFv5WGyh/XqaUzoeHSir/vKA8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YbhnGHFY/LqduHDsATHsaeiSD1PpZnjnVP61BY+U63BG8Rr/T6Zl+jKsfV87a/JIA
         KIqajDw/eonnTVG2zxoq/4ck+aqS0LjZ90/+70kP/NYZYgLE1k2r8RDLGDAXmUiQpA
         y6DVW2JXxWfkESO7UUiDU1iS7xqPyH9TuLkWW33q5jmc8ywDuEHeKrQxPZDDJ+B0uR
         LYo/EGTH/GxpivGgDXaLiFJ1kdpvCJAF6ULeLP1LImNHsyAyU7bItQ1I4i3PVoBBiA
         ZG7iuoDfRnLnIfDNsiD4G5jJIBLrvPWina5kP7wnC6uav9foC5rSIrJWMPUY2lEMSt
         YaLj8ZeUhmilw==
From:   Mark Brown <broonie@kernel.org>
To:     peter.ujfalusi@linux.intel.com, Chunxu Li <chunxu.li@mediatek.com>,
        lgirdwood@gmail.com, angelogioacchino.delregno@collabora.com,
        daniel.baluta@nxp.com, pierre-louis.bossart@linux.intel.com
Cc:     matthias.bgg@gmail.com, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yc.hung@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        project_global_chrome_upstream_group@mediatek.com
In-Reply-To: <20220917022610.594-1-chunxu.li@mediatek.com>
References: <20220917022610.594-1-chunxu.li@mediatek.com>
Subject: Re: [PATCH] ASoC: SOF: mediatek: add pcm_hw_params callback for mt8186
Message-Id: <166370679567.361668.2078852324764910878.b4-ty@kernel.org>
Date:   Tue, 20 Sep 2022 21:46:35 +0100
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

On Sat, 17 Sep 2022 10:26:10 +0800, Chunxu Li wrote:
> add pcm_hw_params callback for mt8186 to support continue
> update dma host position
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: add pcm_hw_params callback for mt8186
      commit: 78091edc1c7806846049e1d480f6a8051507ed94

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
