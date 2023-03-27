Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BD96CA584
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjC0NXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjC0NXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:23:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F973A93
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AF846126E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E30C4339B;
        Mon, 27 Mar 2023 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679923379;
        bh=zwbclZZDoAs7n1UJ2Rgb6plkvsjjn9yg72Ef/Tl+X1Q=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=J62UEf3gHxXmkfeSi1I75sLGwqJj6AH7H8fgH/q+KYD46qkBCl35RQ64/efnHbwIA
         h0dsDZKpjchPgox/P2CCFSVPk+HM/CjmMr7qJqMfcUFZjoX/OIclh3r4YCgzxUPRBc
         CY60twLHiRCYzDAkk9IREGkDTti/iqLDwOPMHEfBs22gTdQCDN7Xp1Mpfp1P5tFBNb
         nbXdTYcA7W+XkWHiBjsu0mSo5KoChYompKsk298YGfROpu5/AgCQiP/DjngqKxXuo1
         agCypQJRLRoXEZ6q2f8KIXq1LYCCVQq7XAr0RRxqZYF5V4HEN/FMXMyCBv0N/Yywhq
         0gijugaO0ybEQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20230325-regcache-sparse-sync-v1-1-2a890239d061@kernel.org>
References: <20230325-regcache-sparse-sync-v1-1-2a890239d061@kernel.org>
Subject: Re: [PATCH] regmap: Handle sparse caches in the default sync
Message-Id: <167992337764.3162264.16990182811684271049.b4-ty@kernel.org>
Date:   Mon, 27 Mar 2023 14:22:57 +0100
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

On Sat, 25 Mar 2023 21:49:49 +0000, Mark Brown wrote:
> If there is no cache entry available we will get -ENOENT from the cache
> implementation, handle this gracefully and skip rather than treating it as
> an error.
> 
> 

Applied to

   broonie/regmap.git for-next

Thanks!

[1/1] regmap: Handle sparse caches in the default sync
      commit: 2c89db8f8d1e544fd817d4c0dc508a00b78a8f7f

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

