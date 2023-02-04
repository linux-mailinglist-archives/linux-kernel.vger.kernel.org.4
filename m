Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD7C68AC05
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 20:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjBDTGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 14:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjBDTG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 14:06:28 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CA526860
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 11:06:26 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso11747657pjj.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 11:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QoMgaRBwpftZsFSUA/NaYhrGZMjYhcRy+dE+lN/6O1E=;
        b=Z4ADyFnc6fwzORH5e6z1NSAJ1n7Z6ZcIr94Kg/BqcBBkg4VqN5ztstkQB1nwZwQzL3
         /J0Zy6a8aS2eqJIjiSwguDn064p5fEtP4siewK92viBFPBWgIch+9JPpDgqDQCCDIufP
         bhxwZyAFguAcg97Bg8W0snjsSEWSW0EuF2k08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoMgaRBwpftZsFSUA/NaYhrGZMjYhcRy+dE+lN/6O1E=;
        b=yU8AOit97Vhn4zFHEfJN8hHGKgKh56Lq4+JqWF5pdeR9/iCOwO27CNrZHog+TE1THr
         COkDVhXGXezMNlsP/n/Oe7gaQCr0PiR7kPmAhVyL/odUZWgCW1hovLOap4SIonlLGGBp
         b1l0oQHylWCkN6b1JJj0cJze0Sx7Wisr4X+EJjxlVC0ATqk5by+a7240TZSAmJiVbssS
         oB9tHZ+DdVd0M+S/Pj/juPICoj4MsmgxXL+1uN3hjfbGPFj7hH/cmPnqhWRhf5QJG0gm
         XnPtD+p312WUHxCLqIFLIxwhl3Be/sp1iBZgfgCM9gFaLolqnFUuCGPonJKu+5dTk0mN
         5J+w==
X-Gm-Message-State: AO0yUKVBWNnmPHuffs8aqpF1pgK28s4KegziQSP9K2lwr1e0ibSVMkS2
        yitUcwwjITxjrYmasCxRe7aVjw==
X-Google-Smtp-Source: AK7set9ig47OFDDy/8XwlY0OJoIGhW13i8inuO00m8K8SWHbrufKyM3+iZqYP60Vh/6VoQcT+qCXJg==
X-Received: by 2002:a17:902:c792:b0:198:fe02:1f94 with SMTP id w18-20020a170902c79200b00198fe021f94mr898432pla.51.1675537586367;
        Sat, 04 Feb 2023 11:06:26 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902d20300b00194c1281ca9sm3769380ply.166.2023.02.04.11.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 11:06:25 -0800 (PST)
Message-ID: <63deacb1.170a0220.f078.6779@mx.google.com>
X-Google-Original-Message-ID: <202302041105.@keescook>
Date:   Sat, 4 Feb 2023 11:06:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] randstruct: temporarily disable clang support
References: <20230203194201.92015-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203194201.92015-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 11:42:01AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Randstruct with clang is currently unsafe to use in any clang release
> that supports it, due to a clang bug that is causing miscompilations:
> "-frandomize-layout-seed inconsistently randomizes all-function-pointers
> structs" (https://github.com/llvm/llvm-project/issues/60349).  Disable
> it temporarily until the bug is fixed and the fix is released in a clang
> version that can be checked for.
> 
> Fixes: 035f7f87b729 ("randstruct: Enable Clang support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  security/Kconfig.hardening | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 53baa95cb644..aad16187148c 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -280,7 +280,8 @@ config ZERO_CALL_USED_REGS
>  endmenu
>  
>  config CC_HAS_RANDSTRUCT
> -	def_bool $(cc-option,-frandomize-layout-seed-file=/dev/null)
> +	# Temporarily disabled due to https://github.com/llvm/llvm-project/issues/60349
> +	def_bool n
>  
>  choice
>  	prompt "Randomize layout of sensitive kernel structures"
> 
> base-commit: 7b753a909f426f2789d9db6f357c3d59180a9354
> -- 
> 2.39.1

This should be fixed with greater precision -- i.e. this is nearly fixed
in Clang now, and is likely to be backported. So I think we'll need
versioned checks here.

-- 
Kees Cook
