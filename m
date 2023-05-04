Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83296F63E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 06:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjEDEKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 00:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjEDEKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 00:10:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2952A19B3;
        Wed,  3 May 2023 21:10:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B915063174;
        Thu,  4 May 2023 04:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0892EC433EF;
        Thu,  4 May 2023 04:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683173452;
        bh=DGzMu0UR7qN4Ii9z2Wd1dG3vUxw/CpUhnj22tEjzdSM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=blPFlMeDvYImnFd4KXEeOnBFpo4IJybECBGd6hSQJ1ocl+dmCH6JCLqqcEvESosPo
         2YVdD378Eii0tgjMitiqA2Dhe0R7HW75pmCP3Qfpts+kSkzJcPhIBW5GIAqh6qvYVM
         Ez5fqNzQt2kfvBeW41/IaM6it5fWxww+qg/YQZ2tIZJWIonn8Subup8P+PUZw4ZuAI
         tejnOfO9q1mieAccH8bIkNxcHPqFLhAlgQFC0fSgaNOi/Q47fRxMTPH/bPyNo40nZf
         plQp2AzvGZdhnTmOqJ3Vjuu2yvwdG+PUsR+R28er6QQZt4tCMn1T+QbOta/zAHHEhK
         zUv9A0T2nkuIg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Patrick Lai <quic_plai@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230503144102.242240-1-krzysztof.kozlowski@linaro.org>
References: <20230503144102.242240-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] ASoC: codecs: wcd938x: fix accessing regmap on
 unattached devices
Message-Id: <168317344974.155442.12857842090912064660.b4-ty@kernel.org>
Date:   Thu, 04 May 2023 13:10:49 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 May 2023 16:41:02 +0200, Krzysztof Kozlowski wrote:
> The WCD938x comes with three devices on two Linux drivers:
> 1. RX Soundwire device (wcd938x-sdw.c driver),
> 2. TX Soundwire device, which is used to access devices via regmap (also
>    wcd938x-sdw.c driver),
> 3. platform device (wcd938x.c driver) - glue and component master,
>    actually having most of the code using TX Soundwire device regmap.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: fix accessing regmap on unattached devices
      commit: 84822215acd15bd86a7759a835271e63bba83a7b

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

