Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CEE656A20
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiL0L5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiL0L4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:56:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAADE65;
        Tue, 27 Dec 2022 03:56:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A2DE61013;
        Tue, 27 Dec 2022 11:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C0EC433EF;
        Tue, 27 Dec 2022 11:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672142213;
        bh=2iTsTT2A+ekcurGrt4ecw7Jd6VDWhmDM/YnuYNKbzyI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aP7nRyB9rxZDBxNHhD9Q8gguRPqnI03i1g9iieY6INIZa3wpDC5KvoDRk5iwvu9rY
         3tu7DvZ3S8DAK7GeERGDm401+nuGJz3/33hENDiaejN53LatQI/KLF8Zdxp/+fmXHO
         U1mKagWjExC13THy+jYE8KcDIkmbejkqtxYUlzcDgtxiMNcSleh2039VbhJ+XkrCrn
         yLryUNwhUyJ952mj6X+mg/cJ8vUeYGXTNhVw6QizT8g7GACLxKaldo1MXvj6cbujGM
         q8G5cJyNeKowv4kYywQ04CG9DXIraiP0fl7XfhdZm8cC16YL7mdpMQypmFt5uN0n8m
         34fZUv3bTDIPg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221209175947.335319-1-krzysztof.kozlowski@linaro.org>
References: <20221209175947.335319-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: adi,adau7002: Convert to DT schema
Message-Id: <167214221201.82924.956548399223155626.b4-ty@kernel.org>
Date:   Tue, 27 Dec 2022 11:56:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Dec 2022 18:59:46 +0100, Krzysztof Kozlowski wrote:
> Convert the Analog Devices ADAU7002 Stereo PDM-to-I2S/TDM Converter
> bindings to DT schema.  During the conversion, add properties already
> used by DTS (sc7180-trogdor-coachz.dts) and Linux driver:
> 1. wakeup-delay-ms,
> 2. sound-dai-cells (via referencing dai-common.yaml).
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: adi,adau7002: Convert to DT schema
      commit: 3bc351aa97e5c4b346c7223749d057ce0c372195

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
