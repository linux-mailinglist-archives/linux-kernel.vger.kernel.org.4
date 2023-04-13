Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52926E179D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjDMWlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjDMWk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:40:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5051746B9;
        Thu, 13 Apr 2023 15:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A188640D3;
        Thu, 13 Apr 2023 22:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD7EC4339B;
        Thu, 13 Apr 2023 22:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681425648;
        bh=P+m9x9eEgk5Ng//ljxoFy7pjRpbkHM5pR2YeVTuo/eM=;
        h=From:To:Cc:Subject:Date:From;
        b=LBM8uwd7ohnplvuWZD9DQZPC0Chd9i4lF/DhrAfh5NxmMs5S6mB584W8Yc6rB0vkg
         /7Bk6ntr1t/S59gk/XHr5jXslbSv2CvTrTHO2J8EWVxcnYRN3chlBj0o8rKPfxPVlL
         h/krdbcesQLTvMIoYKbBRk9ZxWnZP+ouUCu05EaigEPR2tuXLVkyWFDSq+++0skaCj
         HMEAu3Q9f3xO/YNmqmSDbWaM5xPzu9B7xfkxxwmM4HXpUcV1I7JdCAeaOataZF3NVf
         L3T1xzIoVaNScUuTxVP/af0/DbPPo7LLoy6i2J4xvjBeF3ZieFaN48AWNXBQHuuFI4
         YF2l8DyMabvyQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.3-rc6
Date:   Thu, 13 Apr 2023 15:40:47 -0700
Message-ID: <20230413224047.4086269-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5cf9d015be160e2d90d29ae74ef1364390e8fce8:

  clk: Avoid invalid function names in CLK_OF_DECLARE() (2023-03-09 15:40:49 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 632e04739c8f45c2d9ca4d4c5bd18d80c2ac9296:

  clk: rs9: Fix suspend/resume (2023-03-21 10:47:06 -0700)

----------------------------------------------------------------
A few more clk driver fixes

 - Set the max_register member of the spreadtrum regmap so that reads
   don't go off the end of the I/O space

 - Avoid a clk parent error in the i.MX imx6ul driver when the selector
   is unknown

 - Fix an oops due to REGCACHE_NONE usage by the Renesas 9-series driver

----------------------------------------------------------------
Alexander Stein (1):
      clk: rs9: Fix suspend/resume

Chunyan Zhang (1):
      clk: sprd: set max_register according to mapping range

Oleksij Rempel (1):
      clk: imx6ul: fix "failed to get parent" error

 drivers/clk/clk-renesas-pcie.c |  3 ++-
 drivers/clk/imx/clk-imx6ul.c   | 10 ++++++----
 drivers/clk/sprd/common.c      |  9 ++++++---
 3 files changed, 14 insertions(+), 8 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
