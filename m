Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11BF679423
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjAXJ0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjAXJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:26:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A832420F;
        Tue, 24 Jan 2023 01:26:38 -0800 (PST)
Date:   Tue, 24 Jan 2023 09:26:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674552396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TOUgB6MpheGokJ+UbH0HgT93UhNXPaW0u9XIRbJwhM=;
        b=VFP+03TOpEVG3thaj8GKxUJia6MzG2I6tKZC6nKTL01GM1Aci1tN6LWzIjJwlk0Oy7mRca
        AOfU1hoaXrNhcsfOtoNgDCOmrTaFt4lWvEgWwQDFxFLVviRjTMpcBWy89X60+ICrDYHB0G
        PhSE+nMR3zg7do0ReqwoChsL1zy79fVPDeWDVgo6cGEf77BLboS68C/7QJSrlbp72BOf2z
        Tz42OqROmL0nNqRbLfmjYLGUuMeCIq2fTUAWl1VRtX1G6Z/YnYY7MblTaGIOwVDtXAXsNR
        UKq5gFzNWK0rsCEOFZJ7i7d3bqQoHULtdRcHZz5dbKTdQz6idn4QwheClNZ/+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674552396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TOUgB6MpheGokJ+UbH0HgT93UhNXPaW0u9XIRbJwhM=;
        b=ouKnYGeT4XdnOMhVEip86jB1xpJvV+Il3kL/qn59KC3X+u2/KCyQU19+pjmUkPJV/bEJB4
        tCNEF2IwLcmtgrCA==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] Documentation/x86: Update resctrl.rst for new features
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230113152039.770054-14-babu.moger@amd.com>
References: <20230113152039.770054-14-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <167455239549.4906.3797874355154493951.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     0a363fb23ee2f7beb08437ad7db86d195878d79f
Gitweb:        https://git.kernel.org/tip/0a363fb23ee2f7beb08437ad7db86d195878d79f
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 13 Jan 2023 09:20:39 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jan 2023 17:40:37 +01:00

Documentation/x86: Update resctrl.rst for new features

Update the documentation for the new features:

1. Slow Memory Bandwidth allocation (SMBA).

   With this feature, the QOS enforcement policies can be applied to the
   external slow memory connected to the host. QOS enforcement is accomplished
   by assigning a Class Of Service (COS) to a processor and specifying
   allocations or limits for that COS for each resource to be allocated.

2. Bandwidth Monitoring Event Configuration (BMEC).

   The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes are set
   to count all the total and local reads/writes respectively.  With the
   introduction of slow memory, the two counters are not enough to count all the
   different types of memory events. With the feature BMEC, the users have the
   option to configure mbm_total_bytes and mbm_local_bytes to count the specific
   type of events.

Also add configuration instructions with examples.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20230113152039.770054-14-babu.moger@amd.com
---
 Documentation/x86/resctrl.rst | 147 ++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
index 71a5310..058257d 100644
--- a/Documentation/x86/resctrl.rst
+++ b/Documentation/x86/resctrl.rst
@@ -17,14 +17,21 @@ AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
 This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpuinfo
 flag bits:
 
-=============================================	================================
+===============================================	================================
 RDT (Resource Director Technology) Allocation	"rdt_a"
 CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
 CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
 CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"
 MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
 MBA (Memory Bandwidth Allocation)		"mba"
-=============================================	================================
+SMBA (Slow Memory Bandwidth Allocation)         ""
+BMEC (Bandwidth Monitoring Event Configuration) ""
+===============================================	================================
+
+Historically, new features were made visible by default in /proc/cpuinfo. This
+resulted in the feature flags becoming hard to parse by humans. Adding a new
+flag to /proc/cpuinfo should be avoided if user space can obtain information
+about the feature from resctrl's info directory.
 
 To use the feature mount the file system::
 
@@ -161,6 +168,83 @@ with the following files:
 "mon_features":
 		Lists the monitoring events if
 		monitoring is enabled for the resource.
