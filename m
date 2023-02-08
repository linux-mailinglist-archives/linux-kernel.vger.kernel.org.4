Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DCF68F774
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjBHSxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjBHSxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:53:43 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C683D530CF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:53:41 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g9so13766662pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 10:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ARKAnyJbGCDixUf78i+l0G5zkCQxdhupYbkp6nMWaxY=;
        b=GR+o7rQZRnnVhmV8DKpfe5rs/4FwgZ4XFtphgEXVIyvnOUrWvYWq+8ESj61NPNAwJ3
         dwDUvoAgPU5ZnmGOSkt/w/3k1gynrD0KCQZa/uEl2Ep+xMfE8hg0eCu91ETY08mqyi/e
         0gnt4W1ItvQoMk/ZHnutPdnFE5V4Q++7LHZzY5bxKyxElcU/p8zOyjyMJi0mpQ6ImO1C
         6xar8VdeMfFd7NO8f/nu8KgeuHH9uat10q8VE27KqqqQpxm6B9rGY5RPI+mFyCTcdxSp
         3D0uP99uNs82jdJtiQcMwAd4Vl5MlluR/yNHDyP9P+Tsu0o6wJG+R5ZMvgdLQv/gc/mg
         N/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARKAnyJbGCDixUf78i+l0G5zkCQxdhupYbkp6nMWaxY=;
        b=4t+EmZT1QShB2fS/G2gKga7B59dmm5otMlymNAkMvCI62i8GodjTt0Wyk9iECirkR5
         cdwT8txq47SUidJz41ok3xSMR+2lFeyD5IgUt2Gwt21ZfwkkNc3inmwUuF14TucWgpJ/
         hq0XcyW2TLKSfqC3es1iqtry6iLdv/lxhT/YhsiEeriKql5i+nikKmTEQVrlm4cbQUPW
         028gMSSQ+iwXv5o5rYOjfj64WSG870No4xqg/6zDYmsK5sVL4C/QavdYCMaQcVH7/1ZQ
         L9IKDX72fhztfGrcwTw3VxhVJPk9/g0BTZ0KN2bqzhSxv+VUqjbRKxWSQPLHixV+Q6zV
         fbXg==
X-Gm-Message-State: AO0yUKVN402tqBSKFFw7M/zt0z1rPq2o0LhO4kaJoE4JU/ImhYN0tB0A
        6uIoi5xtl9haWzU/xaTFrhmWMwys+kFAVin12d42uQ==
X-Google-Smtp-Source: AK7set+qg/4GJecRaFbLM82rNlur1zcDRisirla89w82/iIvTgqEVWcL7Bup47k6dMJQSzwaLNHJzj/tQ2m6ZDI8CZA=
X-Received: by 2002:a62:5184:0:b0:5a8:4bf8:174e with SMTP id
 f126-20020a625184000000b005a84bf8174emr372120pfb.29.1675882420676; Wed, 08
 Feb 2023 10:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20230208065133.220589-1-ebiggers@kernel.org>
In-Reply-To: <20230208065133.220589-1-ebiggers@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 8 Feb 2023 10:53:29 -0800
Message-ID: <CAKwvOdkYWXCYr75JkzHqMJ8j=UefW86Zq9tD_AyZQKzW__7TEA@mail.gmail.com>
Subject: Re: [PATCH] randstruct: disable Clang 15 support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Bill Wendling <morbo@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 10:52 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> The randstruct support released in Clang 15 is unsafe to use due to a
> bug that can cause miscompilations: "-frandomize-layout-seed
> inconsistently randomizes all-function-pointers structs"
> (https://github.com/llvm/llvm-project/issues/60349).  It has been fixed
> on the Clang 16 release branch, so add a Clang version check.
>
> Fixes: 035f7f87b729 ("randstruct: Enable Clang support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks for the patch and report. Guessing that wasn't fun to debug.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  security/Kconfig.hardening | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 53baa95cb644f..0f295961e7736 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -281,6 +281,9 @@ endmenu
>
>  config CC_HAS_RANDSTRUCT
>         def_bool $(cc-option,-frandomize-layout-seed-file=/dev/null)
> +       # Randstruct was first added in Clang 15, but it isn't safe to use until
> +       # Clang 16 due to https://github.com/llvm/llvm-project/issues/60349
> +       depends on !CC_IS_CLANG || CLANG_VERSION >= 160000
>
>  choice
>         prompt "Randomize layout of sensitive kernel structures"
>
> base-commit: 4ec5183ec48656cec489c49f989c508b68b518e3
> --
> 2.39.1
>
>


-- 
Thanks,
~Nick Desaulniers
