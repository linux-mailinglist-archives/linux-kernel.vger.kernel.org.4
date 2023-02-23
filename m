Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8076A0068
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjBWBEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjBWBEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:04:20 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9332CC46
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:03:57 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l1so729529pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WeVf+lvGNeVYubOJ3KmhlwMD0qDbcIcPAA2fSn/VLqI=;
        b=eUM2OCcj2hc2PrhAjQULqh1Ap6c6rwgKSXbSnPKR3n7tl9VN6COEM/V7oa6XtHgc1o
         8DouMvF8dGS+e5bk9wKEM24Rvk5WogEf9k+aIzh52nH7XmqZVOHxCUkjICO0qMR1aiqq
         gm+t9gGJBUgTjaCAGYSZk1TFzoPhhTNuIO2SgjD75/lyc0QSdTZL0r6/6vmWi4EQeXGk
         zbEdur62BFlMDqX9n5dSHCmpWd3rkWvwwlqPAqeA+6RGWHYsD5lhFLnvgBWjVFdr9lXu
         IT7v6+pbqT4CXHTmaFIEIpYFWy+GCUVd5iS5UjkKtAEBhG9aZI4Z10Iq5cqF+4ezx51z
         y1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeVf+lvGNeVYubOJ3KmhlwMD0qDbcIcPAA2fSn/VLqI=;
        b=auNjOwvtSiQlxRFkjusAfB6ajt63EWn6SlygZFmdwn7LkXlTIl6XIWGHtii8n3ATvu
         0eYCrckEQt1JmYC/7/d2McR8Ow5lEq+QzI7WH5dMquObyjyd2DAA5FiGJBb8kACvbAzN
         eRUAgRn8dnnmEVPwN2F90fCEk2v5FSwu4zdlWsMISmNB44m9GHzuKmY3sSOB56hUV1DG
         U1FeVEIcKiBCaztMYutMDWiGcMAPTuTkV6CA4Bk/HRdz9d6G91bpddxNfYL+IGCARlgf
         M5qgec/4iZLsernBT6JjGz3NAy+JSxYOK0ARkuBz2fePLJh96Mf8qT47LfeVAugU1HpY
         t0Gg==
X-Gm-Message-State: AO0yUKX4x8Tu+2aj9Ng6Mx9d8k8GYN9ZvBUChrkwTjExqE2lJO56E29X
        I+OCbeqa8+Jvl4528XA71d3KVNscRlA=
X-Google-Smtp-Source: AK7set8TXzXaC2/fn0bf1HEdmolAPvXAKURAvIMr8ybRUcpKdxXj2NVbwHr01MjBJ8TL++W/fB2HVA==
X-Received: by 2002:a05:6a21:329e:b0:c2:b249:fe9a with SMTP id yt30-20020a056a21329e00b000c2b249fe9amr12729950pzb.18.1677114236845;
        Wed, 22 Feb 2023 17:03:56 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7904f000000b005a8da960fa8sm5648149pfo.144.2023.02.22.17.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 17:03:55 -0800 (PST)
Date:   Thu, 23 Feb 2023 01:03:49 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vernon Yang <vernon2gm@gmail.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: fix help comment of SLUB_DEBUG[_ON]
Message-ID: <Y/a7db7v9zJJnX30@localhost>
References: <20230222232058.66971-1-vernon2gm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222232058.66971-1-vernon2gm@gmail.com>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 07:20:58AM +0800, Vernon Yang wrote:
> Since commit 081248de0a02 ("kset: move /sys/slab to /sys/kernel/slab"),
> the SYSFS path of slab was modified, so fix up the help comment of
> SLUB_DEBUG to use the correct one.
> 
> And now the "slub_debug" parameter on boot that is support for more
> fine grained debug control, so fix up help comment of SLUB_DEBUG_ON
> for "no support" to "support".
> 
> Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
> ---
>  mm/Kconfig.debug | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index fca699ad1fb0..732043bf56c6 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -61,8 +61,8 @@ config SLUB_DEBUG
>  	help
>  	  SLUB has extensive debug support features. Disabling these can
>  	  result in significant savings in code size. This also disables
> -	  SLUB sysfs support. /sys/slab will not exist and there will be
> -	  no support for cache validation etc.
> +	  SLUB sysfs support. /sys/kernel/slab will not exist and there
> +	  will be no support for cache validation etc.

After commit ab4d5ed5eeda ("slub: Enable sysfs support for !CONFIG_SLUB_DEBUG"),
"Disabling SLUB_DEBUG also disables SLUB sysfs support" is not true anymore.

>  config SLUB_DEBUG_ON
>  	bool "SLUB debugging on by default"
> @@ -73,10 +73,10 @@ config SLUB_DEBUG_ON
>  	  Boot with debugging on by default. SLUB boots by default with
>  	  the runtime debug capabilities switched off. Enabling this is
>  	  equivalent to specifying the "slub_debug" parameter on boot.
> -	  There is no support for more fine grained debug control like
> -	  possible with slub_debug=xxx. SLUB debugging may be switched
> -	  off in a kernel built with CONFIG_SLUB_DEBUG_ON by specifying
> -	  "slub_debug=-".
> +	  There is support for more fine grained debug control like
> +	  possible with slub_debug=xxx, details in Documentation/mm/slub.rst.
> +	  SLUB debugging may be switched off in a kernel built with
> +	  CONFIG_SLUB_DEBUG_ON by specifying "slub_debug=-".

I think this is a misunderstanding. SLUB_DEBUG_ON is equivalent to
passing boot parameter slub_debug=FUPZ, and what the help text says is that

"You can enable slub debugging by default using this config option but
 there is no support for fine-grained control like what slub_debug
 boot parameter provides."

 IOW SLUB_DEBUG_ON cannot be used to have same effect as passing
 something like slub_debug=F.

>  
>  config PAGE_OWNER
>  	bool "Track page owner"
> -- 
> 2.34.1
> 
> 
