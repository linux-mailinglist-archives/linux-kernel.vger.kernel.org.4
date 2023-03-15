Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA346BB45C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjCONTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCONT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:19:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012071F5EB;
        Wed, 15 Mar 2023 06:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AA53B81DEC;
        Wed, 15 Mar 2023 13:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911B4C433EF;
        Wed, 15 Mar 2023 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678886365;
        bh=sga3q+scIZvfNK/6EdO/zdT6nG8pr/gf9L75QKEyXLE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OUirE43Qzm0pBNiCEdWb7jM+cVNqa603CO3Zzp7vsSbCJCbgLFTl1u5uL7NlQSUcQ
         OhbHwNlLmMWGEo9vYEZeeSsKOU2X7l8xkhVu5WhAF+llat0rVrwL2rB3el0OWAFebx
         QT09DZvyQymTRSTzKmZpr2jwXXsVFt98ejUeRMcecOPOJZCZAMxiTKq7fPo00qsGj5
         AuyAMwi7zgAKYm/MwOyTN6bcOXlWX7vW07Vss6xo+auD1hQf3zABe2DilAK6KLvLCH
         Otu5p+bPtC973v3j7H8jOjwnsPe9Nn5dqKNF/LhPBAhOvOs5IVMNWmrndwkPuKWSuo
         X9oySDgyUtEjQ==
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Herve Codina <herve.codina@bootlin.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>
In-Reply-To: <20230314082157.137176-1-herve.codina@bootlin.com>
References: <20230314082157.137176-1-herve.codina@bootlin.com>
Subject: Re: [PATCH] soc: fsl: cpm1: qmc: Fix test dependency
Message-Id: <167888636330.25434.5728670450975508265.b4-ty@kernel.org>
Date:   Wed, 15 Mar 2023 13:19:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 09:21:57 +0100, Herve Codina wrote:
> The QMC depends on (SOC_FSL && COMPILE_TEST). SOC_FSL does not exist.
> 
> Fix the dependency using the correct one: FSL_SOC.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] soc: fsl: cpm1: qmc: Fix test dependency
      commit: 6ffa0da5c63f8408101d01075709981005eb66ec

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

