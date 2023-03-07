Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBC96AEC25
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjCGRws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjCGRwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:52:13 -0500
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AB8A590E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1678211209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bThcQUepZJ0AWbiq81304KDQsqbf5ZE9+QOw1395iBE=;
  b=Cz57Rh2+xV3i0OIUS8SMAIDMBDHTLnt59Bil6tKDZ7d6GQeJmQE6JF6L
   GWqWM9GyTQ79Ppol7EW+/RrnWLDd/KpAVfRILyfHA+em++EQDnwRqW+4B
   r5CHi4nVN/DGAWNlqIb+aPdCv65vQJJHIwAuGW6ONNFthqulhyZ9PldTM
   4=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 99882543
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:1GyuV6P8xvI7JWrvrR0nl8FynXyQoLVcMsEvi/4bfWQNrUpwhWdTz
 zBJUGuHO6neZjOjeYp2O4jj9B9VuZHcxtEyTAto+SlhQUwRpJueD7x1DKtS0wC6dZSfER09v
 63yTvGacajYm1eF/k/F3oDJ9CU6jufQAOKnUoYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE/
 Nj/uKUzAnf8s9JPGj9SuvLrRC9H5qyo42tD5gNmP5ingXeF/5UrJMNHTU2OByOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq/0Te5p0TJvsEAXq7vh3S9zxHJ
 HehgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/ZqAJGpfh66wGMa04AWEX0utaKFNsq
 aUVESoESxqoque7mq2VEfY506zPLOGzVG8eknRpzDWfBvc6W5HTBa7N4Le03h9p2JoIR6yHI
 ZNEN3w2Nk+ojx5nYz/7DLoXmuuyi2a5WDpfsF+P/oI84nTJzRw327/oWDbQUo3bFZUPwxrDz
 o7A10epHxYAKNiH9X3G/C+GvrWSsD3CBJ1HQdVU8dY12QbOlwT/EiY+UVq9vOn8iUOkXd9bA
 1Ib9zBorqUo8kGvCN7nUHWQvHeavwUbc9VVGuw+rgqKz8L8/wmdFkAATzhcdMYhss4mAzAnv
 neMntXmAhR1vbGVQG7b/bCRxRu4IQAcKW4PY39CQQZty9Xqvox1jhvJVdtlOKq0iMDlXzD23
 z2O6iM5gt07nZ5V/6a251bKh3SrvJehZg4t7y3FT36i9EVyY4vNT4Wt7l7S7vFeBIeCVkOIp
 z4ehqCjAPsmVM/X0nbXGaNUQe/vvqzeWNHBvbJxN5QM3gaPpyeuRJpZxTtVCUJkaNkqIiC8N
 Sc/pjhtzJNUOXKra4p+bISwF9kmwMDcKDj1ahzHRoEQO8YsLWdr6AkrPBfNhD61zCDAhIllY
 f+mndCQ4WH24EiN5B6/XK8j3LAi3UjSLkuDFMmgn3xLPVdzDUN5qIvp0nPUM4jVD4ve+m05F
 uqz0OPboyizqMWkPkHqHXc7dDjm10QTC5HssNBwfeWeOAdgE2xJI6aPnuN4IdM6x/kOyrugE
 pSBtqhwkgeXuJE6AV/SNiALhE3HB/6TUk7XzQRzZA31ihDPkK6k7bsFdotfQFXU3LUL8BKAd
 NFcI5/oKq0WGlz6F8E1McGVQHpKKE762mpj/kONPFACQnKXb1eUpYW+JlS0rXNm4+jenZJWn
 oBMHzjzGfIrLzmOxu6MAB5z5ztdZUQgpd8=
IronPort-HdrOrdr: A9a23:AwEHsqqPAL8gs5jXehG7iikaV5vML9V00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssSkb6La90dq7MArhHP9OkP4s1NKZMDUO11HYSL2KgbGC/9SCIVyJygc+79
 YGT0EWMrSZYjZHZK3BkWqF+qMbsby6GdeT9IXjJhlWLT1CWuVF1UNUGwybGkp5SE1tHpwiDq
 eR4cJBun6JZWkXRt7TPAhMY8Hz4/nw0L72ax8PABAqrCOUiymz1bL8Gx+Emj8DTjJ0x6s4+2
 StqX2z2kzjiYDw9vbv7R6e031koqqv9jKFPr3DtiEhEESgtu9vXvUhZ1TNhkF0nAjl0idTrD
 CFmWZaAy000QKZQoj9m2qW5yDwlDkp8HPs0lmenD/qptH4XiszD45biZteaQax0TtTgDhQ6t
 M644uijeslMTrQ2CDmo9TYXRBjkUS55XIkjO4IlnRaFY8TcqVYo4AT9F5cVM5oJlOP1Kk3VO
 11SM3M7vdfdl2XK3jfo2l02dSpGnA+BA2PTEQOstGclzJWgHd6xU0Fw9F3pAZ0yLstD51fo+
 jUOKVhk79DCscQcKJmHe8EBdC6D2TcKCi8QV564W6Xap3vF0i91KIfuo9Fmd1CUKZ4sKcPpA
 ==
X-IronPort-AV: E=Sophos;i="5.98,241,1673931600"; 
   d="scan'208";a="99882543"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Tavis Ormandy <taviso@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH] x86/amd: Work around Erratum 1386 - XSAVES malfunction on context switch
Date:   Tue, 7 Mar 2023 17:46:43 +0000
Message-ID: <20230307174643.1240184-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Erratum 1386 is summarised as:

  XSAVES Instruction May Fail to Save XMM Registers to the Provided
  State Save Area

This piece of accidental chronomancy causes the %xmm registers to
occasionally reset back to an older value.

Ignore the XSAVES feature on all AMD Zen1/2 hardware.  The XSAVEC
instruction (which works fine) is equivalent on affected parts.

Reported-by: Tavis Ormandy <taviso@gmail.com>
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
CC: Tavis Ormandy <taviso@gmail.com>
CC: Alexander Monakov <amonakov@ispras.ru>

Only compile tested.

This wants backporting to all stable trees that understand XSAVES, but
before 5.19(?) needs the XSAVEC support backporting too...
---
 arch/x86/kernel/cpu/amd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 380753b14cab..f3a4bb479fd5 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -890,6 +890,17 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 	node_reclaim_distance = 32;
 #endif
 
+	/*
+	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
+	 * certain circumstances on Zen1/2 uarch, and not all parts have had
+	 * updated microcode at the time of writing (March 2023).
+	 *
+	 * Affected parts all have no supervisor XSAVE states, meaning that
+	 * the XSAVEC instruction (which works fine) is equivelent.
+	 */
+	if (c->x86 == 0x17)
+		clear_cpu_cap(c, X86_FEATURE_XSAVES);
+
 	/* Fix up CPUID bits, but only if not virtualised. */
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 
-- 
2.30.2

