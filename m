Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216766E6945
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjDRQVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjDRQV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:21:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D1BA248
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:21:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89ABD6366C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 16:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49589C4339C;
        Tue, 18 Apr 2023 16:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681834887;
        bh=RKq+8OHiBrOyLAi6BWiPxp9ZIBhsklW6Kv+GwshIKDc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=cCupsJ6zwdXy+BDF9FUeePW5WTgEd+f/JSA+xOLP/v3zEPZbWFrKp3CxNQ5R7VOzo
         eVMlA5V7G44uUSDSPJVijCctaZ2H9UXIcn/cj8ghPrgrnfi/1OfVH9X4w8ZFPi4yBX
         egrZFUCo0IpsoM/BSt1LWWSywZ8wk9kacQWrosZ0ICKv451evk9LFMX/EZNHbeTsZE
         MSaWx4EoCTpSoBdbV41CzOP3h8Zijxi6v6Klsig/eBySGU4vs1x6XRJ/bGeiz4V+Nj
         bnwQTJKj1kClxmBLtioIVknGEkg3M8M/R5bqsw5eq6jIGPil+gaFMoyHxIB2Isoqxv
         J30pp/YXJt77w==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418074630.8681-1-krzysztof.kozlowski@linaro.org>
References: <20230418074630.8681-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 1/4] ASoC: codecs: wcd9335: Simplify with
 dev_err_probe
Message-Id: <168183488500.87933.6599641233526402855.b4-ty@kernel.org>
Date:   Tue, 18 Apr 2023 17:21:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 09:46:27 +0200, Krzysztof Kozlowski wrote:
> Replace dev_err() in probe() path with dev_err_probe() to:
> 1. Make code a bit simpler and easier to read,
> 2. Do not print messages on deferred probe.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/4] ASoC: codecs: wcd934x: Simplify with dev_err_probe
      commit: fa92f4294283cc7d1f29151420be9e9336182518
[3/4] ASoC: codecs: wcd934x: Simplify &pdev->dev in probe
      commit: 92864de45c3e445419d1e99e3a409469a5f3ef57
[4/4] ASoC: codecs: wcd938x: Simplify with dev_err_probe
      commit: 60ba2fda5280528e70fa26b44e36d1530f6d1d7e

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

