Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A16362F93B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241874AbiKRPZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiKRPZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:25:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A3961B8A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:25:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ED28625CA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 15:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F9EC433D6;
        Fri, 18 Nov 2022 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668785117;
        bh=GygClQT09XAwMmXr6yHUgwEriuF+/HCUV6OOmACC2J8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LEukaIck+kATcrrmKi4ZBqC9IYH4rsRZTFW5XAW47VaRX5HAgTMTg8qe5coVeLUsA
         9bJXgUOZgcmM3NwM2aA0cx1EwmRgnhPvEQlLOwUl3P91bCrgDWyuYCjPffBQUAAxfs
         UWGq4g5oB/OEreMVn9CCQQjospgM73728iVuMmRdAXnfMrSdO2u079C1wotL1AhJk/
         OtTM3v/h2Z+uW+fczhFM39GOx5zMndB0mMJz2AOhLgMmqQ4EXWbKFHMZG2MfinJVfH
         IfcOeOSJpLrp5bIFhDspiKDZ/PJQ5IJ6Jbz4ndyjPKc/9slVVW7L373fFya9l29Ih5
         cvwZv2Gmi93SA==
From:   Mark Brown <broonie@kernel.org>
To:     nicolas.ferre@microchip.com, tiwai@suse.com, lgirdwood@gmail.com,
        Claudiu Beznea <claudiu.beznea@microchip.com>, perex@perex.cz,
        alexandre.belloni@bootlin.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20221117123750.291911-1-claudiu.beznea@microchip.com>
References: <20221117123750.291911-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 0/3] ASoC: mchp-spdiftx: add power saving features
Message-Id: <166878511492.955590.9958880472187232412.b4-ty@kernel.org>
Date:   Fri, 18 Nov 2022 15:25:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 14:37:47 +0200, Claudiu Beznea wrote:
> This series adds support for runtime PM and system suspend/resume
> for Microchip SPDIFTX (patches 2/3, 3/3). Along with it I took the
> chance and added a minor cleanup (patch 1/3).
> 
> Thank you,
> Claudiu Beznea
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/3] ASoC: mchp-spdiftx: simplify locking around ctrl->ch_stat
      commit: 215450eb8b0fac000a42c1cd52c8966fb5159037
[2/3] ASoC: mchp-spdiftx: add runtime pm support
      commit: 4bf54ca60f99643cfaa3e5b532f139f6501f318e
[3/3] ASoC: mchp-spdiftx: add support for system suspend/resume
      commit: abc7edb0329cd2eabc0b948f5e248c85f6268296

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
