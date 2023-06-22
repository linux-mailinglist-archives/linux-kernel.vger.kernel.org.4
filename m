Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67FD73ABBD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjFVVmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjFVVmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:42:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC32A184
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 14:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51A0F61900
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F086C433C8;
        Thu, 22 Jun 2023 21:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687470153;
        bh=CmoCKyNaOpNX7hbl6+IjFa9Mgxj6fjzJg7My8SnO4Jo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YEbeTuG/V/Mw8pMW2ykLWzTkV+Ujvw27lgCNVzl2bc/F93XgxYmxuxv0Ebr9K/yYH
         Mj+9YtNH/FkgIHqRHwQc3lOnSAS5Zy60sleRogWIVseiia/4PsTudAaUZFNAz2jfBR
         7GaQKJow5Bff1kXvQ4uRGYa5IS9WzAHPTujsFRDGwk4DN7fcGUgX3PNh8cOIA/Fmrc
         I/IDY1HQ3n+vfjq/ihcMeuLNl2sbRhNYbC1RO5Ol9A5/vDjS/yMubOXUTThaTzQhXq
         79BsBexoWDtgrqZ+SDCB0yQ9IF5+Hh0IymcmCb7X9B7CyfOOnm16EToyxkAfyRcDwU
         cW2sF4V5ZtpZw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ryans.lee@analog.com, Tom Rix <trix@redhat.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230617122635.3225639-1-trix@redhat.com>
References: <20230617122635.3225639-1-trix@redhat.com>
Subject: Re: [PATCH] ASoC: max98388: set variable soc_codec_dev_max98388
 storage-class-specifier to static
Message-Id: <168747015091.308583.17966762362837372641.b4-ty@kernel.org>
Date:   Thu, 22 Jun 2023 22:42:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2023 08:26:35 -0400, Tom Rix wrote:
> smatch reports
> sound/soc/codecs/max98388.c:890:39: warning: symbol
>   'soc_codec_dev_max98388' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98388: set variable soc_codec_dev_max98388 storage-class-specifier to static
      commit: 320d0e2db9edcde026aac93359624c1d429cb865

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

