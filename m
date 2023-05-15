Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59734703195
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242213AbjEOPbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240326AbjEOPbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:31:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E7319BA;
        Mon, 15 May 2023 08:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25DAD6224D;
        Mon, 15 May 2023 15:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5874C4339B;
        Mon, 15 May 2023 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684164667;
        bh=TDEwSTLolQvMt4EHNuIwFIk4wEdg1IERZQM09Ze3bf4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=udjI6GHbvobyWeQRDig3BYNl3hGfXA0T0gv9JC3DL5xeSh7F1qstjH26S/xR6euR8
         1I1UB1fCCSloIr0x6svQWaYIem0Xap9HizBbJqyZSye7xAKcfMWEQOkHBO9pXH7O72
         yodzUprJMtzbiDGKsJLF3O3ni8s9zdt9DrzhIV+jgo1uhJL9+nEbd2C7Ym4K5L0r1Z
         jH0LU9w7dUdPdNNINo2YeBg6Bpm+HDxkCf5b1KbB6tN9Vkjrj4EstuPn9gVVYflNQD
         358K2AJVpS7D9iAjOwKmg22xTYEsDP/swVfhg+5KRKuzdy7quGzOZk1bXd2/tdEyfe
         poLGS98x6vH/A==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20230510035526.18137-1-trevor.wu@mediatek.com>
References: <20230510035526.18137-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH v4 0/9] ASoC: mediatek: mt8188: revise AFE driver
Message-Id: <168416466452.415808.13353377218867876489.b4-ty@kernel.org>
Date:   Tue, 16 May 2023 00:31:04 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 11:55:17 +0800, Trevor Wu wrote:
> The series of patches consists of four major changes.
> First, remove redundant supply for ADDA DAI dirver. Second, revise ETDM
> control including APLL dynamic switch via DAPM, so APLL can be enabled
> when it is really required. Third, update AFE probe function. Bus
> protection change was dropped at the previous patch because the dependent
> change was not accepted at that time. Finally, correct some binding errors
> and add required clocks.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: mediatek: mt8188: remove supply AUDIO_HIRES
      commit: 4db399793c34c72dcad18815d54c0cd23750b8f1
[2/9] ASoC: mediatek: mt8188: complete set_tdm_slot function
      commit: 2664c8790cfdcaa81ff8b3b9f649a6635955d636
[3/9] ASoC: mediatek: mt8188: revise ETDM control flow
      commit: e5d2bd4103df419fd33131f1aa7a8dea35e3638c
[4/9] ASoC: mediatek: mt8188: refine APLL control
      commit: 9be0213a6858d0084a9e800d2b451678f014f337
[5/9] ASoC: mediatek: mt8188: combine afe component registration
      commit: e9eab4bed0436a7b7268114ecf55fe4989855d47
[6/9] ASoC: mediatek: mt8188: add bus protection
      commit: fb167449cec1d2f34ef4c6d17ff860076ac0fc44
[7/9] ASoC: mediatek: mt8188: add required clocks
      commit: 2e5c422a624aa35cefb5a448a2040df6627f505b
[8/9] ASoC: dt-bindings: mediatek,mt8188-afe: correct clock name
      commit: 1e4fe75e9746be8e40c57132bb3fba1ce3dd24af
[9/9] ASoC: dt-bindings: mediatek,mt8188-afe: add audio properties
      commit: 739ee993c38596d93150f96153f9bb1cfd7733bc

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

