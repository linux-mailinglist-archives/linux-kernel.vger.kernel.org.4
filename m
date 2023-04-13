Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7086E10C3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjDMPOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjDMPO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:14:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA7F134;
        Thu, 13 Apr 2023 08:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5800963F7B;
        Thu, 13 Apr 2023 15:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7FBC433EF;
        Thu, 13 Apr 2023 15:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681398866;
        bh=wHnJNHVmb7RqxHn81PnrsufS4lvuIofxtxlWj1muxss=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=haZCSPfIcIuOhMYMjYaPXwhiWiKE7R2JCpEVH3CTDM8noDd6o45zMQhk/M7iWA7fN
         fTeTcgNPG20b83Ak8519RWPN5zxIfKbNmMiiP1zrXxVNQ8GcS9J89sIiYtRhw3nldf
         FVBG+Rbdf0lxZkgarsc8czYRAnzczuRctsaFIynS6jf6P5tdYdvdqw2FyDRoENjpwg
         pnfBZo8dBoVyMwTcfTRTNigVvQ7lhOqUMorwFJGFWGEHVuGNwOCOQdWc0YGVc0kZsr
         HBwVl3s+d7jGiL4TqVPhZLmXzP7ArPyi1q7/Q6zKNVLYDWjaYRDr+tAT0Plg2ZjOr6
         fr95PaEtlsBNA==
From:   Mark Brown <broonie@kernel.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <51976b2515d7007ba5c8aa7524892f147d7cdd51.1681363691.git.christophe.jaillet@wanadoo.fr>
References: <51976b2515d7007ba5c8aa7524892f147d7cdd51.1681363691.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: da7218: Use devm_clk_get_optional()
Message-Id: <168139886490.3579559.9766383367823502218.b4-ty@kernel.org>
Date:   Thu, 13 Apr 2023 16:14:24 +0100
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

On Thu, 13 Apr 2023 07:28:33 +0200, Christophe JAILLET wrote:
> Use devm_clk_get_optional() instead of hand writing it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7218: Use devm_clk_get_optional()
      commit: c6c3581a3e178882c8815462ca129e60be50fde8

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

