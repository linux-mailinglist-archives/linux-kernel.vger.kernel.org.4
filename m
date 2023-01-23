Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8608C678AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjAWWmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjAWWmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:42:46 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4CAEFB8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:42:44 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id y3-20020a17090a390300b00229add7bb36so12340077pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tfx1Kdq5JZAOuptkigDf9HmlIBpLXTHQUZNqsMf2kmA=;
        b=rk1lSfQWy2wCEX1pjGdFn1E0L8p68Q4hvD0CrAgl/4cJbOsrGiSjCWekK8+mB1ljsM
         yYHb50bfnSpgh1phzK85MNh7pVYbQ0bhKE7f7v+f/h4bcoDOaxdhgMXB3OqR4Mkj/a7P
         e7GHRYuNlQwozL7/Puy1CUp2ZqLW8OujD4nhmz3qSEhOwBKbxA3+DHNFAQOxjdSb21I3
         a5M510E60MMFumwrnGGHGRDgHCKfUW2R6hBpgNuBsrFaz4xEIs3j9PxH0cYJZjs4Zg/e
         tm3NqqKO5KkUyYiKbzgjZQMsPpirowjfvLtLe21Iymi7LP683K55SkQChQkstNPbH6sj
         a4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfx1Kdq5JZAOuptkigDf9HmlIBpLXTHQUZNqsMf2kmA=;
        b=lIMA6rF7BZWGENKefwx4VV8E1+30E/JzAuO8oy5cYbYd2f8PRVOPFWHQR0nnKM1Kky
         uyqrGgU0qnaQO48mlbu8ipvU3vcE3KHyx1zjftPow0oCuNPa8naTFJ6PVrlH+AZkOcOI
         mGxZ/ejl/CPR1rRnZHxBvkxdKmjcjdOCPaE+SG4ACfOo1Hipi2EMMuNqrRIHkOmDFtmf
         TZ4EiAvLJS2IllkpvEY4quoO99m5TtutWjlUvC90fa+CI1jb3jMhGMtM8B0W38fFMF+b
         73+iFtP2bwGYvsP2qIoRK3HYHlLpi7M6HINRy541tSJt7xhsahBHX00lTu7FwSsdBeZE
         G8PQ==
X-Gm-Message-State: AFqh2kptQKJznL6ln/I4szfaq9RDtZacaXSWS+H31r1N9RC4GfaaBD4c
        J2+wlNt3733DDBIFJHp6ZZ5vqA==
X-Google-Smtp-Source: AMrXdXtOzWq/4QLp3Fy769DE0LWZYDKqTo2myl0pB3Ch0HjvCL425hOxWMXkGqmYvSgsSJgjH/WipQ==
X-Received: by 2002:a17:902:e80e:b0:193:256d:8afe with SMTP id u14-20020a170902e80e00b00193256d8afemr738261plg.2.1674513763847;
        Mon, 23 Jan 2023 14:42:43 -0800 (PST)
Received: from google.com (13.65.82.34.bc.googleusercontent.com. [34.82.65.13])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902aa4b00b001948107490csm234598plr.19.2023.01.23.14.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:42:42 -0800 (PST)
Date:   Mon, 23 Jan 2023 14:42:39 -0800
From:   William McVicker <willmcvicker@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: do not automatically add -w option to modpost
Message-ID: <Y88NX11/LcnfloYk@google.com>
References: <20230123052653.711899-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123052653.711899-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-16.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/23/2023, Masahiro Yamada wrote:
> When there is a missing input file (vmlinux.o or Module.symvers), you
> are likely to get a ton of unresolved symbols.
> 
> Currently, Kbuild automatically adds the -w option to allow module builds
> to continue with warnings instead of errors.
> 
> This may not be what the user expects because it is generally more useful
> to catch all possible issues at build time instead of at run time.
> 
> Let's not do what the user did not ask.
> 
> If you still want to build modules anyway, you can proceed by explicitly
> setting KBUILD_MODPOST_WARN=1. Since you may miss a real issue, you need
> to be aware of what you are doing.
> 
> Suggested-by: William McVicker <willmcvicker@google.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/Makefile.modpost | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 43343e13c542..9254ed811ddd 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -121,16 +121,14 @@ modpost-args += -e $(addprefix -i , $(KBUILD_EXTRA_SYMBOLS))
>  
>  endif # ($(KBUILD_EXTMOD),)
>  
> -ifneq ($(missing-input),)
> -modpost-args += -w
> -endif
> -
>  quiet_cmd_modpost = MODPOST $@
>        cmd_modpost = \
>  	$(if $(missing-input), \
>  		echo >&2 "WARNING: $(missing-input) is missing."; \
>  		echo >&2 "         Modules may not have dependencies or modversions."; \
> -		echo >&2 "         You may get many unresolved symbol warnings.";) \
> +		echo >&2 "         You may get many unresolved symbol errors.";) \

You need to move the closing parenthesis to come at the end of these
echo messages. Otherwise you get this new message unconditionally.

I also found during testing that the refactoring in commit f73edc8951b2
("kbuild: unify two modpost invocations") dropped the check for missing
KBUILD_EXTRA_SYMBOLS. That means if an external module depends on
another external module and sets:

  KBUILD_EXTRA_SYMBOLS=/path/to/ext_module/Module.symvers

... then make will fail even with KBUILD_MODPOST_WARN=1 since we
unconditionally add KBUILD_EXTRA_SYMBOLS to the modpost-args like this:

  modpost-args += -e $(addprefix -i , $(KBUILD_EXTRA_SYMBOLS))

To fix this, I suggest you also take the following patch so that
KBUILD_MODPOST_WARN=1 will allow you to skip those unresolved symbols as
well:

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 931a3272a4ba..0e2f7fa58056 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -149,14 +149,12 @@ include $(kbuild-file)

 output-symdump := $(KBUILD_EXTMOD)/Module.symvers

-ifeq ($(wildcard Module.symvers),)
-missing-input := Module.symvers
-else
-modpost-args += -i Module.symvers
-modpost-deps += Module.symvers
-endif
+input-symdump := Module.symvers $(KBUILD_EXTRA_SYMBOLS)
+existing-input-symdump := $(wildcard $(input-symdump))
+missing-input := $(filter-out $(existing-input-symdump), $(input-symdump))

-modpost-args += -e $(addprefix -i , $(KBUILD_EXTRA_SYMBOLS))
+modpost-deps += $(existing-input-symdumps)
+modpost-args += -e $(addprefix -i , $(existing-input-symdump))

 endif # ($(KBUILD_EXTMOD),)


With those changes, the patch works for me as expected. I verified I get
a build time error when referencing unresolved symbols without setting
KBUILD_MODPOST_WARN=1. And then I verified setting KBUILD_MODPOST_WARN=1
treated those errors as warnings.

Thanks,
Will

> +		echo >&2 "         You can set KBUILD_MODPOST_WARN=1 to turn errors into warning"; \
> +		echo >&2 "         if you want to proceed at your own risk."; \
>  	$(MODPOST) $(modpost-args)
>  
>  targets += $(output-symdump)
> -- 
> 2.34.1
> 
