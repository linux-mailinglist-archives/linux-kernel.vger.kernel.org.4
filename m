Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87679729350
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240859AbjFIIgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240740AbjFIIfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:35:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196BC2712;
        Fri,  9 Jun 2023 01:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686299735; x=1717835735;
  h=from:to:cc:subject:date:message-id;
  bh=L+c/KWYlHq0/2ccQsnp0j8wUQJh9tHwhKAkllrU2WJg=;
  b=DSvd64wvp/q0abNjV8bEk34AYd96ngwaLsnG5yzvy9SkMd2bBLgOWyjb
   /hQemFapH5rXKci+/7e8VpzPvII8Jix+S/+XCiSnAoxcvBVePZUcZABqE
   SlvHhF4NN9zaepAGtIsi3tzbTnGJgeDC4MLuaSAgq+e2eO/+McUkkFJCz
   1ipZIz8oku0anuLZvPxMIpAW0P9bk8MqVKtjhQX8jcw2DECV0HzmBKM9f
   YPe+t3A0b1OF4x0iKuWqSWIMKIsNLO1RoSAnNqNH5NM10VBEPMvP66JYk
   86gchEN1l2vj6v4ZlCdUlgh2Sy1lgiMfvTb4+U+c5BAGqHMPjCa/abhIh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="355041497"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="355041497"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:35:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="660690487"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="660690487"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2023 01:35:07 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id AB139911E7;
        Fri,  9 Jun 2023 14:05:06 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id A5267B6; Fri,  9 Jun 2023 14:05:06 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 0/2] Minor improvements for Cherryview pinctrl
Date:   Fri,  9 Jun 2023 14:03:54 +0530
Message-Id: <20230609083356.24849-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements minor improvements for Cherryview pinctrl driver.

The optimizations are as tested with gcc 7.5.0 with default -O2.

Raag Jadav (2):
  pinctrl: cherryview: simplify exit path of set_mux hook
  pinctrl: cherryview: simplify exit path of gpio_request_enable hook

 drivers/pinctrl/intel/pinctrl-cherryview.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.17.1

