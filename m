Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5BA646064
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiLGRiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiLGRhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:37:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683893AC2D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:37:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B108961B59
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 17:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E7EC433C1;
        Wed,  7 Dec 2022 17:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670434667;
        bh=l/hr3BP10VYHJeYpDguxTDL8VV9ctO18e0697lGL23A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=f4VXUaOBnDz1nVz+ytjxdy2D8CLl7kX5Yv5JY7ql4RBSUAdMti8E9PaBszdkfKYZ1
         MYNoLzCpxrZcdneiYmj1GJkI8gwHzcwY48M8Johq3/l6KUpsm+ouFPNmhktLAjx2lF
         xTdjiI+/XELJ0DB6PQA3S+m28IayyyyFBVZVfSHsc+SsF3180cqLhJtkXF/pOSng6l
         HXrCrAn6PZvOQJ0LxlyaZ1c2MdMOFomHENjXyZ+R3xvH6tRQzWDEM/ueaNl/iA2UUS
         x9MdwjM5lAEr1qpVSEM9U49KiGhnJK7lk00Wb++6Gfohrt7PvZDN46gjbAcic34BID
         Q2LuIxwKdnDpQ==
From:   Mark Brown <broonie@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     shengjiu.wang@gmail.com, xiubo.lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <202212051943476482106@zte.com.cn>
References: <202212051943476482106@zte.com.cn>
Subject: Re: [PATCH] ASoC: imx-audmux: use sysfs_emit() to instead of scnprintf()
Message-Id: <167043466270.393374.10705355616730317824.b4-ty@kernel.org>
Date:   Wed, 07 Dec 2022 17:37:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-b77ec
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2022 19:43:47 +0800, ye.xingchen@zte.com.cn wrote:
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-audmux: use sysfs_emit() to instead of scnprintf()
      commit: a39bc7cf8e284653fb6fd9d897f269f4ac80cf52

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
