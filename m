Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867EE662BB1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbjAIQvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjAIQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:50:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9816E15F35;
        Mon,  9 Jan 2023 08:49:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 351F4611E2;
        Mon,  9 Jan 2023 16:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D96C43396;
        Mon,  9 Jan 2023 16:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673282957;
        bh=YwSP2w9wGKi2ttakQ9Xz42YL9cH5sw+0e4H+bY+2QYE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=bR5oClSEGTvqSQyskWB8vv5rBgYftECC/PY3hreKOGdwTGX0zkiJnGMoHRss8kqrM
         lRE7aJoVKx7Infq+IqJkWPxjFXfRkRg5Opc8R4SGK4hlK9emXTCCCmlacOWmPhAB0h
         /a4dzJ1OkU2qQZhYD6CaNNUaJW1ROFyUxe+wOnjjTns+qJe7GNrzyl+PJtn6gdN8m5
         Kq1t0WCa4Hs/2YJXgprroIDgSoPUrX8DuBY69ZgkfO4TTt5RZDaHHDWwer+3NG9pvX
         v85z0lslfUv9F8ovsyR2DGr3MkFbfKHHHHc721cg33w7WNgY7601y2tGX7On0R3jx4
         TiUtYT8NwW7Kw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230109083301.76282-1-krzysztof.kozlowski@linaro.org>
References: <20230109083301.76282-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: simple-card: correct DAI subnodes pattern
Message-Id: <167328295575.323147.8150537822946345432.b4-ty@kernel.org>
Date:   Mon, 09 Jan 2023 16:49:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2023 09:33:01 +0100, Krzysztof Kozlowski wrote:
> The simple-audio-card,dai-link node does not allow address/size-cells
> thus children (cpu, codec) should come without unit addresses.  For
> cases with multiple nodes of same type, require a dash before index
> (e.g. cpu-x) and add trailing $ to the pattern to disallow other
> characters.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: simple-card: correct DAI subnodes pattern
      commit: cbf74baf02219978bfa9c2959eac6bf1d98c32cd

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
