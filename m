Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12966FB16B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjEHN1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjEHN1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:27:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536A82BCF0
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:27:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9DC263D26
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 13:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683A1C433D2;
        Mon,  8 May 2023 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683552426;
        bh=9Preocx0f7YMHLQdzCuT7Uy7mFgFqA+N2t0VXY0AnFA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WXQIr4EHHDhWlYyU3qOW4iHcVNPYB+ORmYD2XALeKRA2RdEZTw1Yhs/zymsRZWBS5
         U5LVfdnvAKCRPSOFMS2gCThGeg/P/bLn+w7g0dQkHwogX+3yqyvIJ6LCg6ygS0dAuK
         rAoGUv15qv8fQxg4AtbA2lK6PH9x4S7RJYSVHbdiwmHgO3JRI/MgfeaQlMBQG4AXu6
         rEwGJ/oLwWPTKQsA2QtcpxMl2uPRuozcaBHROnXL01igBjs8SQueWmTo1rmV4xgpLJ
         YadzvRIgp37ZHR00gfBR0Cm4XS7p1DF029I2ibQ88JqBNo5S7HHMR9kjJo4Z0ZmNb4
         UE399dHni8uTg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20230505220218.1239542-1-u.kleine-koenig@pengutronix.de>
References: <20230505220218.1239542-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] regulator: Switch i2c drivers back to use .probe()
Message-Id: <168355242473.260126.9342449014522306239.b4-ty@kernel.org>
Date:   Mon, 08 May 2023 22:27:04 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sat, 06 May 2023 00:02:18 +0200, Uwe Kleine-König wrote:
> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") convert
> back to (the new) .probe() to be able to eventually drop .probe_new() from
> struct i2c_driver.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Switch i2c drivers back to use .probe()
      commit: 964e186547b22b9c3b23fee49eb993391aa73ea8

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

