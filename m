Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BAD671EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjAROGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjAROGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:06:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414A75D905;
        Wed, 18 Jan 2023 05:42:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26E18617EB;
        Wed, 18 Jan 2023 13:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9815C433F1;
        Wed, 18 Jan 2023 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674049359;
        bh=3aw2Of8C8dj0Sl2s2WbPQ4HaD1owl4Omnh3YKIftZSU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SEAzXHBa6pUh42R8aSZQ8mep00K65aAwIAYt03OIA1yAqEk3Lh1t9RZnPjY4lZOMm
         +jzbZbATJHB9xhbD5T0ZNQcuneI6wT7j0xtBXyqAv8aun2KnSGfFvueZ+LMLVYelY4
         eHguuCw8v5z4vWMIFn8+bdgMQHNYSkq4Tw5U7WZWk1CCksDbNgwu757O4GNLWftzZH
         HvPPJggcAmDftf/c/l6JGnGLrZNt4cMfihFtlWj7SSweCekAuBH1dydaQc9eWrfdeM
         hZJ0Nvbg1SItcJ0yWxxyGpD7NQyWbFn77rSD5oVb5GIV4jRcvuxpjddSYhW9TrzA2T
         OJxNw12FHol6A==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
In-Reply-To: <20230116103823.90757-1-p.rajanbabu@samsung.com>
References: <CGME20230116103841epcas5p17b33f2b6567935d6be59b4d2b5d9f847@epcas5p1.samsung.com>
 <20230116103823.90757-1-p.rajanbabu@samsung.com>
Subject: Re: (subset) [PATCH v4 0/5] ASoC: samsung: fsd: audio support for
 FSD SoC
Message-Id: <167404935251.749539.9077335076740575140.b4-ty@kernel.org>
Date:   Wed, 18 Jan 2023 13:42:32 +0000
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

On Mon, 16 Jan 2023 16:08:18 +0530, Padmanabhan Rajanbabu wrote:
> This patch series enables audio support on FSD SoC.
> 
> Changes in v4:
> 1. Rebased and addressed review comments provided for v3.
> 
> Changes in v3:
> 1. Addressed all the review comments provided for v2 patch.
> 2. Fixed compilation warnings reported by kernel test robot.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/5] ASoC: dt-bindings: Add FSD I2S controller bindings
      commit: 93d79d410c0b33ff7b31015b9c2459bb5cabf030
[2/5] ASoC: samsung: i2s: add support for FSD I2S
      commit: bc36d761cad7f3fec22cd97ddaa80f0120610181

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

