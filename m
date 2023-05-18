Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399687077F9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjERCUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjERCUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:20:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387602137
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684376433; x=1715912433;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RJrWgw2jrqW43LRQXu0u3SFenMNt8UEk4W3t6XTV+J0=;
  b=RHP61/sXoFsIShbVhCgdRH2f+IkPYZl52UC4x6F70f0t8ul8f7CdvAnN
   9iif2iM7dyCeuKCadumWVi3Ybs1OpkSlq1M9QrhKL71F5XKXo0RTZ8UTc
   p+MJyYzWvsD9suv9E19Zzc8CUiwotFji46AVR34CR8Z98XMYFT7gpNYuH
   G96xGGS3MW4OrBs15FYZ74fiqanJIleA/4F6UGB17bxx3b1AZJy9HygtV
   QwLGObZ+1rBwHYC5ZN10Maa6GeLRUgFpEW7BB/cgw/L4HpYG1jbmoo5bt
   RCSjGupkF1GopndVOlgUc/Etw95yDegPv9TSVBuO4pTgXf3SfYbkd7rcb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="336504757"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="336504757"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="826195206"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="826195206"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:20:31 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 0/3] soundwire: improve bus reset
Date:   Thu, 18 May 2023 10:41:16 +0800
Message-Id: <20230518024119.164160-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve bus reset sequence by updating programing sequence.

Pierre-Louis Bossart (3):
  soundwire: intel_bus_common: enable interrupts last
  soundwire: intel/cadence: update hardware reset sequence
  soundwire: cadence: revisit parity injection

 drivers/soundwire/cadence_master.c   | 50 ++++++++++-----
 drivers/soundwire/cadence_master.h   |  3 +
 drivers/soundwire/intel_bus_common.c | 93 ++++++++++++++++------------
 3 files changed, 89 insertions(+), 57 deletions(-)

-- 
2.25.1

