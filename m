Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4420774AB60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGGGv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGGGvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:51:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4252130;
        Thu,  6 Jul 2023 23:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688712703; x=1720248703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FNKNGsxGxJ19R+qhSLCXoaTwsh7nlW0+jkk3E1N4B5c=;
  b=Gm+TLgs5qaLsCojkk9IOC37Y5oHsG7SRsElueNulusenk8BE4ZqlWHTL
   4AirhKoQl560ncgZNJlJlZn8BMDBSSsTiu7gvnfHIBSvmv9M7dXp77Nh/
   rTRN8UCnSl1vqmK2JiaGT9LMlRAoZC8DLKsvW7CcNjuSK+D4o8ySstcC/
   JVXEt4t4iocZdMdlAYMCWQ9YuOlXNPpcdFNhwL2DlrzBwmEgYdXhJaPL+
   6F0X1Kz8phsl03U8/udnd3URo6zShanLzxIFDYkkUkGSpE6wZx4xFZQS2
   jbQHz0OxyauJDhiuFyrIWzhEWHyiUaUfm0p3YQNNKXNtwrMHFlHGKq2S/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="394586940"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="394586940"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 23:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="749436225"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="749436225"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.157])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2023 23:51:42 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        bleung@chromium.org
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v3 0/2] Add support to configure active retimer cable
Date:   Thu,  6 Jul 2023 23:53:16 -0700
Message-Id: <20230707065318.18681-1-utkarsh.h.patel@intel.com>
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

This change adds support to configure retimer cable type

Changes in v2:
- Implemented use of cable discover mode vdo.
- Removed adittional changes to host command.

Changes in v3:
- Changed the return method in cros_typec_get_cable_vdo.
- Changed passed parameters in cros_typec_get_cable_vdo.
- Corrected definition for unsigned integers as kerenl standard.
- Assigning cable_vdo values directly in to cable_mode.
- Removed unncessary checks for Retimer cable type.

Utkarsh Patel (2):
  platform/chrome: cros_ec_typec: Configure Retimer cable type
  usb: typec: intel_pmc_mux: Configure Active and Retimer Cable type

 drivers/platform/chrome/cros_ec_typec.c | 26 ++++++++++++++++++++++-
 drivers/usb/typec/mux/intel_pmc_mux.c   | 28 +++++++++++++++++++++----
 2 files changed, 49 insertions(+), 5 deletions(-)

-- 
2.25.1

