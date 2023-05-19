Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15C0708E60
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjESDdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjESDdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:33:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BEB12F
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 20:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1574652C5
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4DFC433EF;
        Fri, 19 May 2023 03:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684467219;
        bh=8FZuxtdcNDCBpb+eqQE7LLSk7QkrZ4DcK9YO3sDCf6o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ff7mHDJCzg53BsY+d6W3AMjxG8kUyDmCubT7U1A2qB/kderJeKkvueI/lMKf5bq8D
         9/S4R1Ze6feAnsZIZcbHWPNRyWSj3TZSNBxEBnZTtuofvOKEoYphTO9cDj8itcRX2g
         yOGXhG5OLjeC5R8zHTwPtvW7I2Ik7OIvOjRAGs1oa3rQ1Kr088YBzDiiShGR5RgXIN
         WKgDp51sP8xE853Z8JndYBNu5nz/p0ymFWVJRROJ/xaHtyNAWH+UB1eCTIN9rNXmgL
         ykcRrLutvDeKvLVS+Bcd0H3vK7er/S6+uR3X0wdQU2i5hWcuwuIh0uUVMTsEi7LpGV
         4kVjTFHf7mgiQ==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230518150250.1121006-1-rf@opensource.cirrus.com>
References: <20230518150250.1121006-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/3] ASoC: cs35l56: Bugfixes and efficiency improvement
Message-Id: <168446721839.559735.6041471929366523184.b4-ty@kernel.org>
Date:   Fri, 19 May 2023 12:33:38 +0900
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

On Thu, 18 May 2023 16:02:47 +0100, Richard Fitzgerald wrote:
> First two patches are bugfixes.
> Third patch skips the overhead of rebooting the amp after applying
> firmware files when we know that it isn't necessary.
> 
> Simon Trimmer (3):
>   ASoC: cs35l56: Move DSP part string generation so that it is done only
>     once
>   ASoC: cs35l56: sdw_write_no_pm() should be performed under a
>     pm_runtime request
>   ASoC: cs35l56: In secure mode skip SHUTDOWN and RESET around fw
>     download
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: cs35l56: Move DSP part string generation so that it is done only once
      commit: 608f1b0dbddec6b2fd766c10bcce2b651995e936
[2/3] ASoC: cs35l56: sdw_write_no_pm() should be performed under a pm_runtime request
      commit: c9001a2754528fa5da20e8674b3afbd8c134cc91
[3/3] ASoC: cs35l56: In secure mode skip SHUTDOWN and RESET around fw download
      commit: 1a8edfcffa2803afc0ef3a6a48819230cdbda2c9

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

