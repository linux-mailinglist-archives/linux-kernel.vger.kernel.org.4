Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7987678206
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjAWQnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjAWQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:43:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1785244B9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:43:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C170060FBE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B3AC433A0;
        Mon, 23 Jan 2023 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674492183;
        bh=I6q+1TqaHhwNsgg4BdDkxDvo9F1rclT1/qSrFDqO+YM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ptp60oyTKkwQPeovyuULop1bZsBG02hFVIVxS02La7Mktoop9wmWl4boWnW8aDB23
         tW96Nx+Mip0+JAlOU+E+0otkxbCzZuOezqq/zO4S0y6BPT/xD4Z85q3KlkjT1rvla2
         agDbOfqKOjI+p4kdxFQu/Yuh09y6JlFb5vpms+16nRzaES/AW9oMjjTjC7zxzpU5rV
         FtEVH/v9b9NOWw3siPzDxn3ffBOpZuTwEo+wngpN/8I81m3GSbD3Nep1rH8SzHrnT9
         oaA5mXkUL6Kpt14DYPac10PAX1ECenIvQhUEfd4ARNImIUraMixKamPE+K7wCC3uTI
         QHpIWUP6phTFw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, angelogioacchino.delregno@collabora.com,
        jiaxin.yu@mediatek.com, Chunxu Li <chunxu.li@mediatek.com>
Cc:     matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        project_global_chrome_upstream_group@mediatek.com
In-Reply-To: <20230110092623.13035-1-chunxu.li@mediatek.com>
References: <20230110092623.13035-1-chunxu.li@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: add AFE_DAC_CON0 to volatile
 register list
Message-Id: <167449218051.1484410.8537098920978259746.b4-ty@kernel.org>
Date:   Mon, 23 Jan 2023 16:43:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 17:26:23 +0800, Chunxu Li wrote:
> Mark AFE_DAC_CON0 as volatile since DSP firmware will access this
> register too.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: add AFE_DAC_CON0 to volatile register list
      commit: 42fc858cc7e3f9e7a5762b29f9daaf23a15e45ef

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

