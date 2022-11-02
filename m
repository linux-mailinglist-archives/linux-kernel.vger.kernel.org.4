Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F00616D70
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiKBTH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiKBTHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:07:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AB1EE10
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:06:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u6so17462444plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=71cIGVUi+2jVEjXbTMLP+sHbufV3ZHGsKiLlY1xVyE4=;
        b=fjGGSl6TZGy6MhSeAlQ9V3XlMvK9/dKuFuRpy8Ew/54JsuPSu62uZ6R7xn5ia9d6mL
         xmWYa3LxJrXqfZL52eFl4W2S7p0zWy5w3mpFGbEqxRpS4Jz1o7xWa7Czjp+BMc/29Ion
         AObRStps16tXSHWBnfGNhb6ksTT8C1QPkW5mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71cIGVUi+2jVEjXbTMLP+sHbufV3ZHGsKiLlY1xVyE4=;
        b=cc4hLp3gqiI7elqEu2ExjwkMgo8vA8NedmwbYqXItO9jl/+QKxIfbrSOy25TBWxcjJ
         JfVZ5DFX1jAy06hbBcChPZte2+g/ICJUfzu9fu/oE3iLO+CZnlpURQJ2tSIfSsAw9vqb
         x0syOsHn732g/G5pL8hewLZibQU1/3CDcmJA+QFu1TpTbKNUqx+ZmU/Ybt0CCGkX0Cqo
         ejrcSqWAeFhLMW2xSbDcBvgSx0A+uTV4GOy1O4+KV5EaGJyb+C3b+CGxim9r22q4MWTD
         zmhMkNRb0uQMIeJ6nxtmFAlCHcRGZfNynCPRHo7a1+Dq4e7qWA5qIq1ssI/y7iyzHE1z
         Hqfw==
X-Gm-Message-State: ACrzQf3oTkqB0XuxTZ/hwZj+zsjP5ptTZCe3Y7Tfs5YkzaDnLMBaYdKj
        CIvUy/uDq7kZGE/GOhB1xdSs9w==
X-Google-Smtp-Source: AMsMyM7w0eDTA7/r8K67/N2jqI2Q9w/r0P434xSeZcahrG3KviKdGBv3lb4n7+RNP3OVrJqxGz8rXA==
X-Received: by 2002:a17:90a:bf82:b0:214:6fd:90ec with SMTP id d2-20020a17090abf8200b0021406fd90ecmr11317834pjs.61.1667416011472;
        Wed, 02 Nov 2022 12:06:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903244c00b0017da2798025sm8710635pls.295.2022.11.02.12.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:06:50 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:06:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Alain Volmat <alain.volmat@foss.st.com>,
        dri-devel@lists.freedesktop.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] drm/sti: Fix return type of
 sti_{dvo,hda,hdmi}_connector_mode_valid()
Message-ID: <202211021206.1A488F29C@keescook>
References: <20221102155623.3042869-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102155623.3042869-1-nathan@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 08:56:23AM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
>   drivers/gpu/drm/sti/sti_hda.c:637:16: error: incompatible function pointer types initializing 'enum drm_mode_status (*)(struct drm_connector *, struct drm_display_mode *)' with an expression of type 'int (struct drm_connector *, struct drm_display_mode *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           .mode_valid = sti_hda_connector_mode_valid,
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   drivers/gpu/drm/sti/sti_dvo.c:376:16: error: incompatible function pointer types initializing 'enum drm_mode_status (*)(struct drm_connector *, struct drm_display_mode *)' with an expression of type 'int (struct drm_connector *, struct drm_display_mode *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           .mode_valid = sti_dvo_connector_mode_valid,
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   drivers/gpu/drm/sti/sti_hdmi.c:1035:16: error: incompatible function pointer types initializing 'enum drm_mode_status (*)(struct drm_connector *, struct drm_display_mode *)' with an expression of type 'int (struct drm_connector *, struct drm_display_mode *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           .mode_valid = sti_hdmi_connector_mode_valid,
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ->mode_valid() in 'struct drm_connector_helper_funcs' expects a return
> type of 'enum drm_mode_status', not 'int'. Adjust the return type of
> sti_{dvo,hda,hdmi}_connector_mode_valid() to match the prototype's to
> resolve the warning and CFI failure.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
