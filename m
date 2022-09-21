Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F05BFCF8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIULa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIULa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:30:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D065961106;
        Wed, 21 Sep 2022 04:30:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so1933925pjk.2;
        Wed, 21 Sep 2022 04:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=R/5/bZN4kuofLcqZ8N/8Nt9PsU4TMvL8T88QA1VrZP0=;
        b=D04zDq0hPLt8U2FZikbD41SLVhmsjzWj2wUhsq0GmlrqsjL5YUpnq0c9oxrMmprnQL
         7A2jHPavxOTRJMQ5E3RLSyJlVkeIrBE4dmo6NtZuqQ8Eq+iqmHfbsy0//G/mP+3FN/3l
         FFp4LhRjfDSJOEVU6DbA8gsMrnYba5shkYu6x7kHyrlRCbh9/dRTgj9QCrT32AOZp5LR
         6zGn+K8kJNNDTRm8zknLLNTvrfkRQizRoXDXocDV5FwylMI+LiZrB7dx1jQLzBw0cWNc
         s/lXtKFash+x7928kTm7arrLspMFO7P3k59ErqjooTI5Eyg54MkkcneRR1dShSCUhMCy
         3/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=R/5/bZN4kuofLcqZ8N/8Nt9PsU4TMvL8T88QA1VrZP0=;
        b=UXbYx8Om9PY0uo+wZnYFdqRy71tukuKLI4SyMOPEFDvbFfOsWGFXhjrC4O2IuHLILZ
         DeHrjeSRG+B7eC87C8/MV49giR9al9QEEEQSycRIBuSU6B8nAkA0VQT0aKM6V7Va8WxZ
         HwH8KrvvO/sN9g4sCWiPBfN1mOPdzCIIyfLJE288osu3AqKvQI5Un1yzdxC/cQ6qNQ3+
         6UfjiFnJUOBKvQ0nEcYZ/0b061lIbVfhVdz8Y/HKEBzUSqhz1o8ypnP+nO1/GGQCnoOZ
         opBKPKrLQ8je7NcDyEDC+z6lCdzfa0A5HyIEgQAFwcLK527AYc/1ReSsAM2mRxGVC/1o
         Pa8w==
X-Gm-Message-State: ACrzQf3W2sgB/VUl6/dn/mc2a0Er390zis/6/1n3m9CNIc1wT7Pil+cl
        OzKPSoDydb6vQ0S7jOnbqug=
X-Google-Smtp-Source: AMsMyM40XX2EHRJ1cqVGM5ZxKo0btuWH/TwwFpusiJiH43zIDSFriOyWiT6twsWwEJIit1RFmXEKwA==
X-Received: by 2002:a17:902:eb90:b0:178:25ab:b3ee with SMTP id q16-20020a170902eb9000b0017825abb3eemr4242909plg.23.1663759825282;
        Wed, 21 Sep 2022 04:30:25 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id m17-20020a63f611000000b0041c0c9c0072sm1686609pgh.64.2022.09.21.04.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:30:24 -0700 (PDT)
Date:   Wed, 21 Sep 2022 20:30:12 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, kernel@openvz.org,
        Kees Cook <keescook@chromium.org>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: Make failslab writable again
Message-ID: <Yyr1xONdw8dBgsKr@hyeyoo>
References: <20220920121111.1792905-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920121111.1792905-1-alexander.atanasov@virtuozzo.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 03:11:11PM +0300, Alexander Atanasov wrote:
> In (060807f841ac mm, slub: make remaining slub_debug related attributes
> read-only) failslab was made read-only.
> I think it became a collateral victim to the two other options for which
> the reasons are perfectly valid.
> Here is why:
>  - sanity_checks and trace are slab internal debug options,
>    failslab is used for fault injection.
>  - for fault injections, which by presumption are random, it
>    does not matter if it is not set atomically. And you need to
>    set atleast one more option to trigger fault injection.
>  - in a testing scenario you may need to change it at runtime
>    example: module loading - you test all allocations limited
>    by the space option. Then you move to test only your module's
>    own slabs.
>  - when set by command line flags it effectively disables all
>    cache merges.

Maybe we can make failslab= boot parameter to consider cache filtering?

With that, just pass something like this:
	failslab=X,X,X,X,cache_filter slub_debug=A,<cache-name>

Users should pass slub_debug=A,<cache-name> anyway to prevent cache merging.

> 
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Vijayanand Jitta <vjitta@codeaurora.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Link: http://lkml.kernel.org/r/20200610163135.17364-5-vbabka@suse.cz
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  Documentation/mm/slub.rst |  2 ++
>  mm/slub.c                 | 16 +++++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> V1->V2: Fixed commit message. Flags are set using WRITE_ONCE.
> 
> diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
> index 43063ade737a..86837073a39e 100644
> --- a/Documentation/mm/slub.rst
> +++ b/Documentation/mm/slub.rst
> @@ -116,6 +116,8 @@ options from the ``slub_debug`` parameter translate to the following files::
>  	T	trace
>  	A	failslab
>  
> +failslab file is writable, so writing 1 or 0 will enable or disable
> +the option at runtime. Write returns -EINVAL if cache is an alias.
>  Careful with tracing: It may spew out lots of information and never stop if
>  used on the wrong slab.
>  
> diff --git a/mm/slub.c b/mm/slub.c
> index 862dbd9af4f5..57cf18936526 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5617,7 +5617,21 @@ static ssize_t failslab_show(struct kmem_cache *s, char *buf)
>  {
>  	return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_FAILSLAB));
>  }
> -SLAB_ATTR_RO(failslab);
> +
> +static ssize_t failslab_store(struct kmem_cache *s, const char *buf,
> +				size_t length)
> +{
> +	if (s->refcount > 1)
> +		return -EINVAL;
> +
> +	if (buf[0] == '1')
> +		WRITE_ONCE(s->flags, s->flags | SLAB_FAILSLAB);
> +	else
> +		WRITE_ONCE(s->flags, s->flags & ~SLAB_FAILSLAB);
> +
> +	return length;
> +}
> +SLAB_ATTR(failslab);
>  #endif
>  
>  static ssize_t shrink_show(struct kmem_cache *s, char *buf)
> 
> base-commit: 80e78fcce86de0288793a0ef0f6acf37656ee4cf
> -- 
> 2.31.1
> 

-- 
Thanks,
Hyeonggon
