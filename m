Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C55E733184
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345409AbjFPMov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345332AbjFPMot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:44:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99663A9F;
        Fri, 16 Jun 2023 05:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qpu53mOY7RRIEjNXXhDmqiD0LTF9CHpHwhY0MHSooGI=; b=NJBD9eq0qytcPooOfyYz6SbYsj
        NTxGgJnTfjaOOpx34YiK/OxqeGEPcNOHfGrLzmjWmpjBZXIojuUsDv+oAnDx4UnZHaS7g12BfkWrO
        DDEL3lxlrLaI65WaUzNxMOnapXfBOagmkBV5VeYf7UX6JRhIgUceBjBdHNy5nUylD7xGOgZuXWcFw
        z0q48RvOammKk7ocZNMBmOLAwCnQGs8qMYViwwmLKX7dvGxN054enfmuO/9qwkJOLgZQKt8yWiKGG
        uErWyt1IRAGItvqVHCW42U0AIHaCJRTs0ZqnlH9LGFS986R1cxVIY8+jwrrP80MQ7Ise7xsZtCPrH
        At5oonzw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qA8o0-00Cv23-1s;
        Fri, 16 Jun 2023 12:43:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 960B03002F0;
        Fri, 16 Jun 2023 14:43:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 011E526A3BE90; Fri, 16 Jun 2023 14:43:54 +0200 (CEST)
Date:   Fri, 16 Jun 2023 14:43:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the block tree
Message-ID: <20230616124354.GD4253@hirez.programming.kicks-ass.net>
References: <20230327120017.6bb826d7@canb.auug.org.au>
 <20230327162630.wmxpycxhllt4clpt@treble>
 <20230328104719.65133586@canb.auug.org.au>
 <20230412073416.73a8ea1a@canb.auug.org.au>
 <20230411215518.u2fgi7napfcwyuce@treble>
 <4959d0b8-96fe-7fe5-8b36-7e0a266d1d17@kernel.dk>
 <20230412001400.yraku5fwsjdchxvk@treble>
 <20230412114400.GB628377@hirez.programming.kicks-ass.net>
 <20230412162517.gji52t34zlvcu5bh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412162517.gji52t34zlvcu5bh@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 09:25:17AM -0700, Josh Poimboeuf wrote:

> From: Josh Poimboeuf <jpoimboe@kernel.org>
> Subject: [PATCH] iov_iter: Mark copy_compat_iovec_from_user() noinline
> 
> After commit 6376ce56feb6 ("iov_iter: import single vector iovecs as
> ITER_UBUF"), GCC does an inter-procedural compiler optimization which
> moves the user_access_begin() out of copy_compat_iovec_from_user() and
> into its callers:
> 
>   lib/iov_iter.o: warning: objtool: .altinstr_replacement+0x0: redundant UACCESS disable
>   lib/iov_iter.o: warning: objtool: iovec_from_user.part.0+0xc7: call to copy_compat_iovec_from_user.part.0() with UACCESS enabled
>   lib/iov_iter.o: warning: objtool: __import_iovec+0x21d: call to copy_compat_iovec_from_user.part.0() with UACCESS enabled
> 
> Enforce the "no UACCESS enable across function boundaries" rule by
> disabling cloning for copy_compat_iovec_from_user().
> 
> Fixes: 6376ce56feb6 ("iov_iter: import single vector iovecs as ITER_UBUF")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> https://lkml.kernel.org/lkml/20230327120017.6bb826d7@canb.auug.org.au
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  lib/iov_iter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 274014e4eafe..48aa9fd99267 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1698,7 +1698,7 @@ const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
>  }
>  EXPORT_SYMBOL(dup_iter);
>  
> -static int copy_compat_iovec_from_user(struct iovec *iov,
> +static __noclone int copy_compat_iovec_from_user(struct iovec *iov,
>  		const struct iovec __user *uvec, unsigned long nr_segs)
>  {
>  	const struct compat_iovec __user *uiov =

I've been getting reports from some anonymous people still using ancient
GCCs (10.4) that also need the following:

---
Subject: iov_iter: Mark copy_iovec_from_user() noclone

Extend commit 50f9a76ef127 ("iov_iter: Mark
copy_compat_iovec_from_user() noinline") to also cover
copy_iovec_from_user(). Different compiler versions cause the same
problem on different functions.

lib/iov_iter.o: warning: objtool: .altinstr_replacement+0x1f: redundant UACCESS disable
lib/iov_iter.o: warning: objtool: iovec_from_user+0x84: call to copy_iovec_from_user.part.0() with UACCESS enabled
lib/iov_iter.o: warning: objtool: __import_iovec+0x143: call to copy_iovec_from_user.part.0() with UACCESS enabled

Fixes: 50f9a76ef127 ("iov_iter: Mark copy_compat_iovec_from_user() noinline")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 960223ed9199..061cc3ed58f5 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1795,7 +1795,7 @@ static __noclone int copy_compat_iovec_from_user(struct iovec *iov,
 	return ret;
 }
 
-static int copy_iovec_from_user(struct iovec *iov,
+static __noclone int copy_iovec_from_user(struct iovec *iov,
 		const struct iovec __user *uiov, unsigned long nr_segs)
 {
 	int ret = -EFAULT;
