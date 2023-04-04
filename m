Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A4A6D65A6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjDDOnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjDDOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:43:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188722D56
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A074C6351D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C7AC433D2;
        Tue,  4 Apr 2023 14:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680619393;
        bh=Wi7gYKtL2g3MeOgWtYUJXYG7O8WJy783HNmUY2xDdcs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Bba8a8fUzyiVfFBxjJRv2ev/LSNkHaopfA6EF6jOOI8ECRdGBV/PNUCincTTP5dLA
         tg5K75baYezHYBcRnLHF6t+fut6of684fV7HdR9VhklfNlgM9wPRBAjL/S1I1wktu9
         YCHyp1xNOk7VMAI6kNMVWILLdseocNR6chm7shV56tBX5HBYVhYw+UbHCQa9J45GwW
         l0kOYnl0wWNbyQE0CmUA4n+5G0C6xdbthQHlhZ2fV8/H5J6JjqC85v28Tv9t1wTZ8W
         6NFTxV4Ho555UPonDm95U1LYH373ctoFKvetdDDIlb70dEGAjo5rWuB6UAEAEtcC/f
         HixakE499eQ1w==
From:   Mark Brown <broonie@kernel.org>
To:     Liam.Howlett@Oracle.com, Mark Brown <broonie@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230403-regmap-maple-unlock-v1-1-89998991b16c@kernel.org>
References: <20230403-regmap-maple-unlock-v1-1-89998991b16c@kernel.org>
Subject: Re: [PATCH] regmap: Fix double unlock in the maple cache
Message-Id: <168061939187.48622.14415852223820721320.b4-ty@kernel.org>
Date:   Tue, 04 Apr 2023 15:43:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 21:02:39 +0100, Mark Brown wrote:
> Doing the dance to drop the maple tree's internal spinlock means we need
> multiple exit paths in our error handling.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Fix double unlock in the maple cache
      commit: 451941ac1ee2be125ac5029593a64b04badaa314

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

