Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A55E660D23
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjAGJKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjAGJKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:10:36 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AA084615
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 01:10:35 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E43095C00F8;
        Sat,  7 Jan 2023 04:10:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 07 Jan 2023 04:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1673082631; x=1673169031; bh=FK
        nmdOzVKyy4kJvBw0IGAezSRAC3ERJEoigxCSqnGug=; b=m6VsE3BUrlajoN5ueg
        vZ3St5gMBp+f8AA0vN+wHs4a92eQPZzLpP76K2D8UFcVRjfqYp/pREE2urBNYsbY
        EbbhWX0cuk1Hqr9YXGAC0l8JrWDeyyi9F5/6lggFXWVPbwT8RsAzQEsaUl77SO4q
        YcsLFK1jXMOpkORWEuQlLplDr8DoyoFPMCeiInOX2BtZ0tj+ezE0TpSzw/nHGaLX
        LgLKWyqgxESMdHElIQ5gjKfZtBncafGjoXydDmNrVZwduQm5AEj3L4x7/EqKTX4O
        zIyJ4dyKN+edhTM47dkMAe16UUPV7cR3nrehaODwrGq87Oy0zx1Kd0gUdqgUbY7d
        fpyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1673082631; x=1673169031; bh=FKnmdOzVKyy4kJvBw0IGAezSRAC3
        ERJEoigxCSqnGug=; b=IB9KbeGD7Isjbc1Eokh4i+VTPBvpIknJu+J3RyGnkJH/
        uk8GPbCzJ0crQpqzQroofvNgFRUiZHubVpRQCU8TTwvwsbQvO18QAryGqLNpViTb
        2SlruqbfnE4kyB3yS6i/BpgWSOAPQshQy1ikfYe+dFfUg3A8X6C1i3I9Lrv/fg18
        aKmy+EiKugiesUpg5z1YGTDHUMpqRLXXv+GMMs5wjt++qcIcw35UoIot70drUfAn
        4qwVlG6lSUkQ+sHYEQFE4GQLehrBabVw02vb4HXomftLKjw2tiAauWSDZXbX+WAq
        vuG10b2MJq2dCNiuuajD/yM63IrEvOroEf3oWuJcBg==
X-ME-Sender: <xms:Bje5Y2t5nbBzt0reEKXFn5T7lryP0GtVAHwQI6-Q3M-Hrwg5pHQjlw>
    <xme:Bje5Y7fwvK60AJuvMQ6eBQyo8QJnq1Sj4u2bYSYGUzv_ka7W9RzTOe4-5EU8w6L4Q
    Ni6hoh42L68EHseQzI>
X-ME-Received: <xmr:Bje5YxxAy7h291sW2w0TSKoS0g6HtKQC-lPPDJV3AZqIyx2ynUR6YWumEA8tNNeeLMnQ6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkedugdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeduveeluefghfeugfegjeeffeduvedugfevtdeu
    keevkedtgefhjeejffdvueffjeenucffohhmrghinhepghgvthhushgvrhdrshgspdhpuh
    htuhhsvghrrdhssgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:Bje5YxPg1vAGEf1TjiYEhO_vMJL6Enq44lH3umHo4_pxwGM7v4gCLQ>
    <xmx:Bje5Y28-luDnRpVBE7JU5D-lMPuYsDFuYUf06XGAA6dMc9jpccztqQ>
    <xmx:Bje5Y5XrSu1P9Ocjv5B0YV0zyG3PCwzeZAscgjtIrf1EzRdHbwoh4Q>
    <xmx:Bze5Y50uGBkphq18InwAFlzHeyz5sajeIOGqZZyUXuok9955ihhQrQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Jan 2023 04:10:30 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8CF9D104373; Sat,  7 Jan 2023 12:10:27 +0300 (+03)
Date:   Sat, 7 Jan 2023 12:10:27 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv13 05/16] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Message-ID: <20230107091027.xbikgiizkeegofdd@box.shutemov.name>
References: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
 <20221227030829.12508-6-kirill.shutemov@linux.intel.com>
 <CAHk-=wgKTcOx1hhWAGJ-g9_9o7xiGJ9v9n2RskBSCkaUMBxDkw@mail.gmail.com>
 <20221231001029.5nckrhtmwahb65jo@box>
 <CAHk-=wgmGqwDD0kvjZxekU6uYR2x6+QgRHeMKy3snL2XYEzwEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgmGqwDD0kvjZxekU6uYR2x6+QgRHeMKy3snL2XYEzwEw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 04:42:05PM -0800, Linus Torvalds wrote:
