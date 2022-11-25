Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AE7638C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiKYO1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiKYO1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:27:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044272CCA3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:27:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FC2EB82AFC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 14:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECE7C433D7;
        Fri, 25 Nov 2022 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669386424;
        bh=I95mCqXAxBgNy1M7H5iHXj3ZCuWyvPCokrJXPIjXYHY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WPucsUQf1aPUC2XcwJVzhcxsYSxRfOOuDTtsWKXyZs3YG4cpIjZq8RgKjlFyjrQuU
         wsLgqI1qFvvOiCSFaHUV3kUbPG9QbbUHi7He/Iaf24oylGSz1JFZgR3jv8bG2mnxl1
         MY/uiOrxc5t8HD8N3zxkcanw36noSW5Y3zo1yKqdnvRcsZpdCyrOIcCYqQUkqciTBo
         76ALgWZ3wMntujc9FxmUwWNvN4zJ9UszZZuaK0R2jOIRWmDWVkw5lJ6MRFqbCPwXBw
         rJ8JvM196aD3DbMARMxyhLBNOsrps8YWEQNBxDZd3sOQze2Mk7i8PqBDDLcyN3qv+A
         ZWOD/MG0X3RHQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20221124140351.407506-1-srinivas.kandagatla@linaro.org>
References: <20221124140351.407506-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: cleanup and fix dependency of QCOM_COMMON
Message-Id: <166938642224.506633.17958881347418036982.b4-ty@kernel.org>
Date:   Fri, 25 Nov 2022 14:27:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 14:03:51 +0000, Srinivas Kandagatla wrote:
> SND_SOC_QCOM_COMMON depends on SOUNDWIRE for some symbols but this
> is not explicitly specified using Kconfig depends. On the other hand
> SND_SOC_QCOM_COMMON is also directly selected by the sound card
> Kconfigs, this could result in various combinations and some symbols
> ending up in modules and soundcard that uses those symbols as in-build
> driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: cleanup and fix dependency of QCOM_COMMON
      commit: 8d89cf6ff229ff31cd4f73f5b3928564b81fc41e

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
