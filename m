Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6796248C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiKJRz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJRzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:55:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962554AF2D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:55:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3371DB82237
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3D6C433D6;
        Thu, 10 Nov 2022 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668102949;
        bh=Kdwf3HBzQKzgKvV7niLjKG3Y6fwZwErSkKiE9iGJJMg=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=BXK0eLGoEiEvF2mpAttVE6XZHMV5Q6YEb2RE6L2eFLQfc78PK4gbCDlbuHYj/7LMz
         evLU7Yisb/kOYTbl5KwJ8+PQ9SZIeJJ4TUZj8Bo2B7YCSI1bkhDgtn0K1/+eFTnetw
         CHrq1AIATw77Ve/SOc/uzKzM8AqRft8A7StTIC+d8a6UO8nvLVzMXugBWdOdoNLeQX
         2U9L/EzUDjddMzbTBE/bhZmrTBlTNUd0yTkz8cT2irwRwp1R44Imj8KlXt57nuvaV8
         AGMf6xXHQl6ZZaBni3luxJ6d/V70ERayTUlwpH119RBuax6ppGCzROI1vlHyf3dAo8
         cG1bOG/Sb1lkg==
From:   Mark Brown <broonie@kernel.org>
To:     u.kleine-koenig@pengutronix.de, alsa-devel@alsa-project.org,
        perex@perex.cz, cmo@melexis.com, Chancel Liu <chancel.liu@nxp.com>,
        ckeepax@opensource.cirrus.com, shengjiu.wang@nxp.com,
        chi.minghao@zte.com.cn, ojeda@kernel.org, lgirdwood@gmail.com,
        luca.ceresoli@bootlin.com, patches@opensource.cirrus.com,
        tiwai@suse.com, xiaolei.wang@windriver.com, steve@sk2.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221109121354.123958-1-chancel.liu@nxp.com>
References: <20221109121354.123958-1-chancel.liu@nxp.com>
Subject: Re: [PATCH v2] ASoC: wm8962: Wait for updated value of WM8962_CLOCKING1 register
Message-Id: <166810294654.959181.11432270569807765176.b4-ty@kernel.org>
Date:   Thu, 10 Nov 2022 17:55:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022 20:13:54 +0800, Chancel Liu wrote:
> DSPCLK_DIV field in WM8962_CLOCKING1 register is used to generate
> correct frequency of LRCLK and BCLK. Sometimes the read-only value
> can't be updated timely after enabling SYSCLK. This results in wrong
> calculation values. Delay is introduced here to wait for newest value
> from register. The time of the delay should be at least 500~1000us
> according to test.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8962: Wait for updated value of WM8962_CLOCKING1 register
      commit: 3ca507bf99611c82dafced73e921c1b10ee12869

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