> The one thing that that "shift by 63 and bitwise or" trick does
> require is that the _ASM_EXTABLE_UA() thing for getuser/putuser would
> have to have an extra annotation to shut up the
> 
>         WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in
> user access. Non-canonical address?");
> 
> in ex_handler_uaccess() for the GP trap that users can now cause by
> giving a non-canonical address with the high bit clear. So we'd
> probably just want a new EX_TYPE_* for these cases, but that still
> looks fairly straightforward.

Plain _ASM_EXTABLE() seems does the trick.

> Hmm?

Here's what I've come up with:

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index b70d98d79a9d..3e69e3727769 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -37,22 +37,22 @@
 
 #define ASM_BARRIER_NOSPEC ALTERNATIVE "", "lfence", X86_FEATURE_LFENCE_RDTSC
 
-#ifdef CONFIG_X86_5LEVEL
-#define LOAD_TASK_SIZE_MINUS_N(n) \
-	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rdx), \
-		    __stringify(mov $((1 << 56) - 4096 - (n)),%rdx), X86_FEATURE_LA57
-#else
-#define LOAD_TASK_SIZE_MINUS_N(n) \
-	mov $(TASK_SIZE_MAX - (n)),%_ASM_DX
-#endif
+.macro check_range size:req
+.if IS_ENABLED(CONFIG_X86_64)
+	mov %rax, %rdx
+	shr $63, %rdx
+	or %rdx, %rax
+.else
+	cmp $TASK_SIZE_MAX-\size+1, %eax
+	jae .Lbad_get_user
+	sbb %edx, %edx		/* array_index_mask_nospec() */
+	and %edx, %eax
+.endif
+.endm
 
 	.text
 SYM_FUNC_START(__get_user_1)
-	LOAD_TASK_SIZE_MINUS_N(0)
-	cmp %_ASM_DX,%_ASM_AX
-	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
-	and %_ASM_DX, %_ASM_AX
+	check_range size=1
 	ASM_STAC
 1:	movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -62,11 +62,7 @@ SYM_FUNC_END(__get_user_1)
 EXPORT_SYMBOL(__get_user_1)
 
 SYM_FUNC_START(__get_user_2)
-	LOAD_TASK_SIZE_MINUS_N(1)
-	cmp %_ASM_DX,%_ASM_AX
-	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
-	and %_ASM_DX, %_ASM_AX
+	check_range size=2
 	ASM_STAC
 2:	movzwl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -76,11 +72,7 @@ SYM_FUNC_END(__get_user_2)
 EXPORT_SYMBOL(__get_user_2)
 
 SYM_FUNC_START(__get_user_4)
-	LOAD_TASK_SIZE_MINUS_N(3)
-	cmp %_ASM_DX,%_ASM_AX
-	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
-	and %_ASM_DX, %_ASM_AX
+	check_range size=4
 	ASM_STAC
 3:	movl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -90,30 +82,17 @@ SYM_FUNC_END(__get_user_4)
 EXPORT_SYMBOL(__get_user_4)
 
 SYM_FUNC_START(__get_user_8)
-#ifdef CONFIG_X86_64
-	LOAD_TASK_SIZE_MINUS_N(7)
-	cmp %_ASM_DX,%_ASM_AX
-	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
-	and %_ASM_DX, %_ASM_AX
+	check_range size=8
 	ASM_STAC
+#ifdef CONFIG_X86_64
 4:	movq (%_ASM_AX),%rdx
-	xor %eax,%eax
-	ASM_CLAC
-	RET
 #else
-	LOAD_TASK_SIZE_MINUS_N(7)
-	cmp %_ASM_DX,%_ASM_AX
-	jae bad_get_user_8
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
-	and %_ASM_DX, %_ASM_AX
-	ASM_STAC
 4:	movl (%_ASM_AX),%edx
 5:	movl 4(%_ASM_AX),%ecx
+#endif
 	xor %eax,%eax
 	ASM_CLAC
 	RET
-#endif
 SYM_FUNC_END(__get_user_8)
 EXPORT_SYMBOL(__get_user_8)
 
@@ -166,7 +145,7 @@ EXPORT_SYMBOL(__get_user_nocheck_8)
 
 SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
 	ASM_CLAC
-bad_get_user:
+.Lbad_get_user:
 	xor %edx,%edx
 	mov $(-EFAULT),%_ASM_AX
 	RET
@@ -184,23 +163,23 @@ SYM_CODE_END(.Lbad_get_user_8_clac)
 #endif
 
 /* get_user */
