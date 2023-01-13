Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EE966A6E3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjAMXUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjAMXUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:20:08 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB58BCB2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:20:08 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id h7so13047716pfq.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84xU26GE6B2A0FvL+1YrfpDZhPaiag0vDWKb7+nHpZ4=;
        b=HzOuTP2OMT93SpVk7dxZEI5EeA5lvl3aMks7aEPL0y4M2MAHsCu1hyNG1blHmW8ccl
         MakQop5gTGOXKoV0JWl3p9eyUjR0G8cl9Jq41Az0VtBP9PdqoM3JAtAPeQvRUktsYvqF
         L4Cc1J43BtxEQCXbQSCkXOArtWT0jW03G0wZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84xU26GE6B2A0FvL+1YrfpDZhPaiag0vDWKb7+nHpZ4=;
        b=EmV/wi04oGmmpj/yN9sCOpL/tyoXCr5JCflB9uwYQAg3M/O4+VmMdb/VaNVMkW8ULZ
         m6dupiyphpQ0147eREgv2mpipTUUnCwaW7dekjLNnu8tETl88LHVC6bE7+5LvwyL9BNZ
         Qodp02lE9UZUi6PTJ7iINQH6Uiqh4rom0pjUk0kEq7MNmrvIebW14raGYvDIyoLhYsSQ
         +gwKt0XKqongQPYe4b1bXzfT+BjC0pwLF1WX8/NzcjG3JwRSXJyHGdQBqIeBXOm2hf+h
         UDinYc2FM9RsOdK/c6X+tIxUE2TBRVdYykY2Ly+0NT8CbHHCREpIjutqRYkvqOm4s1zO
         a4Zw==
X-Gm-Message-State: AFqh2kpzAUqQReu+bmQlJ6ExxI19BSfraiiFP+cCjeVIuRpWTGw7q7wX
        QyJKWEjHa7wFJCZpo2xv/cwMwA==
X-Google-Smtp-Source: AMrXdXucWQV00sJtH/NC78tZOA7xDpH4uwBDfzBrARIIStWMoHMs0HM7zt4mNhpDJLkM/CmTLPNpBw==
X-Received: by 2002:a05:6a00:88a:b0:581:19ed:78b9 with SMTP id q10-20020a056a00088a00b0058119ed78b9mr83251283pfj.2.1673652007689;
        Fri, 13 Jan 2023 15:20:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q29-20020aa7961d000000b0058bacd6c4e8sm3003724pfg.207.2023.01.13.15.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:20:07 -0800 (PST)
Date:   Fri, 13 Jan 2023 15:20:06 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Subject: Re: [PATCH] gcc-plugins: Fix build for upcoming GCC release
Message-ID: <202301131519.31DAEA31E4@keescook>
References: <20230113173033.4380-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113173033.4380-1-palmer@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 09:30:33AM -0800, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> The upcoming GCC release has refactored the gimple plugin interface a
> bit and unless gimple-iterator.h is included before gimple-fold.h I end
> up with a bunch of missing declarations when building the stack
> protector plugin.
> 
> Link: https://inbox.sourceware.org/gcc-patches/CAFiYyc2q%2Bc-0uZb-zAskmR_U%2BM%2BxQfp-W00ZbLErfjx=j5qHGg@mail.gmail.com/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  scripts/gcc-plugins/gcc-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Does this work for you?


diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 9a1895747b15..309b39cee275 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -72,6 +72,9 @@
 #include "stor-layout.h"
 #include "internal-fn.h"
 #include "gimple-expr.h"
+#if BUILDING_GCC_VERSION >= 13000
+#include "gimple-iterator.h"
+#endif
 #include "gimple-fold.h"
 #include "context.h"
 #include "tree-ssa-alias.h"
@@ -88,7 +91,9 @@
 #include "gimple.h"
 #include "tree-phinodes.h"
 #include "tree-cfg.h"
+#if BUILDING_GCC_VERSION < 13000
 #include "gimple-iterator.h"
+#endif
 #include "gimple-ssa.h"
 #include "ssa-iterators.h"
 

> 
> diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
> index 9a1895747b15..2c3a3079128a 100644
> --- a/scripts/gcc-plugins/gcc-common.h
> +++ b/scripts/gcc-plugins/gcc-common.h
> @@ -72,6 +72,7 @@
>  #include "stor-layout.h"
>  #include "internal-fn.h"
>  #include "gimple-expr.h"
> +#include "gimple-iterator.h"
>  #include "gimple-fold.h"
>  #include "context.h"
>  #include "tree-ssa-alias.h"
> @@ -88,7 +89,6 @@
>  #include "gimple.h"
>  #include "tree-phinodes.h"
>  #include "tree-cfg.h"
> -#include "gimple-iterator.h"
>  #include "gimple-ssa.h"
>  #include "ssa-iterators.h"
>  
> -- 
> 2.39.0
> 

-- 
Kees Cook
