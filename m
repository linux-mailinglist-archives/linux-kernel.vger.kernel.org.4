Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7299B64746A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiLHQhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiLHQhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:37:00 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5867E804
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:36:56 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id AB7BC5C2749
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:36:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 432425C26D7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:36:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670517414; a=rsa-sha256;
        cv=none;
        b=xOqOcKFIkSOrrgE3tUyKh7EqRfYjgQYqAt7K/JcRwCbZa99CnXHg4VXZLpZg5il9Y4euhg
        0xK908hpF4T/9XttBvZv5UlH5HgibH+q+xlhgx5FUVhH7iIOFyqgwTx3gRUYlKtxnWUURs
        89mB/CTFgvqABdIW2V+S0d6wMJfteOmtvFaOBqbBd/HFdLg08eVQy2x5+CAjtT9dTtl1Yy
        sNUtR5UIEy1FPvTLPzyFU4m34+HidoP9Zscpu87x0w93nBL4+ZzXdcWvSpXXqqmSy4alNt
        9FX0fV51HPDuNmbOIZ/HNgE3WNTlvLLbztJ0wikSJYqS+x0qq52EkBwMtby04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670517414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=bs74ZGYQ9FzRSVBX/TLanMiHEEc4YJIYzYEP749rubo=;
        b=vpeLPixtILnavoTo+WT2h2ekur2rbWeHCxi+DL8hwkfF7WVxJWwa78XE1xBdFlHNRsUDVK
        tpdB7PnQQlcjV37Ab38qK34KSUxc/bfYsuaD3aKj1BRfULPfw9X2ywPXDHvflR8mxLxb1v
        HyefjLTTgrNpR7q9DcecSfQvlyM2ki0EGJENKNEdH5ch9dsUu0hV7W+L3XaKRQtnDGcpDn
        ERaoBTCNQ8JV74Z+5L9VGCZ2VG2Xu1/uhFjiD415w4yCzCzeC7M439F/BRkYQpsFH2RZsA
        riJuOU3BxJ+jSatcEr7rG0WMrvO4Fb47HD2Kf7mgR9WkdnFBvfYoRfG8dSho8Q==
ARC-Authentication-Results: i=1;
        rspamd-d48c5ddb-vt8bg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Daffy-Company: 4b6091b91c0286ec_1670517414498_684180211
X-MC-Loop-Signature: 1670517414498:1686728700
X-MC-Ingress-Time: 1670517414497
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.106 (trex/6.7.1);
        Thu, 08 Dec 2022 16:36:54 +0000
Received: from kmjvbox (c-73-70-108-208.hsd1.ca.comcast.net [73.70.108.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4NSfts0lgkzK2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1670517413;
        bh=bs74ZGYQ9FzRSVBX/TLanMiHEEc4YJIYzYEP749rubo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=hESgpD/+OrzvH+6b1U6RKBOLOwJiqCQBT1mxoUxpUs5xzHKC70FZgmMfvPziG+V+t
         3eBIu2KxYLoGa8i9QQd0boR7+3sD213cNgI7PAkExFAk+o++TiclVLFHv5RyUUfOsd
         k+iXFBHCT0eW5xuSP4bTilUk6Bkr9itiOEoLNz5g=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e005f
        by kmjvbox (DragonFly Mail Agent v0.12);
        Thu, 08 Dec 2022 08:36:50 -0800
Date:   Thu, 8 Dec 2022 08:36:50 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
Subject: [PATCH linux-next] x86/xen/time: prefer tsc as clocksource when it
 is invariant
Message-ID: <20221208163650.GA3225@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kvm elects to use tsc instead of kvm-clock when it can detect that the
TSC is invariant.

(As of commit 7539b174aef4 ("x86: kvmguest: use TSC clocksource if
invariant TSC is exposed")).

Notable cloud vendors[1] and performance engineers[2] recommend that Xen
users preferentially select tsc over xen-clocksource due the performance
penalty incurred by the latter.  These articles are persuasive and
tailored to specific use cases.  In order to understand the tradeoffs
around this choice more fully, this author had to reference the
documented[3] complexities around the Xen configuration, as well as the
kernel's clocksource selection algorithm.  Many users may not attempt
this to correctly configure the right clock source in their guest.

The approach taken in the kvm-clock module spares users this confusion,
where possible.

Both the Intel SDM[4] and the Xen tsc documentation explain that marking
a tsc as invariant means that it should be considered stable by the OS
and is elibile to be used as a wall clock source.  The Xen documentation
further clarifies that this is only reliable on HVM and PVH because PV
cannot intercept a cpuid instruction.

In order to obtain better out-of-the-box performance, and reduce the
need for user tuning, follow kvm's approach and decrease the xen clock
rating so that tsc is preferable, if it is invariant, stable, and the
guest is a HVM or PVH domain.

[1] https://aws.amazon.com/premiumsupport/knowledge-center/manage-ec2-linux-clock-source/
[2] https://www.brendangregg.com/blog/2021-09-26/the-speed-of-time.html
[3] https://xenbits.xen.org/docs/unstable/man/xen-tscmode.7.html
[4] Intel 64 and IA-32 Architectures Sofware Developer's Manual Volume
    3b: System Programming Guide, Part 2, Section 17.17.1, Invariant TSC

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Code-reviewed-by: David Reaver <me@davidreaver.com>
---
 arch/x86/xen/time.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 9ef0a5cca96e..ca78581e4221 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -480,9 +480,22 @@ static void __init xen_time_init(void)
 	int cpu = smp_processor_id();
 	struct timespec64 tp;
 
-	/* As Dom0 is never moved, no penalty on using TSC there */
-	if (xen_initial_domain())
+	/*
+	 * As Dom0 is never moved, no penalty on using TSC there.
+	 *
+	 * If the guest has invariant tsc, then set xen_clocksource rating
+	 * below that of the tsc so that the system prefers tsc instead.  This
+	 * check excludes PV domains, because PV is unable to guarantee that the
+	 * guest's cpuid call has been intercepted by the hypervisor.
+	 */
+	if (xen_initial_domain()) {
 		xen_clocksource.rating = 275;
+	} else if ((xen_hvm_domain() || xen_pvh_domain()) &&
+	    boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
+	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
+	    !check_tsc_unstable()) {
+		xen_clocksource.rating = 299;
+	}
 
 	clocksource_register_hz(&xen_clocksource, NSEC_PER_SEC);
 
-- 
2.25.1

