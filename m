Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0936FFB71
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 22:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbjEKUqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 16:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbjEKUqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 16:46:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6126F1FE9;
        Thu, 11 May 2023 13:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1cBnKP6x3Oe+QiiIUb/zcPaFkM9YzXjlJtvjbfIDgbg=; b=nU6C9AwWRVAbDSBPEEDGlx/OwE
        LDN5tEOg0813QECZ6Q8ONLOc9wGeB3jZxWn70JlQXAnflZ2MWNa+IxvHwRGxnGG4JGr6a3x7DFFiZ
        4h7wC5ij5dR9WskO0nTLSV/8EqxpmRNSECAhfMWQbbsohcANJ2SMUGTxWySccy72pBUlqL7+bIJk0
        wq0RKQBFfHeq+SLdnY6wGXj0FNe/u1uzZCO67XuYpqMADugUq3vPM+XPEIt83bZKr6N485ic0y+Ph
        IEVFm+nYcXKhQs4VRsNOBx8JAWnWzGzuJxphaeLcDHb7piSx+x8oFTU7frlGskabSq/1rfNpGz5o3
        msb+PwwA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxDBK-008O30-0N;
        Thu, 11 May 2023 20:46:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78C92300244;
        Thu, 11 May 2023 22:46:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55F8A2C7DB755; Thu, 11 May 2023 22:46:33 +0200 (CEST)
Date:   Thu, 11 May 2023 22:46:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH locking/atomic 18/19] locking/atomic: Refrain from
 generating duplicate fallback kernel-doc
Message-ID: <20230511204633.GF2296992@hirez.programming.kicks-ass.net>
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
 <20230510181717.2200934-18-paulmck@kernel.org>
 <ZF0haDfyL3At3Ijw@FVFF77S0Q05N.cambridge.arm.com>
 <20230511193856.GA2296992@hirez.programming.kicks-ass.net>
 <c619d689-e7b5-4136-9bd3-8f41954f43cd@paulmck-laptop>
 <20230511200142.GC2296992@hirez.programming.kicks-ass.net>
 <613a2d06-30f1-4140-aa6c-16d5298d9909@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <613a2d06-30f1-4140-aa6c-16d5298d9909@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 01:25:18PM -0700, Paul E. McKenney wrote:
> On Thu, May 11, 2023 at 10:01:42PM +0200, Peter Zijlstra wrote:
> > On Thu, May 11, 2023 at 12:53:46PM -0700, Paul E. McKenney wrote:
> > > Do you have an alternative suggestion for generating the kernel-doc?
> > > The current lack of it is problematic.
> > 
> > I've never found a lack of kernel-doc to be a problem. And I'm very much
> > against complicating the scripts to add it.
> 
> I am sure that you have not recently found the lack of kernel-doc for
> the atomic operations to be a problem, given that you wrote many of
> these functions.

Sure; but I meant in general -- I've *never* used kernel-doc. Comments I
occasionally read, and sometimes they're not even broken either, but
kernel-doc, nope.

> OK, you mentioned concerns about documentation people nitpicking.  This
> can be dealt with.  The added scripting is not that large or complex.
> 
> > Also, there's Documentation/atomic_t.txt
> 
> Yes, if you very carefully read that document end to end, correctly
> interpreting it all, you will know what you need to.  Of course, first
> you have to find it.  And then you must avoid any lapses while reading
> it while under pressure.  Not particularly friendly to someone trying
> to chase a bug.

It's either brief and terse or tediously long -- I vastly prefer the
former, my brain can much better parse structure than English prose.

Also, I find, pressure is never conductive to anything, except prehaps
cooking rice and steam trains (because nothing is as delicous as a
pressure cooked train -- oh wait).

Add enough pressure and the human brain reduces to driven and can't read
even the most coherent of text no matter how easy to find.

In such situations it's for the manager to take the pressure away and
the engineer to think in relative peace.
