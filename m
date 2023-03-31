Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D79B6D236B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjCaPCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjCaPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23690AF3A;
        Fri, 31 Mar 2023 08:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCC25629E9;
        Fri, 31 Mar 2023 15:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E50CC433D2;
        Fri, 31 Mar 2023 15:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680274966;
        bh=K+HZuqgB9rt/QMhwBweIcNwWvClGQr42KVcvQKa67U4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=C6swUh79DRO5QZSPpqIlQyIThpRfWCLZJqd6GgZq9zRIzg3OMSBxBlp2AKr3MLBHK
         Ihpdq3hbeknoGuZwyDbcI7zBmla6N9FVUnfQl3PH2cNCo2z0XCNbwCm/qIS00Nebu2
         RubHziuxniLGWPQ6hNVCBScMDVVFiajmCQrugBtb8ojyqbWmZi9VU/o/wcw0yfHDtN
         hUUEsK54w9S6cCr4iCqAUD786C96DoYcmkGjmRtjYN5Oji+wDuyB8hO0Mfdou9rcU+
         WaRAkhM4kpoTy5PSpK6DgKQAPMy4o5QoaJTNJ/T15c3Q5p4YSHO61+7vkb3WGvmsqO
         pEDPycD6GW9SQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        krzysztof.kozlowski@linaro.org, rf@opensource.cirrus.com,
        ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com, herve.codina@bootlin.com,
        wangweidong.a@awinic.com, james.schulman@cirrus.com,
        ajye_huang@compal.corp-partner.google.com, shumingf@realtek.com,
        povik+lin@cutebit.org, flatmax@flatmax.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        ryans.lee@analog.com,
        =?utf-8?q?=E2=80=9CRyan?= <ryan.lee.analog@gmail.com>
In-Reply-To: <20230330234319.6841-1-ryan.lee.analog@gmail.com>
References: <20230330234319.6841-1-ryan.lee.analog@gmail.com>
Subject: Re: [PATCH V4 1/2] ASoC: max98363: add soundwire amplifier driver
Message-Id: <168027496197.3365708.8821025322937971454.b4-ty@kernel.org>
Date:   Fri, 31 Mar 2023 16:02:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 16:43:18 -0700, “Ryan wrote:
> Added Analog Devices MAX98363 SoundWire Amplifier Driver.
> The MAX98363 is a SoundWire peripheral device that supports
> MIPI SoundWire v1.2-compatible digital interface for audio and
> control data.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: max98363: add soundwire amplifier driver
      commit: 18c0af945fa35766730d3f729adcf417a3d1ad5d
[2/2] ASoC: dt-bindings: max98363: add soundwire amplifier
      commit: 276d8c08e82b9f6062f6febc7bc63913829bde27

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

