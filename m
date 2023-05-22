Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF1D70C1CC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbjEVPCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbjEVPCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2082910EA;
        Mon, 22 May 2023 08:01:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E42623CC;
        Mon, 22 May 2023 15:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553E5C4339B;
        Mon, 22 May 2023 15:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684767705;
        bh=+EGBPqr4BsG1hnIwIe63izJEjMIoZqI3WyiFSk2ZJbs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mfYbBo/yvc640WeK3Et4s1R6hhXPy0f0UeX2NdqDjSlfAE0HEyeg7lJ/12+x3Ipik
         MsfzrQUgOTZ6zNauHztm4kN9Q0sdVK9QG8J91ZLLYYWq2oEWkhiXVZzphztEPPwPVO
         rnenOFRDIoXavCfOAWMktBasaKp6I8m937pKWMvkV53EF2YXyl0BoEFla4TaY932nP
         Ta6W5eOpVmi+nlA3CDROtfuCBLJttmv8IQ6mh8o3s6Wj91sbsBcqzW5ZBk7nectXDR
         aObmuISYEh1mYwtR7OHePX6VlLrdiC235X6p8cyfbQxHpPnU4ZyV7/l79m+pQyuyYW
         1ft1dno418n0A==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com
In-Reply-To: <3debf3bb7ea504ee9ca2d8eb0f948a426681cbdd.1684594240.git.christophe.jaillet@wanadoo.fr>
References: <3debf3bb7ea504ee9ca2d8eb0f948a426681cbdd.1684594240.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: cs42l51: Use the devm_clk_get_optional() helper
Message-Id: <168476770307.849172.5630485332717931835.b4-ty@kernel.org>
Date:   Mon, 22 May 2023 16:01:43 +0100
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

On Sat, 20 May 2023 16:50:54 +0200, Christophe JAILLET wrote:
> Use devm_clk_get_optional() instead of hand writing it.
> This saves some LoC and improves the semantic.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l51: Use the devm_clk_get_optional() helper
      commit: c0998e0142af8037e4a0ee84dd01cd20cbe0c76e

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

