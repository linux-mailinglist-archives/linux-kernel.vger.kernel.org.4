Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3108A67C19C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbjAZA3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbjAZA3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:29:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37431F909;
        Wed, 25 Jan 2023 16:28:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E659616DE;
        Thu, 26 Jan 2023 00:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1668EC433EF;
        Thu, 26 Jan 2023 00:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674692938;
        bh=gd48QQ1G/fofkw08t5Nm1PtKKDKcVePwRYIRZ/2YscM=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=rriKJ7Q6Cok9gWsDKHoLDJOlzvG7Q8T+zRjYTYlMDBLkFKpkAm4VTSp/smSQijp/B
         aBkMcMXriYwiT+PfmRL90DzVT3iLkfMHcpmmiKTJxMgvQyoP4q2Hp/S16lNLb3GU+2
         8AVRTrNGKFY0URApMz890qGMrVxn1ijgzONEfbYB6lcKg+qN6hyARGGzVmQhxr9aCW
         E016XyIqyHS+eZ2QMFCZxR8BKUCcnZYyHImLq/jOoLuxN51tD/n38Byxy7MiCfHlg0
         5JWPZspfkMZaNip9uW0VPJ5265ikiqQwUI5isom+LwEEMfLFk6I8e2t/jBJKNhaMxM
         Yfnx72mo+AcNw==
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120153020.320270-1-krzysztof.kozlowski@linaro.org>
References: <20230120153020.320270-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: samsung,odroid: correct codec
 DAI phandles
Message-Id: <167469293574.2696228.16859545876419546902.b4-ty@kernel.org>
Date:   Thu, 26 Jan 2023 00:28:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 16:30:19 +0100, Krzysztof Kozlowski wrote:
> The order of codec DAI phandles is reversed - first comes HDMI (always
> present) and then codec (physically not present on Odroid XU4).
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: samsung,odroid: correct codec DAI phandles
      commit: cc5be0e5477f53f2d4b3c9211206f34505ec17ba
[2/2] ASoC: dt-bindings: samsung-i2s: drop unneeded assigned-clock*
      commit: 73ab5b3aa59036e0e6689b0a20a5080ef7ab7c03

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

