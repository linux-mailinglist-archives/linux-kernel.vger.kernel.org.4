Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AD872CC34
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjFLRP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbjFLRPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:15:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D00B10D8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:15:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E97A620E0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 17:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D6EC433EF;
        Mon, 12 Jun 2023 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686590140;
        bh=UUhLelpNrov24l5Qxg3Mphji/Za6TJvjNh0gZoB34PE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=mOvK48yH39zyEq4f7gU2hu2znzNkhhWgdLiu6FYog8k0T2s+rcG9pSl5BUhMVOhBl
         9oVFUP6isYRZ6puuGjV1UnmxX7FuVfS3umnHNr5q1dW6llCqUsujnAyp3uzhltU5u8
         IBEVh+kpw24LuB0o5X2WSYqMt5H5d/VNaD/9z/oSOTgBdDgfZga8gtUaNb9ZJdJnsm
         UVSLpUbXp3uq1IFTkfA/GgYestamMjeBmY33fpH3n1NBtO7F/cvEUkGCOG0IlI8JXy
         ltb8mVw0xgh1ETtqLm0MbqId7z32mF6Lo/hqV+wmfcX3zpsZr0qlLhqwhgSP1XfbNX
         keI68asCDRRQQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20230609-regcache-set-val-no-ret-v1-1-9a6932760cf8@kernel.org>
References: <20230609-regcache-set-val-no-ret-v1-1-9a6932760cf8@kernel.org>
Subject: Re: [PATCH] regmap: Don't check for changes in regcache_set_val()
Message-Id: <168659013974.85655.8352029953272516969.b4-ty@kernel.org>
Date:   Mon, 12 Jun 2023 18:15:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2023 15:05:54 +0100, Mark Brown wrote:
> The only user of regcache_set_val() ignores the return value so we may as
> well not bother checking if the value we are trying to set is the same as
> the value already stored.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Don't check for changes in regcache_set_val()
      commit: d32758acbd4eee8ce95b705a6760526b4d26c2aa

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

