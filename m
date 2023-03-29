Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32E36CEC35
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjC2Oxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjC2Oxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:53:48 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7F81AE;
        Wed, 29 Mar 2023 07:53:47 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 61-20020a9d02c3000000b0069fe8de3139so8347736otl.1;
        Wed, 29 Mar 2023 07:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680101626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUAbF6xPpnaApht7x67RotY/bpdH/Tf1G3eD2cyc8F0=;
        b=ZAV8/O7JwqdsctwR+oxDFJjl7JkT0xjiwpUKAc1PAnqQGj4viWWEcnJG/0Z9WXut14
         pwpgq3vvsuPKmsFKz3qCBekH4CXPWONs70QxVh8I4Pd5P+akeSOtRqtWjQil3LenEEDo
         qFnz1h9MIsPpKsne2RGQkS0jt7ptmyuC13GWzjRS2+Gl2qDOxUYCNfU8vtuzgP4UW1gA
         D077tbthBlvairgPwrtwBxwo3fVOCJ1cp8PHJ5BpgNRwS/HEXwOTpAwruOMtVZTpmrKG
         xJalmVSv7/algAxVmf2W4+n0wa628dyWEZQTUBtLD5aaQzfBjWPQJh4TF2y5gTXCAvIE
         809A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680101626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUAbF6xPpnaApht7x67RotY/bpdH/Tf1G3eD2cyc8F0=;
        b=7WZ+If2IrIFE4FWkDGeRZy5HXuFAy7w3k7cf/9zWkvQCdp322ZezbNQR13wADgHMhW
         Mm19VcgCS+DEJt2IFm96VGxpSSR76abdXBen1RHpiduxadMBv8LjwvgiD0cK1K9A0f7N
         KzvCN6BR/zy1gkS7+ju4m6Njqb2aGqSSjNvFfBr+YY5VVoYeI5v9jYJ0OjG25q1xZYzi
         2sNNFHch6jNSz0fRZh3L4yS3uIkMSPjSQaWOvNCklmY0WbXnJUsGq1/VIzkGHqpZEnh2
         rzzQI6yPGwiaEj+SM13zZvFwG40c1aFMn10aHAMvLAwhIFCwWlRdpX3IW6HKYV/zIMwF
         7+pQ==
X-Gm-Message-State: AAQBX9fsI63kiuvoezp8FuhWyYZ0S671IWX0AGn7Qn6sowZswSO0Qlfu
        LnJsyTSTSWOo3KHTUAFClHg=
X-Google-Smtp-Source: AKy350ZoRTphKvVFMl5GtTPXTy1Qb6aL9bK12jfehzU2n5V4XAZsPrGfXid7dZpcztCeBy4dQpBz4A==
X-Received: by 2002:a05:6830:1d78:b0:6a1:22fe:2a4b with SMTP id l24-20020a0568301d7800b006a122fe2a4bmr6894580oti.18.1680101626737;
        Wed, 29 Mar 2023 07:53:46 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id a12-20020a056830008c00b006a11de6cd02sm5453887oto.34.2023.03.29.07.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 07:53:46 -0700 (PDT)
Message-ID: <7bd381da-2d8a-2c81-bc9b-ac0a13f4edb9@gmail.com>
Date:   Wed, 29 Mar 2023 11:53:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/6] rust: error: Add a helper to convert a C ERR_PTR
 to a `Result`
Content-Language: en-US
To:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Fox Chen <foxhlchen@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
References: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
 <20230224-rust-error-v2-5-3900319812da@asahilina.net>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230224-rust-error-v2-5-3900319812da@asahilina.net>
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

On 3/29/23 09:04, Asahi Lina wrote:
> [...]
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 89f4cd1e0df3..04b9be46e887 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -53,6 +53,18 @@ __force void *rust_helper_ERR_PTR(long err)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_ERR_PTR);
>  
> +bool rust_helper_IS_ERR(__force const void *ptr)
> +{
> +	return IS_ERR(ptr);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_IS_ERR);
> +
> +long rust_helper_PTR_ERR(__force const void *ptr)
> +{
> +	return PTR_ERR(ptr);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 4f599c4d1752..6b10129075a7 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -177,3 +177,52 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
>          Ok(())
>      }
>  }
> +
> +/// Transform a kernel "error pointer" to a normal pointer.
> +///
> +/// Some kernel C API functions return an "error pointer" which optionally
> +/// embeds an `errno`. Callers are supposed to check the returned pointer
> +/// for errors. This function performs the check and converts the "error pointer"
> +/// to a normal pointer in an idiomatic fashion.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// # use kernel::from_err_ptr;
> +/// # use kernel::bindings;
> +/// fn devm_platform_ioremap_resource(
> +///     pdev: &mut PlatformDevice,
> +///     index: u32,
> +/// ) -> Result<*mut core::ffi::c_void> {
> +///     // SAFETY: FFI call.
> +///     unsafe {
> +///         from_err_ptr(bindings::devm_platform_ioremap_resource(
> +///             pdev.to_ptr(),
> +///             index,
> +///         ))
> +///     }
> +/// }
> +/// ```
> +// TODO: Remove `dead_code` marker once an in-kernel client is available.
> +#[allow(dead_code)]
> +pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
> +    // CAST: Casting a pointer to `*const core::ffi::c_void` is always valid.
> +    let const_ptr: *const core::ffi::c_void = ptr.cast();
> +    // SAFETY: The FFI function does not deref the pointer.
> +    if unsafe { bindings::IS_ERR(const_ptr) } {
> +        // SAFETY: The FFI function does not deref the pointer.
> +        let err = unsafe { bindings::PTR_ERR(const_ptr) };
> +        // CAST: If `IS_ERR()` returns `true`,
> +        // then `PTR_ERR()` is guaranteed to return a
> +        // negative value greater-or-equal to `-bindings::MAX_ERRNO`,
> +        // which always fits in an `i16`, as per the invariant above.
> +        // And an `i16` always fits in an `i32`. So casting `err` to
> +        // an `i32` can never overflow, and is always valid.
> +        //
> +        // SAFETY: `IS_ERR()` ensures `err` is a
> +        // negative value greater-or-equal to `-bindings::MAX_ERRNO`.
> +        #[cfg_attr(CONFIG_ARM, allow(clippy::unnecessary_cast))]
> +        return Err(Error(err as i32));
> +    }
> +    Ok(ptr)
> +}
> 

Reviewed-by: Martin Rodriguez Reboredo
