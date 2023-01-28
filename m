Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1B567F77C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 12:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjA1LOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 06:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA1LOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 06:14:34 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEC1FF20;
        Sat, 28 Jan 2023 03:14:33 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hw16so19869619ejc.10;
        Sat, 28 Jan 2023 03:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iT9ACSVXv8yJrfFW5qhotmUWQO2LRFoerVXNspw4ueA=;
        b=cOeG/Kg3T2phj3rUTTVzEZy/Xli2oh94f2BKgH4X3aebncVqV55i4K80ZFPUFS3QN6
         TOtJkP3qls7yWc4nXmXZkgkvqETMZKYCScQDvrupih08zPWZL/yXfuwVjuuvwPNsnyKJ
         QI/qD9cW27tA9ktz3RamFT2NB5XRfUDv057dNFEmgWwxqI1T/uoZtaNjFhQCzVTGGQz6
         NvyyIZ6Q2RvJlPUvaEwdHET/evEnHscTz0jyCEoBPpEHLIcqfI21Wetv0S04CxrloYKO
         2oQaJnS9l1fMARma/aH1+ILkfvkO85x9bpFdo7vM3YQ/nl3czoCiJ73Pk51sYuvBGXGy
         npfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iT9ACSVXv8yJrfFW5qhotmUWQO2LRFoerVXNspw4ueA=;
        b=y0P6OasGGYLgKdtKdLO2Y2YSWvXOEGLiTGqTwmHRRxE+/UBO0vdkqzqaAlcy3C4gAL
         J+V/ErMysKGl4U03LGJdJ2e3WIhRzZZwRO6hPD5QRQ/u4hTKAyhgbJLwSqKGy5Yxd+rj
         vPZ+Y+QYSrea93U/75NwZcwpq7l0NKV2J7qE3kPqo0Sulj1b4V4WC+Y7j8UsfP/Vmgpl
         CepaCrs2P2rV37afaYongEAfQ7F4IodfsGDMI9PxApnfXGbb+kgWcmMfvbMS4sYxj/Pk
         7GZqAXTbGXbbQbXnW78JVJNvQJvS9PNKuQF2fkVfCJJ+eQfhNKppMaoYlbcDv0Pf+GsI
         GIuA==
X-Gm-Message-State: AO0yUKVIWwpDjyYgxlnik9HaRkTs1fUAaqSSuZMjN3nSu3wdKOX/7aGu
        zlVDDYf/dj46e0zoXlc9BI4=
X-Google-Smtp-Source: AK7set+DRWZScwMpwpgYWnQv/Kja6xp2CpKU/nGFnZ6B+SQeLjKQ4JB31tcRPQNbNDUU8xMopkoGcQ==
X-Received: by 2002:a17:906:f1c3:b0:878:5d34:3c41 with SMTP id gx3-20020a170906f1c300b008785d343c41mr10507007ejb.71.1674904471961;
        Sat, 28 Jan 2023 03:14:31 -0800 (PST)
Received: from localhost (93-55-83-125.ip262.fastwebnet.it. [93.55.83.125])
        by smtp.gmail.com with ESMTPSA id e24-20020a17090681d800b0087bda70d3efsm2235930ejx.118.2023.01.28.03.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 03:14:31 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 28 Jan 2023 12:14:29 +0100
Message-Id: <CQ3S2Z84SGAA.36ZVP0G4DF5VP@vincent>
To:     "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        <rust-for-linux@vger.kernel.org>
Cc:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] rust: types: implement `ForeignOwnable` for the
 unit type
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
X-Mailer: aerc 0.8.2
References: <20230119174036.64046-1-wedsonaf@gmail.com>
 <20230119174036.64046-4-wedsonaf@gmail.com>
In-Reply-To: <20230119174036.64046-4-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jan 19, 2023 at 6:40 PM CET, Wedson Almeida Filho wrote:
> This allows us to use the unit type `()` when we have no object whose
> ownership must be managed but one implementing the `ForeignOwnable`
> trait is needed.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

> ---
>  rust/kernel/types.rs | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index e037c262f23e..8f80cffbff59 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -85,6 +85,19 @@ impl<T: 'static> ForeignOwnable for Box<T> {
>      }
>  }
> =20
> +impl ForeignOwnable for () {
> +    type Borrowed<'a> =3D ();
> +
> +    fn into_foreign(self) -> *const core::ffi::c_void {
> +        // We use 1 to be different from a null pointer.
> +        1usize as _
> +    }
> +
> +    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<=
'a> {}
> +
> +    unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
> +}
> +
>  /// Runs a cleanup function/closure when dropped.
>  ///
>  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function f=
rom running.
> --=20
> 2.34.1

