Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE546F193F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346198AbjD1NVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjD1NVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:21:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D3C1BE4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E557C60C8A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698CDC433EF;
        Fri, 28 Apr 2023 13:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682688108;
        bh=MS4aiFfs9Tqd9a/7b5YgXZKEv6MWlgI2J5Sc5Fb+Ab4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uuop/ppq6XH1aAG0HhzlGWhfyGiRYbQ885gAnxScJRsDSySvhmjZZskdKI9vLyvzp
         iYfow1gIfj6DHBPZ1SdVnPXdFKkMVcn/J716j3Af8mI7gFE+kHURMhE6RGzmHWAO6Q
         n/egeVVhy/8H9UYuXEsLv4vOPZ2mz8qdCXxqlrWjY8l3udGjKCOhxlPMxCBVuRmUFl
         iaBc5ljGTWwPZs05Knld/9LckcMCXwtGlLLbNRY+R9wyboDHQMzj12Y/8cKy2GRzTD
         8L5EDaVMWhHrz/oWS6iEjzE2QKsYmZLf+PYtSv/+s8PceuviEAoSj5ptotCfMfuquT
         Hw0rYAgFPnuJg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Philippe De Muyter <Philippe.DeMuyter@macq.eu>
Cc:     Philippe De Muyter <phdm@macqel.be>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <1682537582-2314-1-git-send-email-Philippe.DeMuyter@macq.eu>
References: <1682537582-2314-1-git-send-email-Philippe.DeMuyter@macq.eu>
Subject: Re: [PATCH] Documentation: regulator/consumer.rst: fix
 'regulator_enable' typo.
Message-Id: <168268810712.376458.9891910006553882956.b4-ty@kernel.org>
Date:   Fri, 28 Apr 2023 14:21:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00e42
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2023 21:33:02 +0200, Philippe De Muyter wrote:
> Removing an erroneous 'd' at the end of 'regulator_enable'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] Documentation: regulator/consumer.rst: fix 'regulator_enable' typo.
      commit: 3302212f0384ab286b65683bc340f3953f88f70a

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

