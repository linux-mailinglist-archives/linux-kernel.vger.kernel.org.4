Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B34261666A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiKBPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiKBPna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:43:30 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7329328700
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:43:29 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b11so16618076pjp.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWzb2SKkWTuON7pNcNwFRnwOMg1HNM3x+PlBBYRnE78=;
        b=b1IH6B/wne44OiQXZ9i7FSHJfVW3zIn74ViSqHYAsPnDbPDFo4b0mp4Ea/23Y8yiZp
         4Na6VVGOm+h4UD3nlKM9Rl3pFiFLTzf9UB+jUhfO+J4ZNn+X8eC78BvcBr769QMsJqUU
         WTfGJ4gwtPde3j8W3mqjzgHAHbhf+xT06ghwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWzb2SKkWTuON7pNcNwFRnwOMg1HNM3x+PlBBYRnE78=;
        b=BX1QXP1m7lr62A8c3QS9QyRQbWbiyTIAFvGI/Wcu5fvP4ZoZywNjfnlEuAj13Vu0rF
         AisQ0BTmhyX0rBjVkUc75Y6tO7DQXagUmNmaMwAl87GCQIR+QrzIy/I3qBT7Ua+z4VtD
         dh7q+Xe6V4TQG2loNTIAEmMPpAcai7wZeu88eLR+il1hwaxc7Sp27FxFoTooFBPdYnLo
         kqnbuVfGG8+oZgahlNxzO0lNGlKP6MUBePDzvtJ3XCbbkDRm3FoBPNaAr+GjRPVgHXmE
         HWj4JPhch7hYqVTN1zkl6TAMOyDIkUzLDvG4Q3kwGwBxuS4IJCyML46A/ak5NgQmAhyv
         GjfQ==
X-Gm-Message-State: ACrzQf0tqeXedHZkz4Zy7UUDGf64tN9QOT7nQYFSd+irUOQnM+b+rjfo
        lawmGSeXTnogMSVJ21HSuPIV4A==
X-Google-Smtp-Source: AMsMyM7PDeQil3IUTDK8DEQhhfPtLai6Y8bKaPW2tqDAKdyYKrgbMX/ec7FMD6Z/EWccGgv35ijpyA==
X-Received: by 2002:a17:903:32cf:b0:187:4b3a:15fd with SMTP id i15-20020a17090332cf00b001874b3a15fdmr2922849plr.99.1667403808948;
        Wed, 02 Nov 2022 08:43:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w10-20020aa79a0a000000b0056c681af185sm8605569pfj.87.2022.11.02.08.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:43:28 -0700 (PDT)
Date:   Wed, 2 Nov 2022 08:43:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] drm/fsl-dcu: Fix return type of
 fsl_dcu_drm_connector_mode_valid()
Message-ID: <202211020843.A19F75B@keescook>
References: <20221102154215.78059-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102154215.78059-1-nathan@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 08:42:15AM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
>   drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c:74:16: error: incompatible function pointer types initializing 'enum drm_mode_status (*)(struct drm_connector *, struct drm_display_mode *)' with an expression of type 'int (struct drm_connector *, struct drm_display_mode *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           .mode_valid = fsl_dcu_drm_connector_mode_valid,
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
> 
> ->mode_valid() in 'struct drm_connector_helper_funcs' expects a return
> type of 'enum drm_mode_status', not 'int'. Adjust the return type of
> fsl_dcu_drm_connector_mode_valid() to match the prototype's to resolve
> the warning and CFI failure.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
