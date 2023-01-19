Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8446F673368
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjASIOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjASIOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:14:02 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5974245BDD;
        Thu, 19 Jan 2023 00:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674116041; x=1705652041;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Uw39GHewdVy4hZPaY3+nKckas1yzZpDUlpEw/VuNI/U=;
  b=DNZ/IHsYkcKhI+eej0rRM2g5ymBEt61AaajzC9veQvt0PL3BTy0IP1vb
   CdbIC7PUYkgQ8HURXDsPAvmSNDj2nqy0edKsABk7jlVgWT1z8z5FFZAx6
   yqy1H1CwtJfGaQfd0lCNRnlZULZ0IHXJ+eNElC1iKFx2K9raEbR/4K1kF
   LGTPW3TRhEwjUg1l3aDa0+wIzaYK97HLr533FRLNgHlo5ECWc1XCKI1ww
   Do4vX+AEOqWwiUdmHljeysvy0n5CKkhPA39YTKR2mImjLAcTXnuaaEbzs
   /0qk2KINKUJIAQ4cxVt7oekQ6ftC1zTekVarD2kFD9PCXEmL33O/W7qKi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="352480581"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="352480581"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 00:14:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="637608739"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="637608739"
Received: from r031s002_zp31l10c01.gv.intel.com (HELO fedora..) ([10.219.171.29])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2023 00:13:59 -0800
From:   Meadhbh <meadhbh.fitzpatrick@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        vdronov@redhat.com, wojciech.ziemba@intel.com,
        tomaszx.kowalik@intel.com, bagasdotme@gmail.com,
        linux-kernel@vger.kernel.org,
        Meadhbh <meadhbh.fitzpatrick@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH] Documentation: qat: change kernel version
Date:   Thu, 19 Jan 2023 09:05:08 +0100
Message-Id: <20230119080508.24235-1-meadhbh.fitzpatrick@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Organisation: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare, Ireland
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change kernel version from 5.20 to 6.0, as 5.20 is not a release.

Signed-off-by: Meadhbh Fitzpatrick <meadhbh.fitzpatrick@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 Documentation/ABI/testing/sysfs-driver-qat | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-qat b/Documentation/ABI/testing/sysfs-driver-qat
index 185f81a2aab3..087842b1969e 100644
--- a/Documentation/ABI/testing/sysfs-driver-qat
+++ b/Documentation/ABI/testing/sysfs-driver-qat
@@ -1,6 +1,6 @@
 What:		/sys/bus/pci/devices/<BDF>/qat/state
 Date:		June 2022
-KernelVersion:	5.20
+KernelVersion:	6.0
 Contact:	qat-linux@intel.com
 Description:	(RW) Reports the current state of the QAT device. Write to
 		the file to start or stop the device.
@@ -18,7 +18,7 @@ Description:	(RW) Reports the current state of the QAT device. Write to
 
 What:		/sys/bus/pci/devices/<BDF>/qat/cfg_services
 Date:		June 2022
-KernelVersion:	5.20
+KernelVersion:	6.0
 Contact:	qat-linux@intel.com
 Description:	(RW) Reports the current configuration of the QAT device.
 		Write to the file to change the configured services.
-- 
2.37.3

--------------------------------------------------------------
Intel Research and Development Ireland Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263


This e-mail and any attachments may contain confidential material for the sole
use of the intended recipient(s). Any review or distribution by others is
strictly prohibited. If you are not the intended recipient, please contact the
sender and delete all copies.

