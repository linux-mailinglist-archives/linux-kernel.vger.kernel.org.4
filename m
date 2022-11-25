Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FAD638C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiKYO1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiKYO05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:26:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCD42AE26
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:26:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6E63B82AFD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 14:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E64C433D7;
        Fri, 25 Nov 2022 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669386413;
        bh=1hTsLsAyt9tlsWhWVofHJBaSZd45+Oiiml90QdlACHA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=d7i1XVyeymPD/W1dB8wSyfn631s2sYLxwcYl+RLcNcsR+oLFw/bWQO3xFUVKojZuW
         bq1AjRZFEQcjgWYrWDTD7sWLkBB8W+lc8T/KxjeshziQBlA+4xcpUtHlFCBHP8CSI/
         h6HfX42vHxnmYXUtcjxW0+U27Yn2g0dg9Hy0aIsA3mg/fRbeBbF5azaLBzpMHOtkUi
         FJ9XxcdliNtIir2Hh+545ihzDwwM9aDJP9ojpV+mS9Ycpub+z9RD8CC4Mxa8og/VWR
         XKW1tQZ7HxiLjAKKbasWJI1ZhTduyIvhfOQFQbfGywhD9tE+fuf7Eq0SXOUGwRm/vQ
         J5QG5vKihy7xw==
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>,
        angelogioacchino.delregno@collabora.com, nfraprado@collabora.com
Cc:     linux-kernel@vger.kernel.org,
        ajye_huang@compal.corp-partner.google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        chunxu.li@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
In-Reply-To: <20221123161130.543-1-jiaxin.yu@mediatek.com>
References: <20221123161130.543-1-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Correct I2S shared clocks
Message-Id: <166938641125.506633.2366556842342118458.b4-ty@kernel.org>
Date:   Fri, 25 Nov 2022 14:26:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 00:11:30 +0800, Jiaxin Yu wrote:
> In mt8186 platform, I2S2 should be the main I2S port that will provide the
> clock, on the contrary I2S3 should be the second I2S port that will use
> this clock.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: Correct I2S shared clocks
      commit: 248579fc9a4f3bf36e7cfe9f6a354cee0f9848dc

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
