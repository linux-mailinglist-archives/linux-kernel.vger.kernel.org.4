Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD2B616DC3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiKBTWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiKBTWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:22:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2B1DFE2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:22:12 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q9so2196800pfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4EDI3vYbHaaiAQeZuuGzJ5Pv1WpOR32gAtsS0QDWLuw=;
        b=cf2nTr5YnckoTzWzbGWmtwmcSXrd8AamU45cN4BkmLr5woysN2W1kdbIKrPwII4PVI
         ce8I7YTY4uSDnL6ZPBTz94gxiF8GCs7pA974P296j4z8qCIMA1+np81HnE/zTRa6yv+M
         k3Z8gi82o4u4QsaXVn9ASZodldSA4+ubXIZL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EDI3vYbHaaiAQeZuuGzJ5Pv1WpOR32gAtsS0QDWLuw=;
        b=nOK0wnDv+GfKTEYepn9WjqDiRI4Gh3E2Ltq5fBBmwuW/rCV9fzFdYeepTQHIAV7dZk
         z8i5T3XqMTzXxzFybn9NIz3hREJod+p/boANhrVwsXiHA3tBCvIosF2zuo6c6XvMG/6R
         uJ0tnsqb7zOxN1hj4stKGCUVNJ01bux+gh6J7exsdJXewoMLHg42mZBFLGYF0jlJ3oH1
         kSlUyZJsGGEQjeWIjCEgOO9S7l92fiMypdxTulFS2nEvaqlut+ZRPf1vbmRW10QGoeAb
         LA5lfqajdS0Wb4Xns9c97mLJwJ0rRMz9UzxRC9VmM6sMDKxZ2X+SwIS8LK+elmLeS8ES
         OgIg==
X-Gm-Message-State: ACrzQf1VfmfDNs+mGUi6CkPgCxz+ff4GvFNM+m8DuGZo1ixqQQ7QSLfA
        MJnBnuKYThoVuGdBlfYtLxJ7mA==
X-Google-Smtp-Source: AMsMyM6VtLTeGYSXsL6Ro3gC8gkszOK2+Cjl0KViNXychOWaLiDIqn26ITH/JYsmSRn3aX4X3qwIeQ==
X-Received: by 2002:a05:6a00:1391:b0:56d:2b6f:57b3 with SMTP id t17-20020a056a00139100b0056d2b6f57b3mr23293181pfg.56.1667416932256;
        Wed, 02 Nov 2022 12:22:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 85-20020a621658000000b005609d3d3008sm9054723pfw.171.2022.11.02.12.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:22:11 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:22:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] drm/mediatek: Fix return type of
 mtk_hdmi_bridge_mode_valid()
Message-ID: <202211021222.1E8A8BCB43@keescook>
References: <20221102154712.540548-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102154712.540548-1-nathan@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 08:47:12AM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
>   drivers/gpu/drm/mediatek/mtk_hdmi.c:1407:16: error: incompatible function pointer types initializing 'enum drm_mode_status (*)(struct drm_bridge *, const struct drm_display_info *, const struct drm_display_mode *)' with an expression of type 'int (struct drm_bridge *, const struct drm_display_info *, const struct drm_display_mode *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           .mode_valid = mtk_hdmi_bridge_mode_valid,
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
> 
> ->mode_valid() in 'struct drm_bridge_funcs' expects a return type of
> 'enum drm_mode_status', not 'int'. Adjust the return type of
> mtk_hdmi_bridge_mode_valid() to match the prototype's to resolve the
> warning and CFI failure.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
