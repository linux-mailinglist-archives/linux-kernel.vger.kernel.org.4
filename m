Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DB970869D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjERRU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjERRUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B54E47
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5192C65111
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC832C433EF;
        Thu, 18 May 2023 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684430420;
        bh=piOq5yMlSJS5vyyMJbxfeW2jBDmCAz3nZ9BEF7MQFns=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=l2dQIRYABelwZpNXnjfqP2r6MmhIcv4jS3+TCeML5UpseyRQk91f1zUpvu4CHzOtp
         Du1cAZP4IG6qlTLUOkWgbEhCLi88RKyAl2pzn68l3oXV27ChA16srcBEWS37JQK6OJ
         9fDrz0KL6kb89bhq5SDIMAS9+yyFNmGaFA+8SWJbjNvwuVbw6eRsuD1ZrQtBlyu6VF
         Nay2Qwk285GUkFGngih/Y4UfP/MVn4JsYzpDiiAYlZa61AviwjnrgCyQ6eQBCu48dK
         igDrXLLP77ewA/vSuPz6/9mRD+7K3TdflZ5jplI8spMX2j+foB+OAXyT+iopP69oOW
         hA37MOEQWqptw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com,
        nfraprado@collabora.com, wenst@chromium.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
In-Reply-To: <20230517151516.343037-1-angelogioacchino.delregno@collabora.com>
References: <20230517151516.343037-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8192-mt6359: Remove " Jack" from
 Headphone pin name
Message-Id: <168443041576.472592.13647493326207546899.b4-ty@kernel.org>
Date:   Fri, 19 May 2023 02:20:15 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 17:15:16 +0200, AngeloGioacchino Del Regno wrote:
> Function jack_kctl_name_gen() will remove the redundant " Jack" from
> the name, if present, and then it will add it back, so that all of
> the controls are named "(pin-name) Jack".
> 
> Remove " Jack" from the Headphone pin name to spare some CPU cycles.
> 
> This commit brings no functional changes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8192-mt6359: Remove " Jack" from Headphone pin name
      commit: cbbc0ec6dea09c815f1d1ef0abaf3f2ec89ff11f

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

