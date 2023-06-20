Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE32C736E96
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjFTOZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjFTOZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:25:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158E0A6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0769611EE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47559C433CA;
        Tue, 20 Jun 2023 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687271101;
        bh=FkhY4eztJzP99ERNOjculqfHB32X+QoLfgg9zPuABjE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=r+CUTHrZyJimdZMjRySm4Amzl3F/R/jMvZX0WV8QnuECSpGADO/Xfao3nbVyl10O4
         CNatnlkNgKbGOIiiZfSzXkXiYOQ1adxH0bqYZmeRUwINL0Ee1ByYfUPCD42UUzOYTh
         e57tZVsa0FF/pXjKhIv2SVIxyaXB3lYe7M+L5/XG2mSNUDbS0aqGmKXvj0lnvVpUIV
         5WMo77QJ+47qPozP0jitZ8AAjHeCLB6jiC2hy4m3VhFO44z7JAnszd9vU/nO3IICjx
         w2XZ2wwikijUeo/I332F93SIQ46FCtfhqD9j35H02KUP9ZUsOVrH4Km0z8leSpA9jd
         9+OfACX8qvRzg==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20230619101653.9750-1-srinivas.kandagatla@linaro.org>
References: <20230619101653.9750-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 00/11] ASoC: qcom: audioreach: add compress offload
 support
Message-Id: <168727109901.80037.3338718817975012158.b4-ty@kernel.org>
Date:   Tue, 20 Jun 2023 15:24:59 +0100
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

On Mon, 19 Jun 2023 11:16:42 +0100, Srinivas Kandagatla wrote:
> This patchset adds compressed offload support to Qualcomm audioreach drivers.
> Currently it supports AAC, MP3 and FALC along with gapless.
> 
> Tested this on SM8450 and sc7280.
> 
> thanks,
> srini
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/11] ASoC: qcom: SC7280: audioreach: Add sc7280 hardware param fixup callback
        commit: 5b7e984e22c43d217b3224b3118e5c8c88a5b708
[02/11] ASoC: q6dsp: q6apm: add end of stream events
        commit: 9d11a5431c929c5057e06ff86002f337980caa9e
[03/11] ASoC: q6dsp: audioreach: add helper function to set u32 param
        commit: 69bff594592b0582c36b3aae819deaad0e09eafd
[04/11] ASoC: q6dsp: audioreach: Add placeholder decoder for compress playback
        commit: c7548f5990fb35ccf2bd731570d3cff7df9e1d2e
[05/11] ASoC: q6dsp: audioreach: Add support to set compress format params
        commit: e41521b6e2b3c965c64ff3dcd69042db003c3ef4
[06/11] ASoC: q6dsp: audioreach: Add gapless feature support
        commit: 2c954a3714b3b0d98354cb6801f88b0ef7c1249d
[07/11] ASoC: q6dsp: q6apm-dai: Add open/free compress DAI callbacks
        commit: 88b60bf047fd15b75a0d7b78322ad53f917976ce
[08/11] ASoC: q6dsp: q6apm-dai: Add compress DAI and codec caps get callbacks
        commit: c0c87738a19d3e6d15dac4174d4b90c38a615112
[09/11] ASoC: q6dsp: q6apm-dai: Add trigger/pointer compress DAI callbacks
        commit: c337bf33c41de423fa4d7353bd66d3c14df92445
[10/11] ASoC: q6dsp: q6apm-dai: Add compress set params and metadata DAI callbacks
        commit: b3f736d126d69ef3f3cc4f6b68795478954b2cf4
[11/11] ASoC: q6dsp: q6apm-dai: Add mmap and copy compress DAI callbacks
        commit: c317d148a2b02c4756832fb4bd00a6480d874606

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

