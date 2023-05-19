Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BD3709B40
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjESPXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjESPXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:23:50 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554B819F;
        Fri, 19 May 2023 08:23:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E27217C0;
        Fri, 19 May 2023 15:23:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E27217C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684509829; bh=JXzqn/kBG5UL0/TLKHrauul40S0pyWarjFgX8Y+MmPA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NxYbW5ZZGwsX+RiKZST2x6WGizQQtEBsqBkko8/i14a0XHfYPCjt7+mp4OY2lRdai
         6+RUsWtVRSnLtq30tBmy3NYxTRQE36EO+aB2FD5s2FVl49WcMSDgBO46SHauL0EcIk
         rIgc02IXxThDcfpPe3gpU/pK86BwRFhKXLrJJBZYzZBb7LKbPughD4DVaYAoS/Z2Cw
         ARuUlRpykVhhX5pIlzpKM/533GB1mI6c898EE8BgWfOQpg6xNGj/kXTgW2Sa9jEZ5t
         56HZBrMY1uY+5a7WxjszatZivpkWOHCnQ/ZTBYcrGwM7GBc7W26MPbgbaLc/EremJW
         DPAVO7Q9I6Agw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH] Documentation: Document macro coding style
In-Reply-To: <20230511152951.1970870-1-mathieu.desnoyers@efficios.com>
References: <20230511152951.1970870-1-mathieu.desnoyers@efficios.com>
Date:   Fri, 19 May 2023 09:23:48 -0600
Message-ID: <87y1lkmjjv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:

> Document the kernel coding style for macros with parameters.
>
> The purpose of this text is to be used as a reference to gradually
> transition towards macros with a more consistent style, and eliminate
> subtle bugs that can creep up due to missing parentheses, and generally
> remove the need to think and argue about C operator precedence.
>
> This is based on a mailing list discussion with Linus.
>
> Link: https://lore.kernel.org/lkml/CAHk-=wjfgCa-u8h9z+8U7gaKK6PnRCpws1Md9wYSSXywUxoUSA@mail.gmail.com/
> Link: https://lore.kernel.org/lkml/CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com/
> Link: https://lore.kernel.org/lkml/CAHk-=wh-x1PL=UUGD__Dv6kd+kyCHjNF-TCHGG9ayLnysf-PdQ@mail.gmail.com/
> Link: https://lore.kernel.org/lkml/CAHk-=wg27iiFZWYmjKmULxwkXisOHuAXq=vbiazBabgh9M1rqg@mail.gmail.com/
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/process/coding-style.rst | 152 ++++++++++++++++++++++++-
>  1 file changed, 151 insertions(+), 1 deletion(-)

So this looks generally OK to me.  I really like to see some reviews /
acks on coding-style patches, though; I don't feel like I should be the
arbiter of kernel coding style.

One little comment below

> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 6db37a46d305..3cf62c91d91c 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -819,10 +819,160 @@ Macros with multiple statements should be enclosed in a do - while block:
>  
>  	#define macrofun(a, b, c)			\
>  		do {					\
> -			if (a == 5)			\
> +			if ((a) == 5)			\
>  				do_this(b, c);		\
>  		} while (0)
>  
> +Always use parentheses around macro arguments, except for the situations listed
> +below.
> +
> +Examples where parentheses are required around macro arguments:
> +
> +.. code-block:: c
> +
> +	#define foo(a, b)				\
> +		do {					\
> +			(a) = (b);			\
> +		} while (0)
> +
> +.. code-block:: c
> +
> +	#define foo(a)					\
> +		do {					\
> +			(a)++;				\
> +		} while (0)
> +
> +.. code-block:: c
> +
> +	#define cmp_gt(a, b)			((a) > (b))
> +
> +.. code-block:: c
> +
> +	#define foo(a)				do_this(!(a))
> +
> +.. code-block:: c
> +
> +	#define foo(a)				do_this(*(a))
> +
> +.. code-block:: c
> +
> +	#define foo(a)				do_this(&(a))
> +
> +.. code-block:: c
> +
> +	#define get_member(struct_var)		do_this((struct_var).member)
> +
> +.. code-block:: c
> +
> +	#define deref_member(struct_ptr)	do_this((struct_ptr)->member)

I wonder if we really need to give all of these examples?  We've already
said "always put parentheses except in a few cases" - I would think that
would be enough.

> +Situations where parentheses should not be added around arguments, when:

For these, it would be nice to say *why* parentheses shouldn't be added;
helping readers understand the reasoning might have more benefit than
imparting a set of rules.

Thanks,

jon
