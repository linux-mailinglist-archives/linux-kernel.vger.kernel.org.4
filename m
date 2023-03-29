Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5AA6CECDF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjC2P2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjC2P2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:28:47 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02EC3C15;
        Wed, 29 Mar 2023 08:28:45 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-17ab3a48158so16613301fac.1;
        Wed, 29 Mar 2023 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680103725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/0qYcjpAAKRuBZ39NrE5H4YmMIUNZBowPVzOCdw31g=;
        b=J0rnh8tOyV6nyKFSNlBg9zhfe5I0kCzHK+GFOHljGYDX8gjKeqf9oqxhlxvkRTwKhp
         DWjsCE1cwAtxRlM6tnp8MHJJIa6/lb3qcaUPHjHyPVh0YPse8KfH6Kc3sNYz8cJ8aFui
         +5h8QHvRnm5nl45scpyNuThRzNJ/FS1Uv7BGnzbkRG9XmwSUYcByJj0+OthIIy7Oxahm
         Xnvll1t8ItqcyRgZInPh8LYZIkvONTn4f125W4c+MtxQM6I/67bLz2XVBkh7Ayw21Ct1
         3rdaRT8R/wNQRsMu3utuLHd9/GntbCyBp8q/L40pO8ppxswtJYwv2ieBG1NMpmxk8Obv
         DjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680103725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/0qYcjpAAKRuBZ39NrE5H4YmMIUNZBowPVzOCdw31g=;
        b=60YdMhzUSWZ5WiVWTNyiN0Yt49swJ2TuYSmEGpiNyL9MidVykikUs6e0uGqPEZWHS/
         jJZRKvNfCDt7nzbpmHldwEU+bTIgs9c69GZS/4F8waJtO5ZTUHWLIX88VeD+l3spKNsK
         +Olvkr6uDonh00MxOn5vQ7C6Y/nLvvi6VyI6HRrHpus4r8kUKTaGYA+GPegnn6eEb9MH
         OaM6Q5Ol4sCtk9C7xtwp2EM9jyHJEEQ+Fa1TE2eDkLbXLWY7al9EDbDHHog7tqhp0hSh
         Qtb8KfFDls8e/YzJFI8KU4r9QeX3Q1efFyYqBRC1L4Fv9023DW+np3z49AvpU5rJ62IV
         MvyQ==
X-Gm-Message-State: AO0yUKUPu8WF/C21XHch1ZXPsRtPunzHg6Q8E9eG7WQtK4rt3oFDXLkZ
        YO/l38I2FwjkFC37fAY4tLYSwi99PQg=
X-Google-Smtp-Source: AKy350aQWL881y11040LysOhsXi8xeHNH+bEKwS3hawo3395Fo0RPQK9fEmJb1Q1WOdZF/gD4iiDoA==
X-Received: by 2002:a05:6870:910c:b0:176:3849:4e96 with SMTP id o12-20020a056870910c00b0017638494e96mr13343721oae.13.1680103725182;
        Wed, 29 Mar 2023 08:28:45 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id p16-20020a9d76d0000000b0068bd922a244sm14328829otl.20.2023.03.29.08.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 08:28:44 -0700 (PDT)
Message-ID: <859172d0-062b-82ba-4df6-e10851b69b31@gmail.com>
Date:   Wed, 29 Mar 2023 12:28:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] rust: ioctl: Move to the uapi crate
Content-Language: en-US
To:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev
References: <20230329-rust-uapi-v1-0-ee78f2933726@asahilina.net>
 <20230329-rust-uapi-v1-2-ee78f2933726@asahilina.net>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230329-rust-uapi-v1-2-ee78f2933726@asahilina.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 08:40, Asahi Lina wrote:
