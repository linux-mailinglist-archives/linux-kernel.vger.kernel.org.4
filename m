Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FC25B78A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiIMRro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbiIMRrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:47:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EB012D34;
        Tue, 13 Sep 2022 09:44:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCDB861510;
        Tue, 13 Sep 2022 16:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4C7C433D7;
        Tue, 13 Sep 2022 16:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663087477;
        bh=LazoKil10sVAZo5jouuuvttZYHH0Wrl8ysZuo+MFHqA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UGMg0ZxrSB5Y6y8eMg/Y0A/G+j9ibH66bPhWEedVUf2YD4QweIwj/SbhyEWlWNG36
         rK7QXPvjiOQq18oefDdZs7C7wm2umGln1VW2I4LhUmnFYpzgpes8lfP2ZutmGnyGS3
         vqpzYJYyQewKn4+iIszV+eOoSQRaYy+/5og1k4DlTJ7Ktd1KoegY5gf9gwWl9ahJuT
         EpGhjwUIa8wCC2Tp+knxbWDkSXBRuCNIl958P4h/C2eHOJvEaSQSCqhF00yLKCQ+0z
         qnddPHDYBAJNgbxrByylGyfQA72RswR6iHn2N1MSoIXGO0N3OvGr51L3d/1aZR+iDz
         Bj9/kwajdbHog==
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com
In-Reply-To: <20220913123456.384513-1-angelogioacchino.delregno@collabora.com>
References: <20220913123456.384513-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 0/4] MediaTek Helio X10 MT6795 - MT6331/6332 Regulators
Message-Id: <166308747505.261771.11158894502965288583.b4-ty@kernel.org>
Date:   Tue, 13 Sep 2022 17:44:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-7dade
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 14:34:52 +0200, AngeloGioacchino Del Regno wrote:
> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.
> 
> This series adds support for the regulators found in MT6331 and MT6332
> main/companion PMICs.
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/4] dt-bindings: regulator: Add bindings for MT6331 regulator
      commit: 6385e21692bbb0b35eca8120d576b3c1ba1ad9d3
[2/4] regulator: Add driver for MT6331 PMIC regulators
      commit: 6f7a71f804287a7566314ab1a73d8ca2c18ca0d7
[3/4] dt-bindings: regulator: Add bindings for MT6332 regulator
      commit: e22943e32e1fc314b8e2b095ae3495d1bfa9aca5
[4/4] regulator: Add driver for MT6332 PMIC regulators
      commit: 1cc5a52e873a4f9725eafe5aa9cd213b7b58e29e

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
