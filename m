Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6CA6F5EC4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjECTDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjECTDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:03:18 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9C67D8E;
        Wed,  3 May 2023 12:03:16 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6a5febde157so2045733a34.3;
        Wed, 03 May 2023 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683140596; x=1685732596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U0zanob5psot+MN0L3Jo7naT487S45wikpSmD7HcN6I=;
        b=Y7pSDCAs4pgUkzQE6IaengKTj1KGR+dM7m5U3wjgt7c/cAzupQ8ZjRa/epStopoCba
         Wyq07v5dOlnTpxO7t5xG29NSHxsXk2PcsRwDTFlq6fLPQBjmf4pPov6zNik3HWm3WHGN
         GhAi44H8g1tTcl2btjSqtOPOoCgQLsteMFrkzQqXZZ3MPOqpBcTXZ7Ima21AVABQusnH
         65dIh2UplkfUHuEMOTqqTtTzq2GFZUgwLfQsjiz7/6p5qq4mprddOXnvEWVPpIB5PIWg
         kDNXb/T4+KqC1xLF/PMMpWiqvNhSzdm0DQZJNsakJrvOwxvzyIVu89RgUIaYh4/mY5+O
         rchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683140596; x=1685732596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0zanob5psot+MN0L3Jo7naT487S45wikpSmD7HcN6I=;
        b=NbtHjyKkszgVfP3gLdDdNOAPAnG0xnTBUKgwXC0RMPCJjrmuymRxFjexnW/37CUxlb
         HxYEeHr5tQvbZTWQIUyr4abWvDBXucNwKXSrz4oxN+NJxrgoWASkxBGiyuuosWe35OeH
         EQyBuEm+OfBWR6Ac9Lvwqzc/+1T/dOYCb2auPQsLOKani8cgCKf23EeI1VKEhvdeIwtn
         p66jqIr3d3oyrRKIyws88OJvcxyKzWn4J/aZNrkw5abp2r6XjSvjNcWmudT8fpmkCiwN
         /EiMMRhw9f7XZPcBvsHYen8Fn4rmHvf+/UAn3BP93ak2P3FdD5SIe6vDny/DtOszBMwJ
         Cq3A==
X-Gm-Message-State: AC+VfDwvWlRi95obIOLCCPTuIDAQxyJdQIYJaOECQGoZQbRNxqUnWzJ8
        AbyKbsruCra1tLJYS3WpAs8=
X-Google-Smtp-Source: ACHHUZ45fCKODtKeE+8Qp8r2XRVU4mmpJKXM3rSpGuOzwTDG+lKyAuq1oQHcakWua1AVejIv1wPKQA==
X-Received: by 2002:a05:6870:a704:b0:191:d6cd:6f5b with SMTP id g4-20020a056870a70400b00191d6cd6f5bmr5786911oam.22.1683140595817;
        Wed, 03 May 2023 12:03:15 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id dv5-20020a056870d88500b0018459cc0f52sm897161oab.24.2023.05.03.12.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 12:03:15 -0700 (PDT)
Message-ID: <0aef40dd-a437-58e1-5fa5-b44412a2a89f@gmail.com>
Date:   Wed, 3 May 2023 16:01:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] rust: str: add conversion from `CStr` to `CString`
Content-Language: en-US
To:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230503141016.683634-1-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230503141016.683634-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/23 11:10, Alice Ryhl wrote:
> These methods can be used to copy the data in a temporary c string into
> a separate allocation, so that it can be accessed later even if the
> original is deallocated.
> 
> The API in this change mirrors the standard library API for the `&str`
> and `String` types. The `ToOwned` trait is not implemented because it
> assumes that allocations are infallible.
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>   rust/kernel/str.rs | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index b771310fa4a4..f3dc5b24ea55 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -2,6 +2,7 @@
>   
>   //! String representations.
>   
> +use alloc::alloc::AllocError;
>   use alloc::vec::Vec;
>   use core::fmt::{self, Write};
>   use core::ops::{self, Deref, Index};
> @@ -199,6 +200,12 @@ impl CStr {
>       pub unsafe fn as_str_unchecked(&self) -> &str {
>           unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
>       }
> +
> +    /// Convert this [`CStr`] into a [`CString`] by allocating memory and
> +    /// copying over the string data.
> +    pub fn to_cstring(&self) -> Result<CString, AllocError> {
> +        CString::try_from(self)
> +    }
>   }
>   
>   impl fmt::Display for CStr {
> @@ -584,6 +591,21 @@ impl Deref for CString {
>       }
>   }
>   
> +impl<'a> TryFrom<&'a CStr> for CString {
> +    type Error = AllocError;
> +
> +    fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
> +        let mut buf = Vec::new();
> +
> +        buf.try_extend_from_slice(cstr.as_bytes_with_nul())
> +            .map_err(|_| AllocError)?;
> +
> +        // INVARIANT: The `CStr` and `CString` types have the same invariants for
> +        // the string data, and we copied it over without changes.
> +        Ok(CString { buf })
> +    }
> +}
> +
>   /// A convenience alias for [`core::format_args`].
>   #[macro_export]
>   macro_rules! fmt {
> 
> base-commit: ea76e08f4d901a450619831a255e9e0a4c0ed162

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
