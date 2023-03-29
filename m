Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89C76CECAF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjC2PWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjC2PWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:22:02 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53E0128;
        Wed, 29 Mar 2023 08:22:00 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id o25-20020a9d4119000000b006a11eb19f8eso7194794ote.5;
        Wed, 29 Mar 2023 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680103320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6iilm+JqipfIQ47s9BYxmX6VNLXMk9cec4gpmAXoeJo=;
        b=NMua3BbWCnxs2JMZct3X4hWla8xmo45OeMMMFqZj/IsfYxsaUhMok9FUPMYYTsaFKH
         GhjNfEXDAJQa/WgipoYgerxwIAFofh/RgjIcOtwv6RbgnRjXKC9usXiE0KHvlzHcUtbe
         4k6DTVNbdyqWotQCoRSaI7LirnPLfxs/J9cVaTR4hIF2FztfQ5gb9dZSRB6Wyyexc0pE
         8sPKCs3h5KeyFYfdO+hpY60cT9EuLiR31lxFVIeBJ8zkokzkNNCIu0zVaoJsYAFNdcAr
         WNObttuKupqdnO3jqYJ4N671buF2hmDdusCQZonP4sa/1ySHahZLqhg4qTj2VhrFB+/i
         QxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680103320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iilm+JqipfIQ47s9BYxmX6VNLXMk9cec4gpmAXoeJo=;
        b=oXK6fqXvDoZDhgBjLFVp34NAU1FMKmZwRkE4mNQsKmKsxlAEvcKbmemm7hfP4SeXng
         eANOfVY1N36xsiNsDLgSSmUkEilg9nKUCpjYg39OuvLXYq3RLqfNu5pEO/rlrQtqEmR+
         wMWBZTr2QNmXGiY/VHoG+btV0Ux62b33zlOBbQURPgn85muOZYMGKvyJN3O6i40h6lnU
         NDmdaCLfV0gaNObq9aY+wRRy6bxWqAsdoexXqyaLsKLKkWyQ0gMKVm9YzTXW5RHb9W0r
         FRhJDWR5xl4p31nfVRlLFlA/iy5O9Hfg3GEQA61zGCvOJqPF+GNZKfzEr/kHRR15ijJP
         2WBQ==
X-Gm-Message-State: AAQBX9dB6VIiVqa46z9ri6RLWlHHTETR/sKpWNnA/nhZWI6Y0bl+y5iy
        iKXaEu15Fa/zDlDYAPAaJRc9fSVWhf4=
X-Google-Smtp-Source: AKy350Zk2WM/EXY8rAROoYtM+7neoCd8zUWUKV6/zmpLvM0rOiiAgGbfVfQu0lajJwYRBbolBXCl+g==
X-Received: by 2002:a9d:480f:0:b0:6a1:3101:8e29 with SMTP id c15-20020a9d480f000000b006a131018e29mr5768189otf.18.1680103320108;
        Wed, 29 Mar 2023 08:22:00 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id v1-20020a05683018c100b006a13dd5c8a2sm3567305ote.5.2023.03.29.08.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 08:21:59 -0700 (PDT)
Message-ID: <061e3d9a-394c-88dd-2de8-84fb207afeab@gmail.com>
Date:   Wed, 29 Mar 2023 12:21:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] rust: uapi: Add UAPI crate
Content-Language: en-US
To:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev
References: <20230329-rust-uapi-v1-0-ee78f2933726@asahilina.net>
 <20230329-rust-uapi-v1-1-ee78f2933726@asahilina.net>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230329-rust-uapi-v1-1-ee78f2933726@asahilina.net>
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
> This crate mirrors the `bindings` crate, but will contain only UAPI
> bindings. Unlike the bindings crate, drivers may directly use this crate
> if they have to interface with userspace.
> 
> Initially, just bind the generic ioctl stuff.
> 
> In the future, we would also like to add additional checks to ensure
> that all types exposed by this crate satisfy UAPI-safety guarantees
> (that is, they are safely castable to/from a "bag of bits").
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/.gitignore         |  1 +
>  rust/Makefile           | 18 ++++++++++++++++--
>  rust/kernel/lib.rs      |  1 +
>  rust/uapi/lib.rs        | 27 +++++++++++++++++++++++++++
>  rust/uapi/uapi_helper.h |  9 +++++++++
>  5 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/.gitignore b/rust/.gitignore
> index 168cb26a31b9..21552992b401 100644
> --- a/rust/.gitignore
> +++ b/rust/.gitignore
> @@ -2,6 +2,7 @@
>  
>  bindings_generated.rs
>  bindings_helpers_generated.rs
> +uapi_generated.rs
>  exports_*_generated.h
>  doc/
>  test/
> diff --git a/rust/Makefile b/rust/Makefile
> index f88d108fbef0..59a327f0fa1a 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -16,6 +16,9 @@ obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
>  always-$(CONFIG_RUST) += exports_alloc_generated.h exports_bindings_generated.h \
>      exports_kernel_generated.h
>  
> +always-$(CONFIG_RUST) += uapi/uapi_generated.rs
> +obj-$(CONFIG_RUST) += uapi.o
> +
>  ifdef CONFIG_RUST_BUILD_ASSERT_ALLOW
>  obj-$(CONFIG_RUST) += build_error.o
>  else
> @@ -288,6 +291,12 @@ $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
>      $(src)/bindgen_parameters FORCE
>  	$(call if_changed_dep,bindgen)
>  
> +$(obj)/uapi/uapi_generated.rs: private bindgen_target_flags = \
> +    $(shell grep -v '^\#\|^$$' $(srctree)/$(src)/bindgen_parameters)

