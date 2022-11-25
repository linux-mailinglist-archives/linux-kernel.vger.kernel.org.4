Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666F263910E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiKYV2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKYV2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:28:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A686532F1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:28:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5D1B60E95
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 21:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43908C433C1;
        Fri, 25 Nov 2022 21:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669411711;
        bh=gpXPBtkhlxtel6UIyjoIqn1pao+hcbuVms341nimoJQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Nl9DUJ3vMi8UC8RHx3P+XDA2HgU08oruVOHNvBs651LwYsWMFRU4R4hQ4d7mQ/kTe
         kCqE3b6gSIhwgk2qqX+0soOhAq+q84w3ztomCxUszjVR6xM6vK/5dmOGVM04XaVkHT
         Rr5Wbk5zGQOneBwGQdrMuf0Qbs6/izdmwubpQguAh6t+iqK6ZIPQJWEUzaUHrsEtny
         C3VgwPLCh3I7TgxulJwdwr/mHLhbFRYdtbpCyXxHh1kUEFtRskh52vDE2Jy2uD9GNa
         mIEh+ra80smqk0EsgMjYs/Zg5KHYJCJG/oSQxtj/MMRgatj5xt/6dRv+f/ijIHl9Be
         RAHSy6wS+7ezA==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, lgirdwood@gmail.com, matthias.bgg@gmail.com,
        tiwai@suse.com, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org
In-Reply-To: <20221116030750.40500-1-jiasheng@iscas.ac.cn>
References: <20221116030750.40500-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: mediatek: mtk-btcvsd: Add checks for write and read of mtk_btcvsd_snd
Message-Id: <166941170899.2089698.737782395946563424.b4-ty@kernel.org>
Date:   Fri, 25 Nov 2022 21:28:28 +0000
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

On Wed, 16 Nov 2022 11:07:50 +0800, Jiasheng Jiang wrote:
> As the mtk_btcvsd_snd_write and mtk_btcvsd_snd_read may return error,
> it should be better to catch the exception.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mtk-btcvsd: Add checks for write and read of mtk_btcvsd_snd
      commit: d067b3378a78c9c3048ac535e31c171b6f5b5846

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
