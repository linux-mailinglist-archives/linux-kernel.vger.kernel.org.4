Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0D6116CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiJ1QFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJ1QEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:04:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78C31903C;
        Fri, 28 Oct 2022 09:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C591D62947;
        Fri, 28 Oct 2022 16:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A35EC433D6;
        Fri, 28 Oct 2022 16:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666972971;
        bh=Oxti1A+2ZLM13LWu91bH36f/Fx13AJFSM+jY4B3mE7U=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=DkLDaKvFD2Rwrze6hxXZRo9+kKLB8sEtVs8hwjQHbqkL7Q7ijbMoDuq/gFBKUR0Or
         H0sImDSmMB4S2UDXg5jApERzjViHb30R5L1bHrFOoGA7P0aiVypEnvCfR+J78sdtJj
         najlz55vlJ/guZaA5vJGCboYQn5O0+giD7iNJgIQ2IboHXAcVV7C1NCrAc6N4WIxHZ
         D4LS+cONMnpTQrQGeP++D4qGyUh+ypmBFjINQTFR0/4nM07JEpW7hBXvpk1a0TUSGx
         ai3K4gJso5h9quUOPIwPb75OdU7+DaspFSqjYHONOaM07jhkZ0YAWFuma6u0l9TyI0
         syLrAx8KFkcpQ==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, tiwai@suse.com, festevam@gmail.com,
        linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        Xiubo.Lee@gmail.com, shengjiu.wang@gmail.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        robh+dt@kernel.org, Chancel Liu <chancel.liu@nxp.com>,
        perex@perex.cz
In-Reply-To: <20221027060311.2549711-1-chancel.liu@nxp.com>
References: <20221027060311.2549711-1-chancel.liu@nxp.com>
Subject: Re: [PATCH 0/3] Add support for SAI on i.MX93 platform
Message-Id: <166697296821.717517.14812404041210557854.b4-ty@kernel.org>
Date:   Fri, 28 Oct 2022 17:02:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022 14:03:08 +0800, Chancel Liu wrote:
> This patchset supports SAI on i.MX93 platform.
> 
> Chancel Liu (3):
>   ASoC: dt-bindings: fsl,sai: Add compatible string for i.MX93 platform
>   ASoC: fsl_sai: Add support for i.MX93 platform
>   ASoC: fsl_sai: Specify the maxburst to 8 on i.MX93 platform
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: fsl,sai: Add compatible string for i.MX93 platform
      commit: aa8289fda86ede0e164a260316647c8bf0400d41
[2/3] ASoC: fsl_sai: Add support for i.MX93 platform
      commit: 67d5c6c19923ad26def8a001e86fc0f42264a8b5
[3/3] ASoC: fsl_sai: Specify the maxburst to 8 on i.MX93 platform
      commit: 870b89d118a29bd845ea706a74e313f9b83f5a45

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
