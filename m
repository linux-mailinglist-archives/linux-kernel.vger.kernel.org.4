Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D9372930F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbjFII0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241652AbjFII0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:26:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A768B3AA7;
        Fri,  9 Jun 2023 01:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686299162; x=1717835162;
  h=from:to:cc:subject:date:message-id;
  bh=oHaM0VhiJJoccfQrMVwCKCWjE/9E7rM4bgdOx9QJRqU=;
  b=TvZjkULNAbmdOtoyttQc3G1jc4tBi34aUbYPwRgsfccES2WIMXQb3FX0
   3GeKx6MfST+EMVWKM8bCo60106kH7cQ2+lnV0XChYldhHTe/g9YtiPnaQ
   kOl/0hCmDivZELQDZiEVRXji+BmNdRdomktpzWn0FiEaDawlFXWJLRJoA
   aARDDz+tpCkAlI6w0LhKHbi0ggZQoJ4yvtgaQxgpeYZnK/hm4cQ1Jj4JE
   U+S0SsJhLCA0xUmHJH42p1cJZ8ys35IFRfB9d/887bQLDo7ScRVERhmX1
   scdV5zXr1VkN4SVtFAEQEhu8SgYGUaDxlHKxo1nMAmxDLTLoW44t+znIQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342222295"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="342222295"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713424274"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="713424274"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 01:25:59 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 0416714359;
        Fri,  9 Jun 2023 13:55:59 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id F17A517C; Fri,  9 Jun 2023 13:55:58 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 0/4] Minor improvements for Intel pinctrl
Date:   Fri,  9 Jun 2023 13:55:35 +0530
Message-Id: <20230609082539.24311-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements minor improvements for Intel pinctrl driver.

The optimizations are as tested with gcc 7.5.0 with default -O2.

Raag Jadav (4):
  pinctrl: intel: refine set_mux hook
  pinctrl: intel: refine irq_set_type hook
  pinctrl: intel: simplify exit path of set_mux hook
  pinctrl: intel: simplify exit path of gpio_request_enable hook

 drivers/pinctrl/intel/pinctrl-intel.c | 57 ++++++++++++++-------------
 1 file changed, 29 insertions(+), 28 deletions(-)

-- 
2.17.1

