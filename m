Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AEB70F3D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjEXKNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjEXKNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:13:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC36BF
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1762C62CA7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 10:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17016C433EF;
        Wed, 24 May 2023 10:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684923188;
        bh=timqMsiiUF6SVTULwvrbIIEUkmxde+B0yhggAUidBVo=;
        h=From:To:Cc:Subject:Date:From;
        b=hreptOiJ0NRQKCvyDjxjGamRdRz3dACjdl6wdOaWgjnnboWkpPyK66+kTnR9DCO5K
         A2DWiNkFER3CVOPm5tOa1uedDhtBF5q/8SqbiwBGlwAgrI/eNeP9kN8ot2koJyDkBq
         hAcx+AjRwacohDxBQ9XTGM/K8cAxyyJo4dfPknPLJTxpPX+8AXrt0BZUPtOBuzZhsS
         wLwqFpHdNlJMa+g60yinNwpHIFp42yfcA/Gu9GBL11wHFTMquyXDg9psOm3dob9Pwd
         h7MSHky1G9PgAKtmQfFKeJgutno4NAtVxHVREgOnI10FOHydbpQ2oomXSMDINr63GH
         tBA4vx6x+ifdg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.4-rc3
Date:   Wed, 24 May 2023 11:12:57 +0100
Message-Id: <20230524101308.17016C433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.4-rc3

for you to fetch changes up to a511637502b1caa135046d0f8fdabd55a31af8ef:

  regulator: mt6359: add read check for PMIC MT6359 (2023-05-18 19:24:47 +0900)

----------------------------------------------------------------
regulator: Fixes for v6.4

Some fixes that came in since the merge window, nothing terribly
exciting - a couple of driver specific fixes and a fix for the error
handling when setting up the debugfs for the devices.

----------------------------------------------------------------
Alexander Stein (1):
      regulator: pca9450: Fix BUCK2 enable_mask

Osama Muhammad (1):
      regulator: Fix error checking for debugfs_create_dir

Sen Chu (1):
      regulator: mt6359: add read check for PMIC MT6359

 drivers/regulator/core.c              | 4 ++--
 drivers/regulator/mt6359-regulator.c  | 7 +++++--
 drivers/regulator/pca9450-regulator.c | 4 ++--
 3 files changed, 9 insertions(+), 6 deletions(-)
