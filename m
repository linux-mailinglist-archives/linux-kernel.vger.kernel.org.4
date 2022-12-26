Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BB0655F94
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 04:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiLZDln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 22:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiLZDlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 22:41:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F936DE6;
        Sun, 25 Dec 2022 19:41:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0107B80BA0;
        Mon, 26 Dec 2022 03:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72628C433F1;
        Mon, 26 Dec 2022 03:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672026091;
        bh=zmtqhXQv7hiPZDJGmROKlujPmTGm2oRNxnDcUz2K1XA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aFP63n6aR/0rsvyekq2AImCT+Ltsl9Jl7dPzbNYHhoyZYHDH6lK2bZrhlcgunmhld
         RgMVPID00zacoRWh6/2WcYeqqfuXii7bfwtJk5lxNcH9sYhs6uYZ65sHxjCjvHVJGC
         jU2sooTMKGRe+SFmEQSyRrM2Z5Ebr4Jv8ipoN7FtPVN5x7rUbCF4ahlzEUcQHuzwgS
         dPZnfjIrxijvQKXa4OnPsL5xX8faKU1LhwAeeoNrFyIvTCF3+ednhZDVur/h1/X3jD
         E41cCnOUXtPEk1kFVfqyh2f9D9ufm9IlqPIid1pjLmSc0vc0NcK4CEzAwGC3ktCoTG
         JD3TuvTuDV3ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CBF2E50D66;
        Mon, 26 Dec 2022 03:41:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: Extend name-prefix.yaml into common
 DAI properties
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167202609130.9518.10337988666912704066.git-patchwork-notify@kernel.org>
Date:   Mon, 26 Dec 2022 03:41:31 +0000
References: <20221203160442.69594-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221203160442.69594-1-krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     neil.armstrong@linaro.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, lgirdwood@gmail.com,
        broonie@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, fengzheng923@gmail.com, povik+lin@cutebit.org,
        james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, rf@opensource.cirrus.com,
        ckeepax@opensource.cirrus.com, peter.ujfalusi@gmail.com,
        cychiang@chromium.org, tzungbi@kernel.org, groeck@chromium.org,
        bleung@chromium.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, stephan@gerhold.net, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        frattaroli.nicolas@gmail.com, heiko@sntech.de,
        s.nawrocki@samsung.com, festevam@gmail.com,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        olivier.moysan@foss.st.com, arnaud.pouliquen@foss.st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        alexandre.belloni@bootlin.om, lars@metafoo.de,
        bogdan.togorean@analog.com, nuno.sa@analog.com,
        vincent.knecht@mailoo.org, kuninori.morimoto.gx@renesas.com,
        mripard@kernel.org, rriveram@opensource.cirrus.com,
        patches@opensource.cirrus.com, j-choudhary@ti.com,
        drake@endlessm.com, katsuhiro@katsuster.net, shengjiu.wang@nxp.com,
        paul@crapouillou.net, jee.heng.sia@intel.com, lkundrak@v3.sk,
        codrin.ciubotariu@microchip.com, mkumard@nvidia.com,
        spujar@nvidia.com, rohitkr@codeaurora.org, derek.fang@realtek.com,
        biju.das.jz@bp.renesas.com, cy_huang@richtek.com,
        joabreu@synopsys.com, afd@ti.com, shifu0704@thundersoft.com,
        shenghao-ding@ti.com, flatmax@flatmax.com, ricardw@axis.com,
        perex@perex.cz, tiwai@suse.com, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@lists.linux.dev,
        asahi@lists.linux.dev, chrome-platform@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Mark Brown <broonie@kernel.org>:

On Sat,  3 Dec 2022 17:04:40 +0100 you wrote:
> Rename name-prefix.yaml into common DAI schema and document
> '#sound-dai-cells' for completeness.  The '#sound-dai-cells' cannot be
> really constrained, as there are users with value of 0, 1 and 2, but at
> least it brings definition to one common place.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [1/3] ASoC: dt-bindings: Extend name-prefix.yaml into common DAI properties
    https://git.kernel.org/chrome-platform/c/3fda85324b8d
  - [2/3] ASoC: dt-bindings: Reference common DAI properties
    https://git.kernel.org/chrome-platform/c/58ae9a2aca6f
  - [3/3] ASoC: dt-bindings: maxim,max98357a: Convert to DT schema
    https://git.kernel.org/chrome-platform/c/8a5a05583a04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


