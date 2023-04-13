Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5112D6E10C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjDMPO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjDMPO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:14:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF941B7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:14:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42D2D63F78
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DE2C433D2;
        Thu, 13 Apr 2023 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681398864;
        bh=h7KzqElfNX2f7QoU1g1x1vARdeArVAPCJ+inLnzOy1A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BQpUdVdMEcWwYyDMBNI0G19U6uxSa/VIwZjZBAGO/E2WJCeRPNUPr1tv+OCk6gSlZ
         YUKT/AnoSLVzt1+fGt0LchlJDUauJ+QaTSRPVD0gaOp8fqllGgGWpK8TqOeWnzLosF
         xXAq5SW+mxtSmKv0tGEeLzKXFp2YwYIYtSTJSJ6C9KBFIFI4HU+vTuxwIOH5YcMMu9
         LAk9DTfeDgwORIs2JkKqauAClTpCwMmI7UR5/8jVKYtnYtcGdVxZVPRO+PVbgS8A9I
         lCo7qHHacBVWOs9mUeNoBnYxskY0d6+xqTQdONwCh97uQMce3tFz5GZP6l05nEivTN
         UsCaASo4bOTAQ==
From:   Mark Brown <broonie@kernel.org>
To:     David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, bailideng@google.com,
        groeck@google.com
In-Reply-To: <20230413024134.8612-1-David.Rau.opensource@dm.renesas.com>
References: <20230413024134.8612-1-David.Rau.opensource@dm.renesas.com>
Subject: Re: [PATCH] ASoC: da7219: Improve the relability of AAD IRQ
 process
Message-Id: <168139886267.3579559.15217836331679376399.b4-ty@kernel.org>
Date:   Thu, 13 Apr 2023 16:14:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 02:41:34 +0000, David Rau wrote:
> - Configure the default gound switch delay time before enabling IRQ
>   to avoid the unexpected delay time is set up
> - Apply DA7219 AAD own work queue to handle AAD events
> - Replace msleep with queue_delayed_work to have better relability
> 
> This commit improves the control of ground switches in AAD IRQ
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7219: Improve the relability of AAD IRQ process
      commit: 2c17277893747e30e41d1a7b57b80f2b298da278

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

