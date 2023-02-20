Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3C669D216
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjBTRYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjBTRYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:24:36 -0500
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251DC1C7F1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:24:32 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DCA7D881339
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:16:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7C1688816FC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:16:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1676913418; a=rsa-sha256;
        cv=none;
        b=s9AJ1b3JOScgnMiLWbGWCYnHiziT8tRSLqkeiWvol5IsZq5opSywoDVkHxDGjw6pdBPruh
        jIwsrq4t9JnX/QGfK2YxzN+p/xR0S1tUoY93CcsSHYOZYvsGiMtpsGoHOsCeiGq4bs4mHN
        MvqzL6zxLKr8vTnFfkNrE6n/bTUEuFJJPq+oH8yb37/PvOoHqHaWdsJ69yQxsuv0UIJIAz
        Oz1fPpKNwHABMMqKVXDPfaTuhXr76rya3dl6Zg66szKFCqHt8ydu2Rd2rp6YSEpiFguunZ
        h8QAV139W5tT0AXs0YWgIloHSJFuSbgC/je0Qcvsf6aDnrhJ0wcFrMGIGvzOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1676913418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=jPLOaJx1XC+xepUu7FtXLYzyt2YPI1cX/q7Jp4OSr1s=;
        b=oHKaCJUI7KVwdTLTq2pPIy2Vo2ikfnNZ7wpAL8nyoX4f+kOQLxWUzn1tK2SpVHPSGIb/uy
        6gFGUs6FBx9OzZqayvT0cfOgWUP/enrMlh7Tog1fDBvwq9Zj5FjdM9vi6BakMVR01yykvl
        h0YsDCf+caPAci8ud/WVcX4CdOT/Yv+uis6KPyhrR6VBQbBTHeKk8AxBRrQn30/RrWv/VI
        vPEFoaGsVIBcLyC5r+2jKtujffGaOosfgyKLGsLI485LzHJf65qU+xjrKFNk/mCYzTyyDP
        BPU5SIzgET4WprfMDT5iuzhMy+96P3Ot8kNVy+2Av72AEzVk+RpRxj3bEAnHIA==
ARC-Authentication-Results: i=1;
        rspamd-5db48964c-wmdpd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Company-Tank: 456417dc036ce084_1676913418722_3654916285
X-MC-Loop-Signature: 1676913418722:900851734
X-MC-Ingress-Time: 1676913418721
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.47 (trex/6.7.1);
        Mon, 20 Feb 2023 17:16:58 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4PL8Gx6vTLz1Dw
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1676913418;
        bh=jPLOaJx1XC+xepUu7FtXLYzyt2YPI1cX/q7Jp4OSr1s=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=rBn5t9nd39DD3PrheNBrV//PfuVBGriKg54u+who5tQJupiTqQmzFpE9n1TFxGgTU
         xH4H3u37nLpo1Hus0ou6M6JSe53Ak3WZWHlEXNd1YjZ/vUGRYBJlA0SvOslsHhzLUp
         DozJZqCz3LnFjfiXoMPUBiMBqMd/9C7lTh+5cNiA=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0067
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 20 Feb 2023 09:16:54 -0800
Date:   Mon, 20 Feb 2023 09:16:54 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
Subject: [PATCH linux-next 1/2] xen: update arch/x86/include/asm/xen/cpuid.h
Message-ID: <b8040de892acb46910ebae6d65291b2e021302b9.1676610413.git.kjlx@templeofstupid.com>
References: <cover.1676610413.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676610413.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update arch/x86/include/asm/xen/cpuid.h from the Xen tree to get newest
definitions.  This picks up some TSC mode definitions and comment
formatting changes.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 arch/x86/include/asm/xen/cpuid.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/xen/cpuid.h b/arch/x86/include/asm/xen/cpuid.h
index 6daa9b0c8d11..a3c29b1496c8 100644
--- a/arch/x86/include/asm/xen/cpuid.h
+++ b/arch/x86/include/asm/xen/cpuid.h
@@ -89,11 +89,21 @@
  * Sub-leaf 2: EAX: host tsc frequency in kHz
  */
 
+#define XEN_CPUID_TSC_EMULATED               (1u << 0)
+#define XEN_CPUID_HOST_TSC_RELIABLE          (1u << 1)
+#define XEN_CPUID_RDTSCP_INSTR_AVAIL         (1u << 2)
+
+#define XEN_CPUID_TSC_MODE_DEFAULT           (0)
+#define XEN_CPUID_TSC_MODE_ALWAYS_EMULATE    (1u)
+#define XEN_CPUID_TSC_MODE_NEVER_EMULATE     (2u)
+#define XEN_CPUID_TSC_MODE_PVRDTSCP          (3u)
+
 /*
  * Leaf 5 (0x40000x04)
  * HVM-specific features
  * Sub-leaf 0: EAX: Features
  * Sub-leaf 0: EBX: vcpu id (iff EAX has XEN_HVM_CPUID_VCPU_ID_PRESENT flag)
+ * Sub-leaf 0: ECX: domain id (iff EAX has XEN_HVM_CPUID_DOMID_PRESENT flag)
  */
 #define XEN_HVM_CPUID_APIC_ACCESS_VIRT (1u << 0) /* Virtualized APIC registers */
 #define XEN_HVM_CPUID_X2APIC_VIRT      (1u << 1) /* Virtualized x2APIC accesses */
@@ -102,12 +112,16 @@
 #define XEN_HVM_CPUID_VCPU_ID_PRESENT  (1u << 3) /* vcpu id is present in EBX */
 #define XEN_HVM_CPUID_DOMID_PRESENT    (1u << 4) /* domid is present in ECX */
 /*
- * Bits 55:49 from the IO-APIC RTE and bits 11:5 from the MSI address can be
- * used to store high bits for the Destination ID. This expands the Destination
- * ID field from 8 to 15 bits, allowing to target APIC IDs up 32768.
+ * With interrupt format set to 0 (non-remappable) bits 55:49 from the
+ * IO-APIC RTE and bits 11:5 from the MSI address can be used to store
+ * high bits for the Destination ID. This expands the Destination ID
+ * field from 8 to 15 bits, allowing to target APIC IDs up 32768.
  */
 #define XEN_HVM_CPUID_EXT_DEST_ID      (1u << 5)
-/* Per-vCPU event channel upcalls */
+/*
+ * Per-vCPU event channel upcalls work correctly with physical IRQs
+ * bound to event channels.
+ */
 #define XEN_HVM_CPUID_UPCALL_VECTOR    (1u << 6)
 
 /*
-- 
2.25.1

