Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444E4721B5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 03:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjFEBAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 21:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFEBAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 21:00:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D717B8;
        Sun,  4 Jun 2023 18:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685926848; x=1717462848;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vPVFL0gWX37U9CBUlevg6LC4kAfQg412lVLCpm649ro=;
  b=hZAy8J84KTbvt+42qMvQ8uSaCIwthmsH3WyR/1TAmHSXDOrSr3bYv8jh
   w6EFhg3kxnlkydwCKFQKyvR8h20x+dL+Zrk+//0ka901Lzd0jhx4OSbvI
   tuRs/lz0vFSV72meIybWzsC2tgz1qOvsUlfATGTrxjyZ0MxZXHPrnLStn
   +EyPd7IdoA2e9hTqjnf9hA6VFVMishuQjN4aDXBeAo/+pgSW7vkx63ATS
   6N59Zfb79ZqhsE1SStYkewrLAN54tPf9blYFT9aN8FQ4Uy03VCNyfirKt
   zXW+5FX6Tt0uoWoNJ0XPx5mbqO2UOacQiKu+H+0mZq1nbrVT0RdVZSk75
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="384545399"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="384545399"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 18:00:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="852800018"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="852800018"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.157])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jun 2023 18:00:48 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        bleung@chromium.org
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 0/2] Add support to configure active retimer cable
Date:   Sun,  4 Jun 2023 18:01:15 -0700
Message-Id: <20230605010117.794691-1-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds support to configure retimer cable type

Utkarsh Patel (2):
  platform/chrome: cros_ec_typec: Configure Retimer cable type
  usb: typec: intel_pmc_mux: Configure Active and Retimer Cable type

 drivers/platform/chrome/cros_ec_typec.c       |  8 +++++-
 drivers/usb/typec/mux/intel_pmc_mux.c         | 28 ++++++++++++++++---
 .../linux/platform_data/cros_ec_commands.h    |  2 ++
 3 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.25.1

