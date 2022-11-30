Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF463D1CB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiK3J0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiK3J0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:26:02 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5096932B82
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:26:01 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o12so7329966pjo.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyJDDvQfeBb1GezHTkEwABeQFr6KK0pjnwnX5KAKxeg=;
        b=VYtBzJfydNprTCCyGjvSmq2UTPhRtCyEM+GYH3ITzI0kz1LzU38rjc4HNh7eMcTvkn
         X0NQpBCzxsFcCT2ki5WQXUSmjnkIP3Eg/ALHNonI+eNxpuIV6CBEM0j8tm8z1iIEaN7g
         6zcKPmXhuHV0HfKCaUPinFddN6vqk/37Ff1LF4ogXL2tIbJg5HQHHiW/y/ATv3TT1Rsf
         n4RPsURVcttAjBL/EmBnSM8Zu4Yhpk6NnLdOXzs952NRo2ZG30a/RcBJy+iwcqPeHcxu
         r2VHAMKM6MElynNf6Cfx8cQ8xz7oXg0Fag11t1Alz3045obcUuVp0COnZhcx0HL0eUQm
         MRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyJDDvQfeBb1GezHTkEwABeQFr6KK0pjnwnX5KAKxeg=;
        b=h/W2dIPNZKSwvNSK512D3HtKLsNdSC6mpVuIy2jUOgaQ6r9WomhcxTUUN7IheqnuAF
         iG5dHhoxsoLLEi9aciDeOu6+92GdWGwx1cy0Zvd7EdX3ICl3QEnuWcdXLP2vUFhm2mwq
         ooP6rifL20B5NX2+qPNsT3iHgR7omCQkxhSJHf0wVrBiors6q7EC8OsGmtOI70wHnHJT
         31y+ju5jwv55F4fiTum/DDXql4dIstuDM4AuZEuNouqS5T9KDGnK9eOCiTm6JOD4f2QY
         8XklPeiFqmD6REhvYANvP9Nttk/r75OMwiwPQgNMtV8AJmxe9Xwfz/zd++nNPAdI7OU4
         Dk3Q==
X-Gm-Message-State: ANoB5plWaPuPkXW2BGUUcdksQJlCx5xqGyOhjhSAZFB1eXQQ1Rnu+tUE
        DawYI8Bi/nKt3JHlNIiWN78=
X-Google-Smtp-Source: AA0mqf4oI2QKPut3fSn0Z5fZ4t3zbzf+pNIa00ryxVxejW3LTRP4t9O+dRs3TIeX/GvXbvRHUPS6ig==
X-Received: by 2002:a17:902:ccce:b0:185:4880:91cd with SMTP id z14-20020a170902ccce00b00185488091cdmr41401879ple.130.1669800360563;
        Wed, 30 Nov 2022 01:26:00 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id 21-20020a621615000000b00575f348aa3esm375326pfw.122.2022.11.30.01.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 01:25:59 -0800 (PST)
Date:   Wed, 30 Nov 2022 18:25:54 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Glitta <glittao@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/slub, kunit: add SLAB_SKIP_KFENCE flag for
 cache creation
