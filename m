Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817585B4DA6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiIKLFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiIKLFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:05:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AD5DFAB
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662894302; x=1694430302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xa/tnWTDfFYpsFHInbux92mNF6sFhOjW3NH7JPOApq0=;
  b=ERa2YXa9r3c6BfW4koaI7g3+7y7NtPOJF8QTXlzQFab3nQUrouQRJM9D
   NkvFTJgCv1He3JbN2I2MPv4DQ/eb3QQbEAucuBEKsUaumyky9lN8d7PMY
   juP2efDJUsvT9hHvF9Bv1KcSPdkjMwL5g7/9dcGGUz8vg0OsS08Kgcjgk
   AR5hz3Bz0bfXKXy1XXh9Wpw+0wYZkscJ4QyJlImNBpzg0IF66kxb89gn2
   OUz2snGDkrpTbtwVcd2SGlvY3yQNn/tvEGVkbR0BnvKEChTsSgVJDyxC8
   FV99EX1DP81B14Uj3DDIpawJGo38m4hEBvC+0YyxzJZgxiCdEhC5vcwBY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="296450249"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="296450249"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 04:05:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="677746849"
Received: from dasegal-mobl.amr.corp.intel.com (HELO intel.com) ([10.249.46.19])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 04:04:57 -0700
Date:   Sun, 11 Sep 2022 13:04:55 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mchehab@kernel.org,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, jani.nikula@intel.com,
        nirmoy.das@intel.com, airlied@redhat.com, daniel@ffwll.ch,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        keescook@chromium.org, mauro.chehab@linux.intel.com,
        linux@rasmusvillemoes.dk, vitor@massaru.org, dlatypov@google.com,
        ndesaulniers@google.com
Subject: Re: [PATCH v10 3/9] compiler_types.h: Add assert_type to catch type
 mis-match while compiling
Message-ID: <Yx3A16ZElKOeJr0o@alfio.lan>
References: <20220909105913.752049-1-gwan-gyeong.mun@intel.com>
 <20220909105913.752049-4-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220909105913.752049-4-gwan-gyeong.mun@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwan-gyeong,

On Fri, Sep 09, 2022 at 07:59:07PM +0900, Gwan-gyeong Mun wrote:
> It adds assert_type and assert_typable macros to catch type mis-match while

/Add/It adds/, please use the imperative form.

> compiling. The existing typecheck() macro outputs build warnings, but the
> newly added assert_type() macro uses the _Static_assert() keyword (which is
> introduced in C11) to generate a build break when the types are different
> and can be used to detect explicit build errors.
> Unlike the assert_type() macro, assert_typable() macro allows a constant
> value as the second argument.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Nirmoy Das <nirmoy.das@intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/compiler_types.h | 39 ++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 4f2a819fd60a..19cc125918bb 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -294,6 +294,45 @@ struct ftrace_likely_data {
>  /* Are two types/vars the same type (ignoring qualifiers)? */
>  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>  
> +/**
> + * assert_type - break compile if the first argument's data type and the second
> + *               argument's data type are not the same

I would use /aborts compilation/break compile/

> + *

nowhere is written that this extra blank line is not needed, but
just checking the style in compiler_types.h it is not used.

I personally like the blank line, but standing to the general
taste, it should be removed also for keeping a coherent style.

> + * @t1: data type or variable
> + * @t2: data type or variable
> + *
> + * The first and second arguments can be data types or variables or mixed (the
> + * first argument is the data type and the second argument is variable or vice
> + * versa). It determines whether the first argument's data type and the second
> + * argument's data type are the same while compiling, and it breaks compile if
> + * the two types are not the same.
> + * See also assert_typable().
> + */
> +#define assert_type(t1, t2) _Static_assert(__same_type(t1, t2))

In C11 _Static_assert is defined as:

  _Static_assert ( constant-expression , string-literal ) ;

While

  _Static_assert ( constant-expression ) ;

is defined in C17 along with the previous. I think you should add
the error message as a 'string-literal'.

Andi

> +/**
> + * assert_typable - break compile if the first argument's data type and the
> + *                  second argument's data type are not the same
> + *
> + * @t: data type or variable
> + * @n: data type or variable or constant value
> + *
> + * The first and second arguments can be data types or variables or mixed (the
> + * first argument is the data type and the second argument is variable or vice
> + * versa). Unlike the assert_type() macro, this macro allows a constant value
> + * as the second argument. And if the second argument is a constant value, it
> + * always passes. And it doesn't mean that the types are explicitly the same.
> + * When a constant value is used as the second argument, if you need an
> + * overflow check when assigning a constant value to a variable of the type of
> + * the first argument, you can use the overflows_type() macro. When a constant
> + * value is not used as a second argument, it determines whether the first
> + * argument's data type and the second argument's data type are the same while
> + * compiling, and it breaks compile if the two types are not the same.
> + * See also assert_type() and overflows_type().
> + */
> +#define assert_typable(t, n) _Static_assert(__builtin_constant_p(n) ||	\
> +					    __same_type(t, typeof(n)))
> +
>  /*
>   * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
>   *			       non-scalar types unchanged.
> -- 
> 2.37.1
