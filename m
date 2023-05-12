Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2446A700DB2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbjELRKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbjELRKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:10:09 -0400
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D5830EB;
        Fri, 12 May 2023 10:10:08 -0700 (PDT)
Received: from [64.186.27.43] (helo=srivatsa-dev.eng.vmware.com)
        by outgoing2021.csail.mit.edu with esmtpa (Exim 4.95)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1pxVyN-001Zzx-6w;
        Fri, 12 May 2023 12:50:27 -0400
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To:     jgross@suse.com, bp@suse.de, tglx@linutronix.de, kuba@kernel.org,
        davem@davemloft.net, richardcochran@gmail.com
Cc:     sdeep@vmware.com, amakhalov@vmware.com, akaher@vmware.com,
        vsirnapalli@vmware.com, srivatsa@csail.mit.edu,
        pv-drivers@vmware.com, virtualization@lists.linux-foundation.org,
        x86@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] MAINTAINERS: Update maintainers for VMware virtual PTP clock driver
Date:   Fri, 12 May 2023 09:49:58 -0700
Message-Id: <20230512164958.575174-3-srivatsa@csail.mit.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512164958.575174-1-srivatsa@csail.mit.edu>
References: <20230512164958.575174-1-srivatsa@csail.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>

I have decided to change employers, so I would like to remove myself
from the maintainer role for VMware-supported subsystems.

Remove Srivatsa from the maintainers entry for VMware virtual PTP
clock driver (ptp_vmw) and add Ajay Kaher as an additional reviewer.
Also, update CREDITS for Srivatsa.

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Acked-by: Ajay Kaher <akaher@vmware.com>
Acked-by: Alexey Makhalov <amakhalov@vmware.com>
Acked-by: Deep Shah <sdeep@vmware.com>
---
 CREDITS     | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 313435c93e2c..670c256aff5d 100644
--- a/CREDITS
+++ b/CREDITS
@@ -387,6 +387,7 @@ N: Srivatsa S. Bhat
 E: srivatsa@csail.mit.edu
 D: Maintainer of Generic Paravirt-Ops subsystem
 D: Maintainer of VMware hypervisor interface
+D: Maintainer of VMware virtual PTP clock driver (ptp_vmw)
 
 N: Ross Biro
 E: ross.biro@gmail.com
diff --git a/MAINTAINERS b/MAINTAINERS
index 309d4cc325f9..a00bea4d7438 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22520,8 +22520,8 @@ F:	drivers/scsi/vmw_pvscsi.c
 F:	drivers/scsi/vmw_pvscsi.h
 
 VMWARE VIRTUAL PTP CLOCK DRIVER
-M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
 M:	Deep Shah <sdeep@vmware.com>
+R:	Ajay Kaher <akaher@vmware.com>
 R:	Alexey Makhalov <amakhalov@vmware.com>
 R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	netdev@vger.kernel.org
-- 
2.25.1

