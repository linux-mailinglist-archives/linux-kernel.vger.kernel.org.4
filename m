Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C106343F6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiKVStH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiKVStC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:49:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896E285168;
        Tue, 22 Nov 2022 10:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=YfM1vBW5FbfOtVOuQtqHeHKritwtsNX3a6kj2I381xc=; b=YJ9I4P5C7cPeqjjr7uzZ7li19Y
        5krtlru1ATVA+szEwubOaFnkjgnILi142q8we895NYzctoLwUeOLQgQzHe+2uQVuT+/zTZqq9MoYf
        AKGaNr/o3zAbPmkuQf+qU2iXc85a2X8GYOrGhpXRd6I8p2IKzrqIgOmtzrxkJEcaCDInSBZrfy2/w
        SmxI2H3ETt/l/TVZP9+hXiEpx6juoeW7xRy6N+asc/EGoqMRo6pzXB1kHVgI2C80Qyeo+329yIRNQ
        8f2IY8ohe/nnAsuSfQ3NST8AbG8m9nSy572Bh1pkczxqQN8OwcwpIMcYW9Mx5GZV2YOiQQkRVvXrM
        EF5bDPGA==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxYKG-006egc-ME; Tue, 22 Nov 2022 18:48:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH] clk: sunxi-ng: fix ccu_mmc_timing.c kernel-doc issues
Date:   Tue, 22 Nov 2022 10:48:44 -0800
Message-Id: <20221122184844.6794-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use '-' to separate the function name and its description.
Use '%' on constants in kernel-doc notation.
Use the kernel-doc Return: format for function return values.

Fixes this warning:
ccu_mmc_timing.c:21: warning: No description found for return value of 'sunxi_ccu_set_mmc_timing_mode'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yang Li <yang.lee@linux.alibaba.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
---
 drivers/clk/sunxi-ng/ccu_mmc_timing.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -- a/drivers/clk/sunxi-ng/ccu_mmc_timing.c b/drivers/clk/sunxi-ng/ccu_mmc_timing.c
--- a/drivers/clk/sunxi-ng/ccu_mmc_timing.c
+++ b/drivers/clk/sunxi-ng/ccu_mmc_timing.c
@@ -10,11 +10,11 @@
 #include "ccu_common.h"
 
 /**
- * sunxi_ccu_set_mmc_timing_mode: Configure the MMC clock timing mode
+ * sunxi_ccu_set_mmc_timing_mode - Configure the MMC clock timing mode
  * @clk: clock to be configured
  * @new_mode: true for new timing mode introduced in A83T and later
  *
- * Returns 0 on success, -ENOTSUPP if the clock does not support
+ * Return: %0 on success, %-ENOTSUPP if the clock does not support
  * switching modes.
  */
 int sunxi_ccu_set_mmc_timing_mode(struct clk *clk, bool new_mode)
@@ -46,8 +46,8 @@ EXPORT_SYMBOL_GPL(sunxi_ccu_set_mmc_timi
  * sunxi_ccu_set_mmc_timing_mode: Get the current MMC clock timing mode
  * @clk: clock to query
  *
- * Returns 0 if the clock is in old timing mode, > 0 if it is in
- * new timing mode, and -ENOTSUPP if the clock does not support
+ * Return: %0 if the clock is in old timing mode, > %0 if it is in
+ * new timing mode, and %-ENOTSUPP if the clock does not support
  * this function.
  */
 int sunxi_ccu_get_mmc_timing_mode(struct clk *clk)
