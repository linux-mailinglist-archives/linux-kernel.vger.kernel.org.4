Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1586E82A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjDSUZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjDSUY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:24:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F2B7A87
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C486F62344
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 20:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2BCC433D2;
        Wed, 19 Apr 2023 20:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681935881;
        bh=gk3VTIenmeX8r8Y0damkCedE0wM1wlE1FiP/sF6YWG8=;
        h=From:To:Cc:Subject:Date:From;
        b=eoN97+qCaUonB6I+yDbCbp718MV9g+llA7n8VrSfQ36pqno13Mikv7Q6QqdoC0L9w
         hoDdQED7SDiQNmnKPOwnL47MfFBoapjyKKx/3RiVMZp4cLPN+4hnPEVsHsRwfuBRd0
         MBgiwN5zL2sfUrmpIekM9NvU6yjaSYKfV+MfwzC7eT62B57GiuCq1uzeq+e5l3tBl1
         48R2hk50pmtEzlqM0dUWPQSvJvlgjGTn553MxnESNWs45ycIIkRI1vDDHPFEiigxlf
         lKug3o8XGijm4X5WKMyIhZIcccyo3y/NT6KkEljgrwnvKhXbItNrodCAzZdxfX0h8v
         bM6vrO1kfa0ig==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.3-rc7
Date:   Wed, 19 Apr 2023 21:24:31 +0100
Message-Id: <20230419202440.9B2BCC433D2@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e364e56293bb98cae1b55fd835f5991c4e96e7d:

  Linux 6.3-rc5 (2023-04-02 14:29:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.3-rc7

for you to fetch changes up to 7c7504067c709905fc188c61ac3072d6022d1209:

  regulator: sm5703: Fix missing n_voltages for fixed regulators (2023-04-11 12:41:59 +0100)

----------------------------------------------------------------
regulator: Fixes for v6.3

A few driver specific fixes, one build coverage issue and a couple of
"someone typed in the wrong number" style errors in describing devices
to the subsystem.

----------------------------------------------------------------
Axel Lin (1):
      regulator: sm5703: Fix missing n_voltages for fixed regulators

Cristian Ciocaltea (2):
      regulator: fan53555: Explicitly include bits header
      regulator: fan53555: Fix wrong TCS_SLEW_MASK

 drivers/regulator/fan53555.c         | 13 +++++++------
 drivers/regulator/sm5703-regulator.c |  2 ++
 2 files changed, 9 insertions(+), 6 deletions(-)
