Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8C56B5EA1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCKRTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCKRT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:19:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667737ECC;
        Sat, 11 Mar 2023 09:19:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F20F860BB1;
        Sat, 11 Mar 2023 17:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338D3C4339E;
        Sat, 11 Mar 2023 17:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678555164;
        bh=gYQkLYUkx1K3uGDgxKkQD4VX8afsfuR+PMZMTcszPB4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jmj9901erMgO5Qg/Job+i2yn0gkTkpnOXRJLD9SDx5ECiQSGhgjv0vfxDAIgr25RU
         56a3IEUtk0BceHVEAApcY8qO/eR+EHII8ZTs8XJnb7oVqIowVyhqX43nhPQ29ZPoJa
         1VfR+6QmopMC6s6RHktfbMjtXnR2GUy8+TIv366nQ12NIHSLZ18eDS5Zxn3QTzZGs3
         Ao1xjVlh5HN+stqLX2lmyphh8kazoWmSxFJoL/ggzx6NyOqwsRTEiX8nUVn7iYxQ6g
         FxhSm+EBe5DqLf6bugPVUEk+quT+UWIhvjrHD/bHdzHBS6EZ8C/nzt6kygdQBVH+NM
         HK7IOXmN5zoqg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230310144733.1546413-1-robh@kernel.org>
References: <20230310144733.1546413-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: Use of_property_read_bool() for boolean
 properties
Message-Id: <167855516017.950365.11671456936566563006.b4-ty@kernel.org>
Date:   Sat, 11 Mar 2023 17:19:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 08:47:32 -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: Use of_property_read_bool() for boolean properties
      commit: 2d2998b84330899bf88a0414f3356869be4a69eb

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

