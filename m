Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969836A7130
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCAQdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjCAQdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:33:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A690E4A1DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 08:32:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBDE96142D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 16:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62365C4339C;
        Wed,  1 Mar 2023 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677688291;
        bh=L4jlMMdY5+vXff3HkIyD62qExEfKSQ2Kua/FRvp/i0U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uT5HtI8pstrVytkQosOYEks70B7+x4u/NK9pUQvJfieKVnQYWrlT12z0xmjVzZjoC
         dzTYM1QfNLP0CamFVRviSa7obvzop7LN0fvUZmieTjI+s8d058AgLflKcbWa5wvoW2
         NQ2KRw1IUhezvcWLu0/twY3IdmX8FXcBvpsb9tgZSf2Qhi1+lEtWlppEv+o5z6YduM
         YIbm7UFxjgmBLhoDNWzs/wlKPYlT2VQHhiHUvasQ8e8G78ADbThogNljD4a0AhpOtx
         k+8Tp657eqHO8km2i8ffAXIII6v0nPo+93YBZEjMjCduRw2TI4lHqAugZEMXJMlkPm
         8y15t4+c3aUGA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com, Trevor Wu <trevor.wu@mediatek.com>
Cc:     angelogioacchino.delregno@collabora.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230301110200.26177-1-trevor.wu@mediatek.com>
References: <20230301110200.26177-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH v2 0/2] ASoC: mediatek: add missing initialization
Message-Id: <167768828912.48425.1653466601154354942.b4-ty@kernel.org>
Date:   Wed, 01 Mar 2023 16:31:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2023 19:01:58 +0800, Trevor Wu wrote:
> Fix dts parsing problem in mt8188 and mt8195 etdm dai drivers.
> 
> Changes since v1:
>   - split the patch into two commits and add Fixes tag.
> 
> Trevor Wu (2):
>   ASoC: mediatek: mt8188: add missing initialization
>   ASoC: mediatek: mt8195: add missing initialization
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt8188: add missing initialization
      commit: 23badca4248a9a467f630adbd1557f664585e1db
[2/2] ASoC: mediatek: mt8195: add missing initialization
      commit: b56ec2992a2e43bc3e60d6db86849d31640e791f

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

