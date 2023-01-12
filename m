Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4BD667125
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbjALLmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbjALLlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:41:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CFA34770
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:33:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0103D6200A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C9FC433D2;
        Thu, 12 Jan 2023 11:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673523192;
        bh=cVtKxF1chMjz0+jO9u4PrZPLGYxSGqaqVd36Q36u5bM=;
        h=From:To:Cc:Subject:Date:From;
        b=UsYRUT9Q+HTy1HE2qr4PlwEYJZguVdErMphptF8K4ToHHpp09ysWCAafzs0Wm4Fd4
         LpsKGuJ2kXVVH0+knVVC2iFAujVZvHLvyWThE658nEGiO0/8gcTXeCo++hGy4piRDL
         VOrRY3orzP84UuKXFk64xx00VviMLCfvjHJY5zn+ooHdFLyiX8DzZdNuuBFhNjtT8x
         l4hxTyN6C9lZblusdgY3r7fc4idC8E/AQ5WCS8j9qCx0ddxpee48nWQWHLME67jEbx
         6BjZ3ad6NAwm9FKqlVllzmsm1NKIK7LwHh+VvwDXZfwzyjVqdl5SUWBl4svcAEdg1M
         K+TgbmMmq1j3A==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.2-rc3
Date:   Thu, 12 Jan 2023 11:33:00 +0000
Message-Id: <20230112113311.98C9FC433D2@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.2-rc3

for you to fetch changes up to f528fe213a6ad21a6e8644dbd5de10dc264a89fd:

  regulator: qcom-rpmh: PM8550 ldo11 regulator is an nldo (2023-01-03 15:54:38 +0000)

----------------------------------------------------------------
regulator: Fixes for 6.2

A couple of small driver specific fixes, one of which I queued for 6.1
but didn't actually send out so has had *plenty* of testing in -next.

----------------------------------------------------------------
Mark Brown (1):
      regulator: Merge up forgotten fix

Neil Armstrong (1):
      regulator: qcom-rpmh: PM8550 ldo11 regulator is an nldo

Ricardo Ribalda (1):
      regulator: da9211: Use irq handler when ready

 drivers/regulator/da9211-regulator.c    | 11 ++++++-----
 drivers/regulator/qcom-rpmh-regulator.c |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)
