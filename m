Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF9372E7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbjFMQGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242362AbjFMQGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:06:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2944E79
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EF0D630EF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A49C433D9;
        Tue, 13 Jun 2023 16:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686672373;
        bh=Dl0OghRMzPviG4eXWfhJlqKwsFaEmHV8aUPmsmdalV8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=B0EpYklYr58JrxjWPakYbw+Oh9g0ZAraoGWskKrC/bm67cjTAYQQcyL6mBIXvq+co
         XhL3jzv0qVejQ+dYci9EOYsVb1K4uPCNgth3tE0dNNA5apMEgCGkU/aC8+bAO8K7IF
         pToSIHtkdXeJDY5n4tybCLniZcplv3iG7/mq52OoWMeyIGfJy4F7z2T/coFp+EAex+
         xTleLghp+T4njsDJGCs5PijzVlXgnjH3D9mo7+jUGvx2Cic/JC3cBy02F1UiQ17370
         vIFBzdjUm4l28EK+JYAyUUStfXJB8mxv/M+BKHLlDnB19eKCfQ+yTedOuGgILTFcWn
         Nw6SrIoa6C8oQ==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20230613112240.3361-1-tiwai@suse.de>
References: <20230613112240.3361-1-tiwai@suse.de>
Subject: Re: [PATCH v2] regmap: regcache: Don't sync read-only registers
Message-Id: <168667237262.96226.5408735800913182259.b4-ty@kernel.org>
Date:   Tue, 13 Jun 2023 17:06:12 +0100
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

On Tue, 13 Jun 2023 13:22:40 +0200, Takashi Iwai wrote:
> regcache_maple_sync() tries to sync all cached values no matter
> whether it's writable or not.  OTOH, regache_sync_val() does care the
> wrtability and returns -EIO for a read-only register.  This results in
> an error message like:
>   snd_hda_codec_realtek hdaudioC0D0: Unable to sync register 0x2f0009. -5
> and the sync loop is aborted incompletely.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: regcache: Don't sync read-only registers
      commit: 44e46572f0bae431a6092e3cfd2f47bff8b8d18c

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