> Now that we have the uapi crate, this abstraction can use that instead
> of bindings.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/kernel/ioctl.rs | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
> index b2076113b6a8..007437959395 100644
> --- a/rust/kernel/ioctl.rs
> +++ b/rust/kernel/ioctl.rs
> @@ -10,40 +10,40 @@ use crate::build_assert;
>  /// Build an ioctl number, analogous to the C macro of the same name.
>  #[inline(always)]
>  const fn _IOC(dir: u32, ty: u32, nr: u32, size: usize) -> u32 {
> -    build_assert!(dir <= bindings::_IOC_DIRMASK);
> -    build_assert!(ty <= bindings::_IOC_TYPEMASK);
> -    build_assert!(nr <= bindings::_IOC_NRMASK);
> -    build_assert!(size <= (bindings::_IOC_SIZEMASK as usize));
> +    build_assert!(dir <= uapi::_IOC_DIRMASK);
> +    build_assert!(ty <= uapi::_IOC_TYPEMASK);
> +    build_assert!(nr <= uapi::_IOC_NRMASK);
> +    build_assert!(size <= (uapi::_IOC_SIZEMASK as usize));
>  
> -    (dir << bindings::_IOC_DIRSHIFT)
> -        | (ty << bindings::_IOC_TYPESHIFT)
> -        | (nr << bindings::_IOC_NRSHIFT)
> -        | ((size as u32) << bindings::_IOC_SIZESHIFT)
> +    (dir << uapi::_IOC_DIRSHIFT)
> +        | (ty << uapi::_IOC_TYPESHIFT)
> +        | (nr << uapi::_IOC_NRSHIFT)
> +        | ((size as u32) << uapi::_IOC_SIZESHIFT)
>  }
>  
>  /// Build an ioctl number for an argumentless ioctl.
>  #[inline(always)]
>  pub const fn _IO(ty: u32, nr: u32) -> u32 {
> -    _IOC(bindings::_IOC_NONE, ty, nr, 0)
> +    _IOC(uapi::_IOC_NONE, ty, nr, 0)
>  }
>  
>  /// Build an ioctl number for an read-only ioctl.
>  #[inline(always)]
>  pub const fn _IOR<T>(ty: u32, nr: u32) -> u32 {
> -    _IOC(bindings::_IOC_READ, ty, nr, core::mem::size_of::<T>())
> +    _IOC(uapi::_IOC_READ, ty, nr, core::mem::size_of::<T>())
>  }
>  
>  /// Build an ioctl number for an write-only ioctl.
>  #[inline(always)]
>  pub const fn _IOW<T>(ty: u32, nr: u32) -> u32 {
> -    _IOC(bindings::_IOC_WRITE, ty, nr, core::mem::size_of::<T>())
> +    _IOC(uapi::_IOC_WRITE, ty, nr, core::mem::size_of::<T>())
>  }
>  
>  /// Build an ioctl number for a read-write ioctl.
>  #[inline(always)]
>  pub const fn _IOWR<T>(ty: u32, nr: u32) -> u32 {
>      _IOC(
> -        bindings::_IOC_READ | bindings::_IOC_WRITE,
> +        uapi::_IOC_READ | uapi::_IOC_WRITE,
>          ty,
>          nr,
>          core::mem::size_of::<T>(),
> @@ -52,20 +52,20 @@ pub const fn _IOWR<T>(ty: u32, nr: u32) -> u32 {
>  
>  /// Get the ioctl direction from an ioctl number.
>  pub const fn _IOC_DIR(nr: u32) -> u32 {
> -    (nr >> bindings::_IOC_DIRSHIFT) & bindings::_IOC_DIRMASK
> +    (nr >> uapi::_IOC_DIRSHIFT) & uapi::_IOC_DIRMASK
>  }
>  
>  /// Get the ioctl type from an ioctl number.
>  pub const fn _IOC_TYPE(nr: u32) -> u32 {
> -    (nr >> bindings::_IOC_TYPESHIFT) & bindings::_IOC_TYPEMASK
> +    (nr >> uapi::_IOC_TYPESHIFT) & uapi::_IOC_TYPEMASK
>  }
>  
>  /// Get the ioctl number from an ioctl number.
>  pub const fn _IOC_NR(nr: u32) -> u32 {
> -    (nr >> bindings::_IOC_NRSHIFT) & bindings::_IOC_NRMASK
> +    (nr >> uapi::_IOC_NRSHIFT) & uapi::_IOC_NRMASK
>  }
>  
>  /// Get the ioctl size from an ioctl number.
>  pub const fn _IOC_SIZE(nr: u32) -> usize {
> -    ((nr >> bindings::_IOC_SIZESHIFT) & bindings::_IOC_SIZEMASK) as usize
> +    ((nr >> uapi::_IOC_SIZESHIFT) & uapi::_IOC_SIZEMASK) as usize
>  }
> 

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
