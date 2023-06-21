Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29877737B40
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjFUGP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjFUGPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:15:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F371735
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687328147; x=1718864147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UkKcYaLCdZ9dshQU8JrbFqmeYpci+eRXUQRb756OC3k=;
  b=huK2gxVJAs87OuxUcHg+YMZ3QIWZnSYeK+6ciSgZwEgmlB0DVZ+SEVwn
   bDM5b59jOw3qRTE6P9u8K31AGWqjdVNTjrc72KB6hh3yXIgCbMY/EX5Z4
   XZCBeapjpPEWfKZhLiNH5TD3h/mAk2JAyK936yVbnVL4TDm+l6pp8CEv0
   mI7W9M87PBUP6nCLC2YgrOFLXROwEbAJjDuNyCKd16Y4GroS3T2ZJE9Vv
   aGv7hSs4wroeh2ZyebWQQrO9ICn5mBuHot26n59eR2r1xrdl0w5xqstCn
   GlHcVxoL7y28OJJ/9+JC5U6oSPNSwuWOXWB92E+KBeRQfRNoyYzvj4x88
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="349814379"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="349814379"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 23:15:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="714327498"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="714327498"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga002.jf.intel.com with ESMTP; 20 Jun 2023 23:15:44 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 0/3] extend svc to support attestation
Date:   Wed, 21 Jun 2023 14:15:05 +0800
Message-Id: <20230621061508.1429913-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

hi,
This patch set is to extend the svc driver to support the new 
attestation SDM mailbox commands.

Ang Tien Sung (3):
  firmware: stratix10-svc: extend svc for attestation
  firmware: stratix10-svc: extend for single certificate
  firmware: stratix10-svc: extend to support new FPGA attestation

 drivers/firmware/stratix10-svc.c              |  64 +++++++-
 include/linux/firmware/intel/stratix10-smc.h  | 148 +++++++++++++++++-
 .../firmware/intel/stratix10-svc-client.h     |  32 ++++
 3 files changed, 242 insertions(+), 2 deletions(-)

-- 
2.25.1

