Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0BF637860
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiKXMDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiKXMCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:02:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6653E1CB22;
        Thu, 24 Nov 2022 04:02:54 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:02:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=To7oIj3xlstxDJLovDga6gmsNv+yahCX7K9mhqQxSyU=;
        b=dB+SBaRnOOHrGWqI6FfkWpO/MMSX0Pj2zH62MSD7I334gzwfIWgL4J0W9MjW2yOnaJGZF9
        XNTDoYPOwnK1h9FxrdbSiET+0llVy4J3PIbYF4jIzaIkT/Ws8BR1sTYkqRhiyRPkZtttat
        wPQamie9qjPj4gfyxN5DMPd46Ci3TtYL/gn+mKB9eKyIaw3hURly7M/5hcVFr5Y83i1ajW
        7iOAG4LahxenZhXuwXgyJDNGGP1j6Vme1mMmIVZKDeh6Qxg1u3BByBEF+TFOIAL2EXsazd
        yEi41dXYar7i/dN7FC/Pn23mERzEgHQCjyrWfas57VtKETUAWz1fmiYpQJaBqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=To7oIj3xlstxDJLovDga6gmsNv+yahCX7K9mhqQxSyU=;
        b=UT3xMvR6mBtKEWyFIvDJOw7wiMcetjDRq7fQddwDtuaXuLkvz6NsHD6B3wqlreae0SnJaV
        OAVrx1nRLU9as3Aw==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Update sysfs-devices-mapping file
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117122833.3103580-11-alexander.antonov@linux.intel.com>
References: <20221117122833.3103580-11-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166929137153.4906.11100268678842231768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     61fb0f7e974ac00ead611c00a57efdafac7785b5
Gitweb:        https://git.kernel.org/tip/61fb0f7e974ac00ead611c00a57efdafac7785b5
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Thu, 17 Nov 2022 12:28:32 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:24 +01:00

perf/x86/intel/uncore: Update sysfs-devices-mapping file

Add description for /sys/devices/uncore_upi_*/die* attributes to
sysfs-devices-mapping.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20221117122833.3103580-11-alexander.antonov@linux.intel.com
---
 Documentation/ABI/testing/sysfs-devices-mapping | 30 +++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-mapping b/Documentation/ABI/testing/sysfs-devices-mapping
index 8d202ba..2eee144 100644
--- a/Documentation/ABI/testing/sysfs-devices-mapping
+++ b/Documentation/ABI/testing/sysfs-devices-mapping
@@ -1,6 +1,6 @@
 What:           /sys/devices/uncore_iio_x/dieX
 Date:           February 2020
-Contact:        Roman Sudarikov <roman.sudarikov@linux.intel.com>
+Contact:        Alexander Antonov <alexander.antonov@linux.intel.com>
 Description:
                 Each IIO stack (PCIe root port) has its own IIO PMON block, so
                 each dieX file (where X is die number) holds "Segment:Root Bus"
@@ -32,3 +32,31 @@ Description:
 		    IIO PMU 0 on die 1 belongs to PCI RP on bus 0x40, domain 0x0000
 		    IIO PMU 0 on die 2 belongs to PCI RP on bus 0x80, domain 0x0000
 		    IIO PMU 0 on die 3 belongs to PCI RP on bus 0xc0, domain 0x0000
+
+What:           /sys/devices/uncore_upi_x/dieX
+Date:           March 2022
+Contact:        Alexander Antonov <alexander.antonov@linux.intel.com>
+Description:
+                Each /sys/devices/uncore_upi_X/dieY file holds "upi_Z,die_W"
+                value that means UPI link number X on die Y is connected to UPI
+                link Z on die W and this link between sockets can be monitored
+                by UPI PMON block.
+                For example, 4-die Sapphire Rapids platform has the following
+                UPI 0 topology::
+
+		    # tail /sys/devices/uncore_upi_0/die*
+		    ==> /sys/devices/uncore_upi_0/die0 <==
+		    upi_1,die_1
+		    ==> /sys/devices/uncore_upi_0/die1 <==
+		    upi_0,die_3
+		    ==> /sys/devices/uncore_upi_0/die2 <==
+		    upi_1,die_3
+		    ==> /sys/devices/uncore_upi_0/die3 <==
+		    upi_0,die_1
+
+                Which means::
+
+		    UPI link 0 on die 0 is connected to UPI link 1 on die 1
+		    UPI link 0 on die 1 is connected to UPI link 0 on die 3
+		    UPI link 0 on die 2 is connected to UPI link 1 on die 3
+		    UPI link 0 on die 3 is connected to UPI link 0 on die 1
\ No newline at end of file
