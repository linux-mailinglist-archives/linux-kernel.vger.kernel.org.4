Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27022676021
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjATWW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjATWW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:22:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806D330FD;
        Fri, 20 Jan 2023 14:22:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12312620A8;
        Fri, 20 Jan 2023 22:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876B7C4339B;
        Fri, 20 Jan 2023 22:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674253369;
        bh=deX7jDxlX/W6uQkqoupHiyuH1WVUYRSy7lZvPqAJLbk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MX2hM4TQ+A95PgAsk2oSMOmtuYi/CNxMzUFd3n4OdNLbpv6oGxxm0gT4btzep0acC
         JZRnNbOPfsos+fym+BNN4eEqc5STi/cRQzTQlb4wQHSLn4M+Y9wuwMAH/J7+NpHQxp
         J3n1rFozIqrpYCqZosyt561/jgpnqYz8acIaZzdt0yQzzd5fpDsWBLSj3GNDbDBjji
         Tvb+svcNol1LcxOwjk1Ovikt85ll9zMILbCmgg/pN0dLxGu2j5RYf5Imudq7LIyegk
         XausqtoetS97YMu2auFuaOLykRX/6CTCUP6vgsYUMBIytotxpiYV5ob61zvv/dkIgz
         /n2ilaDAPvxbg==
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20230118161110.521504-1-arnd@kernel.org>
References: <20230118161110.521504-1-arnd@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: samsung: remove DMA filter function and data
Message-Id: <167425336610.1425934.15022702108965764366.b4-ty@kernel.org>
Date:   Fri, 20 Jan 2023 22:22:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-77e06
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 17:10:45 +0100, Arnd Bergmann wrote:
> This data is no longer passed by the platform code, so
> there is no point passing it down at all.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/5] ASoC: samsung: remove DMA filter function and data
      (no commit info)
[2/5] ASoC: pxa: remove snd_dmaengine_pcm_open_request_chan()
      (no commit info)
[3/5] ASoC: ux500: remove platform_data support
      commit: 1766ac5248063c25d1fe46e04bb936c46313ed89
[4/5] ASoC: ux500: remove stedma40 references
      commit: aafe9375b386010e28614f58499d199250a16874
[5/5] ASoC: remove snd_dmaengine_pcm_config->compat_request_channel
      (no commit info)

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

