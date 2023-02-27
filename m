Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEDB6A3C16
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjB0INh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjB0INf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:13:35 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C14E166D8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:13:34 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id df20so9679465vsb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wdl9GK7NYLudHv+065gtQBOUCVSu0p7AyWwbwCzE8vc=;
        b=iI0xF7UQb7KpWVxDANMZP1YPXehsV6nQ5TFAdr6iUjIO6hz05Z4fco4GJIwVFCXiuz
         K9BeymwdW0hdeHQZlGenSg295ZnYOW9swtSjKmhc9+2Rdm1DQ2qmbGKyuDGvFlrmXsPe
         fJE1qzNAHv+SzuqzIOrKV63544fQGOmOIUQTGbBFeBr9xp6uhZwoGLE9+tevc+3TatAa
         IP9DZRZGdDZWZ7d50OLRCqhF+ESIy6XWZyPHg0s883bDk9Lw0ftsdXjYPA1Xeo4KhVgT
         N7tFgvuN890SgJftD1fsgmGsvH4YfJefnYPaDhVjQn22r6OdxHxV5j+8pz1J4SHaXE8S
         RETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wdl9GK7NYLudHv+065gtQBOUCVSu0p7AyWwbwCzE8vc=;
        b=GVv/zGK/fDsfkwHLeB4YjBcOlqwFpwCkfUqjV4myfW6v23zS9YExx4tTQ7Ryh6995M
         nor7RKcOHTu1tZkdBP9JrGIlOHUouxANwYkwk4pW72qgXTnKou08K0MqlGrIbtzrr1wa
         nOCMIMYPRHnaLbB0bB8h2pw8XkgotM5/kemE4PB35nbwLd3AaLJh0GzcrNQ8TL6XO/TX
         ZKsvwjcDnitJzrsmtXz+wqxLNqzwP9vu7DXHDFveibVk/Z18OQfm//dZ/dYq0sTQE+QU
         7ZrVt9wyrSW4gFUT2WRD1Vd0wiv5abwT0DmOJwcNB6RE48C1pDLsJ+1FxIOY7TYGqX7O
         UvFA==
X-Gm-Message-State: AO0yUKXY82bCpdXG4SfuJzroDpLxicp6Pvwbckh5nGMiNwhYwW+EoUQ9
        Qzud/96lpdW72wIMREQHDY96SdMssEjCzVVHpsI0yw==
X-Google-Smtp-Source: AK7set+UyyQ9BOyFeVp27YqxolrYd5i/RxRehyRGW+YZ4PIz/4Nw0MOJiqVLa7vQ7Ya33nVybi9AQCJlWjk6IeN+CI4=
X-Received: by 2002:a05:6122:11b3:b0:401:82ca:8592 with SMTP id
 y19-20020a05612211b300b0040182ca8592mr7055728vkn.3.1677485613244; Mon, 27 Feb
 2023 00:13:33 -0800 (PST)
