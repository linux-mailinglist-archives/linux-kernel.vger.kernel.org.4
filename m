Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B995E5EBD56
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiI0IcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiI0IcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:32:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AD231346;
        Tue, 27 Sep 2022 01:32:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so14887570pjq.3;
        Tue, 27 Sep 2022 01:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Z8rSg6dmSRUhDrv1i/BVR40v9x+7rBEf82xJDnX4Oso=;
        b=Wmj3cSD/p9IDn1/7DnPbsH8zUc4XAWQL8vicPT9oXALsB0Io+NFEwZfFSw867lZk+d
         icbVV5RjHm3GzxT48No3ZCxlBeyPoGi8tMB3LePqpwRb6a4vy6W2LTa11kFYUACqC3Lh
         XsW+9yoA70Iu+gninE5KUMUdxJmtu2Ee4NGI4deCog56gltPmdjBkuJ6b2JfelhXgE10
         C4jK0/aTq06w+QxzBz4hzonSoL2823v2SKvr/vitDQoI8C7YDXHKw2gn/ayon5mmmQqq
         pwbJkgxSL25a/dhTdMuRYSDpx1Q5/U5s/BtiVey14bNKiaDgfDcSgjpCQTHUu1SwNVUD
         KSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Z8rSg6dmSRUhDrv1i/BVR40v9x+7rBEf82xJDnX4Oso=;
        b=2yX1hR4l95BGwGiowhhAhTbNbAbT1slejAii7dC+pgJxhlLcgrUYrg7lQTgTcgQIxw
         hYT7vwnawyEvYTDXHenSY6pAia8HQH694uJmCXvtp+XmwJKhnlvpww9bUO5DCxeTxZs8
         vv7YR+g17WPVjN/D7adt/2JiEYsjweg9fnmnpN66Q12w4vtljjcSzLTmEcH4DGgkBG8w
         SyEgUG0uJmCHuc3WDTMufFPw3ZlR5/71N7DuSmYcJHGmBhysZtcy6Jzas2B7WMGrfejg
         nGFftkOdPPMfZhj7M0i68VOtqAd4r3wyXS2SmJR0Ll3/kPedKDtkYUXcDIwN73LJW6Op
         /4ng==
X-Gm-Message-State: ACrzQf3OZ2FUQGUjRExALn2/EHba9L+yFYSmTMLitvVDc0CjHL1qQrBI
        qHKCfU7y0itzhfGRL9TU7InVP9z1pqE=
X-Google-Smtp-Source: AMsMyM4JQNaxJsqMUcQpmtgXORo5ugwbGjuHkg7Eyo3J8Yvdsb+bRRiIMqksIR3WJZd036gQ5CzHrQ==
X-Received: by 2002:a17:902:d58a:b0:179:ec1d:9ead with SMTP id k10-20020a170902d58a00b00179ec1d9eadmr1994854plh.158.1664267531430;
        Tue, 27 Sep 2022 01:32:11 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-32.three.co.id. [116.206.12.32])
        by smtp.gmail.com with ESMTPSA id d2-20020a631d02000000b0043a09d5c32bsm898781pgd.74.2022.09.27.01.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 01:32:10 -0700 (PDT)