This emits a warning with grep about a numeral unnecessarily escaped as
seen in a patch sent by Vicenzo Palazzo [1].

```
grep: warning: stray \ before #
```

> +$(obj)/uapi/uapi_generated.rs: $(src)/uapi/uapi_helper.h \
> +    $(src)/bindgen_parameters FORCE
> +	$(call if_changed_dep,bindgen)
> +
>  # See `CFLAGS_REMOVE_helpers.o` above. In addition, Clang on C does not warn
>  # with `-Wmissing-declarations` (unlike GCC), so it is not strictly needed here
>  # given it is `libclang`; but for consistency, future Clang changes and/or
> @@ -388,10 +397,15 @@ $(obj)/bindings.o: $(src)/bindings/lib.rs \
>      $(obj)/bindings/bindings_helpers_generated.rs FORCE
>  	$(call if_changed_dep,rustc_library)
>  
> +$(obj)/uapi.o: $(src)/uapi/lib.rs \
> +    $(obj)/compiler_builtins.o \
> +    $(obj)/uapi/uapi_generated.rs FORCE
> +	$(call if_changed_dep,rustc_library)
> +
>  $(obj)/kernel.o: private rustc_target_flags = --extern alloc \
> -    --extern build_error --extern macros --extern bindings
> +    --extern build_error --extern macros --extern bindings --extern uapi
>  $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
> -    $(obj)/libmacros.so $(obj)/bindings.o FORCE
> +    $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
>  	$(call if_changed_dep,rustc_library)
>  
>  endif # CONFIG_RUST
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 7610b18ee642..63f796781b7c 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -43,6 +43,7 @@ pub mod types;
>  #[doc(hidden)]
>  pub use bindings;
>  pub use macros;
> +pub use uapi;
>  
>  #[doc(hidden)]
>  pub use build_error::build_error;
> diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
> new file mode 100644
> index 000000000000..29f69f3a52de
> --- /dev/null
> +++ b/rust/uapi/lib.rs
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! UAPI Bindings.
> +//!
> +//! Contains the bindings generated by `bindgen` for UAPI interfaces.
> +//!
> +//! This crate may be used directly by drivers that need to interact with
> +//! userspace APIs.
> +
> +#![no_std]
> +#![feature(core_ffi_c)]
> +// See <https://github.com/rust-lang/rust-bindgen/issues/1651>.
> +#![cfg_attr(test, allow(deref_nullptr))]
> +#![cfg_attr(test, allow(unaligned_references))]
> +#![cfg_attr(test, allow(unsafe_op_in_unsafe_fn))]
> +#![allow(
> +    clippy::all,
> +    missing_docs,
> +    non_camel_case_types,
> +    non_upper_case_globals,
> +    non_snake_case,
> +    improper_ctypes,
> +    unreachable_pub,
> +    unsafe_op_in_unsafe_fn
> +)]
> +
> +include!(concat!(env!("OBJTREE"), "/rust/uapi/uapi_generated.rs"));
> diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
> new file mode 100644
> index 000000000000..301f5207f023
> --- /dev/null
> +++ b/rust/uapi/uapi_helper.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header that contains the headers for which Rust UAPI bindings
> + * will be automatically generated by `bindgen`.
> + *
> + * Sorted alphabetically.
> + */
> +
> +#include <uapi/asm-generic/ioctl.h>
> 

Link: https://lore.kernel.org/rust-for-linux/20230302132107.210502-1-vincenzopalazzodev@gmail.com/ [1]

Reviewed-by: Martin Rodriguez Reboredo
