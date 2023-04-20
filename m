Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FA96E95D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjDTN0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDTN0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:26:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABF244AE;
        Thu, 20 Apr 2023 06:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BF9E64966;
        Thu, 20 Apr 2023 13:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A31FC433D2;
        Thu, 20 Apr 2023 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681997209;
        bh=J2vGlh/VykjbR4ar6yZ60zUmjSqs5dIfxT2XqOgmb0s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XJsjnsjLmrzX9PZPSw4dXgT6h9MXEvf1rkEHzf+WBpGKa++ZrCrwduhTkaiI9g47c
         BEUjlsszMZ521coYouUMxTE3L75W+coMcf0i9/FdmP0diA+Hje7UjwjX/9PTeuTxZ6
         ikhZGdZ4Cw2UItyzyN4e8gE6pnUMtjLpaPJCaXi6Kw86fuoxVScOwVRxGiMHil21b9
         g1qgANtP6zV+GRotTiKQuakwecDt13UBSbDl8m4LHXvT4KMAhFhf1yo6j+KfwunD39
         ZeIdgdCkhjJ1EYn49OPFS+0VLq1wMXVPhx56ZNiLqV9fpKQVZH0nR+R5uuVbRlnl5q
         +vEC7EUFNi2lw==
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Vaishnav Achath <vaishnav.a@ti.com>, Vignesh <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20230420054257.925092-1-d-gole@ti.com>
References: <20230420054257.925092-1-d-gole@ti.com>
Subject: Re: [PATCH V3] spi: cadence-quadspi: use macro
 DEFINE_SIMPLE_DEV_PM_OPS
Message-Id: <168199720703.80523.4875780053049670259.b4-ty@kernel.org>
Date:   Thu, 20 Apr 2023 14:26:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00e42
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 11:12:57 +0530, Dhruva Gole wrote:
> Using this macro makes the code more readable.
> It also inits the members of dev_pm_ops in the following manner
> without us explicitly needing to:
> 
> .suspend = cqspi_suspend, \
> .resume = cqspi_resume, \
> .freeze = cqspi_suspend, \
> .thaw = cqspi_resume, \
> .poweroff = cqspi_suspend, \
> .restore = cqspi_resume
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: use macro DEFINE_SIMPLE_DEV_PM_OPS
      commit: be3206e8906e7a93df673ab2e96d69304a008edc

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

