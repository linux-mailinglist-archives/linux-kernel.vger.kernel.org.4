Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF43B70F723
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbjEXNCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjEXNB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:01:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BCDE5D;
        Wed, 24 May 2023 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Gs6521OAO55Ps5HZd1+Z4biYP4c4WIEJ9jEhOQwydU0=; b=nO3w9Q7Mr3fqYdBaXMcymquAWx
        qTQ02SlNsSE+F751/qcyvNknrxZX86mO2fC/2CUosdGtplMnnVxemmNl6u3Uig9rlZOSI1/0hpeGH
        PengW+/XcNaqjEoDkqIuIJGN9ZUoEWTx9bfemcwrq7NWs98z3TR2OsevWYIW1d47hwhWoIbWFJMN4
        1eHm4vr89Qcp33EJHItWjxVT5OLJSEguR5yeIq+6wAEJoctOvVKDZOWPO/ZJMJwrA/vkvdI8Kq7m1
        cYliOmotZ/UWVU7qMNwN6wBwnDZXbs/hWCv44UcihXEc7JlvtduuJu69NAD/8+D+FxZd4GcOgQ0cL
        l+dbnS+g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q1o71-00BDYy-GX; Wed, 24 May 2023 13:01:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 151AA3002C5;
        Wed, 24 May 2023 15:01:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7DBC20A99318; Wed, 24 May 2023 15:01:04 +0200 (CEST)
Date:   Wed, 24 May 2023 15:01:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, x86@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        clang-built-linux <llvm@lists.linux.dev>
Subject: Re: next: i386-boot: clang-nightly: failed - intermittently - BUG:
 unable to handle page fault for address: 000024c0
Message-ID: <20230524130104.GR83892@hirez.programming.kicks-ass.net>
References: <CA+G9fYvhPgoP57ip1cW5TaWJfkbkHA2SZqd5fFoTJ7rDGA138w@mail.gmail.com>
 <CAKwvOdkABkajMqBS=xcHxXUTQGXbTN3tj1GcPqpGgGkmAGLkDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdkABkajMqBS=xcHxXUTQGXbTN3tj1GcPqpGgGkmAGLkDA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 11:11:51AM -0700, Nick Desaulniers wrote:
> On Wed, May 17, 2023 at 8:21 AM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > Linux next-20230517 build with clang nightly for i386 boot fails intermittently.
> 
> Keyword: intermittently. That will make tracking this down fun.
> 
> Our CI also hit a boot failure on tip/master with the same splat:
> https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/4998374271/jobs/8957285746
> Though the CI pulled down a SHA
> 0932447780e1f9a43bf68ef7fe3d9b41b46d58fc
> which looks weird on
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=0932447780e1f9a43bf68ef7fe3d9b41b46d58fc
> >> Notice: this object is not reachable from any branch.

Github isn't willing to show me content unless I log in or somesuch
nonsense.

> That this failed in -next and -tip in the same way makes me wonder if
> something affecting this is coming in via -tip? Maybe the splat looks
> familiar to x86 folks?
> 
> I haven't been able to reproduce locally when my machine is relatively
> load-less.  If I do a kernel build in the background, I was able to
> get QEMU to hang, but without any splat. That was using tip/master @
> f81d8f759e7f.
> 
> Naresh, when you say "intermittent" do you have any data on the
> relative frequency of this boot failure? (Also, please make sure to
> use llvm@lists.linux.dev in the future; we moved mailing lists years
> ago).
> 
> Looks like our CI report linked above has an additional splat though
> via apply_alternatives and optimize_nops.
> 
> >> [ 0.166742] Code: Unable to access opcode bytes at 0x36.
> 
> Peter, that smells like perhaps either:
> commit b6c881b248ef ("x86/alternative: Complicate optimize_nops() some more")
> commit 6c480f222128 ("x86/alternative: Rewrite optimize_nops() some")

So I did find me a 'funny' there, but nothing that explains boot fail.

It would think that 'PAUSE' is a 2 byte NOP and replace it with NOP2;
which is not quite the same thing. The below seems to cure that.

Let me continue poking at things...

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 93aa95afd005..bb0a7b03e52f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -159,9 +160,12 @@ void text_poke_early(void *addr, const void *opcode, size_t len);
  */
 static bool insn_is_nop(struct insn *insn)
 {
-	if (insn->opcode.bytes[0] == 0x90)
+	/* Anything NOP, but not REP NOP. */
+	if (insn->opcode.bytes[0] == 0x90 &&
+	    (!insn->prefixes.nbytes || insn->prefixes.bytes[0] != 0xF3))
 		return true;
 
+	/* NOPL */
 	if (insn->opcode.bytes[0] == 0x0F && insn->opcode.bytes[1] == 0x1F)
 		return true;
 
