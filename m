Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE3A6A4586
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjB0PEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjB0PEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:04:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930021DB88
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:04:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3065D60DC1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 15:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B72C4339B;
        Mon, 27 Feb 2023 15:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677510277;
        bh=Kx97Ns8PMv+vXJT8MoJzzZibJ4eRFFFU1qfgwou49sU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TzE6LrYuzO2f6RdP8E1/kkTkMYMuuedKwkMdHQ+wpyNoP5T0pjSUby3Ng4/ZXsRIV
         s7ZuymPgCTyV1M/ZWJGAzTerBEdt1D2Vo/2Rp8CPQYMUJ5hAEdk0gTw4AiGO8uC9WR
         R3+Ylul9PmaSCTBWkHPFyo97deWBZA7vzAtLm+4D3dguuUasbxg28x9SICC1DmuAhw
         YHD2drG9SzF7iZwfh6O8K+vQ9W7/Ttkh/m8KvY3XuUQtTPHol+4oWhNwgDZLFkaMjS
         zc3vw+Hu5dperheTVeb2hIFX2tZun3oO9yHMkS/mu5GQmhp04Xl6q4VpJ2gKswyc5r
         Pz96XCohUgGjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 284D65C019D; Mon, 27 Feb 2023 07:04:37 -0800 (PST)
Date:   Mon, 27 Feb 2023 07:04:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] instrumented.h: fix all kernel-doc format warnings
Message-ID: <20230227150437.GE2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230227011700.23947-1-rdunlap@infradead.org>
 <CANpmjNNmnRNos4ZtQrHuf3o4-hmN3nCEo-FDGdMPRo=JiJwWEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNmnRNos4ZtQrHuf3o4-hmN3nCEo-FDGdMPRo=JiJwWEw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 09:12:53AM +0100, Marco Elver wrote:
> On Mon, 27 Feb 2023 at 02:17, Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > Fix 26 kernel-doc notation warnings by converting the function
> > documentation to kernel-doc format.
> >
> > Warning example:
> >
> > instrumented.h:155: warning: Function parameter or member 'to' not described in 'instrument_copy_from_user_after'
> > instrumented.h:155: warning: Function parameter or member 'from' not described in 'instrument_copy_from_user_after'
> > instrumented.h:155: warning: Function parameter or member 'n' not described in 'instrument_copy_from_user_after'
> > instrumented.h:155: warning: Function parameter or member 'left' not described in 'instrument_copy_from_user_after'
> >
> > Fixes: 36e4d4dd4fc4 ("include/linux: Add instrumented.h infrastructure")
> > Fixes: 00047c2e6d7c ("instrumented.h: Introduce read-write instrumentation hooks")
> > Fixes: 33b75c1d884e ("instrumented.h: allow instrumenting both sides of copy_from_user()")
> > Fixes: 888f84a6da4d ("x86: asm: instrument usercopy in get_user() and put_user()")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Alexander Potapenko <glider@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> 
> Reviewed-by: Marco Elver <elver@google.com>
> 
> Thanks for the fixes.

I pulled this in for v6.4, thank you both!

							Thanx, Paul

