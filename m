Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A229610079
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbiJ0Slc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiJ0Sl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:41:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9534A18A;
        Thu, 27 Oct 2022 11:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666896088; x=1698432088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UZuk/q5fM41E9vtQd97mAMiexoqsdKI6J1hD4x0iZdM=;
  b=e1wIgULMD5daRi8B5e4fLxIxNd+PfT0zH1oKTW2eBk5Xc6XclqsoJ1jK
   j8lBJzpc7Y5GNp77R1qNK3QU567KCkXLdapWkpiRbfAKUFrLL3GAkufPb
   qPY3/su+gobgWxucrtyfRoxDgt2ywD/FEKe/TRabzNNjK6IH6LHD9u4aU
   8ckpP1p+KY2MMB8gG5bX0dc7KddaOm2iGbH0Jr2Yt7X6H2GoHM1zh7apd
   vsq4Fi99yut4oKHrKsXUz85Lx3R5gVdPIzpfJKfgbv9+s2szRP5NII+f4
   P8skRBj4zyT2jjnxQm1ibRljhIhQ4CJ2NDpwI0VbeaNnFj4//H7yvkwSH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="310007021"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="310007021"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 11:41:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="665788119"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="665788119"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 27 Oct 2022 11:41:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9F4E1D0; Thu, 27 Oct 2022 21:41:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] pinctrl: qcom: lpass-lpi: Add missed bitfield.h
Date:   Thu, 27 Oct 2022 21:41:45 +0300
Message-Id: <20221027184145.2533-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the cleanup change dropped the bitfield.h from the
pinctrl-lpass-lpi.h, since it's not used there, but forgot to
re-instantiate it in the C-file, where users are located.

Fix this by adding missed bitfield.h to the C-file.

Fixes: aa9430f8a6de ("pinctrl: qcom: Add missing header(s)")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index d5cfa91e2eff..3dc670faa59e 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2020 Linaro Ltd.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
-- 
2.35.1

