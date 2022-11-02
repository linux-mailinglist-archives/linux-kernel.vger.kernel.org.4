Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D621D616666
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiKBPnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiKBPm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:42:56 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB19628E37
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:42:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y4so16965663plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gbHhHvdRSfNW3M6lKiiBiHsy/aZHIegD8in6WLhhzSY=;
        b=grx0sX1vyt4doXabEeN05DzVGZaktvYdcCfg6WGKYn2Um48Zgp2UMnzv9yxRjGlvDs
         s02OzcMqRXmY81P844mFxCquKl032+JyuX8aVk9fGB0kVUT/d3ioGHRtH7AHRaujNbdw
         65vnLvXCz2xWmb3ZUvb4RYrBdcrT6g2PSeo3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbHhHvdRSfNW3M6lKiiBiHsy/aZHIegD8in6WLhhzSY=;
        b=yVHE3CCFdqsVwvJ89TFjO65uOtRu+SjtYoPabZNsCUJhW5Lx2ixCriBJZucb3EArDR
         cv3E5ObCl0mNg0C9M2YB8JZwRfsDzQvqc3ZgHdQsUXcybRMFVQkfVsPRRVnVyKOKdmPV
         uI8bxsCGJ0CVugvvbm2N7lEH3eEa1fHL2byHcvihfcHIQdZDt5BaY5qQVkgMSble+8y9
         hhGMkeQ5MNT2mrTddtPmnSN/L/saymcBTL4YfaNqBSI8V53/F2qrlY/Jp5+REEyyLT68
         Re6sqTsX190VGXRw8UztVfDbRH8sEan324tQzTErOylNeHBKDOUIx9Apm0g8QcjiegaG
         nXcQ==
X-Gm-Message-State: ACrzQf2QBpgQC8JaaG8/0GjTRG4gPPf2ivMEEoUBNvFKv3oQ7VceKZTW
        i5BMc4EKR4xRDqlyye0x9AiGqg==
X-Google-Smtp-Source: AMsMyM5riCGdRLVGt8cheeiKjHf8n8+rR3sMc60dvYFpdMSefduVp5ovnjO/E9dJecAFytPwR3myDw==
X-Received: by 2002:a17:902:720c:b0:186:fb90:573e with SMTP id ba12-20020a170902720c00b00186fb90573emr25604727plb.160.1667403775155;
        Wed, 02 Nov 2022 08:42:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b001885041d7b8sm47015pll.293.2022.11.02.08.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:42:54 -0700 (PDT)
Date:   Wed, 2 Nov 2022 08:42:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix type of second parameter in
 trans_msg() callback
Message-ID: <202211020842.8F3ECD397@keescook>
References: <20221102152540.2389891-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102152540.2389891-1-nathan@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 08:25:39AM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c:412:15: error: incompatible function pointer types initializing 'void (*)(struct amdgpu_device *, u32, u32, u32, u32)' (aka 'void (*)(struct amdgpu_device *, unsigned int, unsigned int, unsigned int, unsigned int)') with an expression of type 'void (struct amdgpu_device *, enum idh_request, u32, u32, u32)' (aka 'void (struct amdgpu_device *, enum idh_request, unsigned int, unsigned int, unsigned int)') [-Werror,-Wincompatible-function-pointer-types-strict]
>           .trans_msg = xgpu_ai_mailbox_trans_msg,
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
> 
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c:435:15: error: incompatible function pointer types initializing 'void (*)(struct amdgpu_device *, u32, u32, u32, u32)' (aka 'void (*)(struct amdgpu_device *, unsigned int, unsigned int, unsigned int, unsigned int)') with an expression of type 'void (struct amdgpu_device *, enum idh_request, u32, u32, u32)' (aka 'void (struct amdgpu_device *, enum idh_request, unsigned int, unsigned int, unsigned int)') [-Werror,-Wincompatible-function-pointer-types-strict]
>           .trans_msg = xgpu_nv_mailbox_trans_msg,
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
> 
> The type of the second parameter in the prototype should be 'enum
> idh_request' instead of 'u32'. Update it to clear up the warnings.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
