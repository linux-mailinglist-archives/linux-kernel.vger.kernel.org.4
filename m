Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012176C53AE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjCVSY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjCVSYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:24:54 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7722B63C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:24:50 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k17so8895378iob.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679509489;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=RxPyedNzNAXsqu0jNbaorNbWksg+Q+Z8edncnO9iqW4=;
        b=CJKlrU205njQnhGzwutLgaZoA7IifC4SWcd2QcVQKblhY4nMjLkpqaaKWjXLP0RZnN
         eC7w2cc5tddjUgdzsuCgmyx1QbNNduyqWdBDMt2qPvR1T8MN6xPF0BsWzhlq4VwoZqym
         GGl3r6PGrjsYZ98Qxm28hjnEP1gT7TsH7AAVv1A6jKJBJJRxCJTFgC5y88AheoSYs3ac
         TpAQ/vp9axWPBMJq31Uzqw6GjIuLddV4+KkUecWIsYqyH996gOfu39A3e2342j6SjO09
         IWEoHRx1Z/1DJk1/X4Vgi28DZokD015G0TrL7NvPqeSWIf7iIgSFGaQi3WTA/cBfw7WS
         d4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679509489;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxPyedNzNAXsqu0jNbaorNbWksg+Q+Z8edncnO9iqW4=;
        b=fv6VF2LphWyuxOJQZ7gCR867aitu7NYV9ExeFPYgeluQaNWGQ6+OvDIX+fKhmO9Psh
         aq/Yk0jTKWpEYqtgZ/0+gbYZv8lXN8w19gI+ihUiOH2grakcJT+lT5DkGcqY8GNzFF2g
         JpT4fHmzkM87Q00nfrXh4m476OKUk0lc9RQZCmcp6JWbLKX4FvPFdy7Ovq2L5D6qgbr1
         ScpXQ25A6VB/UMOLJfWk8qnrpEr6acrnQuNoJEZTk4g/6ZpXzCoFKS43SC2q093Vn5Su
         vVadCksLrIWF0hZaLbtaZqqXldpUrPIToy2ILz7YS7V5rxZ/61VxjOBhih27BFiHjOj7
         GiEg==
X-Gm-Message-State: AO0yUKU2JBTP6KpVgBud/NrDqu6RlsDO7YSaEXsLRK45W3LRENvh9C6+
        vy2HerFmvlwGmPTzV9Y3m3c=
X-Google-Smtp-Source: AK7set+dYAN3K3hFqqxnUu4VWysDJwoHY0TWucDkZcCgwnlYmww1MNYhDiCWL7WGqfCuALfEzF2ubg==
X-Received: by 2002:a5e:aa0d:0:b0:74c:aa8f:a83e with SMTP id s13-20020a5eaa0d000000b0074caa8fa83emr4828772ioe.6.1679509489438;
        Wed, 22 Mar 2023 11:24:49 -0700 (PDT)
Received: from ArchLinux ([125.122.223.69])
        by smtp.gmail.com with ESMTPSA id a22-20020a6b6616000000b007530bbfa577sm4454588ioc.18.2023.03.22.11.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 11:24:49 -0700 (PDT)
References: <20230303161906.831686-1-schspa@gmail.com> <87bkl9jt3a.ffs@tglx>
 <m2ttycd8kx.fsf@gmail.com> <87sfdw8yru.ffs@tglx> <87pm908xvu.ffs@tglx>
User-agent: mu4e 1.7.5; emacs 28.2
From:   Schspa Shi <schspa@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     longman@redhat.com, swboyd@chromium.org, linux@roeck-us.net,
        wuchi.zero@gmail.com, linux-kernel@vger.kernel.org,
        syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] debugobject: fix concurrency issues with
 is_static_object
