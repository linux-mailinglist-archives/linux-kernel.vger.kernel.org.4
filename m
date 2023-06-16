Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFD97335DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbjFPQUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345156AbjFPQTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:19:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4030E44B8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:17:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D39DF63D27
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 16:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D71C433C8;
        Fri, 16 Jun 2023 16:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686932222;
        bh=A9dVxzPM4+M/LW7dRokXamx4CMKnxAHX0prWOssGKe8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eUdJTbVWTJLBumVi1LLoxtOd7p+BeND7e5aQ3hlkbMUUcYMWTdYdq0rKAzvRf7ctJ
         38LFfRh4Q7t/KWnT9vEfhg8YrGs9Ac0xD6DjaqFcrnYarR9Oo35IDNohoF1qKZVm4C
         13TZ35bYOpKL65CxW3QIhv3cPFQqszNBiBMOLYg3fI7yxdW2K3iO9JWu30z4/Eby6c
         RSvRpiiaCYAgZBhRikALAviHI6bNtiGvlj5f6V2aWEIGjck2B8SyGzGMA4xYfVML5b
         pQQx5yDe6RAti+XfSrEBfytDfAYJLXDUN5s1lLObdgWzmv7RcmdPWk9AxkZIHkEn8i
         x/QNTUcTloJcA==
From:   Mark Brown <broonie@kernel.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230616115549.1011903-1-juerg.haefliger@canonical.com>
References: <20230616115549.1011903-1-juerg.haefliger@canonical.com>
Subject: Re: [PATCH] ASoC: rt5677: Add MODULE_FIRMWARE macro
Message-Id: <168693222059.298269.16346280609105415774.b4-ty@kernel.org>
Date:   Fri, 16 Jun 2023 17:17:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 13:55:49 +0200, Juerg Haefliger wrote:
> The module loads firmware so add a MODULE_FIRMWARE macro to provide that
> information via modinfo.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5677: Add MODULE_FIRMWARE macro
      commit: 0f9c14e57818d077ceca060b8a0d0ee5ed3abd95

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

