Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D35750687
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjGLLqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjGLLqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA824198B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4EB61794
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52051C433CA;
        Wed, 12 Jul 2023 11:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162394;
        bh=qVhulzstUJ4uSDTRxWOAXGiWsrinypPIfPE5kZRZS2U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=R+Be2Q+YrwTmsioW4fNMiK4k97HYGi3/lQb1W33Iwc9JtnBS9wo2ZfzqjmV0huyGp
         ExcnxwkhkAiUlcMIm/Zgvp3Ra03TOpJrTjYS4tmU42mywcdfaiCian7cawtudEYEBR
         HlzmrorLNyh5ru/mOj00AHOAm1orh4AxRuTEx/r5WOVSDsUVTfUdHY8mrHUGeT/K+n
         ISjlRVOVqkYPT/rdrLTaoJXLMhpdqn8VlzuyaYtrrlVTuDBogbNMwkeg/7AcTHx1nl
         HJ6GVZCbMfQokJG2V2DLlsf6nS/Pml3J/PV316h9vK6OyCRykJvQON7cRWzQzqQxY1
         Pj/JcZJg+5MNw==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, Yang Li <yang.lee@linux.alibaba.com>
Cc:     tiwai@suse.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230625010547.7353-1-yang.lee@linux.alibaba.com>
References: <20230625010547.7353-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: tas2781: No need to set device_driver
 owner
Message-Id: <168916239302.46574.14475207879403261091.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 12:46:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2023 09:05:47 +0800, Yang Li wrote:
> Remove .owner field if calls are used which set it automatically.
> 
> to silence the warning:
> ./sound/soc/codecs/tas2781-i2c.c:746:3-8: No need to set .owner here.  The core will do it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: No need to set device_driver owner
      commit: 24e04c94bebc4144f790a21a93d090cf9673acd9

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