> > ---
> >  include/linux/instrumented.h |   63 +++++++++++++--------------------
> >  1 file changed, 26 insertions(+), 37 deletions(-)
> >
> > diff -- a/include/linux/instrumented.h b/include/linux/instrumented.h
> > --- a/include/linux/instrumented.h
> > +++ b/include/linux/instrumented.h
> > @@ -15,12 +15,11 @@
> >
> >  /**
> >   * instrument_read - instrument regular read access
> > + * @v: address of access
> > + * @size: size of access
> >   *
> >   * Instrument a regular read access. The instrumentation should be inserted
> >   * before the actual read happens.
> > - *
> > - * @ptr address of access
> > - * @size size of access
> >   */
> >  static __always_inline void instrument_read(const volatile void *v, size_t size)
> >  {
> > @@ -30,12 +29,11 @@ static __always_inline void instrument_r
> >
> >  /**
> >   * instrument_write - instrument regular write access
> > + * @v: address of access
> > + * @size: size of access
> >   *
> >   * Instrument a regular write access. The instrumentation should be inserted
> >   * before the actual write happens.
> > - *
> > - * @ptr address of access
> > - * @size size of access
> >   */
> >  static __always_inline void instrument_write(const volatile void *v, size_t size)
> >  {
> > @@ -45,12 +43,11 @@ static __always_inline void instrument_w
> >
> >  /**
> >   * instrument_read_write - instrument regular read-write access
> > + * @v: address of access
> > + * @size: size of access
> >   *
> >   * Instrument a regular write access. The instrumentation should be inserted
> >   * before the actual write happens.
> > - *
> > - * @ptr address of access
> > - * @size size of access
> >   */
> >  static __always_inline void instrument_read_write(const volatile void *v, size_t size)
> >  {
> > @@ -60,12 +57,11 @@ static __always_inline void instrument_r
> >
> >  /**
> >   * instrument_atomic_read - instrument atomic read access
> > + * @v: address of access
> > + * @size: size of access
> >   *
> >   * Instrument an atomic read access. The instrumentation should be inserted
> >   * before the actual read happens.
> > - *
> > - * @ptr address of access
> > - * @size size of access
> >   */
> >  static __always_inline void instrument_atomic_read(const volatile void *v, size_t size)
> >  {
> > @@ -75,12 +71,11 @@ static __always_inline void instrument_a
> >
> >  /**
> >   * instrument_atomic_write - instrument atomic write access
> > + * @v: address of access
> > + * @size: size of access
> >   *
> >   * Instrument an atomic write access. The instrumentation should be inserted
> >   * before the actual write happens.
> > - *
> > - * @ptr address of access
> > - * @size size of access
> >   */
> >  static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
> >  {
> > @@ -90,12 +85,11 @@ static __always_inline void instrument_a
> >
> >  /**
> >   * instrument_atomic_read_write - instrument atomic read-write access
> > + * @v: address of access
> > + * @size: size of access
> >   *
> >   * Instrument an atomic read-write access. The instrumentation should be
> >   * inserted before the actual write happens.
> > - *
> > - * @ptr address of access
> > - * @size size of access
> >   */
> >  static __always_inline void instrument_atomic_read_write(const volatile void *v, size_t size)
> >  {
> > @@ -105,13 +99,12 @@ static __always_inline void instrument_a
> >
> >  /**
> >   * instrument_copy_to_user - instrument reads of copy_to_user
> > + * @to: destination address
> > + * @from: source address
> > + * @n: number of bytes to copy
> >   *
> >   * Instrument reads from kernel memory, that are due to copy_to_user (and
> >   * variants). The instrumentation must be inserted before the accesses.
> > - *
> > - * @to destination address
> > - * @from source address
> > - * @n number of bytes to copy
> >   */
> >  static __always_inline void
> >  instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
> > @@ -123,13 +116,12 @@ instrument_copy_to_user(void __user *to,
> >
> >  /**
> >   * instrument_copy_from_user_before - add instrumentation before copy_from_user
> > + * @to: destination address
> > + * @from: source address
> > + * @n: number of bytes to copy
> >   *
> >   * Instrument writes to kernel memory, that are due to copy_from_user (and
> >   * variants). The instrumentation should be inserted before the accesses.
> > - *
> > - * @to destination address
> > - * @from source address
> > - * @n number of bytes to copy
> >   */
> >  static __always_inline void
> >  instrument_copy_from_user_before(const void *to, const void __user *from, unsigned long n)
> > @@ -140,14 +132,13 @@ instrument_copy_from_user_before(const v
> >
> >  /**
> >   * instrument_copy_from_user_after - add instrumentation after copy_from_user
> > + * @to: destination address
> > + * @from: source address
> > + * @n: number of bytes to copy
> > + * @left: number of bytes not copied (as returned by copy_from_user)
> >   *
> >   * Instrument writes to kernel memory, that are due to copy_from_user (and
> >   * variants). The instrumentation should be inserted after the accesses.
> > - *
> > - * @to destination address
> > - * @from source address
> > - * @n number of bytes to copy
> > - * @left number of bytes not copied (as returned by copy_from_user)
> >   */
> >  static __always_inline void
> >  instrument_copy_from_user_after(const void *to, const void __user *from,
> > @@ -158,12 +149,11 @@ instrument_copy_from_user_after(const vo
> >
> >  /**
> >   * instrument_get_user() - add instrumentation to get_user()-like macros
> > + * @to: destination variable, may not be address-taken
> >   *
> >   * get_user() and friends are fragile, so it may depend on the implementation
> >   * whether the instrumentation happens before or after the data is copied from
> >   * the userspace.
> > - *
> > - * @to destination variable, may not be address-taken
> >   */
> >  #define instrument_get_user(to)                                \
> >  ({                                                     \
> > @@ -175,14 +165,13 @@ instrument_copy_from_user_after(const vo
> >
> >  /**
> >   * instrument_put_user() - add instrumentation to put_user()-like macros
> > + * @from: source address
> > + * @ptr: userspace pointer to copy to
> > + * @size: number of bytes to copy
> >   *
> >   * put_user() and friends are fragile, so it may depend on the implementation
> >   * whether the instrumentation happens before or after the data is copied from
> >   * the userspace.
> > - *
> > - * @from source address
> > - * @ptr userspace pointer to copy to
> > - * @size number of bytes to copy
> >   */
> >  #define instrument_put_user(from, ptr, size)                   \
> >  ({                                                             \
