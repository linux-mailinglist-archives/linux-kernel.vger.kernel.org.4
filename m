Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F3D6AF0E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjCGShJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjCGSgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:36:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C4832E79;
        Tue,  7 Mar 2023 10:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678213698; x=1709749698;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0dXDtqIyINEoAtHwo3652ovkLBTpOPT/eHzG1iEnLls=;
  b=g8XljUweO7sBulSVad3C94TPn+JHn1W0DL35eUfmj35ggQ1G9iqX6XUr
   a9FW/R/qRspFJj5BBk1kbH4vaWb8ZrS4psHCT5Ob7kdLQUbVrlL88/+mZ
   0qtbAJjHu5SOcZBgM8BuAZXEJkY2IGS56bNAeVZQM/RxyoEYonQB228i/
   3wkqjYk47mlm7y0nDwfaf6t2E2bN/NAiKS2oWzvidm2oFRwYN2DOHfJ8o
   gZ2Xv0vTwQRhAVQNzrZJVW6r3NF1+amCT3BqcYwj7PdZ2PUh5iT+lWeRd
   92BCIrnl7Co3AK+biL6Ju9rD0E6HdJ5qCfj/f5dEsVyYCsQado3NWSZkH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="316333914"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="316333914"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 10:25:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="706902042"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="706902042"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 07 Mar 2023 10:25:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EF0AE143; Tue,  7 Mar 2023 20:25:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 0/3] gpiolib: cleanups WRT GPIO device handling
Date:   Tue,  7 Mar 2023 20:25:54 +0200
Message-Id: <20230307182557.42215-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few cleanups to GPIO device handling in the library code.

Andy Shevchenko (3):
  gpiolib: Access device's fwnode via dev_fwnode()
  gpiolib: Get rid of gpio_bus_match() forward declaration
  gpiolib: Move gpiodevice_*() to gpiodev namespace

 drivers/gpio/gpiolib.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

-- 
2.39.1

