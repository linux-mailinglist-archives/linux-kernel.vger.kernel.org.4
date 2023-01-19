Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F51E674B17
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjATEoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjATEnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:43:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FF1CE890;
        Thu, 19 Jan 2023 20:39:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EDB2B82592;
        Thu, 19 Jan 2023 15:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9AFC433EF;
        Thu, 19 Jan 2023 15:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674142399;
        bh=H771fSfWeWB3a/8kw3DPz5R4e39zQUSOubvNIKtjKX4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=B6h7r9Sxi4wnsa4Ax46HpkHlw4IIIf68GlWNrLMp/2RQqeCOQzmUzcaoXSgOpT0/6
         R4UCZJaClvRt5uKNh988KwdDhf176o2hoHU06zbrr8fQ/Lfjv8ukY+BsacoD2iEVZi
         KTEg+3gRD37fDSKXL5uwERrATcHuxjZvGxCyPtDJ9fkxnEzY30rq39l+1qBzi4od1u
         szO/1qdEto4avW2HFYjTjrVvgvN0pBiMOe3Xl9195cvSSOWWuekwBxPCBcL4S5G16l
         eY9qsO2hc9l9eZO59uH6ViYwtJd4MC9OSSnZ6J3N3iH8pwQQfaIFJZwOCKKf9F+ojf
         TaidLFyl9nzOw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20230116034131.23943-1-trevor.wu@mediatek.com>
References: <20230116034131.23943-1-trevor.wu@mediatek.com>
Subject: Re: [RESEND,v5 00/13] ASoC: mediatek: Add support for MT8188 SoC
Message-Id: <167414239535.1082520.4972233422127115256.b4-ty@kernel.org>
Date:   Thu, 19 Jan 2023 15:33:15 +0000
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

On Mon, 16 Jan 2023 11:41:18 +0800, Trevor Wu wrote:
> This series of patches adds support for Mediatek AFE of MT8188 SoC.
> Patches are based on broonie tree "for-next" branch.
> 
> Changes since v4:
>   - refine etdm dai driver based on reviewer's suggestions
>   - refine dt-binding files based on reviewer's suggestions
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[01/13] ASoC: mediatek: common: add SMC ops and SMC CMD
        commit: 7d40cc8eedbad7cce77226c5d01d891a40373eeb
[02/13] ASoC: mediatek: mt8188: add common header
        commit: f90f0dd809e6600cf20ab74f07237241925f5cf8
[03/13] ASoC: mediatek: mt8188: support audsys clock
        commit: fdd4e1a28d69648c35bea020c0df3735ddc74889
[04/13] ASoC: mediatek: mt8188: support adda in platform driver
        commit: 5d1c8e881ae0e6e931396952534d422facbebdbe
[05/13] ASoC: mediatek: mt8188: support etdm in platform driver
        commit: 2babb47774891bc8e68ae229d42ee7df90db9fd9
[06/13] ASoC: mediatek: mt8188: support pcmif in platform driver
        commit: 5d43bdd71200e1b08b7c4b7f3d3c86fdd23c4a3d
[07/13] ASoC: mediatek: mt8188: support audio clock control
        commit: f6b026479b1392b4b2aa51ed1edbfa99f6d49b59
[08/13] ASoC: mediatek: mt8188: add platform driver
        commit: bf106bf09376608e4992f9806c21842a4223f18b
[09/13] ASoC: mediatek: mt8188: add control for timing select
        commit: da387d3223aea9505fcd740105b7494df5bb44ad
[10/13] ASoC: dt-bindings: mediatek,mt8188-afe: add audio afe document
        commit: 692d25b67e1089a7683978d1860e511f2ca86e7b
[11/13] ASoC: mediatek: common: add soundcard driver common code
        commit: 4302187d955f166c03b4fa7c993b89ffbabfca4e
[12/13] ASoC: mediatek: mt8188: add machine driver with mt6359
        commit: 96035d46d4b45274208327826608b873ec6d7f06
[13/13] ASoC: dt-bindings: mediatek,mt8188-mt6359: add mt8188-mt6359 document
        commit: ce0382384e88c75d2506d4e49929ab8c22527dc7

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

