Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E53F6CC71C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjC1Pwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjC1Pw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:52:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9240572B8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D4AE61820
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C817C433A1;
        Tue, 28 Mar 2023 15:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680018745;
        bh=d2B4g7ELlECDxHuK+tRBn44p0WvlU5rl+zfuMRzCQGA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=V6x2vky+uIWjGVtJjE+jyCbJKJEaXi6QTqw4SAVlFXgjV/XMbUVyOv0zyzuF/bbsq
         zJISh4tLacLNI5Kt2uih4xLAxtIyBlokZO7D3fGMPzH9mixzn4u5rRqnr3e97YNYBF
         JzPGGMiMChc3XhSnRCHlEfPaBTIlDmMJWMv4skEdl8ur3CbUcQ0VuFd9G5M3NoXYnO
         jowRthPts0iNDs2FWvcCZC6KLEE5mealidq/YKHzwAi3lXvbf0WHnmj83CwmkolbLz
         g8AepTemPvp44MhogE3y7tL7Kz315JhjjfG6m2LCd0HP8WzSSyBhr78v1/GmLU1ksY
         92yaVaBBI1vAg==
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lgirdwood@gmail.com, clamor95@gmail.com,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20230328095819.1632802-1-ckeepax@opensource.cirrus.com>
References: <20230328095819.1632802-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm8903: Remove outdated DMIC comment
Message-Id: <168001874429.43606.14982485812774781599.b4-ty@kernel.org>
Date:   Tue, 28 Mar 2023 16:52:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 10:58:19 +0100, Charles Keepax wrote:
> Support for DMICs was added in commit 97945c46a23d ("ASoC: WM8903:
> Implement DMIC support"). Remove them from the TODO list at the top of
> the driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8903: Remove outdated DMIC comment
      commit: 7739b152776655a86568103afded77aa240f3ad4

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

