Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA85E607005
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJUG1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJUG1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:27:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D30239231
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666333659; x=1697869659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JR2Ej9sMDTPdzXZaqlO8V8artslbt8VzaADI4VUIdSo=;
  b=loSRt9ok+i7w/m1NERwALAJhASf94hpXLkxoYdCB+YCPvhRjvZtHXv4k
   RZ0odjgxNWvn/ACfxe9jahkySXBoB6y3IufPIcM4DCRPl6GW2+QQYPBvh
   +chNPRWMvkKS9/4T9kTNpae+FNnSDlx/g4ndTtMrm4aX0CTIARCLSm8Qd
   WstRmJlC/GImHusuLDc2kZtQOGBume64N/YLINClkL4oWn72AdxEA34Pz
   TkKm71+eKzl72hwbvpYZshlDDjIJnQmteB6mZ7isgM3NVXwNphvqXv4Ge
   4J36KpfYpPdI2KGsFygC/fUWx2BhQXxiNDrswNAOR0ma2irbXPGGliBW9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="286642398"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="286642398"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 23:27:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="735358026"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="735358026"
Received: from d8bbc18b98c6.jf.intel.com ([10.54.241.152])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2022 23:27:38 -0700
From:   shaoqin.huang@intel.com
To:     mst@redhat.com, jasowang@redhat.com
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 0/2] virtio: use helper function is_power_of_2()
Date:   Thu, 20 Oct 2022 23:27:32 -0700
Message-Id: <20221021062734.228881-1-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaoqin Huang <shaoqin.huang@intel.com>

Use helper function is_power_of_2() to check if num is power of two.
Minor readability improvement.

Shaoqin Huang (2):
  virtio_pci: use helper function is_power_of_2()
  virtio_ring: use helper function is_power_of_2()

 drivers/virtio/virtio_pci_modern.c | 2 +-
 drivers/virtio/virtio_ring.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1

