Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF09A63AF92
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiK1Rnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiK1RnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:43:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652CE29347
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:40:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02F23612F3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C351C433D6;
        Mon, 28 Nov 2022 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669657226;
        bh=ksNf/YddouAnHYSNO35e1eWHI7ypXSlIfibrJFdWEf4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Osc1H1Y2dd/1zAyoQv+CJvEfOBepdr9KnkC0Zq43CfxEmyEQzwk67A9puNnYw1UAG
         O7eYNatbOG5Z14pGD8hrppnia2Ca1TJvKAzr96aG88MMS/18dMhTP38B9tjfH3zMta
         YqQR6azn+QEVmFrzUXaVXRPwFej2H01vc+BY0ce5spLiGefmYlCDipt0DhT9Q/yvmS
         hc7EKRFdHf93+NgdMwL47eGE10e3kiqHQqqsBa/sHM/+o+IenCpufIpc78A+zKNHDF
         gZ3Sq/2abivOb7aykWQsyg+5mbBuDoihw6NCLvLqoHlYm07PhN7incrFBJbmaAy2Ym
         3o1u0nuxP+WUw==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20221128-mt8173-afe-v1-0-70728221628f@chromium.org>
References: <20221128-mt8173-afe-v1-0-70728221628f@chromium.org>
Subject: Re: [PATCH] ASoC: mediatek: mt8173: Enable IRQ when pdata is ready
Message-Id: <166965722420.688163.18006301242962769416.b4-ty@kernel.org>
Date:   Mon, 28 Nov 2022 17:40:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 11:49:16 +0100, Ricardo Ribalda wrote:
> If the device does not come straight from reset, we might receive an IRQ
> before we are ready to handle it.
> 
> Fixes:
> 
> [    2.334737] Unable to handle kernel read from unreadable memory at virtual address 00000000000001e4
> [    2.522601] Call trace:
> [    2.525040]  regmap_read+0x1c/0x80
> [    2.528434]  mt8173_afe_irq_handler+0x40/0xf0
> ...
> [    2.598921]  start_kernel+0x338/0x42c
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8173: Enable IRQ when pdata is ready
      commit: 4cbb264d4e9136acab2c8fd39e39ab1b1402b84b

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
