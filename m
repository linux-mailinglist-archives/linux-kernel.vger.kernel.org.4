Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB34470318C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbjEOP3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbjEOP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:29:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D08519B1;
        Mon, 15 May 2023 08:28:57 -0700 (PDT)
Date:   Mon, 15 May 2023 15:28:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684164535;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKLUU5CHN+pr/VTE8TLRWntPY7crsG3zIk0FHJJ/i3k=;
        b=MAWGT0xDFYGJi59K8Ih5+5CoyvCNbDZwe9Wj+Ds4aaZoPUIbhDjP0latxrgivVwy85pPda
        QXgw0MwQoX2AlLhZ/TJlJ/Oeukp6xwmmCLBKmm6ZOLBnbiIGo+Ph4GPx/F2SgzigqSBJRy
        RzYECnuZnnxCXnA7SOBos/SuSuLOX0sjkxNxtEu+q4dmZ6fOpsRSRIudUMvSYo087uQzFL
        rOWGYvrg3qfvNK7+twqIh0nOFad/NzikKaloj4zjTYuuhkydaPP920mG2deWltCHmlAISA
        78YDXul5GyRwqhdNe24+6eLyfke3RjktoeaAz6Qn+TqFpiaOnI0wEJA24zqTJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684164535;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKLUU5CHN+pr/VTE8TLRWntPY7crsG3zIk0FHJJ/i3k=;
        b=FnfVBjZ1YFu8UZmFvdWtpzKGaurzjXV4lHYwvRa+bUyX1a7rFEDKJnxdLHByaEClWwlZjZ
        f6AXhKntWI8lGAAQ==
From:   "tip-bot2 for Srivatsa S. Bhat (VMware)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] MAINTAINERS: Update Srivatsa S. Bhat's maintained areas
Cc:     "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Ajay Kaher <akaher@vmware.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512164958.575174-1-srivatsa@csail.mit.edu>
References: <20230512164958.575174-1-srivatsa@csail.mit.edu>
MIME-Version: 1.0
Message-ID: <168416453507.404.18114577812971743442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     e31a5c5cfeab70d3554e237daf9e319265cbb411
Gitweb:        https://git.kernel.org/tip/e31a5c5cfeab70d3554e237daf9e319265cbb411
Author:        Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
AuthorDate:    Fri, 12 May 2023 09:49:56 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 May 2023 17:18:19 +02:00

MAINTAINERS: Update Srivatsa S. Bhat's maintained areas

I have decided to change employers and I'm not sure if I'll be able to
spend as much time on the subsystems/drivers I maintain. So, I would
like to remove myself from the maintainer role.

Remove Srivatsa from the maintainers entry and add Ajay Kaher as an
additional reviewer/maintainer for the respective areas. Also, add an
entry to CREDITS for Srivatsa.

  [ bp: Merge all three into one patch, adjust commit message. ]

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Alexey Makhalov <amakhalov@vmware.com>
Acked-by: Ajay Kaher <akaher@vmware.com>
Acked-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20230512164958.575174-1-srivatsa@csail.mit.edu
---
 CREDITS     | 6 ++++++
 MAINTAINERS | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/CREDITS b/CREDITS
index 2d9da9a..670c256 100644
--- a/CREDITS
+++ b/CREDITS
@@ -383,6 +383,12 @@ E: tomas@nocrew.org
 W: http://tomas.nocrew.org/
 D: dsp56k device driver
 
+N: Srivatsa S. Bhat
+E: srivatsa@csail.mit.edu
+D: Maintainer of Generic Paravirt-Ops subsystem
+D: Maintainer of VMware hypervisor interface
+D: Maintainer of VMware virtual PTP clock driver (ptp_vmw)
+
 N: Ross Biro
 E: ross.biro@gmail.com
 D: Original author of the Linux networking code
diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886..a00bea4 100644
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
@@ -22493,7 +22493,7 @@ S:	Supported
 F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
-M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
+M:	Ajay Kaher <akaher@vmware.com>
 M:	Alexey Makhalov <amakhalov@vmware.com>
 R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
@@ -22520,8 +22520,8 @@ F:	drivers/scsi/vmw_pvscsi.c
 F:	drivers/scsi/vmw_pvscsi.h
 
 VMWARE VIRTUAL PTP CLOCK DRIVER
-M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
 M:	Deep Shah <sdeep@vmware.com>
+R:	Ajay Kaher <akaher@vmware.com>
 R:	Alexey Makhalov <amakhalov@vmware.com>
 R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	netdev@vger.kernel.org
