Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B938E68F6CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjBHSVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjBHSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:21:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EED241DE;
        Wed,  8 Feb 2023 10:21:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 705AC61644;
        Wed,  8 Feb 2023 18:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7E7C433D2;
        Wed,  8 Feb 2023 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675880465;
        bh=A3n0nGZLvj39U/jVCAMmkf50AXmyykK4cBXFyjRUEI8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=vM8zBdZmnGDwhC9d+aA/tyJIiVWIPa8XO+fRKKyYaZWm2mAJaM4bvsGqkucEsaqdO
         XT1ZIWwMriMTr3+0dUHTTeKdRatMQ6cZiAach0QgAwCEERGyNfNA7dtv6WT1v+ONBY
         1HqQTRNuYEFyucD8geWd+ttsu5Rq7/7k9XpbwQyREbKuv+aIhHp0y4Hv1iVdoWavL3
         JkG+8qbkzEFFQGRE1/5r6HGB316meziv579/isaEvb6Q7Ei8DhwXhSLQ/vJl1rVeIC
         BIy7RV7f/8yuOFWwu68BQm2t0U1yrhVeC840RTmMZPXlNB/TlAGlxAFUVJ78XHb1Va
         lgaCnSivSpoFA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230208093520.52843-1-jbrunet@baylibre.com>
References: <20230208093520.52843-1-jbrunet@baylibre.com>
Subject: Re: [PATCH v3 0/1] ASoC: dt-bindings: meson: covert axg audio to
 schema
Message-Id: <167588046319.297485.6961864943902317327.b4-ty@kernel.org>
Date:   Wed, 08 Feb 2023 18:21:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Feb 2023 10:35:18 +0100, Jerome Brunet wrote:
> Continue conversion of AXG audio dt-binding documentation to schema
> 
> Changes since v2:
>  * Drop 6 patches applied with v2
>  * Drop Yaml block style indicator for multiline description
> 
> Changes since v1:
> * Drop 2 patches applied with v1
> * Drop node name patterns
> * Fix examples indentation
> * Yaml fixups requested by Krzysztof
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: meson: convert axg sound card control to schema
      commit: 65f0a8ea90d2fc2e79a616143f844047e25057c8

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

