Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD7A716B54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjE3RlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjE3Rky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:40:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2888F3;
        Tue, 30 May 2023 10:40:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3397A6315B;
        Tue, 30 May 2023 17:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFF1C4339E;
        Tue, 30 May 2023 17:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685468452;
        bh=bYphihI0RQXCDYKKX4nwsfEmTMSVyo6V1uKqYjWYKno=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mXoHfX70CKBP2s5bjHxg+jCwXsCE5Z2xcnHGUoostG7p+Xb1byVBE7UyRqS2Jnx6n
         ry1l3F5sAqtrVE2T8vwEMvpNMDoGRGuf5++bDF+uhoD3XbZa8bVKiYaT5RCZskblFN
         6fGzhOq7WMnlKtDDKyg6DYmvHujv8wftQWPAo6k+6B+ryzuUI+XZlf2S31duuBj6AY
         4X/Eg2+iHdr5gZFMa8fQmX0ytUsWH1IKQqExHcu4vjIlc1uSq9Nvtz6/83ACUR04jc
         4eci0cG0TRkreyAUtNOCwEtZMM63A+mLHABi9iH76ZifqqYSVo2uooZM0kh07EszRm
         ZvEzO3sh3JoOg==
From:   Mark Brown <broonie@kernel.org>
To:     fancer.lancer@gmail.com, Osama Muhammad <osmtendev@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230520224025.14928-1-osmtendev@gmail.com>
References: <20230520224025.14928-1-osmtendev@gmail.com>
Subject: Re: [PATCH v1] spi-dw-core.c: Fix error checking for
 debugfs_create_dir
Message-Id: <168546845148.691057.9965315836245052581.b4-ty@kernel.org>
Date:   Tue, 30 May 2023 18:40:51 +0100
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

On Sun, 21 May 2023 03:40:25 +0500, Osama Muhammad wrote:
> This patch fixes the error checking in spi-dw-core.c in
> debugfs_create_dir. The DebugFS kernel API is developed in
> a way that the caller can safely ignore the errors that
> occur during the creation of DebugFS nodes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi-dw-core.c: Fix error checking for debugfs_create_dir
      commit: 0178f1e5d9845a31024eddd37e93a182e2dbab5d

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

