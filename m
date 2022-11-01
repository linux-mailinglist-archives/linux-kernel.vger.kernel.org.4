Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793C7614CA0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKAOeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiKAOd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:33:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577DA1B9DC;
        Tue,  1 Nov 2022 07:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E588DB81CC4;
        Tue,  1 Nov 2022 14:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2CCC433D6;
        Tue,  1 Nov 2022 14:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313233;
        bh=5wW5fMffXJgRHGmoyZvOIkPaV2Johu/1uvLcafbGSG0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=OHqr7Vo/xB2puwUuLILh2ggR5FlTfNTzr+bxUpXT1Q2MyStbEvdrIz+u1euEv6J5C
         8dCmpItF0Qv4j0reelkFGia/zaYAbr7s/Nke8I8m61t15DacLt3ERd6AY7szsYhGkR
         Z7DeaheSdF2O0g4qti0p6HiB75qEjfIPow9TH+Hd9X0qaCBnj3xVydFjtdOsk2IuA7
         FVroEkRxkUTzjlvyk4IrzK8QZ0wO/3XKeHrDcSIJ5PFN06GO2ei+zNA02XymRv3cce
         sQxpeRV4Gg4TnVstaAzlmSQ8ANtNjuZPDSDiKmxJKuqD93ygeKoUmuaQ5JnqNC0cu0
         8JRE86XpHOAmg==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, festevam@gmail.com, perex@perex.cz,
        Xiubo.Lee@gmail.com, robh+dt@kernel.org,
        linuxppc-dev@lists.ozlabs.org, shengjiu.wang@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        nicoleotsuka@gmail.com, tiwai@suse.com,
        Chancel Liu <chancel.liu@nxp.com>,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com
In-Reply-To: <20221028082750.991822-1-chancel.liu@nxp.com>
References: <20221028082750.991822-1-chancel.liu@nxp.com>
Subject: Re: [PATCH 0/3] Add support for MICFIL on i.MX93 platform
Message-Id: <166731323052.255497.10142620061824758896.b4-ty@kernel.org>
Date:   Tue, 01 Nov 2022 14:33:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 16:27:47 +0800, Chancel Liu wrote:
> This patchset supports MICFIL on i.MX93 platform.
> 
> Chancel Liu (3):
>   ASoC: dt-bindings: fsl,micfil: Add compatible string for i.MX93
>     platform
>   ASoC: fsl_micfil: Add support for i.MX93 platform
>   ASoC: fsl_micfil: Add support when using eDMA
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: fsl,micfil: Add compatible string for i.MX93 platform
      commit: fb3425689699daebecf27a37d729ae43ef66ebab
[2/3] ASoC: fsl_micfil: Add support for i.MX93 platform
      commit: a10a52541f644a1fdf8876d474f31a54c4142ccc
[3/3] ASoC: fsl_micfil: Add support when using eDMA
      commit: 77a7a6e9a94df0ac7ba46677b5ce4a743a931fce

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
