Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F2E67D2BE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjAZRKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjAZRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:09:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36653AB3;
        Thu, 26 Jan 2023 09:09:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8154F618D1;
        Thu, 26 Jan 2023 17:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDACBC433D2;
        Thu, 26 Jan 2023 17:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674752995;
        bh=if+ZZR9mriJNhiK1akAY2Str+irW5BQMixOqBjyg1fM=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=dTNlG/bHwQJv9i2yhSDxGCUewNDtoybJyCqWIrugN0Jpb295ax9aY4nGKEmKP33Uw
         GYuZRCfjhKSfgxqDDsuphTvev2OsO/+kjoNLeIwWtvsnQjRZfRss+G8KChgu+PMpd/
         e/KMWxvoMJH1LoM7K3kYXkuIGIDy+/aB6Ve81kqFCsKg3D8VhT+Jybjrbjgpf1t/wB
         LrD+VIBKmc3cX6ZRFB1n0zwRWwOO/Ji0+ASh4NlM+jUcbx6tNE3yeKcbKRtssH5jVF
         DAGeom+4sOJM0SQmXRZhyn64CIsWj8kB8mHjE4Aw9EwYNE//BH18qXjD7LfsUf/rf0
         PcYnR0edZqKiA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126100722.9473-1-krzysztof.kozlowski@linaro.org>
References: <20230126100722.9473-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: renesas,rsnd: simplify list of
 compatibles
Message-Id: <167475299258.4003145.8163069094653403292.b4-ty@kernel.org>
Date:   Thu, 26 Jan 2023 17:09:52 +0000
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

On Thu, 26 Jan 2023 11:07:22 +0100, Krzysztof Kozlowski wrote:
> The fallback compatible in a list (the last one) cannot be enum, because
> it is always fixed.  Also if such fallback is used alone ("Generic"
> case), it's not a list anymore.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: renesas,rsnd: simplify list of compatibles
      commit: 167b3a2b23c86ce44518afde93c82b65295ea60a

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