MIME-Version: 1.0
References: <20230227011700.23947-1-rdunlap@infradead.org>
In-Reply-To: <20230227011700.23947-1-rdunlap@infradead.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 27 Feb 2023 09:12:53 +0100
Message-ID: <CANpmjNNmnRNos4ZtQrHuf3o4-hmN3nCEo-FDGdMPRo=JiJwWEw@mail.gmail.com>
Subject: Re: [PATCH] instrumented.h: fix all kernel-doc format warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 at 02:17, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix 26 kernel-doc notation warnings by converting the function
> documentation to kernel-doc format.
>
> Warning example:
>
> instrumented.h:155: warning: Function parameter or member 'to' not described in 'instrument_copy_from_user_after'
> instrumented.h:155: warning: Function parameter or member 'from' not described in 'instrument_copy_from_user_after'
> instrumented.h:155: warning: Function parameter or member 'n' not described in 'instrument_copy_from_user_after'
> instrumented.h:155: warning: Function parameter or member 'left' not described in 'instrument_copy_from_user_after'
>
> Fixes: 36e4d4dd4fc4 ("include/linux: Add instrumented.h infrastructure")
> Fixes: 00047c2e6d7c ("instrumented.h: Introduce read-write instrumentation hooks")
> Fixes: 33b75c1d884e ("instrumented.h: allow instrumenting both sides of copy_from_user()")
> Fixes: 888f84a6da4d ("x86: asm: instrument usercopy in get_user() and put_user()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Marco Elver <elver@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>

Reviewed-by: Marco Elver <elver@google.com>

Thanks for the fixes.

> ---
>  include/linux/instrumented.h |   63 +++++++++++++--------------------
>  1 file changed, 26 insertions(+), 37 deletions(-)
>
> diff -- a/include/linux/instrumented.h b/include/linux/instrumented.h
> --- a/include/linux/instrumented.h
> +++ b/include/linux/instrumented.h
> @@ -15,12 +15,11 @@
>
>  /**
>   * instrument_read - instrument regular read access
> + * @v: address of access
> + * @size: size of access
>   *
>   * Instrument a regular read access. The instrumentation should be inserted
>   * before the actual read happens.
> - *
> - * @ptr address of access
> - * @size size of access
>   */
>  static __always_inline void instrument_read(const volatile void *v, size_t size)
>  {
> @@ -30,12 +29,11 @@ static __always_inline void instrument_r
>
>  /**
>   * instrument_write - instrument regular write access
> + * @v: address of access
> + * @size: size of access
>   *
>   * Instrument a regular write access. The instrumentation should be inserted
>   * before the actual write happens.
> - *
> - * @ptr address of access
> - * @size size of access
>   */
>  static __always_inline void instrument_write(const volatile void *v, size_t size)
>  {
> @@ -45,12 +43,11 @@ static __always_inline void instrument_w
>
>  /**
>   * instrument_read_write - instrument regular read-write access
> + * @v: address of access
> + * @size: size of access
>   *
>   * Instrument a regular write access. The instrumentation should be inserted
>   * before the actual write happens.
> - *
> - * @ptr address of access
> - * @size size of access
>   */
>  static __always_inline void instrument_read_write(const volatile void *v, size_t size)
>  {
> @@ -60,12 +57,11 @@ static __always_inline void instrument_r
>
>  /**
>   * instrument_atomic_read - instrument atomic read access
> + * @v: address of access
> + * @size: size of access
>   *
>   * Instrument an atomic read access. The instrumentation should be inserted
>   * before the actual read happens.
> - *
> - * @ptr address of access
> - * @size size of access
>   */
>  static __always_inline void instrument_atomic_read(const volatile void *v, size_t size)
>  {
> @@ -75,12 +71,11 @@ static __always_inline void instrument_a
>
>  /**
>   * instrument_atomic_write - instrument atomic write access
> + * @v: address of access
> + * @size: size of access
>   *
>   * Instrument an atomic write access. The instrumentation should be inserted
>   * before the actual write happens.
> - *
> - * @ptr address of access
> - * @size size of access
>   */
>  static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
>  {
> @@ -90,12 +85,11 @@ static __always_inline void instrument_a
>
>  /**
>   * instrument_atomic_read_write - instrument atomic read-write access
> + * @v: address of access
> + * @size: size of access
>   *
>   * Instrument an atomic read-write access. The instrumentation should be
>   * inserted before the actual write happens.
> - *
> - * @ptr address of access
> - * @size size of access
>   */
>  static __always_inline void instrument_atomic_read_write(const volatile void *v, size_t size)
>  {
> @@ -105,13 +99,12 @@ static __always_inline void instrument_a
>
>  /**
>   * instrument_copy_to_user - instrument reads of copy_to_user
> + * @to: destination address
> + * @from: source address
> + * @n: number of bytes to copy
>   *
>   * Instrument reads from kernel memory, that are due to copy_to_user (and
>   * variants). The instrumentation must be inserted before the accesses.
> - *
> - * @to destination address
> - * @from source address
> - * @n number of bytes to copy
>   */
>  static __always_inline void
>  instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
> @@ -123,13 +116,12 @@ instrument_copy_to_user(void __user *to,
>
>  /**
>   * instrument_copy_from_user_before - add instrumentation before copy_from_user
> + * @to: destination address
> + * @from: source address
> + * @n: number of bytes to copy
>   *
>   * Instrument writes to kernel memory, that are due to copy_from_user (and
>   * variants). The instrumentation should be inserted before the accesses.
> - *
> - * @to destination address
> - * @from source address
> - * @n number of bytes to copy
>   */
>  static __always_inline void
>  instrument_copy_from_user_before(const void *to, const void __user *from, unsigned long n)
> @@ -140,14 +132,13 @@ instrument_copy_from_user_before(const v
>
>  /**
>   * instrument_copy_from_user_after - add instrumentation after copy_from_user
> + * @to: destination address
> + * @from: source address
> + * @n: number of bytes to copy
> + * @left: number of bytes not copied (as returned by copy_from_user)
>   *
>   * Instrument writes to kernel memory, that are due to copy_from_user (and
>   * variants). The instrumentation should be inserted after the accesses.
> - *
> - * @to destination address
> - * @from source address
> - * @n number of bytes to copy
> - * @left number of bytes not copied (as returned by copy_from_user)
>   */
>  static __always_inline void
>  instrument_copy_from_user_after(const void *to, const void __user *from,
> @@ -158,12 +149,11 @@ instrument_copy_from_user_after(const vo
>
>  /**
>   * instrument_get_user() - add instrumentation to get_user()-like macros
> + * @to: destination variable, may not be address-taken
>   *
>   * get_user() and friends are fragile, so it may depend on the implementation
>   * whether the instrumentation happens before or after the data is copied from
>   * the userspace.
> - *
> - * @to destination variable, may not be address-taken
>   */
>  #define instrument_get_user(to)                                \
>  ({                                                     \
> @@ -175,14 +165,13 @@ instrument_copy_from_user_after(const vo
>
>  /**
>   * instrument_put_user() - add instrumentation to put_user()-like macros
> + * @from: source address
> + * @ptr: userspace pointer to copy to
> + * @size: number of bytes to copy
>   *
>   * put_user() and friends are fragile, so it may depend on the implementation
>   * whether the instrumentation happens before or after the data is copied from
>   * the userspace.
> - *
> - * @from source address
> - * @ptr userspace pointer to copy to
> - * @size number of bytes to copy
>   */
>  #define instrument_put_user(from, ptr, size)                   \
>  ({                                                             \
