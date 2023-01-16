Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184DA66C30A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjAPO7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjAPO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:58:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35646A67;
        Mon, 16 Jan 2023 06:49:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E30E60FD6;
        Mon, 16 Jan 2023 14:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D8BC433F0;
        Mon, 16 Jan 2023 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673880543;
        bh=y3TvSgmud3kXyKu5FipycE51zj70NUWuclGNv3ekUzI=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=congVETMqSTg+NovrE+Hk6lcnH29x2ibRHjJVl/HNwy9SJ5g+pge5GDmUySEQ9TQm
         VkCCMvB1z7aoB/O4yrBA1Lj2LK95vmQt/rhr1a3Np4rtHuV9HuqEtfJWh6m7dTq4Hq
         CT8nbrEymleKK4LtiirjfGPdzDNGymG8J4/Gt1QYkNd3IdaD583TI+4l9uIh6YRikC
         aLX7xW8ZQV6qmUzhAhT+o4qmovoAjOSi2M/sE0fA+feUyr4VNyVaSGno57Z9GfK/0n
         80imCdanPW5jNGAtc5bhHrx5Qhg5lYFNCJMm8vrPOmLMxnr/uV7CXnmVtB337enPcX
         PyPI98NnzYsBA==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230102114152.297305-1-krzysztof.kozlowski@linaro.org>
References: <20230102114152.297305-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/8] ASoC: codecs: wsa883x: Simplify &pdev->dev in probe
Message-Id: <167388053865.388539.17611906188714090984.b4-ty@kernel.org>
Date:   Mon, 16 Jan 2023 14:48:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-69c4d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jan 2023 12:41:45 +0100, Krzysztof Kozlowski wrote:
> The probe already stores pointer to &pdev->dev, so use it to make the
> code a bit easier to read.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/8] ASoC: codecs: wsa883x: Simplify &pdev->dev in probe
      commit: d5ce5d3895a33fa8e0dce89c2404facbdef55dcb
[2/8] ASoC: codecs: wsa881x: Simplify &pdev->dev in probe
      commit: c617c9e7024d152426acf9f1aaf01070b6852f13
[3/8] ASoC: codecs: wsa881x: Simplify with dev_err_probe
      commit: 31a90367443b21f76b972c00aad3430447c999d6
[4/8] ASoC: codecs: wsa881x: Use proper shutdown GPIO polarity
      commit: 738455858a2d21b769f673892546cf8300c9fd78

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