Message-ID: <479bd33b-f68c-aceb-49e0-122a2e99d5c1@gmail.com>
Date:   Tue, 27 Sep 2022 15:32:07 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] overflow: Fix kern-doc markup for functions
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926194713.1806917-1-keescook@chromium.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220926194713.1806917-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 02:47, Kees Cook wrote:
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 58eb34aa2af9..4b5b3ec91233 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -51,7 +51,8 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  	return unlikely(overflow);
>  }
>  
> -/** check_add_overflow() - Calculate addition with overflow checking
> +/**
> + * check_add_overflow - Calculate addition with overflow checking
>   *
>   * @a: first addend
>   * @b: second addend
> @@ -66,7 +67,8 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  #define check_add_overflow(a, b, d)	\
>  	__must_check_overflow(__builtin_add_overflow(a, b, d))
>  
> -/** check_sub_overflow() - Calculate subtraction with overflow checking
> +/**
> + * check_sub_overflow - Calculate subtraction with overflow checking
>   *
>   * @a: minuend; value to subtract from
>   * @b: subtrahend; value to subtract from @a
> @@ -81,7 +83,8 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  #define check_sub_overflow(a, b, d)	\
>  	__must_check_overflow(__builtin_sub_overflow(a, b, d))
>  
> -/** check_mul_overflow() - Calculate multiplication with overflow checking
> +/**
> + * check_mul_overflow - Calculate multiplication with overflow checking
>   *
>   * @a: first factor
>   * @b: second factor
> @@ -96,7 +99,8 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  #define check_mul_overflow(a, b, d)	\
>  	__must_check_overflow(__builtin_mul_overflow(a, b, d))
>  
> -/** check_shl_overflow() - Calculate a left-shifted value and check overflow
> +/**
> + * check_shl_overflow - Calculate a left-shifted value and check overflow
>   *
>   * @a: Value to be shifted
>   * @s: How many bits left to shift
> @@ -104,15 +108,16 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>   *
>   * Computes *@d = (@a << @s)
>   *
> - * Returns true if '*d' cannot hold the result or when 'a << s' doesn't
> + * Returns true if '*@d' cannot hold the result or when '@a << @s' doesn't
>   * make sense. Example conditions:
> - * - 'a << s' causes bits to be lost when stored in *d.
> - * - 's' is garbage (e.g. negative) or so large that the result of
> - *   'a << s' is guaranteed to be 0.
> - * - 'a' is negative.
> - * - 'a << s' sets the sign bit, if any, in '*d'.
>   *
> - * '*d' will hold the results of the attempted shift, but is not
> + * - '@a << @s' causes bits to be lost when stored in *@d.
> + * - '@s' is garbage (e.g. negative) or so large that the result of
> + *   '@a << @s' is guaranteed to be 0.
> + * - '@a' is negative.
> + * - '@a << @s' sets the sign bit, if any, in '*@d'.
> + *
> + * '*@d' will hold the results of the attempted shift, but is not
>   * considered "safe for use" if true is returned.
>   */
>  #define check_shl_overflow(a, s, d) __must_check_overflow(({		\
> @@ -176,7 +181,7 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  			      __same_type(n, T))
>  
>  /**
> - * size_mul() - Calculate size_t multiplication with saturation at SIZE_MAX
> + * size_mul - Calculate size_t multiplication with saturation at SIZE_MAX
>   *
>   * @factor1: first factor
>   * @factor2: second factor
> @@ -196,7 +201,7 @@ static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
>  }
>  
>  /**
> - * size_add() - Calculate size_t addition with saturation at SIZE_MAX
> + * size_add - Calculate size_t addition with saturation at SIZE_MAX
>   *
>   * @addend1: first addend
>   * @addend2: second addend
> @@ -216,7 +221,7 @@ static inline size_t __must_check size_add(size_t addend1, size_t addend2)
>  }
>  
>  /**
> - * size_sub() - Calculate size_t subtraction with saturation at SIZE_MAX
> + * size_sub - Calculate size_t subtraction with saturation at SIZE_MAX
>   *
>   * @minuend: value to subtract from
>   * @subtrahend: value to subtract from @minuend
> @@ -239,7 +244,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>  }
>  
>  /**
> - * array_size() - Calculate size of 2-dimensional array.
> + * array_size - Calculate size of 2-dimensional array.
>   *
>   * @a: dimension one
>   * @b: dimension two
> @@ -252,7 +257,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>  #define array_size(a, b)	size_mul(a, b)
>  
>  /**
> - * array3_size() - Calculate size of 3-dimensional array.
> + * array3_size - Calculate size of 3-dimensional array.
>   *
>   * @a: dimension one
>   * @b: dimension two
> @@ -266,8 +271,8 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>  #define array3_size(a, b, c)	size_mul(size_mul(a, b), c)
>  
>  /**
> - * flex_array_size() - Calculate size of a flexible array member
> - *                     within an enclosing structure.
> + * flex_array_size - Calculate size of a flexible array member
> + *                   within an enclosing structure.
>   *
>   * @p: Pointer to the structure.
>   * @member: Name of the flexible array member.
> @@ -284,7 +289,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>  		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
>  
>  /**
> - * struct_size() - Calculate size of structure with trailing flexible array.
> + * struct_size - Calculate size of structure with trailing flexible array.
>   *
>   * @p: Pointer to the structure.
>   * @member: Name of the array member.

Hmm...

I can't apply this patch for testing. On what tree (and what commit) this
patch is based on?

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
