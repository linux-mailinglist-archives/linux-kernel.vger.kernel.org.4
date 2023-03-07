Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7A96AE7F3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjCGRJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCGRIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:08:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2AA8E3F6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:03:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA048B819A8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0C5C433A0;
        Tue,  7 Mar 2023 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678208550;
        bh=GScLqEqCnu+bviGeey8U9Zftmk90IDhLi6xfpSybFuk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=n99lNXa+omA0svigLClGIMqwmCCxws2eF1XR5o1FJep7Cc8mjG6jGBu9yyAJN6rA5
         BF6Nkr+rcCVhR4gqnt4jusDQVgQmcS4uVmiOQanGEMWy90chy/IBEivxO1lmFafuyH
         SWJYVtFcM+Ffx2Qx88Zy01tYWL3V/KuKTeVxv0/2YhXsmv7zi68yKRej/2HBw5ZBRO
         iqWRV0uPr1g49mSxLebzX6xs0dOANSAeK6UvVYahlSRQZSUQc3ifKB+5CSSp4PPE0H
         z8vfmf6avKEI66C8mxGQPGTIgGsW1w7PgZik20S20/dp0XjKCaEBIvh+RdGDgpBSfa
         DaXazRXrW2vCA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <05f26d8e1e527f8b3fd2828f75ce2174e19c69e7.1678188171.git.geert+renesas@glider.be>
References: <05f26d8e1e527f8b3fd2828f75ce2174e19c69e7.1678188171.git.geert+renesas@glider.be>
Subject: Re: [PATCH] regulator: rt5739: Spelling s/Rcihtek/Richtek/
Message-Id: <167820854946.106988.164125988090318551.b4-ty@kernel.org>
Date:   Tue, 07 Mar 2023 17:02:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023 12:23:42 +0100, Geert Uytterhoeven wrote:
> Fix a misspelling of "Richtek".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt5739: Spelling s/Rcihtek/Richtek/
      commit: 4eb6678ab53cac74e71fc5d4e6ff4035e5c847b6

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

