Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA2669959E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjBPNXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjBPNXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:23:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9251854561
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:23:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A11AB827F7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9643C433D2;
        Thu, 16 Feb 2023 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676553815;
        bh=zZ4rQNc8mPRkeZ0/8qJ2pJ5hmbNsF1z0HeQ280pKM6E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZUpV/cal3CvprEvJANGAsyd4jjRMoj2iuceMPIdBzVvrvACNFdGcn7m9r7o9P+lbP
         j2NdFaCR6W9mlUAa9529aKRKl5210D++z7f2doAAAuWDd6TZ2Tp7N05PaTpNSJYiLI
         NbBHhn3/yv0yHLlRLV0mQ+tZVCclF5PYujt+jzgX+VOSyhr6PscPj9B2icQvQmBNTM
         z2iRSqKptCLCSOenFzS/dse6BJwSD4bsumw9EH/spJm9k9/Vtl4OxJZyQMOWlEzGfX
         BWjdTfauhtM9v+962YbyUCkUge/b8vunBFYUudx49t3PTC3sgR02iaiyNCdrsbnEX3
         FEfim0Ag+tl/Q==
From:   Mark Brown <broonie@kernel.org>
To:     David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, bailideng@google.com
In-Reply-To: <20230215101045.21456-1-David.Rau.opensource@dm.renesas.com>
References: <20230215101045.21456-1-David.Rau.opensource@dm.renesas.com>
Subject: Re: [PATCH] ASoC: da7219: Improve the IRQ process to increase the
 stability
Message-Id: <167655381355.3676286.5725030746001526408.b4-ty@kernel.org>
Date:   Thu, 16 Feb 2023 13:23:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 10:10:45 +0000, David Rau wrote:
> Remove the sleep control in IRQ thread
> and create an individual task to handel it for Jack plug in event.
> 
> This commit improves the control of ground switches in the AAD IRQ.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7219: Improve the IRQ process to increase the stability
      commit: 7fde88eda855952766a74026c181c6270b3392fc

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

