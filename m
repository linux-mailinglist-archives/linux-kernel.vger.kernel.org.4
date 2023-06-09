Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0A7729950
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbjFIMOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjFIMOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:14:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AC61A2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E02961F3E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DC8C433D2;
        Fri,  9 Jun 2023 12:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686312871;
        bh=uEkHK/OWnkh6TBr8Tflth6P5jYUmDTQTMsMjbj0gNak=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SETVrGFe66DeI9nDQrp9PDzhE14TlMnCnBvWMHQ/nPJb9roX+1jNaMI5zJsNhhxVq
         HmIvOmR3qqU3ZNKi+qgWOB/19H5DVN+M4CP5I8Cb9EoSIOmZ7/AFy5J+ex8OOqve9m
         K9Wo2iLgFdPQrsGvtnXVMJ33IVIaTtF1hvugL6gEqhl094LyGYjgAgGOwzLrUdzFDi
         aWKa98PyqnFvhdmgV/SWzbhwqAo8Y2RTotx+gEMXiRKCxRwUAHJZeDpSRRK0ar8fCC
         LESA1UpBK1eJ003zMU1EZ/DgfneDbojR3eLLXssIcpjNKKF3gmEt9/R2GyqN03HQGm
         868D2dF3WfNdw==
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Walker Chen <walker.chen@starfivetech.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230608135750.11041-1-walker.chen@starfivetech.com>
References: <20230608135750.11041-1-walker.chen@starfivetech.com>
Subject: Re: [PATCH v2 0/2] Fix error check and cleanup for JH7110 TDM
Message-Id: <168631286990.42950.16318348817986270915.b4-ty@kernel.org>
Date:   Fri, 09 Jun 2023 13:14:29 +0100
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

On Thu, 08 Jun 2023 21:57:48 +0800, Walker Chen wrote:
> Some minor issues were found during addtional testing and static
> analysis. The first patch fix the error check for the return value of
> devm_reset_control_array_get_exclusive(). The second patch drop some
> unused macros.
> 
> Fixes: fd4762b6b5cf ("ASoC: starfive: Add JH7110 TDM driver")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: starfive: Fix an error check in jh7110_tdm_clk_reset_get()
      commit: 3582cf94ff49469ffe78e96014550f7d4e466fbd
[2/2] ASoC: starfive: Remove some unused macros
      commit: 8bd81864533bd02d6922deadeed643c813dfe142

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

