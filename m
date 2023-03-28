Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C8A6CC71E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjC1Pwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjC1Pw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:52:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB66198B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5139CB81D79
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E64EC433D2;
        Tue, 28 Mar 2023 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680018744;
        bh=N/0Q2ofWL1px+rKg7cbc8KWr7TkYVLJkqMMOXNaxdNQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rzwSHNXzPA7AMhJbSZffuulKOqXtRg4P5Qyv+373duLbJh8qP1hJ1h1akNsErxJ1C
         drti1Y7AAZAaX91u9xzal5l5yY+2loWagf9IHl60dL2YmF0ubzagpC7Xf2Q+P8Q4OX
         9bCvOF9D6kLl8VHGGrYlwp7vaahN04AAOwumn32ch9Xqtig3p3T3ZDy9CRTLgHDJBm
         i6ymSJhMZmWFIVjR91InD6a1Q333mHhPVAtOYUIQR3BptFUeOrtMUwdUFIqKVdxeqd
         wEA/+TLwDD9ovvWUIRTSL/cf516im5w6illGgjCToc55JBXE6BTRzcb61Sq0ep6Dmu
         IXaN7fZY1I9Jw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
In-Reply-To: <20230328094901.50763-1-cristian.ciocaltea@collabora.com>
References: <20230328094901.50763-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH] ASoC: es8316: Handle optional IRQ assignment
Message-Id: <168001874221.43606.9872298334839661286.b4-ty@kernel.org>
Date:   Tue, 28 Mar 2023 16:52:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 12:49:01 +0300, Cristian Ciocaltea wrote:
> The driver is able to work fine without relying on a mandatory interrupt
> being assigned to the I2C device. This is only needed when making use of
> the jack-detect support.
> 
> However, the following warning message is always emitted when there is
> no such interrupt available:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: es8316: Handle optional IRQ assignment
      commit: 39db65a0a17b54915b269d3685f253a4731f344c

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

