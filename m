Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDEE646065
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiLGRi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiLGRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:38:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E5F5B869
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:37:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1FDA61B80
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 17:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B249C433B5;
        Wed,  7 Dec 2022 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670434672;
        bh=8QWEQn+zKzCFj1WRsl+nO7lAaKxvMO0yYD7CsBPujQE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ReRQ0peILFdvUb8wufK8d2EnzPSJhzPn9TjYRfXAlEmvz+GrhL+OS7HXX6vFXij9a
         LoJyUsn/96/R9fXkV/lAepwqPPba0NV1yuVxu65XqZHrp3AN4K3kiWiqEA5HV4ICPT
         FkCj5+/6Wfo3GCkm7fq2mAsJkH6wUm/TcihgceKxr2Pz365hJcKK5xQsjGpAo3LNMi
         nA6owA7Jek2ygIlmYp+dMVncFFwZLtGzh37gPcDW+a/XrK0PBRa9qLZyDsu8yjgm9S
         Cinon+hXXL4+wb/jtNz1Aiv/Q2cXqlZX8G2CIKcdUuymTB7ZME0xs7ob+DtTnvq9H9
         m66xmZctzNnSQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        heiko@sntech.de, sugar.zhang@rock-chips.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wang Jingjin <wangjingjin1@huawei.com>
In-Reply-To: <20221205032802.2422983-1-wangjingjin1@huawei.com>
References: <20221205032802.2422983-1-wangjingjin1@huawei.com>
Subject: Re: [PATCH] ASoC: rockchip: pdm: Add missing clk_disable_unprepare()
 in rockchip_pdm_runtime_resume()
Message-Id: <167043466982.393374.17030767228632271968.b4-ty@kernel.org>
Date:   Wed, 07 Dec 2022 17:37:49 +0000
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

On Mon, 05 Dec 2022 11:28:02 +0800, Wang Jingjin wrote:
> The clk_disable_unprepare() should be called in the error handling of
> rockchip_pdm_runtime_resume().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: pdm: Add missing clk_disable_unprepare() in rockchip_pdm_runtime_resume()
      commit: ef0a098efb36660326c133af9b5a04a96a00e3ca

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
