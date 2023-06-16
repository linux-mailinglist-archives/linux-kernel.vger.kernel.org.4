Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E613E7335DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344762AbjFPQUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345302AbjFPQTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:19:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D564683
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E658061737
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 16:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3B1C433C9;
        Fri, 16 Jun 2023 16:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686932224;
        bh=2kVal/nzSVsBGlkTLFoOeXQi1g+H/v+1G/o1A1F/w8M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GrVEVq1bRU5Mg0ACZT55lDnFZeiTMf+M6dru4Wh+DSqNh7s4Vhw5B9PdIFes+ZDNr
         dfQtRh4VGI6oh6z8mmWKmcub2E4Ex18wP+8ZNHzEjzMho8/RQOYQngw8gBoBzpMF7k
         QwOTbsYe3qgzdApg00VJ9HS48KDfRhAG0Y1oDNdyRcE6mZIOIdBL2+zz5BUQIUauoZ
         OwF0FpoVVQMd4Kxk99NkNKgpbui0GCyGvDvBbV9GYMSzS3W1Ygr1ujQ0N00uHH8WAN
         G/mKEJjPiDj5SBAA2T5x79mzLD/MOSctCSPaA54vvu1tAWPtbQwrfCIupIeNYjPRas
         YWHg0p7GlGJgA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com
In-Reply-To: <20230616115432.1011707-1-juerg.haefliger@canonical.com>
References: <20230616115432.1011707-1-juerg.haefliger@canonical.com>
Subject: Re: [PATCH] ASoC: codecs: wm0010: Add MODULE_FIRMWARE macros
Message-Id: <168693222248.298269.5546880276593537709.b4-ty@kernel.org>
Date:   Fri, 16 Jun 2023 17:17:02 +0100
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

On Fri, 16 Jun 2023 13:54:32 +0200, Juerg Haefliger wrote:
> The module loads firmware so add MODULE_FIRMWARE macros to provide that
> information via modinfo.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wm0010: Add MODULE_FIRMWARE macros
      commit: 60e07fa49b3201d7201cdd7286e7d51e8d937a28

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

