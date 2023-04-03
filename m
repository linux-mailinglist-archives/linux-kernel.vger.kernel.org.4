Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C6F6D4B6A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjDCPII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjDCPH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:07:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E4C1CBA7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B8EF61A55
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72277C433EF;
        Mon,  3 Apr 2023 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680534473;
        bh=BSS3Ft8JQ9etJOn1zN0oTwzUaes1AtJBsgymC/v4kdc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LH6/UPc2zLS065s2+tZPcVdZUiadCX0D0+ucwbowf+9GAdMeVXzEUGVjxqu6zBBlu
         PxGDkfaLD4x0nPXajNRS7WcMTdKpyQ74urU0X29Xc4DeJTHLLpP/8o4ch58oA4nZtI
         3HCO81N1V9Ko9cJMH4tH3EAPvUPRGEkdB295IcU1lfq9sKwoBmhMSlCTNMpEGgJZHX
         VIBB9CXQyFAXAjisMPGJDoLg2PLMITWOfOh/tNThpFHBiiJrO1tUc6EXj/GqEbXvht
         YpXJ/9kftMUe9VMfRs7aK4bHQuJ1e54oQsnT6oR4q/KhNJTh6mg+dbNlmQbiCkVHZG
         AQe0G0fPoHYUw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20230329080418.1100-1-allen-kh.cheng@mediatek.com>
References: <20230329080418.1100-1-allen-kh.cheng@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Move some prints to debug
 level
Message-Id: <168053447118.47553.13821701231639468315.b4-ty@kernel.org>
Date:   Mon, 03 Apr 2023 16:07:51 +0100
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

On Wed, 29 Mar 2023 16:04:18 +0800, Allen-KH Cheng wrote:
> There are many log messages scattered throughout the mt8186 sound
> drivers, and they are frequently triggered.
> 
> To avoid spamming the console, move these messages to the debug level.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: Move some prints to debug level
      commit: 3af24372964a8f999d62427c0585d9a4693ae4e4

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

