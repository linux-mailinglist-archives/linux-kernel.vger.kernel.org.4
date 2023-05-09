Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417BE6FBF5D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbjEIGjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjEIGj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:39:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B0FD076;
        Mon,  8 May 2023 23:39:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2D1C6164F;
        Tue,  9 May 2023 06:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B629C433EF;
        Tue,  9 May 2023 06:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683614348;
        bh=w22KuX01pMZbO/Eaa6JLtKePa21cyYmG8SwUr9hiNyw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IlTXY2aCEu3Kl2vnXKCZZeoatsDFBy1icDMudOcR8MwKfg8GF4CyU+J0ULOaggod6
         59qXgpp7PyhhHfp8MCeDCdflybDeEFgRSxfAADu1zRj82SmwmbUwi/xKLXGPhS5Ede
         aubQxRLVVoym0NzqSpINOLJqvKsgFQsEh/LItG5orBwMH2IyyiG7K+oWGctHrOseRl
         UD/i/G6Iqj3R4I7zRHKNHIM1I6s/YZnrnqht83bnf/CYkg/pqxf966b5wi6UuSdZ8X
         A5mesHEWClaSKcI/2OSv4KsK1BHEN8w2xoitPSCpe3hJ0BX3lAzlcudu8gQ8mneJI9
         gWVMjtPNm86Cw==
From:   Mark Brown <broonie@kernel.org>
To:     robh@kernel.org, Anup Sharma <anupnewsmail@gmail.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, KCHSU0@nuvoton.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <ZFYxWVdE9YkMKvXv@yoga>
References: <ZFYxWVdE9YkMKvXv@yoga>
Subject: Re: [PATCH v2] ASoC: dt-bindings: nau8540: Convert to dtschema
Message-Id: <168361434507.303059.8363951498743127692.b4-ty@kernel.org>
Date:   Tue, 09 May 2023 15:39:05 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 May 2023 16:22:09 +0530, Anup Sharma wrote:
> Convert the NAU8540 audio CODEC bindings to DT schema
> 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> 
> Changes:
> V1 -> V2: Adhere to the correct procedure by including the maintainer's name.
>           Drop Mark from maintainer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: nau8540: Convert to dtschema
      commit: 0f0d70c2881f8c28e6d449349e057963a742f842

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

