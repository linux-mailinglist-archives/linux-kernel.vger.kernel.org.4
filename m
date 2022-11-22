Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454F9633F38
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiKVOtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiKVOtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:49:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9261D663D2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:49:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C83A6170B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E94FC433C1;
        Tue, 22 Nov 2022 14:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669128554;
        bh=bKeRPVjJrncT4C0fmvTZ2poFrpNaAGtHQW4ySLc8gUU=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=qkp7G5LChqlxCNxZPCZ1TRGAmlU997CYbuhQJ6cK0YdwjVtpogmfc5eQQJynKzW0i
         oMS2Z2U60Iq//AlYuXhDULaSNjOex0oguGYP0o/FUDoXcW39hLcUNCASOyIA1aaznT
         0sjpZ3trjAeurfgYg9oyNZedjBW58vHXuQIjQ2dGwOSNvEBm+WGZSbe0GqNqgeZYRa
         qkXTPX0vCkcHrALdAVqVgzz44ot0AEIYWNqmjWNkKS4FsET3+LjFBb1kIGBjLHx9hS
         Ka8E20/E3cO+E4Gh3tU7WCW16CH2eterIC3nY2jha90K8DO+XteuDwIK/ySSCEXaYK
         iDYM+a+o9CPgg==
From:   Mark Brown <broonie@kernel.org>
To:     cezary.rojewski@intel.com, linux-kernel@vger.kernel.org,
        perex@perex.cz, kai.vehmanen@linux.intel.com, tiwai@suse.com,
        alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        lili.li@intel.com
In-Reply-To: <20221121104742.1007486-1-lili.li@intel.com>
References: <20221121104742.1007486-1-lili.li@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Fix Kconfig dependency
Message-Id: <166912855277.213382.2191182990253588501.b4-ty@kernel.org>
Date:   Tue, 22 Nov 2022 14:49:12 +0000
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

On Mon, 21 Nov 2022 18:47:42 +0800, lili.li@intel.com wrote:
> From: Lili Li <lili.li@intel.com>
> 
> Commit e4746d94d00c ("ASoC: Intel: Skylake: Introduce HDA codec init and
> exit routines") introduced HDA codec init routine which depends on SND_HDA.
> Select SND_SOC_HDAC_HDA unconditionally to fix following compile error:
> ERROR: modpost: "snd_hda_codec_device_init" [sound/soc/intel/skylake/snd-soc-skl.ko] undefined!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Skylake: Fix Kconfig dependency
      commit: e5d4d2b23aed20a7815d1b500dbcd50af1da0023

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
