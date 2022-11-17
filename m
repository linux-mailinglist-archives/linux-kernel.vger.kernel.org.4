Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAEE62D9C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbiKQLsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239849AbiKQLsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:48:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FB82DDF;
        Thu, 17 Nov 2022 03:48:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EE17B81FFF;
        Thu, 17 Nov 2022 11:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FB3C433C1;
        Thu, 17 Nov 2022 11:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668685712;
        bh=g8/3G3XdboS8Kov6oVnhtxCrpiItGsbE4yX4Gt6DTwg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bHau+qISLSBSgiJlt1hDf9QIAQTF3TTJr3VbNYpCAu22kCrY4WUFj0RSsX1YKbGAo
         BNr8eyaRbRIextwu/UeraOWb29Hwe3dhrIDtnQARR1kFzQIay4wplPoVZtQA82HjJf
         A4VBFmX7NuIBATrDydmXRbPHMejAbwlnLoEl35EnhS0ZYHHMsvFNLeeriWmiDzg945
         7VkPIFlTiTuJGLE5JLU79MN1XFQF6rrsH+mVr3yL1rVYkf+RW8HqCEsc2JP85GKXCh
         Y9xuqLC1FsJJZ3DMQN5O/Mc3yGYjte7Qxxo7LHIfXbApLM8H9AkmWF0kDgEl+AHBuw
         QYp9U4a+FH0Tg==
From:   Mark Brown <broonie@kernel.org>
To:     jonathanh@nvidia.com, Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        skomatineni@nvidia.com
In-Reply-To: <20221117070320.18720-1-kyarlagadda@nvidia.com>
References: <20221117070320.18720-1-kyarlagadda@nvidia.com>
Subject: Re: [PATCH] spi: tegra210-quad: Fix duplicate resource error
Message-Id: <166868571080.694164.9085397886273331587.b4-ty@kernel.org>
Date:   Thu, 17 Nov 2022 11:48:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 12:33:20 +0530, Krishna Yarlagadda wrote:
> controller data alloc is done with client device data causing duplicate
> resource error. Allocate memory using controller device when using devm
> 
> Fixes: f89d2cc3967a ("spi: tegra210-quad: use devm call for cdata memory")
> 
> 

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: tegra210-quad: Fix duplicate resource error
      commit: 2197aa6b0aa236b9896a09b9d08d6924d18b84f6

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
