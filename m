Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBFB6A8509
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjCBPPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjCBPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:15:41 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6024497EC;
        Thu,  2 Mar 2023 07:15:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j2so16848992wrh.9;
        Thu, 02 Mar 2023 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677770136;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHhD6PZbrJdLnN8I5j6dz8m695ceK7U+Bmp/aiVGzQE=;
        b=oQFwvGzOz0+N/vAFnagvmKGjhskYfnqsEymRMxkLLNXSCYjp8wucJWnk51b3bQJr/9
         JOuqYBqWnwcYk3dp7OGodTylYwxalkIMxa6N9GBPFDkmf97NWAuGO1MdIZdkVlnHZo1L
         TU8qzhSzaxAMXaYqd7+oVKZPodqEn25jiy7WbMZMXcsm/1dgYLovG11TKj6D4QHqmH2Q
         bfSTkJSKs+nfDkvZyImbcxUvI3b1DJnjGtym8aov+rUHubsqUefwBy8lLCbBHOWjqaG6
         1QcbfIOjVi0jbijnYRzi91FMhDtjJiI2Wu9L3v6UpEhmrh0zrvdlZ6eDQMt/PK2JqZDZ
         pJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677770136;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JHhD6PZbrJdLnN8I5j6dz8m695ceK7U+Bmp/aiVGzQE=;
        b=299kJN4wC7RlgrSUPUUatxpxhdiJLVwue5VI2ghhS0KhkM4ex8J7DU5vsglJygmj4X
         781z6oWCIYUoVdy70vFRsqg6Rfx6IjXY3IyWD3VPsM0wscMSvHvcsFvkUC87H/zx8Jv1
         p0xs520LixnOirFBrmAXaTlZQFjNjr6O0528YfM94KN2OSJzFIH1u1EA+R5VnxN+lIeo
         tKLv3AxEEao0gIed0eJ66z8ITH7bRzw68jiRFdNm1+vF/Nza9oP+13r2+klg0u5MjmR5
         YuMxa38pu8iJnhBtcBP0kdHmoTx1bJpiOdGjnUWvbHWXFFRiez3eBqpNzpVMM23Z97D4
         HQvQ==
X-Gm-Message-State: AO0yUKUyNTL3Yx1JEBCMEMAFOKf5qOUnYY/BCtUOUHZJLIJTGKkpIOFB
        RIkEQiT389qhM8ipO1u2cfM=
X-Google-Smtp-Source: AK7set/DUvxKY6tPHNQVbTQ+ktOJBEK2ArxzYbGg/5mil44VvguxxxnkP8TJPXm1jEma5Q6daYhYDA==
X-Received: by 2002:a5d:5092:0:b0:2c9:97f8:2604 with SMTP id a18-20020a5d5092000000b002c997f82604mr7106271wrt.14.1677770136143;
        Thu, 02 Mar 2023 07:15:36 -0800 (PST)
Received: from localhost (93-55-83-125.ip262.fastwebnet.it. [93.55.83.125])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b002425be3c9e2sm15627886wru.60.2023.03.02.07.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 07:15:35 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 02 Mar 2023 16:15:34 +0100
Message-Id: <CQVZVJ7DRUKZ.2MAN8KWV2U03@vincent-arch>
Cc:     "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Derek Barbosa" <debarbos@redhat.com>,
        <rust-for-linux@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] rust: bindgen: Add `alt_instr` as opaque type
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Miguel Ojeda" <ojeda@kernel.org>
References: <ZACvxNOuuyifQ9Nx@kernel.org>
In-Reply-To: <ZACvxNOuuyifQ9Nx@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> To address this build error:
>
>     BINDGEN rust/bindings/bindings_generated.rs
>     BINDGEN rust/bindings/bindings_helpers_generated.rs
>     EXPORTS rust/exports_core_generated.h
>     RUSTC P rust/libmacros.so
>     RUSTC L rust/compiler_builtins.o
>     RUSTC L rust/alloc.o
>     RUSTC L rust/bindings.o
>     RUSTC L rust/build_error.o
>     EXPORTS rust/exports_alloc_generated.h
>   error[E0588]: packed type cannot transitively contain a `#[repr(align)]=
` type
>        --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:1=
0094:1
>         |
>   10094 | / pub struct alt_instr {
>   10095 | |     pub instr_offset: s32,
>   10096 | |     pub repl_offset: s32,
>   10097 | |     pub __bindgen_anon_1: alt_instr__bindgen_ty_1,
>   10098 | |     pub instrlen: u8_,
>   10099 | |     pub replacementlen: u8_,
>   10100 | | }
>         | |_^
>         |
>   note: `alt_instr__bindgen_ty_1__bindgen_ty_1` has a `#[repr(align)]` at=
tribute
>        --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:1=
0111:1
>         |
>   10111 | / pub struct alt_instr__bindgen_ty_1__bindgen_ty_1 {
>   10112 | |     pub _bitfield_1: __BindgenBitfieldUnit<[u8; 4usize], u16>=
,
>   10113 | | }
>         | |_^
>   note: `alt_instr` contains a field of type `alt_instr__bindgen_ty_1`
>        --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:1=
0097:9
>         |
>   10097 |     pub __bindgen_anon_1: alt_instr__bindgen_ty_1,
>         |         ^^^^^^^^^^^^^^^^
>   note: ...which contains a field of type `alt_instr__bindgen_ty_1__bindg=
en_ty_1`
>        --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:1=
0104:9
>         |
>   10104 |     pub __bindgen_anon_1: alt_instr__bindgen_ty_1__bindgen_ty_1=
,
>         |         ^^^^^^^^^^^^^^^^
>
>   error: aborting due to previous error
>
>   For more information about this error, try `rustc --explain E0588`.
>   make[1]: *** [rust/Makefile:389: rust/bindings.o] Error 1
>   make: *** [Makefile:1293: prepare] Error 2
>
> Cc: Derek Barbosa <debarbos@redhat.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Ah good catch!

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
