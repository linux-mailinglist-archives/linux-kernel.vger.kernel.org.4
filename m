Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A03629F43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbiKOQmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238718AbiKOQmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:42:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415A62CE23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:42:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1E67B816DA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 16:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FD2C4347C;
        Tue, 15 Nov 2022 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668530528;
        bh=MCL7/zKeDqjuXRH+QYYELKKcFNovM0JNSv98DVO5jac=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DV2Ghcs76E6oXFu42CBX7XCpUBMhWoVhxILV4qYOjj1N4QET8VdxHHdfvMWeDq/3m
         uTSbC+MqnnUekMj4eSBswx0OXhYTt1ComYcenUTzKGqG3xgUk5jXjaucaE3567r0LN
         F2O+xgqRQ1AoZiNa6cHe0MC88B4dUU7MTndIj143o9MRuqOmIgrkaYXiTlTgJw1v3W
         kIlgGFYUayOjLAF23+isyNGNc9FFfkw6odsdNLloZfnY+hIhLRFat1UABppTN/ZnJy
         n4bihnehB0SVkjD5ycRgrPlqqceyKZtqDS4BuduCQvikia2fbjvV6qmNhASSsFhLYf
         kon0GyF/pPpuw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, perex@perex.cz, lgirdwood@gmail.com
In-Reply-To: <20221115065430.4126-1-srinivas.kandagatla@linaro.org>
References: <20221115065430.4126-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: tx-macro: add dmic support via tx macro
Message-Id: <166853052539.230692.12211909671431172423.b4-ty@kernel.org>
Date:   Tue, 15 Nov 2022 16:42:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 06:54:30 +0000, Srinivas Kandagatla wrote:
> DMIC Paths into LPASS digital codec can go via tx-macro or va-macro codec, add
> support to tx-macro path as va-macro path is already supported.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: tx-macro: add dmic support via tx macro
      commit: 710ccba0cf0e12c7c29d862fd6192d8fe46c5fe7

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