Message-ID: <Y4chov84Uxgls97S@hyeyoo>
References: <20221130085451.3390992-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130085451.3390992-1-feng.tang@intel.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 04:54:50PM +0800, Feng Tang wrote:
> When kfence is enabled, the buffer allocated from the test case
> could be from a kfence pool, and the operation could be also
> caught and reported by kfence first, causing the case to fail.
> 
> With default kfence setting, this is very difficult to be triggered.
> By changing CONFIG_KFENCE_NUM_OBJECTS from 255 to 16383, and
> CONFIG_KFENCE_SAMPLE_INTERVAL from 100 to 5, the allocation from
> kfence did hit 7 times in different slub_kunit cases out of 900
> times of boot test.
> 
> To avoid this, initially we tried is_kfence_address() to check this
> and repeated allocation till finding a non-kfence address. Vlastimil
> Babka suggested SLAB_SKIP_KFENCE flag could be used to achieve this,
> and better add a wrapper function for simplifying cache creation.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Changelog:
> 
>   since v2:
>     * Don't make SKIP_KFENCE an allowd flag for cache creation, and
>       solve a bug of failed cache creation issue (Marco Elver)
>     * Add a wrapper cache creation function to simplify code
>      including SKIP_KFENCE handling (Vlastimil Babka)
> 
>  lib/slub_kunit.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index 7a0564d7cb7a..5b0c8e7eb6dc 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -9,10 +9,25 @@
>  static struct kunit_resource resource;
>  static int slab_errors;
>  
> +/*
> + * Wrapper function for kmem_cache_create(), which reduces 2 parameters:
> + * 'align' and 'ctor', and sets SLAB_SKIP_KFENCE flag to avoid getting an
> + * object from kfence pool, where the operation could be caught by both
> + * our test and kfence sanity check.
> + */
> +static struct kmem_cache *test_kmem_cache_create(const char *name,
> +				unsigned int size, slab_flags_t flags)
> +{
> +	struct kmem_cache *s = kmem_cache_create(name, size, 0,
> +					(flags | SLAB_NO_USER_FLAGS), NULL);
> +	s->flags |= SLAB_SKIP_KFENCE;
> +	return s;
> +}
> +
>  static void test_clobber_zone(struct kunit *test)
>  {
> -	struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_alloc", 64, 0,
> -				SLAB_RED_ZONE|SLAB_NO_USER_FLAGS, NULL);
> +	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_alloc", 64,
> +							SLAB_RED_ZONE);
>  	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
>  
>  	kasan_disable_current();
> @@ -29,8 +44,8 @@ static void test_clobber_zone(struct kunit *test)
>  #ifndef CONFIG_KASAN
>  static void test_next_pointer(struct kunit *test)
>  {
> -	struct kmem_cache *s = kmem_cache_create("TestSlub_next_ptr_free", 64, 0,
> -				SLAB_POISON|SLAB_NO_USER_FLAGS, NULL);
> +	struct kmem_cache *s = test_kmem_cache_create("TestSlub_next_ptr_free",
> +							64, SLAB_POISON);
>  	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
>  	unsigned long tmp;
>  	unsigned long *ptr_addr;
> @@ -74,8 +89,8 @@ static void test_next_pointer(struct kunit *test)
>  
>  static void test_first_word(struct kunit *test)
>  {
> -	struct kmem_cache *s = kmem_cache_create("TestSlub_1th_word_free", 64, 0,
> -				SLAB_POISON|SLAB_NO_USER_FLAGS, NULL);
> +	struct kmem_cache *s = test_kmem_cache_create("TestSlub_1th_word_free",
> +							64, SLAB_POISON);
>  	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
>  
>  	kmem_cache_free(s, p);
> @@ -89,8 +104,8 @@ static void test_first_word(struct kunit *test)
>  
>  static void test_clobber_50th_byte(struct kunit *test)
>  {
> -	struct kmem_cache *s = kmem_cache_create("TestSlub_50th_word_free", 64, 0,
> -				SLAB_POISON|SLAB_NO_USER_FLAGS, NULL);
> +	struct kmem_cache *s = test_kmem_cache_create("TestSlub_50th_word_free",
> +							64, SLAB_POISON);
>  	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
>  
>  	kmem_cache_free(s, p);
> @@ -105,8 +120,8 @@ static void test_clobber_50th_byte(struct kunit *test)
>  
>  static void test_clobber_redzone_free(struct kunit *test)
>  {
> -	struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_free", 64, 0,
> -				SLAB_RED_ZONE|SLAB_NO_USER_FLAGS, NULL);
> +	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_free", 64,
> +							SLAB_RED_ZONE);
>  	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
>  
>  	kasan_disable_current();
> -- 
> 2.34.1
> 

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
