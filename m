Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADB765917C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiL2UZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbiL2UZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:25:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43A8167C7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:24:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6885BB81915
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 20:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAD9C433EF;
        Thu, 29 Dec 2022 20:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672345495;
        bh=N/o94YEt8tE0HvVCN7MrD6twr+9nAJ1Qbw3h//lCd7E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qB+QQnXYSXB8UINx2KICWxiYMZn2Dwdnda0PUnCvEUMBQSD7AdiEay6V9HH7mLxIY
         6DAl6szs7To9OwwByZ9U96h78eAkY6IV51j6H7Zej0RLzs7/PsERMPN0/tKs3YzR8p
         Pq+Tfs70LiYcqzzNuCOpOPP00pakJamWrhBrBXHoiS1CnS+Z9oyEMTeB97DKkVZNP3
         zbk3K4l7dhnS7sQQZ74ChEazB/vY1olz3hhMAvq7fW32N+M2EzhUZlw2FJ+Z/CXeaz
         sR9waNTq3/9vE9QaSOQ5Nlf0PHMxCeprh2CHgZD8GkNNM3IXY9HHqeubJdJet9k6el
         y4VQRBNNlIS7Q==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, cy_huang <u0084500@gmail.com>
Cc:     cy_huang@richtek.com, jeff_chang@richtek.com,
        oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <1672301033-3675-1-git-send-email-u0084500@gmail.com>
References: <1672301033-3675-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH] ASoC: rt9120: Make dev PM runtime bind AsoC component PM
Message-Id: <167234549276.88546.3985652949744191629.b4-ty@kernel.org>
Date:   Thu, 29 Dec 2022 20:24:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-69c4d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2022 16:03:53 +0800, cy_huang wrote:
> RT9120 uses PM runtime autosuspend to decrease the frequently on/off
> spent time. This exists one case, when pcm is closed and dev PM is
> waiting for autosuspend time expired to enter runtime suspend state.
> At the mean time, system is going to enter suspend, dev PM runtime
> suspend won't be called. It makes the rt9120 suspend consumption
> current not as expected.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt9120: Make dev PM runtime bind AsoC component PM
      commit: 7161bd540eebebae2bbe8c79de25d8caf12dbf78

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
