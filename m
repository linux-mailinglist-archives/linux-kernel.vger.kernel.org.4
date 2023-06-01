Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6987871EE7A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjFAQPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFAQPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:15:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082F1E4;
        Thu,  1 Jun 2023 09:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9172164726;
        Thu,  1 Jun 2023 16:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69FCC433EF;
        Thu,  1 Jun 2023 16:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685636148;
        bh=eWGdEZKINAA3oZQdXTLJRYSprRFlsOM1achzah3z79g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Di1miZNqxPJvp8zuVYMlCvH6afVnUa46LqmK+h4/XltpNeifZPViIczfgCCbxBY2l
         MOyLD32cJpFKO5DTyCsftOcwuL0ZBf7osuDmj3CqDGF4ZOk//QOf6S4/nsXNU8jxD4
         iMTjuNXF1ZuDyKxaJuDKekRVE7IlE7te5dXeAilKJh2ZCDAOR57aqEfU+RVem8v5w/
         30/mfqJ50n81HMnKz3TGlfqbSt24m2i5ulhkp7b1moLvz/X2amo5kKgb5zaPnFWTYl
         gWuNjIK/NMMwf6BE2LpH1DOpeAso69EaUx1dVFl7uyGAaHNCdr8iVZFdm0E8UIq089
         5jKI/ESXOkxbA==
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Osama Muhammad <osmtendev@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230530221725.26319-1-Sergey.Semin@baikalelectronics.ru>
References: <20230530221725.26319-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH] spi: dw: Drop empty line from DebugFS init function
Message-Id: <168563614666.139315.15131843196445419713.b4-ty@kernel.org>
Date:   Thu, 01 Jun 2023 17:15:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 01:17:25 +0300, Serge Semin wrote:
> Just drop a redundant empty line from the dw_spi_debugfs_init() function
> left in the framework of the commit 0178f1e5d984 ("spi-dw-core.c: Fix
> error checking for debugfs_create_dir") after removing the last return
> statement.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw: Drop empty line from DebugFS init function
      commit: 3ecd5a728903b3057012043f98464c20cea1cdbb

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

