Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268E15F33E3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJCQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJCQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:48:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058D32F676;
        Mon,  3 Oct 2022 09:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A639AB81110;
        Mon,  3 Oct 2022 16:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15E6C433C1;
        Mon,  3 Oct 2022 16:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664815677;
        bh=XtvExxchVlDh7PWub1JJO1kNRtZLJokZK3uiD3JNED4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tSKgq8loUa/tq2URDLFMK5kJvAZC1hPzxDczgHQRbt3pZj8Wj2UiXdS/6ZOT9dJwR
         4KpyRKo4orj/kuqFC2eCF6U0YrPi06fOniTnsQyGTP35uaJttKGfUo2xhNSJZ/XLnj
         077w/Yiv+MVIFG3uWebzAtBBrD2biG3C/8EQ9F8mHoskwpJvQBUmd298XPFaz+EFOX
         3LdMUX8s+yhXCURLB6iGVE73mQKAPdh4CKIuNf4AdsWGVSs8HtIPMVBU6H7fi9bF9r
         2nUQfngs/CZuA15y/aPwr8xt2xKUxu7KP507LabwAtWmUg9oHWgYaZV5vAJMwJH2W/
         zOskDyOKcJCjQ==
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        linux-tegra@vger.kernel.org, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, thierry.reding@gmail.com
Cc:     skomatineni@nvidia.com, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com
In-Reply-To: <20221001122148.9158-1-kyarlagadda@nvidia.com>
References: <20221001122148.9158-1-kyarlagadda@nvidia.com>
Subject: Re: (subset) [PATCH 1/5] spi: tegra210-quad: Fix combined sequence
Message-Id: <166481567551.272308.1247948376003313434.b4-ty@kernel.org>
Date:   Mon, 03 Oct 2022 17:47:55 +0100
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

On Sat, 1 Oct 2022 17:51:44 +0530, Krishna Yarlagadda wrote:
> Return value should be updated to zero in combined sequence routine
> if transfer is completed successfully. Currently it holds timeout value
> resulting in errors.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: tegra210-quad: Fix combined sequence
      commit: 8777dd9dff4020bba66654ec92e4b0ab6367ad30

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
