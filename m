Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B9264CD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbiLNPsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbiLNPrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:47:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C190422B09
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:47:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6100161B20
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63338C433F1;
        Wed, 14 Dec 2022 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671032843;
        bh=Y8qD8rMmJhmPqz25ZwVyMqlVTaSyGcKy80GqxbqJej8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=g/i7IcSmoXZ9RNvsAZ7TIMNyWEbeHNDlkdnsZfo4Ro3/dFq9BkvJ/600GhHyBc3Dc
         GOM2nSHHYCBJ+NDAWoQWyxV6r6+8HXFWxTSG88LAtM1Bq1gLAi1Nc3alGzaE67Fo27
         toCrJXxDNBqeId7BTuhbDATyh2pIihI9ZdvWdA9TCtpfKGdRcbJr1lzhfoGnpOJ4mt
         ogPmzFrLp0UNMdnWEZChc+4e7ZGEmJO0DbgGdMfOobvJYvzL9KhgF9lwnxkEt/70le
         T03niXnZdVwoBXYLwj0GCAprN5kDROCEXtNF3MNFbSieGLHpEdxqPObjJ+sEUUwsEZ
         jXqUQVgllx4qw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, cy_huang <u0084500@gmail.com>
Cc:     m.szyprowski@samsung.com, cy_huang@richtek.com,
        chiaen_wu@richtek.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <1670981831-12583-1-git-send-email-u0084500@gmail.com>
References: <1670981831-12583-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH] regulator: core: Fix resolve supply lookup issue
Message-Id: <167103284213.341365.14545132888451712010.b4-ty@kernel.org>
Date:   Wed, 14 Dec 2022 15:47:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-7e003
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 09:37:11 +0800, cy_huang wrote:
> From Marek's log, the previous change modify the parent of rdev.
> https://lore.kernel.org/all/58b92e75-f373-dae7-7031-8abd465bb874@samsung.com/
> 
> In 'regulator_resolve_supply', it uses the parent DT node of rdev as the
> DT-lookup starting node. But the parent DT node may not exist. This will
> cause the NULL supply issue.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Fix resolve supply lookup issue
      commit: 0debed5b117d11e33cba52870c4dcb64f5911891

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