+		Example::
+
+			# cat /sys/fs/resctrl/info/L3_MON/mon_features
+			llc_occupancy
+			mbm_total_bytes
+			mbm_local_bytes
+
+		If the system supports Bandwidth Monitoring Event
+		Configuration (BMEC), then the bandwidth events will
+		be configurable. The output will be::
+
+			# cat /sys/fs/resctrl/info/L3_MON/mon_features
+			llc_occupancy
+			mbm_total_bytes
+			mbm_total_bytes_config
+			mbm_local_bytes
+			mbm_local_bytes_config
+
+"mbm_total_bytes_config", "mbm_local_bytes_config":
+	Read/write files containing the configuration for the mbm_total_bytes
+	and mbm_local_bytes events, respectively, when the Bandwidth
+	Monitoring Event Configuration (BMEC) feature is supported.
+	The event configuration settings are domain specific and affect
+	all the CPUs in the domain. When either event configuration is
+	changed, the bandwidth counters for all RMIDs of both events
+	(mbm_total_bytes as well as mbm_local_bytes) are cleared for that
+	domain. The next read for every RMID will report "Unavailable"
+	and subsequent reads will report the valid value.
+
+	Following are the types of events supported:
+
+	====    ========================================================
+	Bits    Description
+	====    ========================================================
+	6       Dirty Victims from the QOS domain to all types of memory
+	5       Reads to slow memory in the non-local NUMA domain
+	4       Reads to slow memory in the local NUMA domain
+	3       Non-temporal writes to non-local NUMA domain
+	2       Non-temporal writes to local NUMA domain
+	1       Reads to memory in the non-local NUMA domain
+	0       Reads to memory in the local NUMA domain
+	====    ========================================================
+
+	By default, the mbm_total_bytes configuration is set to 0x7f to count
+	all the event types and the mbm_local_bytes configuration is set to
+	0x15 to count all the local memory events.
+
+	Examples:
+
+	* To view the current configuration::
+	  ::
+
+	    # cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
+	    0=0x7f;1=0x7f;2=0x7f;3=0x7f
+
+	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
+	    0=0x15;1=0x15;3=0x15;4=0x15
+
+	* To change the mbm_total_bytes to count only reads on domain 0,
+	  the bits 0, 1, 4 and 5 needs to be set, which is 110011b in binary
+	  (in hexadecimal 0x33):
+	  ::
+
+	    # echo  "0=0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
+
+	    # cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
+	    0=0x33;1=0x7f;2=0x7f;3=0x7f
+
+	* To change the mbm_local_bytes to count all the slow memory reads on
+	  domain 0 and 1, the bits 4 and 5 needs to be set, which is 110000b
+	  in binary (in hexadecimal 0x30):
+	  ::
+
+	    # echo  "0=0x30;1=0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
+
+	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
+	    0=0x30;1=0x30;3=0x15;4=0x15
 
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
@@ -464,6 +548,25 @@ Memory bandwidth domain is L3 cache.
 
 	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
 
+Slow Memory Bandwidth Allocation (SMBA)
+---------------------------------------
+AMD hardware supports Slow Memory Bandwidth Allocation (SMBA).
+CXL.memory is the only supported "slow" memory device. With the
+support of SMBA, the hardware enables bandwidth allocation on
+the slow memory devices. If there are multiple such devices in
+the system, the throttling logic groups all the slow sources
+together and applies the limit on them as a whole.
+
+The presence of SMBA (with CXL.memory) is independent of slow memory
+devices presence. If there are no such devices on the system, then
+configuring SMBA will have no impact on the performance of the system.
+
+The bandwidth domain for slow memory is L3 cache. Its schemata file
+is formatted as:
+::
+
+	SMBA:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
+
 Reading/writing the schemata file
 ---------------------------------
 Reading the schemata file will show the state of all resources
@@ -479,6 +582,46 @@ which you wish to change.  E.g.
   L3DATA:0=fffff;1=fffff;2=3c0;3=fffff
   L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
 
+Reading/writing the schemata file (on AMD systems)
+--------------------------------------------------
+Reading the schemata file will show the current bandwidth limit on all
+domains. The allocated resources are in multiples of one eighth GB/s.
+When writing to the file, you need to specify what cache id you wish to
+configure the bandwidth limit.
+
+For example, to allocate 2GB/s limit on the first cache id:
+
+::
+
+  # cat schemata
+    MB:0=2048;1=2048;2=2048;3=2048
+    L3:0=ffff;1=ffff;2=ffff;3=ffff
+
+  # echo "MB:1=16" > schemata
+  # cat schemata
+    MB:0=2048;1=  16;2=2048;3=2048
+    L3:0=ffff;1=ffff;2=ffff;3=ffff
+
+Reading/writing the schemata file (on AMD systems) with SMBA feature
+--------------------------------------------------------------------
+Reading and writing the schemata file is the same as without SMBA in
+above section.
+
+For example, to allocate 8GB/s limit on the first cache id:
+
+::
+
+  # cat schemata
+    SMBA:0=2048;1=2048;2=2048;3=2048
+      MB:0=2048;1=2048;2=2048;3=2048
+      L3:0=ffff;1=ffff;2=ffff;3=ffff
+
+  # echo "SMBA:1=64" > schemata
+  # cat schemata
+    SMBA:0=2048;1=  64;2=2048;3=2048
+      MB:0=2048;1=2048;2=2048;3=2048
+      L3:0=ffff;1=ffff;2=ffff;3=ffff
+
 Cache Pseudo-Locking
 ====================
 CAT enables a user to specify the amount of cache space that an