Date:   Thu, 23 Mar 2023 02:18:10 +0800
In-reply-to: <87pm908xvu.ffs@tglx>
Message-ID: <m28rfomyoi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, Mar 22 2023 at 18:46, Thomas Gleixner wrote:
>> On Wed, Mar 22 2023 at 23:40, Schspa Shi wrote:
>>> I think we should introduce lookup_object_or_alloc and is_static at the
>>> same time.
>>
>> What for?
>
> The below has the NONE/INIT issue addressed and plugs that race
> completely, so no further action required.
>
> Thanks,
>
>         tglx
> ---
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -216,10 +216,6 @@ static struct debug_obj *__alloc_object(
>  	return obj;
>  }
>  
> -/*
> - * Allocate a new object. If the pool is empty, switch off the debugger.
> - * Must be called with interrupts disabled.
> - */
>  static struct debug_obj *
>  alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
>  {
> @@ -552,11 +548,49 @@ static void debug_object_is_on_stack(voi
>  	WARN_ON(1);
>  }
>  
> +static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket *b,
> +						const struct debug_obj_descr *descr,
> +						bool onstack, bool alloc_ifstatic)
> +{
> +	struct debug_obj *obj = lookup_object(addr, b);
> +	enum debug_obj_state state = ODEBUG_STATE_NONE;
> +
> +	if (likely(obj))
> +		return obj;
> +
> +	/*
> +	 * debug_object_init() unconditionally allocates untracked
> +	 * objects. It does not matter whether it is a static object or
> +	 * not.
> +	 *
> +	 * debug_object_assert_init() and debug_object_activate() allow
> +	 * allocation only if the descriptor callback confirms that the
> +	 * object is static and considered initialized. For non-static
> +	 * objects the allocation needs to be done from the fixup callback.
> +	 */
> +	if (unlikely(alloc_ifstatic)) {
> +		if (!descr->is_static_object || !descr->is_static_object(addr))
> +			return ERR_PTR(-ENOENT);
> +		/* Statically allocated objects are considered initialized */
> +		state = ODEBUG_STATE_INIT;
> +	}
> +
> +	obj = alloc_object(addr, b, descr);
> +	if (likely(obj)) {
> +		obj->state = state;
> +		debug_object_is_on_stack(addr, onstack);
> +		return obj;
> +	}
> +
> +	/* Out of memory. Do the cleanup outside of the locked region */
> +	debug_objects_enabled = 0;
> +	return NULL;
> +}
> +
>  static void
>  __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
>  {
>  	enum debug_obj_state state;
> -	bool check_stack = false;
>  	struct debug_bucket *db;
>  	struct debug_obj *obj;
>  	unsigned long flags;
> @@ -572,16 +606,11 @@ static void
>  
>  	raw_spin_lock_irqsave(&db->lock, flags);
>  
> -	obj = lookup_object(addr, db);
> -	if (!obj) {
> -		obj = alloc_object(addr, db, descr);
> -		if (!obj) {
> -			debug_objects_enabled = 0;
> -			raw_spin_unlock_irqrestore(&db->lock, flags);
> -			debug_objects_oom();
> -			return;
> -		}
> -		check_stack = true;
> +	obj = lookup_object_or_alloc(addr, db, descr, onstack, false);
> +	if (unlikely(!obj)) {
> +		raw_spin_unlock_irqrestore(&db->lock, flags);
> +		debug_objects_oom();
> +		return;
>  	}
>  
>  	switch (obj->state) {
> @@ -607,8 +636,6 @@ static void
>  	}
>  
>  	raw_spin_unlock_irqrestore(&db->lock, flags);
> -	if (check_stack)
> -		debug_object_is_on_stack(addr, onstack);
>  }
>  
>  /**
> @@ -648,14 +675,12 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_s
>   */
>  int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
>  {
> +	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
>  	enum debug_obj_state state;
>  	struct debug_bucket *db;
>  	struct debug_obj *obj;
>  	unsigned long flags;
>  	int ret;
> -	struct debug_obj o = { .object = addr,
> -			       .state = ODEBUG_STATE_NOTAVAILABLE,
> -			       .descr = descr };
>  
>  	if (!debug_objects_enabled)
>  		return 0;
> @@ -664,8 +689,8 @@ int debug_object_activate(void *addr, co
>  
>  	raw_spin_lock_irqsave(&db->lock, flags);
>  
> -	obj = lookup_object(addr, db);
> -	if (obj) {
> +	obj = lookup_object_or_alloc(addr, db, descr, false, true);
> +	if (likely(!IS_ERR_OR_NULL(obj))) {
>  		bool print_object = false;
>  
>  		switch (obj->state) {
> @@ -698,24 +723,16 @@ int debug_object_activate(void *addr, co
>  
>  	raw_spin_unlock_irqrestore(&db->lock, flags);
>  
> -	/*
> -	 * We are here when a static object is activated. We
> -	 * let the type specific code confirm whether this is
> -	 * true or not. if true, we just make sure that the
> -	 * static object is tracked in the object tracker. If
> -	 * not, this must be a bug, so we try to fix it up.
> -	 */
> -	if (descr->is_static_object && descr->is_static_object(addr)) {
> -		/* track this static object */
> -		debug_object_init(addr, descr);
> -		debug_object_activate(addr, descr);
> -	} else {
> -		debug_print_object(&o, "activate");
> -		ret = debug_object_fixup(descr->fixup_activate, addr,
> -					ODEBUG_STATE_NOTAVAILABLE);
> -		return ret ? 0 : -EINVAL;
> +	/* If NULL the allocaction has hit OOM */
> +	if (!obj) {
> +		debug_objects_oom();
> +		return 0;
>  	}
> -	return 0;
> +
> +	/* Object is neither static nor tracked. It's not initialized */
> +	debug_print_object(&o, "activate");
> +	ret = debug_object_fixup(descr->fixup_activate, addr, ODEBUG_STATE_NOTAVAILABLE);
> +	return ret ? 0 : -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(debug_object_activate);
>  
> @@ -869,6 +886,7 @@ EXPORT_SYMBOL_GPL(debug_object_free);
>   */
>  void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
>  {
> +	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
>  	struct debug_bucket *db;
>  	struct debug_obj *obj;
>  	unsigned long flags;
> @@ -879,31 +897,20 @@ void debug_object_assert_init(void *addr
>  	db = get_bucket((unsigned long) addr);
>  
>  	raw_spin_lock_irqsave(&db->lock, flags);
> +	obj = lookup_object_or_alloc(addr, db, descr, false, true);
> +	raw_spin_unlock_irqrestore(&db->lock, flags);
> +	if (likely(!IS_ERR_OR_NULL(obj)))
> +		return;
>  
> -	obj = lookup_object(addr, db);
> +	/* If NULL the allocaction has hit OOM */
>  	if (!obj) {
> -		struct debug_obj o = { .object = addr,
> -				       .state = ODEBUG_STATE_NOTAVAILABLE,
> -				       .descr = descr };
> -
> -		raw_spin_unlock_irqrestore(&db->lock, flags);
> -		/*
> -		 * Maybe the object is static, and we let the type specific
> -		 * code confirm. Track this static object if true, else invoke
> -		 * fixup.
> -		 */
> -		if (descr->is_static_object && descr->is_static_object(addr)) {
> -			/* Track this static object */
> -			debug_object_init(addr, descr);
> -		} else {
> -			debug_print_object(&o, "assert_init");
> -			debug_object_fixup(descr->fixup_assert_init, addr,
> -					   ODEBUG_STATE_NOTAVAILABLE);
> -		}
> +		debug_objects_oom();
>  		return;
>  	}
>  
> -	raw_spin_unlock_irqrestore(&db->lock, flags);
> +	/* Object is neither tracked nor static. It's not initialized. */
> +	debug_print_object(&o, "assert_init");
> +	debug_object_fixup(descr->fixup_assert_init, addr, ODEBUG_STATE_NOTAVAILABLE);
>  }
>  EXPORT_SYMBOL_GPL(debug_object_assert_init);
>  

It's OK if you don't think debug_object_free() should report a error when
the object is static. But I still think we should report an error and
modify the autotest case in debug_objects_selftest() to remove
debug_object_free() call on the static object.

-- 
BRs
Schspa Shi
