Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2170700DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbjELRKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbjELRKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:10:07 -0400
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863202D47;
        Fri, 12 May 2023 10:10:06 -0700 (PDT)
Received: from [64.186.27.43] (helo=srivatsa-dev.eng.vmware.com)
        by outgoing2021.csail.mit.edu with esmtpa (Exim 4.95)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1pxVyD-001Zzx-3Z;
        Fri, 12 May 2023 12:50:17 -0400
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To:     jgross@suse.com, bp@suse.de, tglx@linutronix.de, kuba@kernel.org,
        davem@davemloft.net, richardcochran@gmail.com
Cc:     sdeep@vmware.com, amakhalov@vmware.com, akaher@vmware.com,
        vsirnapalli@vmware.com, srivatsa@csail.mit.edu,
        pv-drivers@vmware.com, virtualization@lists.linux-foundation.org,
        x86@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] MAINTAINERS: Update maintainers for paravirt-ops
Date:   Fri, 12 May 2023 09:49:56 -0700
Message-Id: <20230512164958.575174-1-srivatsa@csail.mit.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>

I have decided to change employers and I'm not sure if I'll be able to
spend as much time on the paravirt-ops subsystem going forward. So, I
would like to remove myself from the maintainer role for paravirt-ops.

Remove Srivatsa from the maintainers entry and add Ajay Kaher as an
additional reviewer for paravirt-ops. Also, add an entry to CREDITS
for Srivatsa.

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Acked-by: Alexey Makhalov <amakhalov@vmware.com>
Acked-by: Ajay Kaher <akaher@vmware.com>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 2d9da9a7defa..5d48f1a201f2 100644
--- a/CREDITS
+++ b/CREDITS
@@ -383,6 +383,10 @@ E: tomas@nocrew.org
 W: http://tomas.nocrew.org/
 D: dsp56k device driver
 
+N: Srivatsa S. Bhat
+E: srivatsa@csail.mit.edu
+D: Maintainer of Generic Paravirt-Ops subsystem
+
 N: Ross Biro
 E: ross.biro@gmail.com
 D: Original author of the Linux networking code
diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..2d8d000353b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15929,7 +15929,7 @@ F:	include/uapi/linux/ppdev.h
 
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
-M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
+R:	Ajay Kaher <akaher@vmware.com>
 R:	Alexey Makhalov <amakhalov@vmware.com>
 R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
-- 
2.25.1

