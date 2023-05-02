Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166746F459A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjEBNzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbjEBNzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:55:13 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818123AB2;
        Tue,  2 May 2023 06:55:12 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-19288cce249so447521fac.0;
        Tue, 02 May 2023 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683035712; x=1685627712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3JDA/PhIA0G0O8d1Tw0il5CJD7WwGew6nVyEwWH6lvQ=;
        b=U0yfWYoxRlWeKcALRu7aKMAwi5A8oOs+4Z+5+g2s0ANcfWoRm3X2iBFya84RSgbiVH
         MowHXnYm3q5ir7KqhjmvtNaNr0K5e2Oae+QOl2X84ff8x9VkSzOPzrMeiOdW54dhEfkv
         O33nVKePRa2YNQHNQRVM5/C/S/1uycn/BZBQ8rV/RLxs9DcOAJcDQhyNl7jlDUUw9R6J
         M9msNW/pqbtyDLnscBRax/fj4ZiWBvJCzPTSHwVGJdznODiHV7wU5cpnl60FgVn+gfhS
         gDjrfr+7Y+rZpSKoxAvjtO9ZFE/3A7rgOyunE2sZ9Fnosmosl3EesHoqxLB5MK2O5831
         BWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683035712; x=1685627712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JDA/PhIA0G0O8d1Tw0il5CJD7WwGew6nVyEwWH6lvQ=;
        b=aQnzz7G7DQ1Fz8Lk8LWAbneuEv5cyt5nyC/0KsG6xPMnC/xzw4Wy7GCcNwfcu9kuCz
         0wAoVGUCdJJSPR6T4mXYNJou21XtIEMp/zQzRPyAQPnqjCj1V60U3McjdjXaglNc3srC
         7L5j1I7arJMInmFVju109xdnd5i0zlAh7U+jgXVVCzwBNJrwINmdoj2deyqFu7MJYq+U
         uC2/6Os7ZPQ02E5cufi136eta7iSfffMnofVCdIrGuXQUpf5IGOKOaQDHrl2Z8WAXx2p
         Ic4v2pDxKznFQPXPKdLWsiOaYermLuEgO4Eo09mAo+Z9cZl+nEa4jTd1K3iKxV/tKjg3
         aZCA==
X-Gm-Message-State: AC+VfDzX4NZkFEexSY4QC2E8UD75FTxtbQDJv3Cs46xT7CjN1L37N0GA
        oiNakrKY/z92DglT4K0NUuQ=
X-Google-Smtp-Source: ACHHUZ5X1USdDCg3uqZzHTIADD4uVJj38sSm5V1NZkTOyKDu70KEXr87H+7xExpqkz1CG5AxhcPrqg==
X-Received: by 2002:a05:6871:595:b0:184:5428:d6bb with SMTP id u21-20020a056871059500b001845428d6bbmr8447737oan.57.1683035711614;
        Tue, 02 May 2023 06:55:11 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id p16-20020a4a95d0000000b005251e3f92ecsm1057071ooi.47.2023.05.02.06.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 06:55:10 -0700 (PDT)
Message-ID: <1271ca9a-e7ca-e76f-3ae8-23a490994bd5@gmail.com>
Date:   Tue, 2 May 2023 10:55:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] rust: str: add conversion from `CStr` to `CString`
To:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230502125306.358283-1-aliceryhl@google.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230502125306.358283-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/23 09:53, Alice Ryhl wrote:
> These methods can be used to copy the data in a temporary c string into
> a separate allocation, so that it can be accessed later even if the
> original is deallocated.
> 
> The API in this file mirrors the standard library API for the `&str` and
> `String` types. The `ToOwned` trait is not implemented because it
> assumes that allocations are infallible.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/str.rs | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index b771310fa4a4..54935ff3a610 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -2,6 +2,7 @@
>  
>  //! String representations.
>  
> +use alloc::collections::TryReserveError;
>  use alloc::vec::Vec;
>  use core::fmt::{self, Write};
>  use core::ops::{self, Deref, Index};
> @@ -199,6 +200,12 @@ impl CStr {
>      pub unsafe fn as_str_unchecked(&self) -> &str {
>          unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
>      }
> +
> +    /// Convert this [`CStr`] into a [`CString`] by allocating memory and
> +    /// copying over the string data.
> +    pub fn to_cstring(&self) -> Result<CString, TryReserveError> {
> +        CString::try_from(self)
> +    }
>  }
>  
>  impl fmt::Display for CStr {
> @@ -584,6 +591,20 @@ impl Deref for CString {
>      }
>  }
>  
> +impl<'a> TryFrom<&'a CStr> for CString {
> +    type Error = TryReserveError;
> +
> +    fn try_from(cstr: &'a CStr) -> Result<CString, TryReserveError> {
> +        let len = cstr.len_with_nul();
> +        let mut buf = Vec::try_with_capacity(len)?;
> +        buf.try_extend_from_slice(cstr.as_bytes_with_nul())?;
> +
> +        // INVARIANT: The CStr and CString types have the same invariants for
> +        // the string data, and we copied it over without changes.
> +        Ok(CString { buf })
> +    }
> +}
> +
>  /// A convenience alias for [`core::format_args`].
>  #[macro_export]
>  macro_rules! fmt {
> 
> base-commit: ea76e08f4d901a450619831a255e9e0a4c0ed162

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
