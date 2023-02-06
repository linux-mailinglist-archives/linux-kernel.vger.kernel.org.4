Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C982568C8D5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjBFVhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBFVhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:37:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287AB1448C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:37:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1E87B815C2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 21:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E87EC433D2;
        Mon,  6 Feb 2023 21:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675719450;
        bh=3iD31edkdUHtR+qWce/Oi3JEyusbFB/JSiYqBPNRtAs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BC7npsMjyT4OxrtrtrU1hSPVABbayP64phjkZ6mT5iMZUW/BiHrUjMR2UgY9LH2P5
         HRhnxliIwkJTXdV7V9mlwq8S4elOdbyFtlovIc3eLdDPIFGOSBTt9sV7VFHzd5wkZq
         25BQfAjvYLt5nLUuyKzHEKCgcI9vicezocTaTZGFGR/o68nXxIqXkYtN61mT9JZov1
         CEG2q1I1K4T/9ZTWz5Y4W5/kafRJk2Zx6Zg2IJ+d8gGck7HRQ4NSKLV+8r3QvB3oCm
         VWnXCSBHYua9hDxSEvgEJUDVbRghD8QKNtAd10BqW9wPEd6JBVKSMlKBehC2fNibg2
         jNXL2xvx4FYKw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Daniel Beer <daniel.beer@igorinstitute.com>
Cc:     linux-kernel@vger.kernel.org, Andy Liu <andy-liu@ti.com>
In-Reply-To: <cover.1675497326.git.daniel.beer@igorinstitute.com>
References: <cover.1675497326.git.daniel.beer@igorinstitute.com>
Subject: Re: [PATCH v3 0/2] Two bug fixes for tas5805m codec driver
Message-Id: <167571944937.1296981.10882189914536189021.b4-ty@kernel.org>
Date:   Mon, 06 Feb 2023 21:37:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Feb 2023 20:55:26 +1300, Daniel Beer wrote:
> This pair of patches fixes two issues which crept in while revising the
> original submission, at a time when I no longer had access to test
> hardware.
> 
> The fixes here have been tested and verified on hardware.
> 
> Changes v2 -> v3:
>   - Resubmit with cover letter
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tas5805m: rework to avoid scheduling while atomic.
      commit: 147323792693bf013f60dca160be1d32bd4d180a
[2/2] ASoC: tas5805m: add missing page switch.
      commit: e0576cd642ced1ac65370b4516b7be9f536a0498

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

