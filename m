Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011C0638C60
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiKYOif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiKYOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:38:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4273209B2;
        Fri, 25 Nov 2022 06:38:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C8456245B;
        Fri, 25 Nov 2022 14:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A44C433D6;
        Fri, 25 Nov 2022 14:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669387108;
        bh=FcTggnf+rfccYnN6dKDPhz0HK+goPR+/Hv67+RvzE/8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OBu0GW4iCLq5pp7j2b4YwbAm3cb+b54WPBwBCAaDf7q2PaTspg/ML975iHxl4zP1F
         k1b/tut8Yb3gpVfBTG0YD0fUTmfg2imJ07TtI+tTT9MWfQoYl7cIe0HCFPeh26Et5t
         7a2l032FZiRuzkJx/oWVNWWocnLi0Gwi/+AAfW5qqjPLF5mekm3tTaiLiWEqL1MZee
         HnAw72YQymjDrTcoMtdYEM+/MhYwzyEmAVRPEHWIZ0FUIJA/fnlqc2dxcZUYOOQMjo
         O3DXyaJos4Uvdq+vyiiS1EvxZc/HlLJPRe3TXx+S1WbTo5BApFNZpwfqBRm64BLvf7
         2iTdoCBhWGIVw==
From:   Mark Brown <broonie@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>, linux-spi@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20221125083114.67e7f83c@endymion.delvare>
References: <20221125083114.67e7f83c@endymion.delvare>
Subject: Re: [PATCH] spi: cadence: Drop obsolete dependency on COMPILE_TEST
Message-Id: <166938710801.543681.1594390263495409207.b4-ty@kernel.org>
Date:   Fri, 25 Nov 2022 14:38:28 +0000
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

On Fri, 25 Nov 2022 08:31:14 +0100, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence: Drop obsolete dependency on COMPILE_TEST
      commit: 9c512e476b0bf8b4f22982eac82db7ff7cc08f73

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
