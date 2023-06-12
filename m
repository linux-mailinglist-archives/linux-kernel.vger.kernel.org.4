Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3282272CC35
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjFLRQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbjFLRPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:15:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E4210D3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:15:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12D5062087
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 17:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37DBC4339C;
        Mon, 12 Jun 2023 17:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686590141;
        bh=vHXhCQfo2Qv8OkSgBZ68ejlcCbap+8Qo+S8iDqOIRtE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=fVzEz+B1tGYk7932tYv05Z07Yu9vGfyrL9SAc6v3t3SjGlZG1O8/J5vSM8O2SIOUp
         y21S9worRZejvuQG6Wr3CZKtio0BjV1j5LnWFgoAQAncBYlwciHjrr+CXspJc/tysJ
         MefEh+C4hYO+W9UxJARdVzxg3V+UX6uiexa+4TGPRzcMncjRYwsohlI+iZxDOQCgTr
         HMM1FyxdPCV2RSAp7vvZd2S58hNNxNjZoX7piFIB4V2Zeg0tstO8SsYmEisqWTDgcl
         0N2NNzYx6aGMRjCGVPJ20GFHrPsfUrYdFKXjgMHHwD9wgXAysbVKQKSSFc3RI8TQ9S
         1D5iusEuZxxdw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20230609-regcache-maple-sync-raw-v1-1-8ddeb4e2b9ab@kernel.org>
References: <20230609-regcache-maple-sync-raw-v1-1-8ddeb4e2b9ab@kernel.org>
Subject: Re: [PATCH] regmap: maple: Implement block sync for the maple tree
 cache
Message-Id: <168659014071.85655.7107903749952317283.b4-ty@kernel.org>
Date:   Mon, 12 Jun 2023 18:15:40 +0100
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

On Sun, 11 Jun 2023 13:06:07 +0100, Mark Brown wrote:
> For register maps where we can write multiple values in a single bus
> operation it is generally much faster to do so. Improve the performance of
> maple tree cache syncs on such devices by identifying blocks of adjacent
> registers that need to be written out and combining them into a single
> operation.
> 
> Combining writes does mean that we need to allocate a scratch buffer and
> format the data into it but it is expected that for most cases where caches
> are in use the cost of I/O will be much greater than the cost of doing the
> allocation and format.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: maple: Implement block sync for the maple tree cache
      commit: bfa0b38c148379c8a8c52e23bbdcb086414fb354

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