-	_ASM_EXTABLE_UA(1b, .Lbad_get_user_clac)
-	_ASM_EXTABLE_UA(2b, .Lbad_get_user_clac)
-	_ASM_EXTABLE_UA(3b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(1b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(2b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(3b, .Lbad_get_user_clac)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE_UA(4b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(4b, .Lbad_get_user_clac)
 #else
-	_ASM_EXTABLE_UA(4b, .Lbad_get_user_8_clac)
-	_ASM_EXTABLE_UA(5b, .Lbad_get_user_8_clac)
+	_ASM_EXTABLE(4b, .Lbad_get_user_8_clac)
+	_ASM_EXTABLE(5b, .Lbad_get_user_8_clac)
 #endif
 
 /* __get_user */
-	_ASM_EXTABLE_UA(6b, .Lbad_get_user_clac)
-	_ASM_EXTABLE_UA(7b, .Lbad_get_user_clac)
-	_ASM_EXTABLE_UA(8b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(6b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(7b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(8b, .Lbad_get_user_clac)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE_UA(9b, .Lbad_get_user_clac)
+	_ASM_EXTABLE(9b, .Lbad_get_user_clac)
 #else
-	_ASM_EXTABLE_UA(9b, .Lbad_get_user_8_clac)
-	_ASM_EXTABLE_UA(10b, .Lbad_get_user_8_clac)
+	_ASM_EXTABLE(9b, .Lbad_get_user_8_clac)
+	_ASM_EXTABLE(10b, .Lbad_get_user_8_clac)
 #endif
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 32125224fcca..0ec57997a764 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -33,20 +33,20 @@
  * as they get called from within inline assembly.
  */
 
-#ifdef CONFIG_X86_5LEVEL
-#define LOAD_TASK_SIZE_MINUS_N(n) \
-	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rbx), \
-		    __stringify(mov $((1 << 56) - 4096 - (n)),%rbx), X86_FEATURE_LA57
-#else
-#define LOAD_TASK_SIZE_MINUS_N(n) \
-	mov $(TASK_SIZE_MAX - (n)),%_ASM_BX
-#endif
+.macro check_range size:req
+.if IS_ENABLED(CONFIG_X86_64)
+	movq %rcx, %rbx
+	shrq $63, %rbx
+	orq %rbx, %rcx
+.else
+	cmp $TASK_SIZE_MAX-\size+1, %ecx
+	jae .Lbad_put_user
+.endif
+.endm
 
 .text
 SYM_FUNC_START(__put_user_1)
-	LOAD_TASK_SIZE_MINUS_N(0)
-	cmp %_ASM_BX,%_ASM_CX
-	jae .Lbad_put_user
+	check_range size=1
 	ASM_STAC
 1:	movb %al,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -66,9 +66,7 @@ SYM_FUNC_END(__put_user_nocheck_1)
 EXPORT_SYMBOL(__put_user_nocheck_1)
 
 SYM_FUNC_START(__put_user_2)
-	LOAD_TASK_SIZE_MINUS_N(1)
-	cmp %_ASM_BX,%_ASM_CX
-	jae .Lbad_put_user
+	check_range size=2
 	ASM_STAC
 3:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -88,9 +86,7 @@ SYM_FUNC_END(__put_user_nocheck_2)
 EXPORT_SYMBOL(__put_user_nocheck_2)
 
 SYM_FUNC_START(__put_user_4)
-	LOAD_TASK_SIZE_MINUS_N(3)
-	cmp %_ASM_BX,%_ASM_CX
-	jae .Lbad_put_user
+	check_range size=4
 	ASM_STAC
 5:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -110,9 +106,7 @@ SYM_FUNC_END(__put_user_nocheck_4)
 EXPORT_SYMBOL(__put_user_nocheck_4)
 
 SYM_FUNC_START(__put_user_8)
-	LOAD_TASK_SIZE_MINUS_N(7)
-	cmp %_ASM_BX,%_ASM_CX
-	jae .Lbad_put_user
+	check_range size=8
 	ASM_STAC
 7:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32
@@ -144,15 +138,15 @@ SYM_CODE_START_LOCAL(.Lbad_put_user_clac)
 	RET
 SYM_CODE_END(.Lbad_put_user_clac)
 
-	_ASM_EXTABLE_UA(1b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(2b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(3b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(4b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(5b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(6b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(7b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(9b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(1b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(2b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(3b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(4b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(5b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(6b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(7b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(9b, .Lbad_put_user_clac)
 #ifdef CONFIG_X86_32
-	_ASM_EXTABLE_UA(8b, .Lbad_put_user_clac)
-	_ASM_EXTABLE_UA(10b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(8b, .Lbad_put_user_clac)
+	_ASM_EXTABLE(10b, .Lbad_put_user_clac)
 #endif
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
