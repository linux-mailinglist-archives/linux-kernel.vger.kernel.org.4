Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D25720A88
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 22:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjFBUr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 16:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjFBUr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 16:47:27 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1FA1A6;
        Fri,  2 Jun 2023 13:47:26 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-19f675022d8so2397294fac.0;
        Fri, 02 Jun 2023 13:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685738846; x=1688330846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fpVxJlX5W3JW3Wms1UzwwveVMUvugM8mrsz7VvlhE8=;
        b=sxxSItkuxRLKCKA6I/VuQKqtP7FG6Z4tmn5KgTMnZHHEEQh4c34xP4A7NtOAZfnu00
         Jo5j8a0O+bOEM/p352a00xtwu/6ARmoAl9dW9kC6jxNClELOTZm16NHlgUVcVEaDl4us
         u0maxRnnlBIxRKAoX0823a9ux2+UQyTSypXhYsJ5MBPT9GGG7Vvd18LdrnWLIJsouN+x
         rDDdUAMcE/v4y0vy6LM2RDq6EvJf56AcQVdkhkWQEA7WWotXI9QaZt0vKf8LJjPQZYh9
         TwJOny1ZYkNf5bmORxxPQu+Bk2ruL4LMJazlrAsihqo6OCybjpxtBP7KCkQDuqGhS8IG
         SjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685738846; x=1688330846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fpVxJlX5W3JW3Wms1UzwwveVMUvugM8mrsz7VvlhE8=;
        b=KGwxJHSdyCbVh1ON+orr6yHy/MU82QMyYSeR6HoKoT4PM2eCfm1fyxv+lySZdXwe6j
         zo6BMn3zei8CAGHYgR+2YqXKW/uH1/3bRdCC6rSIdl9z/GiDFg2xapsxYhJK8O6qaABA
         ncJ+G76q3SscD4PLY1IPnQC+wdFVgvyt2i8/uOXqUvZ7jWXoBxxDfaCAF8Ahbrafjq1w
         CxN/a4tJI0OV/+ptguhJ05RZdkCP/jJIDRh19RHU4vL4ArxLs7geD2jk9fLxlMEgZcMd
         PsQBc1uA7oJ+IbgeDjGe/T4se9xuFqGGm1Kl0EVOMpsF1t3zfEpkLqp2CoXIqiThSASM
         XOnA==
X-Gm-Message-State: AC+VfDy5UK9KK1KRshuCXm/MBHl1gRZtxr0xJRL/eNCX7+3WT3Mw9Xnc
        tjlBSw/3gzJBeF2m4EVfy18=
X-Google-Smtp-Source: ACHHUZ4tMi+Ade6psTARRj2HLO6wbYndQemQXCSJ3/GCDP1n/lFxfFPTcSWz9i5s8+RmpypeHzek0w==
X-Received: by 2002:a05:6870:5aa5:b0:19d:767:9da2 with SMTP id dt37-20020a0568705aa500b0019d07679da2mr2617655oab.3.1685738845889;
        Fri, 02 Jun 2023 13:47:25 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id u21-20020a056871059500b0019e6f81740fsm1016298oan.30.2023.06.02.13.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 13:47:25 -0700 (PDT)
Message-ID: <5cbf5dcc-50e2-f6f6-262b-96ac1a8ebc52@gmail.com>
Date:   Fri, 2 Jun 2023 16:54:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/3] rust: kernel: add ScatterList abstraction
Content-Language: en-US
To:     Qingsong Chen <changxian.cqs@antgroup.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org
References: <20230602101819.2134194-1-changxian.cqs@antgroup.com>
 <20230602101819.2134194-2-changxian.cqs@antgroup.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230602101819.2134194-2-changxian.cqs@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/23 07:18, Qingsong Chen wrote:
> Add a wrapper for `struct scatterlist`.
> 
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
> ---
> [...]
> +/// Wrap the kernel's `struct scatterlist`.
> +///
> +/// According to the design of kernel's `struct sg_table`, the `page_link`
> +/// field of one `scatterlist` may contain a pointer to another. That is,
> +/// there could exist external pointers to it, making it necessary to pin
> +/// this struct.
> +///
> +/// # Invirants
> +///
> +/// All instances should be valid, either created by the `new` constructor
> +/// (see [`pin_init`]), or transmuted from raw pointers (which could be used
> +/// to reference a valid entry of `sg_table`).
> +///
> +/// # Examples
> +///
> +/// The following is some use cases of [`ScatterList`].
> +///
> +/// ```rust
> +/// use core::pin::pin;
> +/// # use kernel::error::Result;
> +/// # use kernel::scatterlist::ScatterList;
> +///
> +/// // Prepare memory buffers.
> +/// let buf0: Pin<&mut [u8]> = pin!([0u8; 512]);
> +/// let buf1: Pin<&mut [u8]> = pin!([1u8; 512]);
> +///
> +/// // Allocates an instance on stack.
> +/// kernel::stack_pin_init!(let foo = ScatterList::new(&buf0));
> +/// let mut foo: Pin<&mut ScatterList<'_>> = foo;
> +/// assert_eq!(foo.length(), 512);
> +///
> +/// // Alloccate an instance by Box::pin_init.
> +/// let bar: Pin<Box<ScatterList<'_>>> = Box::pin_init(ScatterList::new(&buf1))?;
> +/// assert_eq!(bar.length(), 512);
> +///
> +/// // Assert other attributes of a instance.
> +/// assert_eq!(foo.is_dma_bus_address(), false);
> +/// assert_eq!(foo.is_chain(), false);
> +/// assert_eq!(foo.is_last(), true);
> +/// assert_eq!(foo.count(), 1);
> +///
> +/// // Get a immutable reference to memory buffer.
> +/// assert_eq!(foo.get_buf(), [0u8; 512]);
> +///
> +/// // Reset the memory buffer.
> +/// foo.set_buf(&buf1);
> +/// assert_eq!(foo.get_buf(), [1u8; 512]);
> +///
> +/// // Get a mutable reference to memory buffer.
> +/// foo.get_mut_buf().fill(2);
> +/// assert_eq!(foo.get_buf(), [2u8; 512]);
> +/// ```

This comment has some typos, but luckily there's the `typos` tool [1]
out there to help us.

> +#[pin_data]
> +pub struct ScatterList<'a> {
> +    #[pin]
> +    opaque: Opaque<bindings::scatterlist>,
> +    _p: PhantomData<&'a mut bindings::scatterlist>,
> +}
> +
> +impl<'a> ScatterList<'a> {
> [...]
> +
> +    /// Obtain a pinned reference to an immutable scatterlist from a raw pointer.
> +    pub fn as_ref(ptr: *mut bindings::scatterlist) -> Option<Pin<&'a Self>> {
> +        // SAFETY: `sgl` is non-null and valid.
> +        NonNull::new(ptr).map(|sgl| Pin::new(unsafe { &*(sgl.as_ptr() as *const ScatterList<'_>) }))
> +    }
> +
> +    /// Obtain a pinned reference to a mutable scatterlist from a raw pointer.
> +    pub fn as_mut(ptr: *mut bindings::scatterlist) -> Option<Pin<&'a mut Self>> {
> +        // SAFETY: `sgl` is non-null and valid.
> +        NonNull::new(ptr)
> +            .map(|sgl| Pin::new(unsafe { &mut *(sgl.as_ptr() as *mut ScatterList<'_>) }))
> +    }

Please mark both of these as `unsafe` as you can still pass an invalid
pointer to them. Also, if there's no other user of those methods other
than this module then I'd suggest to make them private.

> +}
> +
> [...]

Link: https://github.com/crate-ci/typos [1]
