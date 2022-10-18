Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48770602A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJRL2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJRL2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:28:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE04AAC3B5;
        Tue, 18 Oct 2022 04:28:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E30361528;
        Tue, 18 Oct 2022 11:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC62C433D6;
        Tue, 18 Oct 2022 11:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666092496;
        bh=BUVIpGsmdTCdBA7+xoYUq7u8Hy6f/qPMi/vD85vO8qY=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Bp+e3TWBZpcnp8j8oKCQlYshMQgFVn3sXqxmMAG43ZjFwS4dNTRjk1BtXTQJ445GH
         p/M3luP+EC0cwNFU8KCiTc6ua4qJ7y10sZfDLnWx8BFI3fWx5jHOSi18Jnw5ArvL1q
         NFq5iIGwqmCSTHetSMf6pITjCiWxY6ATqY3qtXWuxQQS8R/OBQiqLqWcnSj2HDtm7a
         6lTaJPaQDikS1gPE4puAt7jwAzavsm8Eg4nHNhBtT8RzLiI9zZt8x5asH55we0qb8F
         2SVevsbHCp7EDx79HJW2B5o38YED5rN5mH20B4O3nBFMR57gblqeA2G7zbnHpZLvHN
         FrsyuSB4axOew==
From:   Mark Brown <broonie@kernel.org>
To:     linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Xiubo.Lee@gmail.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, nicoleotsuka@gmail.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        Chancel Liu <chancel.liu@nxp.com>, festevam@gmail.com,
        perex@perex.cz
In-Reply-To: <20220930064441.2548505-1-chancel.liu@nxp.com>
References: <20220930064441.2548505-1-chancel.liu@nxp.com>
Subject: Re: [PATCH v3 0/7] Create a new sound card to access MICFIL based on rpmsg channel
Message-Id: <166609249377.155136.8150989631074960130.b4-ty@kernel.org>
Date:   Tue, 18 Oct 2022 12:28:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 14:44:34 +0800, Chancel Liu wrote:
> At a previous time, we have successfully created a virtual sound card
> based on rpmsg. The sound card works under this mechanism Cortex-A core
> tells the Cortex-M core the format, rate, channel, .etc configuration
> of the PCM parameters and Cortex-M controls real hardware devices such
> as SAI and DMA. From the view of Linux side, the sound card is bound to
> a rpmsg channel through which it can access SAI.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: dt-bindings: fsl_rpmsg: Add a property to assign the rpmsg channel
      commit: 3570e6873b1a506bca4b5788d71141944c55132c
[2/7] ASoC: imx-audio-rpmsg: Create rpmsg channel for MICFIL
      commit: f04189e0b85f6bbd10679e71061bf6d1ced5c539
[3/7] ASoC: imx-pcm-rpmsg: Register different platform drivers
      commit: b2c2a947b3412f6edb9a86f5b12d6420958e67ba
[4/7] ASoC: imx-pcm-rpmsg: Multi-channel support for sound card based on rpmsg
      commit: bdc0f6ca1c079ba790e0e227cff6164feae90460
[5/7] ASoC: fsl_rpmsg: Register different ASoC machine devices
      commit: 76a874caeab596972f529968aa0d19d4ba1d2197
[6/7] ASoC: fsl_rpmsg: Multi-channel support in CPU DAI driver
      commit: f26c1bb8a8ebe72748a3bb6f5d75079b642a33e8
[7/7] ASoC: imx-rpmsg: Assign platform driver used by machine driver to link with
      commit: 4b48440ea390bada41928920446928beb3652a76

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
