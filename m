Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAFB691126
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjBITTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBITTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:19:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59486BA9C;
        Thu,  9 Feb 2023 11:18:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D824AB82287;
        Thu,  9 Feb 2023 19:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE50C433D2;
        Thu,  9 Feb 2023 19:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675970323;
        bh=mDkzITMeQax7M/mdpkLZOTnU0VTywWzADEO1NFt7WtI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I5qAoAZlJ9ktZK+svpS08bNObcipk6QOo528BUt0+E0F/IbWtNriGeVTjYWXmhIi8
         xc9Q+c3W+39q0AnwG6PKz1lglgKQSdbOMz5x8L21aRTpLYqbmnn2AN9TYQ1f9dUHav
         KUj2fgjx0OzhFJwCR0RjuYkFcExiWDXSfSlxEkFptutZ99LeA4ds9f28eHkdcEueCM
         +RvxK5Wkk5mN5/y3nZgEyxHrE2vOGk/GE23D1c4qxvvAHw5gImOqMG04DkWMp9uedJ
         zEhwd6gzST5oXrtSowKOb7KZyZGBaIQcWZ5AEmeeVlElZsMnsyOrbfHgmUE9djggEC
         II+2tN3RKcm2A==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc:     Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        benliang.zhao@mediatek.com, bin.zhang@mediatek.com
In-Reply-To: <20230201020921.26712-1-xiangsheng.hou@mediatek.com>
References: <20230201020921.26712-1-xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v6 0/5] Add MediaTek MT7986 SPI NAND support
Message-Id: <167597032096.933619.6758508358414336782.b4-ty@kernel.org>
Date:   Thu, 09 Feb 2023 19:18:40 +0000
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

On Wed, 01 Feb 2023 10:09:16 +0800, Xiangsheng Hou wrote:
> This patch series split from bellow series which pick-up spi relevant patches
> https://lore.kernel.org/all/20230130030656.12127-1-xiangsheng.hou@mediatek.com.
> This series add MediaTek MT7986 SPI NAND controller support, add read latch
> latency, smaple delay adjust and add optional nfi_hclk.
> 
> Changes since V5:
>  - Split spi relevant patches from previous series V4
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: mtk-snfi: Change default page format to setup default setting
      commit: 2b1e19811a8ecc776d15da4ca89df48db6974d66
[2/5] spi: mtk-snfi: Add optional nfi_hclk which is needed for MT7986
      commit: e40fa328551dd67d14e5dc3e4ed82b5b770f027f
[3/5] dt-bindings: spi: mtk-snfi: Add compatible for MT7986
      commit: 8aa2ef233fa3b985ced1ed31b86fddddfd6be4b2
[4/5] spi: mtk-snfi: Add snfi sample delay and read latency adjustment
      commit: 1d36c99062bf4e809271cc534486342442508d4a
[5/5] dt-bindings: spi: mtk-snfi: Add read latch latency property
      commit: 351c02cb740472c659145b0027e77a3353e58185

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

