Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B774745ABF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjGCLEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCLET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:04:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124F5D2;
        Mon,  3 Jul 2023 04:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=03s2CTOBPsHxXr3YvCrlnEAntgxBtCRafB6H4CGjacw=; b=F7JSqiAe4tKea0RQsgYLJLbUKs
        TA9ntQiucp5EJ5wXD/iJmAG+UF/ZB4BbHfRkblCWE11xjX/wiR4EOZ1mUPw9B9EvauKfBxOeLmTC5
        NGZycnuqUf8FXYzSM7p8y9vIFs/bdnX3zN5hAzBnz1HGa8Ep6MfAbn3e1s8wCeGUoRb75oxEhFE2W
        ekUCeW9dmMA0ZmZUzBV/iKIVZEbPVULWjvNEnC33s7FnsMhLeyxpCJfNa1GGwzJFnWRv+TEih1cpv
        uVAjNj+3wKoGow/tBGxZavR5TGfpm9saVkPvatfkVh2iyT40L7nYZ/97tvzOP7zsVWWHTzsW7MqxJ
        CNkOur9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGHLj-00A4F6-1N;
        Mon, 03 Jul 2023 11:04:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 71AF530005E;
        Mon,  3 Jul 2023 13:04:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C9BD202A2A17; Mon,  3 Jul 2023 13:04:05 +0200 (CEST)
Date:   Mon, 3 Jul 2023 13:04:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the block tree
Message-ID: <20230703110405.GU38236@hirez.programming.kicks-ass.net>
References: <20230327120017.6bb826d7@canb.auug.org.au>
 <20230327162630.wmxpycxhllt4clpt@treble>
 <20230328104719.65133586@canb.auug.org.au>
 <20230412073416.73a8ea1a@canb.auug.org.au>
 <20230411215518.u2fgi7napfcwyuce@treble>
 <4959d0b8-96fe-7fe5-8b36-7e0a266d1d17@kernel.dk>
 <20230412001400.yraku5fwsjdchxvk@treble>
 <20230412114400.GB628377@hirez.programming.kicks-ass.net>
 <20230412162517.gji52t34zlvcu5bh@treble>
 <20230616124354.GD4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616124354.GD4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 02:43:55PM +0200, Peter Zijlstra wrote:

> I've been getting reports from some anonymous people still using ancient
> GCCs (10.4) that also need the following:

Jens, will you pick this up or should I route it through the objtool
tree?

> ---
> Subject: iov_iter: Mark copy_iovec_from_user() noclone
> 
> Extend commit 50f9a76ef127 ("iov_iter: Mark
> copy_compat_iovec_from_user() noinline") to also cover
> copy_iovec_from_user(). Different compiler versions cause the same
> problem on different functions.
> 
> lib/iov_iter.o: warning: objtool: .altinstr_replacement+0x1f: redundant UACCESS disable
> lib/iov_iter.o: warning: objtool: iovec_from_user+0x84: call to copy_iovec_from_user.part.0() with UACCESS enabled
> lib/iov_iter.o: warning: objtool: __import_iovec+0x143: call to copy_iovec_from_user.part.0() with UACCESS enabled
> 
> Fixes: 50f9a76ef127 ("iov_iter: Mark copy_compat_iovec_from_user() noinline")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 960223ed9199..061cc3ed58f5 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1795,7 +1795,7 @@ static __noclone int copy_compat_iovec_from_user(struct iovec *iov,
>  	return ret;
>  }
>  
> -static int copy_iovec_from_user(struct iovec *iov,
> +static __noclone int copy_iovec_from_user(struct iovec *iov,
>  		const struct iovec __user *uiov, unsigned long nr_segs)
>  {
>  	int ret = -EFAULT;
