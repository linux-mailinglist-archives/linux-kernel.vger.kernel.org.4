Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F46574FA91
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjGKWEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjGKWEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:04:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DA7171C;
        Tue, 11 Jul 2023 15:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97EB3615FF;
        Tue, 11 Jul 2023 22:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70006C433C8;
        Tue, 11 Jul 2023 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689113043;
        bh=oBxNVJg4vSx6LNjM26ubu2NlwygUbvR3D4ABT5dk5Iw=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=KhdRHRpYv5ncqt72lmW3ddspokU1/xDMSuttpRxmaWqiVEUqS4nGB59QP/HkZyYCV
         3ZlRvkqxNyytgnNoRiWpTYR/rbyx+tMWoCYRAIYJlyZTDiPHcy5xu/nE80+rt+JmX5
         ctS9GW2hN8MbTv7i5Q1QtDe8C4G3T3vT6QnBEd/348pso578iM+zsG4u3URGEHx8Cy
         1wzZ9sMpdXhu0tDBduFZxw6y3aflqDA+QM0UURdZPBPwX5SSu5UIyfotdlvbZLzeyx
         lcxqyiG0gMCQCaAz7y0bAIGF4oj5wrr0rP1wlniGuHo6ye5ZD5HHxUY9qWFm/9U5TG
         9XdTvaCyeObuA==
From:   Mark Brown <broonie@kernel.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Moring <stefan.moring@technolution.nl>
In-Reply-To: <20230628125406.237949-1-stefan.moring@technolution.nl>
References: <20230628125406.237949-1-stefan.moring@technolution.nl>
Subject: Re: [PATCH] spi: Increase imx51 ecspi burst length based on
 transfer length
Message-Id: <168911304110.642798.9300862955272613470.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 23:04:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 14:54:06 +0200, Stefan Moring wrote:
> IMX51 supports 4096 bit burst lengths. Using the spi transfer length
> instead of bits_per_word increases performance significantly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Increase imx51 ecspi burst length based on transfer length
      commit: 15a6af94a2779d5dfb42ee4bfac858ea8e964a3f

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

