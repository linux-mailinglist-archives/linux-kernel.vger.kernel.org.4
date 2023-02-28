Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922B86A5F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjB1TPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjB1TO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:14:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2004C32CE2;
        Tue, 28 Feb 2023 11:14:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C88A3B80E9E;
        Tue, 28 Feb 2023 19:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1C2C433EF;
        Tue, 28 Feb 2023 19:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677611696;
        bh=hMcyWzfB+CJs+vB4XGHHem6rKXPwI1qIRw58A3m8+RU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mAJZpMNDvM0uchr6VUI6XzJjCNjMWJrTC6gw5LqnA1bT2HUEPO3xkQXpS1ooYqjJh
         JJj9H0ClEl3Ej8Imuz3SFiNBrIykn5YB/2g9kCpwfV3gABP+gxEp5xLdiEqo+WvNip
         WiQUnoFuxbBS5owr7c9iRJngnByyA8BbVoT2pa0pcZeram4RagzcccXCyX178YPUOn
         EqxSUWumZrwxhKYr0izyp9Hg3ZQZnOH0YI8nTGgA5Q+dmXtZXgC3lLtjVLEPsrN3ak
         72qvRDmMX7Ji+XSsC+i2b7unR/ssdk+jgLq4amEv6wgZHj3ypSB6uQOSRrrcPc8UTn
         ECppZKzFobtMQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
In-Reply-To: <20230224163513.27290-1-kyarlagadda@nvidia.com>
References: <20230224163513.27290-1-kyarlagadda@nvidia.com>
Subject: Re: [PATCH] spi: tegra210-quad: Fix iterator outside loop
Message-Id: <167761169476.74633.14822513277416475053.b4-ty@kernel.org>
Date:   Tue, 28 Feb 2023 19:14:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 22:05:13 +0530, Krishna Yarlagadda wrote:
> Fix warn: iterator used outside loop: 'xfer'
> xfer variable may contain invalid value in few conditions.
> Move transfer complete check within list loop.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Link:https://lore.kernel.org/all/202210191211.46FkzKmv-lkp@intel.com/
> Fixes: 8777dd9dff40 ("spi: tegra210-quad: Fix combined sequence")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra210-quad: Fix iterator outside loop
      commit: 2449d436681d40bc63ec2c766fd51b632270d8a7

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

