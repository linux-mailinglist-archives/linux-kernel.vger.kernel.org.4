Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268146CA583
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjC0NXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjC0NXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:23:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF15A2D76
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:22:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 637AAB81588
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A62AC433A0;
        Mon, 27 Mar 2023 13:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679923377;
        bh=zon8YDJaxFyfOkDSfVhpwhKl4rQzC7OFT8QlaxmYQSs=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=GYnR6YDFChI4Hj9dWmrOLBQzxOglQ5CV+ktVVSkh2U2s81uIJhjXhnHSgT6SNwSZe
         BokXXr8p5Na+co0KzCKHZ8krr6dwTBkQegKYVOgFrje3cyQxXa85lADQAv1o7m5+21
         GqnZtva203HEmv536Xjk4kdhSrREnwkkUCVT6SAsW3BdcS/olgaVn0ChiNi/QmKZvy
         O41jMX1C4AvNrob15fJBuOsgngN+F79qYtxAThFk/BfNRqHhtNvQ70MYs8z/U3YXpk
         ZVqUEYGUt9PozhJTKSpaf4hv3hVNYIpLVZhalCz/oLFOljOaek1fYpzg+8QEFs4zjo
         L2NuHSXssrPDg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20230324-regcache-unknown-v1-1-80deecbf196b@kernel.org>
References: <20230324-regcache-unknown-v1-1-80deecbf196b@kernel.org>
Subject: Re: [PATCH] regmap: Clarify error for unknown cache types
Message-Id: <167992337541.3162264.2269514649107080383.b4-ty@kernel.org>
Date:   Mon, 27 Mar 2023 14:22:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 16:22:26 +0000, Mark Brown wrote:
> The error message printed when we fail to locate the cache type the map
> requested says it can't find a compress type rather than a cache type,
> fix that. Since the compressed type is the only one currently compiled
> conditionally it's likely to be the missing type but that might not always
> be true and is still unclear.
> 
> 
> [...]

Applied to

   broonie/regmap.git for-next

Thanks!

[1/1] regmap: Clarify error for unknown cache types
      commit: 2d38e8615a21e264042870f811247d5c52c27f4e

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

