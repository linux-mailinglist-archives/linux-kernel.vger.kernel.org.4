Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2F66E51DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjDQU1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDQU1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AE61FC7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 13:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 746C062036
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04660C433D2;
        Mon, 17 Apr 2023 20:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681763262;
        bh=f5WmfpzL8IKLAgdbpNwv/8PyUKUYDvOrFroiYuwRsVg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Gf2wLhb+ale7Pra5hMLANyXZzrTRGIcwy5FNCGzsmxPpZLXC7Np0Ndu45JjgbFPLf
         f4dIS4xsCNstsPg/ua8zCRylp6htgrnlzHne0O5hvcwEaIOnjlK2KNGdembYXeaqyt
         n0oXoLQjJDVcCQ+8mxHxLhOitR3ItKEm4QX3xFbNaoh7GiTC9re2n2ww9x5c/HI9BV
         lUWtwD73Maj4RRdIsiZE9UdFDISvoQRSniWYIWT9PT2xOWHI1+p2vlTxGV7DM11hSj
         fX4X4N0spQR39CUb818wmPQoxthqdX+rV7y3qr+jxTDdwrzXm5V+iBW5556P3fyWEF
         VcBKFjxc69j+Q==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230414133753.653139-1-rf@opensource.cirrus.com>
References: <20230414133753.653139-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/5] ASoC: cs35l56: Code improvements
Message-Id: <168176326169.1296984.12735339184719682836.b4-ty@kernel.org>
Date:   Mon, 17 Apr 2023 21:27:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 14:37:48 +0100, Richard Fitzgerald wrote:
> Various code improvements. These remove redundant code and
> clean up less-than-optimal original implementations.
> 
> Simon Trimmer (5):
>   ASoC: cs35l56: Rework IRQ allocation
>   ASoC: cs35l56: Allow a wider range for reset pulse width
>   ASoC: cs35l56: Wait for init_complete in cs35l56_component_probe()
>   ASoC: cs35l56: Remove redundant dsp_ready_completion
>   ASoC: cs35l56: Don't return a value from cs35l56_remove()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: cs35l56: Rework IRQ allocation
      commit: 7d72351a4ef6e1e763bccc24d43c44ffbe1a1555
[2/5] ASoC: cs35l56: Allow a wider range for reset pulse width
      commit: b82396122b028a07ce2977e3f33123d7ab526d91
[3/5] ASoC: cs35l56: Wait for init_complete in cs35l56_component_probe()
      commit: 440c2d38950f738d7a35d3d29533728e74586d54
[4/5] ASoC: cs35l56: Remove redundant dsp_ready_completion
      commit: 4be476830bf96c0095e4e1acdfc12081aa0fb165
[5/5] ASoC: cs35l56: Don't return a value from cs35l56_remove()
      commit: 9ed4c762e214a6592184d0dd65b6db86ad30e6d5

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

