Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBA15B77E0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiIMR0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiIMRZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:25:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBF175482
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:13:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 337A0614FE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008C5C433C1;
        Tue, 13 Sep 2022 16:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663085577;
        bh=GVVGW0XNbw65Kif4FFiljAj61CM7fhSjCYDVZNvRSdM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iviA63r0Lnm9UEQn9DmhBWffJx4Tw1RqEphmsamTrPfgWRh4ifN5EJBu5RYLu6Vjy
         rc1KkkuoMDQMaIQ+6UvAlJOabjXFlKvK2Xd8TN9fDVVsjh0eb/5wxaS4SJQnHyVc0H
         B1+DsRScvdtLYBirx0t2zXQff0l1CW0o7UGbQWHFpzSfjgrILjEFYnvwkKOKoq4JAQ
         Oen66MBTKKvvyUAPwEX9T4jX8GIn8tI+VyPpQnHUEdNLAdfIr5zPuFN20bQt4NQJlK
         MdQI2kt+UDLwI0XewGwTmutlxypa9xSgLJ/Q81ZhQjT1mHUXZYbh++1NBZWsMbInON
         xYd9dTe5P/reA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, perex@perex.cz,
        Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com
Cc:     kuninori.morimoto.gx@renesas.com
In-Reply-To: <1663057594-29141-1-git-send-email-shengjiu.wang@nxp.com>
References: <1663057594-29141-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: ak4458: Add ak4458_reset in device probe and remove
Message-Id: <166308557481.242391.17534144170473474022.b4-ty@kernel.org>
Date:   Tue, 13 Sep 2022 17:12:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-7dade
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 16:26:34 +0800, Shengjiu Wang wrote:
> This patch fixup this warning when CONFIG_PM not defined
> 
> linux/sound/soc/codecs/ak4458.c:631:13: error: 'ak4458_reset' defined but\
>         not used [-Werror=unused-function]
>   631 | static void ak4458_reset(struct ak4458_priv *ak4458, bool active)
>       |             ^~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: ak4458: Add ak4458_reset in device probe and remove
      commit: da995e22fa7193b067f2545e63d726ffe36ba174

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
