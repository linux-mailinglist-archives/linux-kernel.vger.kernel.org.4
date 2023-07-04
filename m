Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7D474757F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjGDPm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDPm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:42:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB40E76
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0108B6124D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 15:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FF0C433C7;
        Tue,  4 Jul 2023 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688485344;
        bh=o5dj9Kjl7vvHnsLs0SMupSPpdUwYaSVo+kjmjoFynV8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BXszOKT5g+8zRjVQtbbRL3Ow+hZmbrid6te/zfzTD0LztSrfXeB5a32JauYvyRqgC
         T6g1qOufqcepiNM5sQHvDCxYh3XicHKDhfesMCufrGfACg117KGs/ZAKsKMpm1hV4n
         +NGijJM7PIDJdulsMbVnyb5hT5MPKzCN2fx6CVv46I8CrPD3Yk8leEoZrnKREV+xaM
         4r+cm2lK6kX+h3nR2TmlZ//Z8Qt3abPRbuQpg9N734q9DryWDpsI/juntBJJJZZyAp
         EH1yMLqUtWN7HAnFrSntAu2yH6NsERG43Zxrn2040fWj9S1EaTFbiejkr0J+kBWEgE
         u118CTZV+uoqg==
From:   Mark Brown <broonie@kernel.org>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230630202257.8449-1-jonas.gorski@gmail.com>
References: <20230630202257.8449-1-jonas.gorski@gmail.com>
Subject: Re: (subset) [PATCH 1/3] MAINTAINERS: add myself for spi-bcm63xx
Message-Id: <168848534358.86644.6954201495019514994.b4-ty@kernel.org>
Date:   Tue, 04 Jul 2023 16:42:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 22:22:54 +0200, Jonas Gorski wrote:
> I noticed the driver is unclaimed. Since I was the last one doing
> substantial work on it, add me as the maintainer.
> 
> As it is only found in legacy products, mark it as "Odd Fixes"
> instead of "Maintained".
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/3] spi: bcm{63xx,bca}-hsspi: update my email address
      commit: 879a879c216a41f5403d8d3dbc204a48501912bf

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

