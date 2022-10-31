Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80C1613353
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiJaKLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiJaKLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:11:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292C6DED3;
        Mon, 31 Oct 2022 03:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oYiGTrq5J1dOadLc8Mo/LeUNJ8vMn/fd6dYj/vEpKvI=; b=H0OlndsHp9kAOs6Cyfv2Zzqalt
        qyjHmVBCnPLDsNhMHikzlqDZ5Lf41z8ZRlqOLE5zS1w+ykmJ+M4nSQuv3KVuzd44z3R/TWj1C0vb+
        Z9vGw7Zksu9Z9KQbnn3w7tVcDM5R1vPVYBFGzIFKA4tBR3g7XlyiV1KmR2KA5hptcKS9leiLBNtte
        Q5rvM6wJy5DrEKihCgbWszuFS8gEUsndyxcpraXbKz2NrE89XIx2E6LYIbhnEaLctuqGTx6X1+xFr
        I7Q4M3/eOxkE9ZudwcNrd+C5wwSuUE1bAFCfJAs7RWMBxFYq7Tju2i+Wk73FOfje3uojp9IxtRlks
        kbu3biEw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opRku-007qNr-Hs; Mon, 31 Oct 2022 10:10:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1BCC130013F;
        Mon, 31 Oct 2022 11:10:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F1AB62010F55F; Mon, 31 Oct 2022 11:10:55 +0100 (CET)
Date:   Mon, 31 Oct 2022 11:10:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reference to non-existing CONFIG_X86_FEATURE_CALL_DEPTH
Message-ID: <Y1+fL4qQEIGZEEKB@hirez.programming.kicks-ass.net>
References: <CAKXUXMx3cgTA66h_ezNTqyVo_Oa-Q0H=FeBM64zntZ4E0YCT6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMx3cgTA66h_ezNTqyVo_Oa-Q0H=FeBM64zntZ4E0YCT6g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:14:03AM +0100, Lukas Bulwahn wrote:
> Dear Thomas, dear Peter,
> 
> in your work on call depth tracking mitigation, commit 5d8213864ade
> ("x86/retbleed: Add SKL return thunk") on linux-next references the
> configuration symbol CONFIG_X86_FEATURE_CALL_DEPTH, which is not
> introduced in any Kconfig file.
> 
> Is this just some left-over from some previous iteration of this
> feature or is there still a patch to come that will introduce that
> configuration symbol in some Kconfig file?
> 
> This issue was identified with ./scripts/checkkconfigsymbols.py.

Thanks!

---
Subject: x86: Unconfuse CONFIG_ and X86_FEATURE_ namespaces
From: Peter Zijlstra <peterz@infradead.org>

Lukas reported someone fat fingered the CONFIG_ symbol; fix er up.

Fixes: 5d8213864ade ("x86/retbleed: Add SKL return thunk") 
Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 82580adbca4b..3ab90f23e7f7 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -285,7 +285,7 @@
  */
 .macro UNTRAIN_RET
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
-	defined(CONFIG_X86_FEATURE_CALL_DEPTH)
+	defined(CONFIG_CALL_DEPTH_TRACKING)
 	ANNOTATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
@@ -296,7 +296,7 @@
 
 .macro UNTRAIN_RET_FROM_CALL
 #if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
-	defined(CONFIG_X86_FEATURE_CALL_DEPTH)
+	defined(CONFIG_CALL_DEPTH_TRACKING)
 	ANNOTATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
