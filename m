Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA3B656A31
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiL0L6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiL0L5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:57:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D40B4A0;
        Tue, 27 Dec 2022 03:57:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62BB96106C;
        Tue, 27 Dec 2022 11:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C6AC433EF;
        Tue, 27 Dec 2022 11:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672142261;
        bh=D9LK7ENnl/JQNWQUoFQ60Z9qugjwWm/tEjiU72DchGM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=buPl+RNwvPZoCmNudrAy9qfsXze67FWNFHWmbuwuxKczB8dK9oz33f11AZTvRkY8X
         ktojCKrBPlhJj89b7bjriNe82Tmvv3wdOm+zUXdE+QgeFe4JWzpD6UNxPEuUqilRVk
         yOtd9R17dqt3hXM+BtgwHOgiE/P/ax+1cQCDru8gej8FQIflo4cxL0odgbpsQW7QnU
         TknRcY1Se41feB98u0kb8ultfMvWU8NF0vqZ2D+MKHaBAZgQ2tM6Vcr6qM1/1xxkSZ
         WtDZzezDQMxrBPC7TgTY0cyXu5fA4nRI0vBsSbKEXf1ZToGYzJuFOV1Ysfxk+SF877
         1YfxzEkGwb6nA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wadim Egorov <w.egorov@phytec.de>
Cc:     linux-arm-kernel@lists.infradead.org, j-neanne@baylibre.com,
        lgirdwood@gmail.com, tony@atomide.com, upstream@phytec.de
In-Reply-To: <20221214153409.1270213-1-w.egorov@phytec.de>
References: <20221214153409.1270213-1-w.egorov@phytec.de>
Subject: Re: [PATCH] regulator: tps65219: Report regulator name if
 devm_regulator_register fails
Message-Id: <167214225991.87975.6915126748096471073.b4-ty@kernel.org>
Date:   Tue, 27 Dec 2022 11:57:39 +0000
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

On Wed, 14 Dec 2022 16:34:09 +0100, Wadim Egorov wrote:
> Make the error message more useful by reporting the actual regulator
> name if devm_regulator_register() fails.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps65219: Report regulator name if devm_regulator_register fails
      commit: cfbe9dfd664c7717ef297e01b7eecccc2b5fde6f

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
