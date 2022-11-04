Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB58618FC3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 06:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiKDFAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 01:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKDFA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 01:00:29 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFFF25EB6;
        Thu,  3 Nov 2022 22:00:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b185so3540401pfb.9;
        Thu, 03 Nov 2022 22:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RbsKwk2Ze0a5EYeW42rZ4T7BWU2ghCIbOlL+4KjCrSA=;
        b=RFzz9X9p1w1SEIQ63P5JxPgyV2EcluHej5H3tsRel7O7ey7zGeegO7k9PwoTsMNjrs
         T5cb96OwKV0zwXbw4r1rJVQQOrMo+O1MJWpmWLq06pU98nvGNL8ZuK5HjNubjpazbiLs
         x9btqZAQljMdHgAyqjHeau03vEp1aUvhmeeNEJdZ/abpbI9+MaSApNk13lAIlIsekb2/
         CngVaHk1ddZlmGFB2U9Y4W5uE13FeG4tARBHIWhmP+4mQrsWwV3h747w6duX8sC7znKF
         UtqJ/2DzQdqCX5BXJH+HWDw6gKyRQS8sr4hCiz2C3nKPwkBHYKovINGi0rVL0hBEIMIw
         +kDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbsKwk2Ze0a5EYeW42rZ4T7BWU2ghCIbOlL+4KjCrSA=;
        b=dBPUQk9+pT3Z5e/92sKCay4lsTakOfFWHSSfNMfa/E1HqPPWtXvyj/RVvxeR5iTRJH
         o/SVFBzH6w7SSYSpuKfcE5gC0Nj+/v+vuJ2XWZqIArs0NSNwxPixgqGePf2gcdRrb4CV
         yx/kUqr3G4FD11I6vmVueJV/PiuUopOLwq+A+q2ObXP7dXfGZ6+y1opZ4Ja8plAgkZ/D
         5F7eX9I2D8Ii51iJDalQIjr5Tve9FFBZtbvrtBgbcH16h+H9uwqYz/r+w5Vr/r/qbH3A
         pU+EEN7TOkmyLESHJkPmYwCIaVlzc0PJ1QMC3Uxb88ssAZK2mqFeEmNwYrH3yJST3MyD
         NarQ==
X-Gm-Message-State: ACrzQf3lzxcmWmDS8T9rabsvwr71wd/izMVkDUHnh1IOOBGTVhHhRRqj
        Y+gxgr7QtgEfTxwkn7cS4zSZfdxzdHtjazz0
X-Google-Smtp-Source: AMsMyM4j1xPj2Iui456ebdwBJaC4wCNuIKpEFlws2n1lOFGR5OsDZ89KfBpXvz0TsIH42WasFCiXQQ==
X-Received: by 2002:a63:dc45:0:b0:43c:b43f:5228 with SMTP id f5-20020a63dc45000000b0043cb43f5228mr267639pgj.58.1667538028712;
        Thu, 03 Nov 2022 22:00:28 -0700 (PDT)
Received: from mail.google.com (125-237-50-34-fibre.sparkbb.co.nz. [125.237.50.34])
        by smtp.gmail.com with ESMTPSA id d16-20020a63ed10000000b00459a36795cbsm1569438pgi.42.2022.11.03.22.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 22:00:28 -0700 (PDT)
Date:   Fri, 4 Nov 2022 18:00:22 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5] [next] dlm: replace one-element array with fixed size
 array
Message-ID: <Y2ScZqWnJKe7J6NR@mail.google.com>
References: <202210111305.743F591@keescook>
 <Y0XQsqdRzlrSpgOh@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0XQsqdRzlrSpgOh@mail.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 09:23:14AM +1300, Paulo Miguel Almeida wrote:
> One-element arrays are deprecated. So, replace one-element array with
> fixed size array member in struct dlm_ls, and refactor the rest of the
> code, accordingly.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/228
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836
> Link: https://lore.kernel.org/lkml/Y0W5jkiXUkpNl4ap@mail.google.com/
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Changelog:
> 
> v5: use preferred sizeof style. Req: Gustavo Silva
> v4: resend patch using the right version number. Req: Gustavo Silva
> v3: replace one-element array with a fixed size array. Req: Kees Cook
> v2: patch resent as I had an issue with a <CRLF> char in my mail client
> v1: https://lore.kernel.org/lkml/Y0ICbf8tCtXMn+W0@mail.google.com/
> ---
> 
>  fs/dlm/dlm_internal.h | 2 +-
>  fs/dlm/lockspace.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
> index e34c3d2639a5..94fadb619ba0 100644
> --- a/fs/dlm/dlm_internal.h
> +++ b/fs/dlm/dlm_internal.h
> @@ -670,7 +670,7 @@ struct dlm_ls {
>  	void			*ls_ops_arg;
>  
>  	int			ls_namelen;
> -	char			ls_name[1];
> +	char			ls_name[DLM_LOCKSPACE_LEN + 1];
>  };
>  
>  /*
> diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
> index bae050df7abf..9479c8110979 100644
> --- a/fs/dlm/lockspace.c
> +++ b/fs/dlm/lockspace.c
> @@ -473,7 +473,7 @@ static int new_lockspace(const char *name, const char *cluster,
>  
>  	error = -ENOMEM;
>  
> -	ls = kzalloc(sizeof(struct dlm_ls) + namelen, GFP_NOFS);
> +	ls = kzalloc(sizeof(*ls), GFP_NOFS);
>  	if (!ls)
>  		goto out;
>  	memcpy(ls->ls_name, name, namelen);
> -- 
> 2.37.3
> 

Christine, David,

Just following up on this patch. Is there anything that either of you
want me change for this patch to be merged?

thanks!

- Paulo A.
