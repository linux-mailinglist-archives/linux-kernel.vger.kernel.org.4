Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A755616D6F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiKBTHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiKBTGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:06:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB9EC776
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:06:36 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b185so17243759pfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLJw50A1K+KhusFBEa675+xxaU3caL5GDgA+x/6AGwQ=;
        b=eanRVW/LBbSyQtTn8NWCZTTDAawhljklM58TSIe0LHlwW/gHbMD11JP3ckeaEe/msg
         vmppBy0RmvOGmkJW6vTqFKB6oG4y+0rkYyOuCChrP4Sy/x03U/caHHgMIFnNNWlXRSYQ
         MKBSw57TYyF6OcudfzZhtv+PDEccU/3X7mxRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLJw50A1K+KhusFBEa675+xxaU3caL5GDgA+x/6AGwQ=;
        b=g3FmnV1qQUUHmnfgnfOh8+wRiNA/n/MQvcOgOeiJaEHJIokzAgk4yK7DgETWAIYMjJ
         Qtz9J6iFDvV3XuPinD+uWYxx99zhzMgVeuvOltU5Xx1APYUyM8FQe6kTNu2LAeVN0+ks
         O4Ps1xeHuK/HD/EeliDJ2M6L9b93AJLDPl3hI5vCGygZ4i3O09znqUYdDArTJX46mzPg
         17o2jtwvWPiProQCJaA5FgduohnfKb/t/9d2TV900lTfXNCrvSHf2Ee9sqhs+5jdu8Ci
         JPo0K85oiWZ8i4zttZoLDphqQ5Rj/m1LC2vyG/WEIHVxMe8OMkYh+B18qkHUzkHzC3hk
         4Jwg==
X-Gm-Message-State: ACrzQf0cdWNuE7TrldroK+TtTAkhrmccCOzEYqv8li/t+QE47tuJ2CGb
        n5grZVppAMl13Khv5VutLg6g/g==
X-Google-Smtp-Source: AMsMyM5nOP7TB+tQ3IHpynS+a4tGqv36tuqeuJEkR1BO6kWK8sdX+uSJsUdso0ZtKCVhfl6YA8bm0g==
X-Received: by 2002:a05:6a00:1688:b0:53b:4239:7c5c with SMTP id k8-20020a056a00168800b0053b42397c5cmr27219671pfc.81.1667415995509;
        Wed, 02 Nov 2022 12:06:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b00186727e5f5csm8710774plg.248.2022.11.02.12.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:06:35 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:06:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] drm/meson: Fix return type of
 meson_encoder_cvbs_mode_valid()
Message-ID: <202211021206.F5C5954F66@keescook>
References: <20221102155242.1927166-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102155242.1927166-1-nathan@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 08:52:42AM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
>   drivers/gpu/drm/meson/meson_encoder_cvbs.c:211:16: error: incompatible function pointer types initializing 'enum drm_mode_status (*)(struct drm_bridge *, const struct drm_display_info *, const struct drm_display_mode *)' with an expression of type 'int (struct drm_bridge *, const struct drm_display_info *, const struct drm_display_mode *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           .mode_valid = meson_encoder_cvbs_mode_valid,
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
> 
> ->mode_valid() in 'struct drm_bridge_funcs' expects a return type of
> 'enum drm_mode_status', not 'int'. Adjust the return type of
> meson_encoder_cvbs_mode_valid() to match the prototype's to resolve the
> warning and CFI failure.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
