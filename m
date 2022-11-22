Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBD4634458
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiKVTKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiKVTKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:10:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A4367F75
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:10:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A567761830
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 19:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B163C433C1;
        Tue, 22 Nov 2022 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669144221;
        bh=Xtr82pMQ8rwNFYGCQaCNhLznQCDj1TlivAY9WIqpdJs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Gt54PpnocgQ3T8H7CzQtMxmYYGtV2jplBAvU1xQwozMnT0H/M+bXMjQK5/PcfnnFA
         /z3+4nNPC5g26MxBW/+DJeHkHdVQMnBf2ELl9/FfN3+vncM3eb+eL+Nfx+rfRNdwbL
         GyPBsc2GgvgA8uMQ/fnfmApwbi0Vz3VxWAuBCbo1W3UUOS3VQOHE67yzZYbtMz8z37
         NuchOBa7C2RUP64KNEhhrbUU97rZKFLvSXU2NgTkVXOxM7Ro4LQElYkLw0KGJ72qDP
         y+icR/UULEYhDpq6xGyOu7XVAacDaoTMg6shqotEQKOPt3Sws7QFrFMrQ7Ft1QJ9lL
         tFDMisXD17FKA==
From:   Mark Brown <broonie@kernel.org>
To:     clabbe@baylibre.com, lgirdwood@gmail.com,
        Peng Wu <wupeng58@huawei.com>
Cc:     linux-kernel@vger.kernel.org, liwei391@huawei.com
In-Reply-To: <20221122082242.82937-1-wupeng58@huawei.com>
References: <20221122082242.82937-1-wupeng58@huawei.com>
Subject: Re: [PATCH -next] iregulator: of: fix a NULL vs IS_ERR() check in of_regulator_bulk_get_all()
Message-Id: <166914421976.306908.8890162988275879813.b4-ty@kernel.org>
Date:   Tue, 22 Nov 2022 19:10:19 +0000
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

On Tue, 22 Nov 2022 08:22:42 +0000, Peng Wu wrote:
> The regulator_get() function never returns NULL. It returns error pointers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] iregulator: of: fix a NULL vs IS_ERR() check in of_regulator_bulk_get_all()
      commit: c957387c402a1a213102e38f92b800d7909a728d

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
