Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576BD6A215B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjBXSTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjBXSTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:19:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECB96C8C9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:19:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E78DB81C9C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 18:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F570C433EF;
        Fri, 24 Feb 2023 18:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677262761;
        bh=IP3WmVGiSdHPgtth19FmgMeNWLngRTpXqmuQC7OcnYE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CuHTWtUwJmsByLaDSGrpYnkmjXg3kjw8kyKorqYDc1kBRZbuxpGH6xmRev2LcVS92
         rBb6sEHPIteFv+xOZDnsQuzjCDL4iXV/0+muHPdDMZkSvpUPOEdLYvSl54fL9MrKvE
         GByIOBuOtAxHY/DoHi5yb4/6u1RNzNZ8MkT1Pqzm4Jwp+qgH0Mr/Hv5FZAqCeeHGe0
         UqVAquIOC26y3XJEVo8NfanW6rucia08Xdd6g31EUci5BNjWPc+lYq2+wtzlYZIfuE
         hWgqBnGW7CYD1avOwFJovMCuA/OINR+GZnhU0jJxpBy2oFky9BP2tLgkfT3uapMiQY
         aVXyNN07oE0ww==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230224153302.45365-1-povik+lin@cutebit.org>
References: <20230224153302.45365-1-povik+lin@cutebit.org>
Subject: Re: [PATCH 1/3] ASoC: apple: mca: Fix final status read on SERDES
 reset
Message-Id: <167726276023.536872.10083688435650517455.b4-ty@kernel.org>
Date:   Fri, 24 Feb 2023 18:19:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 16:33:00 +0100, Martin Povišer wrote:
> From within the early trigger we are doing a reset of the SERDES unit,
> but the final status read is on a bad address. Add the missing SERDES
> unit offset in calculation of the address.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: apple: mca: Fix final status read on SERDES reset
      commit: aaf5f0d76b6e1870e3674408de2b13a92a4d4059
[2/3] ASoC: apple: mca: Fix SERDES reset sequence
      commit: d8b3e396088d787771f19fd3b7949e080dc31d6f
[3/3] ASoC: apple: mca: Improve handling of unavailable DMA channels
      commit: fb1847cc460c127b12720119eae5f438ffc62e85

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

