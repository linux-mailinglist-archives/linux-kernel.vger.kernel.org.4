Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8ED70C1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjEVPCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbjEVPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:02:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF190E4B;
        Mon, 22 May 2023 08:01:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC7D5623AC;
        Mon, 22 May 2023 15:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FB5C433D2;
        Mon, 22 May 2023 15:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684767710;
        bh=FFjp9TlBTb9pZ6Q8XbdWktID7xpqUqBNNGV6hRLdV9Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ghmuTwgIiZv74F1eDiHQ5tZDEgWJE8W8AEPC/A6QpZHk0rZ4gvIYtfJXByOMLobWG
         MdbfimjGjHHZn9iBOSOkloEoJ/DnRib7ngA4HK9yzE5FVxoE4CoMiOyGD60BHbfFx4
         aqi7ZEbRcyZG3OyGjDId25UZS25Req3+FtMasAtdpaBqWx1ImDb3+WZn9LvBWpcJaR
         a/q3LViHxMx7YdWxiypdobic9Hqh14NoiAo7SX2yPCqlpp0GJWiS1gX0rOfJA6aNla
         3mfCLaVOCM1rjHBehdpLx5naPikrpg1A1zetUN7iygVReotvcWx5qbM06srQu8tuLu
         eR4yg8nWfdewg==
From:   Mark Brown <broonie@kernel.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <5b44b2fddd8973e949e4ae2132971b147cfd1ec1.1684594544.git.christophe.jaillet@wanadoo.fr>
References: <5b44b2fddd8973e949e4ae2132971b147cfd1ec1.1684594544.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: rt5659: Use the devm_clk_get_optional() helper
Message-Id: <168476770826.849172.16102240174611371988.b4-ty@kernel.org>
Date:   Mon, 22 May 2023 16:01:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2023 16:56:00 +0200, Christophe JAILLET wrote:
> Use devm_clk_get_optional() instead of hand writing it.
> This saves some LoC and improves the semantic.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5659: Use the devm_clk_get_optional() helper
      commit: f364eb563164f52dcc42ea265a66510c6f15f829

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

