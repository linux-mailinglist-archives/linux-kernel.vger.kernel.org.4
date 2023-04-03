Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C916D4B66
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjDCPHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjDCPHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:07:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203C24EE9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:07:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7BB261FD4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8873AC4339C;
        Mon,  3 Apr 2023 15:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680534465;
        bh=CbaEpR5yxDPf+9mbPIwZAe+9wiobjn23JtwSiA7b8tI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JJadlxr2t7/HfOxYuSdYkwE83y6tsAr9FEk7r8hW6JwPOFMHPzrEC91yRD4bvdyMa
         C6+c/syy9Zpdw8hjqnlLkonRQZ3FSBin2Ce3pv/c921cy8bMZToWHby4eScisBhLwC
         8VUvhmJXzC48fZl0mkaGr7/ypHk5s6gzyAdpPg8LMXM+8F5X5AOBcAZgQxYuMXVerC
         pQ7P45quZSnaIUZMLPeLXsvRzHhFwNw8x6LpkULKYRwTGj8/6h4VKhu26E9YjeCkVb
         T11AYXJfxPM8aUYLLIeuVgMkWJGzHaTB8diAOr8EvskCL/CvxuDnH42OqcmCn3PtIR
         of3USepvxiq1A==
From:   Mark Brown <broonie@kernel.org>
To:     Prajna Sariputra <putr4.s@gmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <2283110.ElGaqSPkdT@n0067ax-linux62>
References: <2283110.ElGaqSPkdT@n0067ax-linux62>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI entries to support HP OMEN
 16-n0xxx (8A42)
Message-Id: <168053446427.47553.8097664872905045881.b4-ty@kernel.org>
Date:   Mon, 03 Apr 2023 16:07:44 +0100
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

On Sun, 02 Apr 2023 02:21:30 +1100, Prajna Sariputra wrote:
> This model requires an additional detection quirk to enable the internal microphone.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add DMI entries to support HP OMEN 16-n0xxx (8A42)
      commit: ee4281de4d60288b9c802bb0906061ec355ecef2

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

