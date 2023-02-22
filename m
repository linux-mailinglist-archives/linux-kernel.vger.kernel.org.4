Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E7369FA8A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjBVRyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjBVRyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:54:50 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38203CE10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:54:49 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7ADD85C20EC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:54:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1B0A25C220A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:54:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677088487; a=rsa-sha256;
        cv=none;
        b=nctrzUK76VOvXeO7zHsAKPayMCSKTL7CKSXUViMaTmhWtI1HHpw41CLL9tdtT+x0J6EqnJ
        ixAQJWbmCgL/lG7WwuASmkan4sEXRK33kkOTDcm15GdXSgpUwoKOrCKfRHtc9ruNfP9f2R
        +eLINy21XKajNeTmjBRKW+M+2mMdH/LA6Sx9RyTpk8RTPZOKEG8RaC50ndLf7gUGqHakOG
        /R8/jDoGe1/XChR8gU4oY8AI50CJfklFN2LuRjFwl+VRwfB9z1Sr6Fm+pJdAE+zXelmfR6
        DlBSvZdpfZaxhOpgwcz5kgiGAkRqCR0Y+oXVVUjOSmjQbTea6rSAiucyCZrAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677088487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=jPLOaJx1XC+xepUu7FtXLYzyt2YPI1cX/q7Jp4OSr1s=;
        b=TgQVHRddwVMproX+4/ztTf4A2wTDDMNKZyEmYD1NaY66Al0OGkr8oxFgE5TXQOPfjJBU3H
        hRx2YB5ZKcY5FJRxr81o07dPwop6Y21lOg8AYvcjjq3YkMX1/0sRTO28TY+DKbwCHl7cqh
        QpMUUUJ7aGV5s5g5Gr0twH6BzEGr9v8X4VzSoXJkD967OeOVhFVa1cBEZTglAnQptkHnCa
        JbKS29MYPbTuaghLTkw/5YGCaEfve1960o+q4Y6Gk+dhycTtazEHexjfJm3/oFe5dgl+jb
        xm96M4EHrROxNRmZUkOdCWKqXPqhUPfkZ0HRfcEU9t16UxTuAhoApVVlVY17hQ==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-ngd69;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Fumbling-Shelf: 27a17fbf61ced001_1677088487351_811464493
X-MC-Loop-Signature: 1677088487351:901770116
X-MC-Ingress-Time: 1677088487351
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.87 (trex/6.7.1);
        Wed, 22 Feb 2023 17:54:47 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4PMP1f0223z1Nt
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1677088486;
        bh=jPLOaJx1XC+xepUu7FtXLYzyt2YPI1cX/q7Jp4OSr1s=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=PfqaKgwb9Q4qCwAI1hyYXJ6QTsFQmaVjcqQhOuxkDWs6+Lc5zIuwbbdBrcC/TRPby
         Ar73uyNbaXjOlnoBre1syBaNtMH30moy0JonO+0NnnIZ875rLx06BR4iwgvqoSr09Q
         7ksNIwhFpnxWrhxMICs3B/fqy9DDqAS2Ah8+3XUo=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e004a
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 22 Feb 2023 09:54:42 -0800
Date:   Wed, 22 Feb 2023 09:54:42 -0800
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
Subject: [PATCH linux-next v2 1/2] xen: update
 arch/x86/include/asm/xen/cpuid.h
Message-ID: <94b9046dd0db3794f0633d134b7108508957758d.1677038165.git.kjlx@templeofstupid.com>
References: <cover.1677038165.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677038165.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
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

