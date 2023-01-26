Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FC667C171
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjAZAZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjAZAZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:25:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED85614EB3;
        Wed, 25 Jan 2023 16:25:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 855AF616B5;
        Thu, 26 Jan 2023 00:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69BCC433EF;
        Thu, 26 Jan 2023 00:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674692714;
        bh=E8zykYaSJjMpGHhrfssLUOl/kS3IP+6qr/f7aT+b+O0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=q/AK5Wf9loQtO2GqG4xqGwt97vC1KQMQeZKccTxfWy2W6GzyiZnbKGfL21lOwEwaS
         xVdzQ+Ap6Zrg6uATJxpmRvLky3T31Wt08DNvOMrh6HeyAuFP1teCNmMOSm0mn2YPU9
         JXGOeiLlHAWg3bLynM5SnKzhAu+eEwytC3nYHIphLOHx7+JFx6fOVlaLTrWj3ik1bA
         hLXXNVobjBSrGBVyz8+QKk7Mgc77e3DxqYSxEYJ3UwuRQLSpcQLd9YAFC1VA5IG9py
         /IiHAB0Y47QXzMtrVaoUY2Aw/mjDIkd8x1cIs3Tmi8K1MCI265E4VqVTfNqVj5C3Gq
         rlwbgVHjFfVFg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20230124233502.23330-1-rdunlap@infradead.org>
References: <20230124233502.23330-1-rdunlap@infradead.org>
Subject: Re: [PATCH] spi: Kconfig: fix a spelling mistake & hyphenation
Message-Id: <167469271256.2661317.5414958160945628987.b4-ty@kernel.org>
Date:   Thu, 26 Jan 2023 00:25:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023 15:35:02 -0800, Randy Dunlap wrote:
> Correct a spelling mistake (reported by codespell).
> Also hyphenate "8-bit".
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: Kconfig: fix a spelling mistake & hyphenation
      commit: 22913a63b477c5f167012d4f1265d023a102c1fe

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

