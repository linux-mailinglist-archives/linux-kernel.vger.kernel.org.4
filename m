Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD216D4631
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjDCNu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjDCNu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:50:57 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170EB1DF80;
        Mon,  3 Apr 2023 06:50:20 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w13so10368655oik.2;
        Mon, 03 Apr 2023 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680529818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=InpwIkfzMfFKvnUynZiDQ4EYC27ogHEpEwT6lD5JTZU=;
        b=Q8xv2xnIMER0v9Il8wiCe/yWjZjrBQRXMgoZmxz+BNRL+naN1f34yfFTXhhqEUZo0n
         97mHDkYMAfPIQEilTAnjRqS/PBbBG8y9Htnoq/FqIG9G2Ocydmi7IALhiSSvK6PQ1/O0
         C5W+eUG/X9zXQiwklc5OY8vueJp6IirvRkL9gPrwlRPcUYPJtMaWLPlSN+v9TkkIGmU8
         yHkaZiX5nCsM5v8igTmMzPUSb0V+r+orKDy4/ak9c1+4o+8rr24WpHLeElYygqCHLpub
         uZ0JQlIt3Be8NtcU8EniYPhrpIXMOx5K1VN6+ck/EKqnnkCRD4FKtiBx1Dr7otugrHNV
         R/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680529818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InpwIkfzMfFKvnUynZiDQ4EYC27ogHEpEwT6lD5JTZU=;
        b=Sp0DD1PSnJtjbfTi6YaAP6+GsXABSUvVqYO6hGVZBBrGPZrrVgOwhWRmVbjiRMmPgw
         ItiEEawg3F+owaKG8lVaJKveazjSIn9qKbmbzH6s1hiLIzcDn7AZJ4rgQtz63hHrmSOE
         76+fSl1w4DdJS88nMH+DkgtvhnowatmtDw3457Y/AKzPTrAcBPm7u+BTpmYflKgaU3/o
         rsW7xWO1TlnqyVC9y4Y2ku2oSHfp7G/+zwXXwYrP9IqSgo4OxQunx+sO7VmcXYFCx9jG
         nj8RsZbhzVbyO6ZCIfYB6tDFGJ0QZegazjy7sLGE6+EUcSPZUlY2A4KD8vblqS1544cC
         f7DA==
X-Gm-Message-State: AAQBX9dc6nXHV3CXEBuDwPY5EqZsqNzr768QWmjnGh2Ml9P4ouHHktjW
        iMO5UmFrdkLE4wAAw9sU/uc=
X-Google-Smtp-Source: AKy350YvvRrZtco0zHUDCvnjm4ThL3hC+XGGBF0DyYSjuxDIy1FgOKbiwQt6y/aXCiCqhq32GpiN5g==
X-Received: by 2002:a54:4d01:0:b0:389:93da:f533 with SMTP id v1-20020a544d01000000b0038993daf533mr4847055oix.40.1680529818512;
        Mon, 03 Apr 2023 06:50:18 -0700 (PDT)
Received: from wedsonaf-dev ([189.124.190.154])
        by smtp.gmail.com with ESMTPSA id p20-20020a4a8e94000000b0049fd5c02d25sm4019354ook.12.2023.04.03.06.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:50:18 -0700 (PDT)
Date:   Mon, 3 Apr 2023 10:50:09 -0300
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 03/13] rust: lock: introduce `Mutex`
Message-ID: <ZCrZkUaoslXHpige@wedsonaf-dev>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
 <20230330043954.562237-3-wedsonaf@gmail.com>
 <20230330130108.GE124812@hirez.programming.kicks-ass.net>
 <ZCXZMNj7aOKbC7Ev@boqun-archlinux>
 <20230403082052.GR4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403082052.GR4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 10:20:52AM +0200, Peter Zijlstra wrote:
> On Thu, Mar 30, 2023 at 11:47:12AM -0700, Boqun Feng wrote:
> > On Thu, Mar 30, 2023 at 03:01:08PM +0200, Peter Zijlstra wrote:
> > > On Thu, Mar 30, 2023 at 01:39:44AM -0300, Wedson Almeida Filho wrote:
> > > > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > > > 
> > > > This is the `struct mutex` lock backend and allows Rust code to use the
> > > > kernel mutex idiomatically.
> > > 
> > > What, if anything, are the plans to support the various lockdep
> > > annotations? Idem for the spinlock thing in the other patch I suppose.
> > 
> > FWIW:
> > 
> > *	At the init stage, SpinLock and Mutex in Rust use initializers
> > 	that are aware of the lockdep, so everything (lockdep_map and
> > 	lock_class) is all set up.
> > 
> > *	At acquire or release time, Rust locks just use ffi to call C
> > 	functions that have lockdep annotations in them, so lockdep
> > 	should just work.
> > 
> 
> ffi is what the C++ world calls RAII ?

No, ffi is 'foreign function interface', it just means that the caller will use
the same ABI as the callee.

> But yes, I got that far, but I wondered about things like
> spin_lock_nested(&foo, SINGLE_DEPTH_NESTING) and other such 'advanced'
> annotations.
> 
> Surely we're going to be needing them at some point. I suppose you can
> do the single depth nesting one with a special guard type (or whatever
> you call that in the rust world) ?

I haven't looked at all the advanced annotations, but something like
spin_lock_nested/mutex_lock_nested can be exposed as a lock_nested() associated
function of the `Lock` type, so one would do:

  let guard = my_mutex.lock_nested(SINGLE_DEPTH_NESTING);
  // Do something with data protected by my_mutex.
