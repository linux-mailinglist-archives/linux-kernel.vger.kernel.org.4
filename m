Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5048470E69F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238511AbjEWUjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbjEWUja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:39:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B179BDA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 441786364B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ECCC4339C;
        Tue, 23 May 2023 20:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684874367;
        bh=2PLqWR+i15J+SV534O/7WQhY4Oxjwkyn8L/Dppp68zc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SST6f6Cta/7ajLms92C3ZvmWJnOkt2aYPPMhshGPYM8CoEtjsDFeRlNAX6243gW0L
         IHA64M0/oXPGYlp5JifRs0InO/RAOqAuQw9eLaWkGRCzB1mf5QL1J8I6Rp4QUcwulS
         qYcpm62yJCMS5Ylzl0z6Uum026RMSIwbWgQKK3f+9HGwtXP4oSh8dgkN/FvWBz6IMC
         g4WNTcf5Miw/w83klKCbS8JMbu/FqvhyoNEepejm65jMsO7YItISUWDQWwnlDX/GUL
         LfwDn/Xt/O/K4QNJUvaSeqX37BWdkJfewte+0IpY/AJXRFI9TgtJ3G1EEYxUwpgKb/
         DotQ5K7EOeI/w==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230414152552.574502-1-sbinding@opensource.cirrus.com>
References: <20230414152552.574502-1-sbinding@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v1 0/4] Fixes and cleanup for CS35L41 HDA
Message-Id: <168487436612.287432.3938851801782775444.b4-ty@kernel.org>
Date:   Tue, 23 May 2023 21:39:26 +0100
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

On Fri, 14 Apr 2023 16:25:48 +0100, Stefan Binding wrote:
> Several minor issues were found during additional testing and
> static analysis. These patches fix these minor issues.
> 
> Stefan Binding (4):
>   ALSA: hda: cs35l41: Clean up Firmware Load Controls
>   ALSA: hda: cs35l41: Fix endian conversions
>   ALSA: cs35l41: Fix default regmap values for some registers
>   ALSA: hda/realtek: Delete cs35l41 component master during free
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[3/4] ALSA: cs35l41: Fix default regmap values for some registers
      commit: e2d035f5a7d597bbabc268e236ec6c0408c4af0e

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

