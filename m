Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB76B702AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbjEOK4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbjEOK4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3091700
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7903D621AF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A5EC4339B;
        Mon, 15 May 2023 10:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684148202;
        bh=oUEF/4yz5sEIrZ7t89/BFOOYYjSfgj/UEFCTdYNipbQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XU95rmpIaPSIIx+Ycad09tzaJNOLXHKLQ6Q4CLKfW0h8PtVRzE/mW1HiaaT/UY68n
         32PgteB5alYmmj/u6Z5L5sdjtE5AIKVQEXBeuGjLS0FPNNXUJcp3jZE7dkSs+7Gc7l
         RmOQfh4VIYMPyW1VcoDxwiuJ0I6pHW8/wXdMT9B3hb/UGZH87CJumCz56vIR5TipLd
         sM25GxTKmRw3lavNibiJK1H8VKyZMkjXsW6y0BUiChTVIuws6YloJzxvf48Qrp1r2W
         GNG8O1jccYByAoobTs2/QlTvvA8LNvr/TGXRVv7fV4Pqz97zhic540BgsY8qEr/kUj
         S5YYA/YFzMW0w==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Robin Gong <yibin.gong@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230512081935.2396180-1-alexander.stein@ew.tq-group.com>
References: <20230512081935.2396180-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v3 1/1] regulator: pca9450: Fix BUCK2 enable_mask
Message-Id: <168414820135.387159.3888721463040874252.b4-ty@kernel.org>
Date:   Mon, 15 May 2023 19:56:41 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 10:19:34 +0200, Alexander Stein wrote:
> This fixes a copy & paste error.
> No functional change intended, BUCK1_ENMODE_MASK equals BUCK2_ENMODE_MASK.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pca9450: Fix BUCK2 enable_mask
      commit: d67dada3e2524514b09496b9ee1df22d4507a280

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

