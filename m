Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A712716E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjE3UPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjE3UP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:15:28 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415E19D;
        Tue, 30 May 2023 13:15:23 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-399e9455e9fso1529501b6e.0;
        Tue, 30 May 2023 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685477722; x=1688069722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXAybs3M1jd6+Bigy7bnSFaPmpOAVXQJa7fJ334Uuxo=;
        b=EODtw8QI5x4Aan2NA2lhWfLoxgLgENaYuF4eUcRkrL3coQ0qZ9YdCt16+N9xeieRxA
         1FL1+9TcRSjiynoR1GpxFoPpagSTk6DZX69WtWVb+u9Fjr0e6udLJNdWqKNVCKYGTRuX
         c3eQIYyCgvQ5omPnIlcMOo+JvoCNGQJ+d4mALHp3LbktwgrfvCdMQQ8/fqfbUtTzZ30V
         7zrNjzJc+McCYzmGbyEHcOeHou8QRtnz6gcIeYcguTRAMrNjsottxIbbDNGDOlt27AHP
         VZ+TjFKGbwhZJ4Fhrtmut6y0TZTtc6Cv0JlEmsVSeKFgY3noc1NBNFdg7MZ2NM/y1vX5
         BkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685477722; x=1688069722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXAybs3M1jd6+Bigy7bnSFaPmpOAVXQJa7fJ334Uuxo=;
        b=DS25iH9RZPlWMNoUgTsTTUXoKwqfP+y18RM9WS1lSKLD4aFFBdn2wVXA741h4OuZTt
         FEq4zlgihs3w7IxgedJWU1CkpgoMwqQ+FtNZ45ofemgGgV0ZUauAxE4oKRCPWBHelbxj
         PsiYZ1v4a8yae2ndi8jkXmGmZoj6JthKbCbkPPO7sdXPPWCoAwiMbMYRg9DosReMXdfX
         NiDVqKK0SOnr+m3WgUISJK1AWKA32/kPkm2qi8fv0vTqzJBWb2UgO+fdcDbSlu62Bwww
         ta5Z177xDrwtBbDqdVYeIEcCk464WN0NB7mgikzxhyw/ja5LpeezyRFtaTO9rcko3Ghp
         MuIw==
X-Gm-Message-State: AC+VfDxX2B7Dn+UTJhPJk65cgrT4EljUYBtbIct+mOqzGQ9PBF34Bt+k
        9ajj8xB3WhkKAsx5t5zSXjU=
X-Google-Smtp-Source: ACHHUZ6ycO8RJMK28QDVMakl+n6fgRe2gt29wwYKvo6Zz01XTDAE7OzKoB+U+hEHr2DD3o4KyY77UQ==
X-Received: by 2002:a05:6808:3942:b0:398:57fa:9b23 with SMTP id en2-20020a056808394200b0039857fa9b23mr1833675oib.0.1685477722063;
        Tue, 30 May 2023 13:15:22 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id l1-20020a056870e90100b0019f44a07b35sm3453765oan.51.2023.05.30.13.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 13:15:21 -0700 (PDT)
Message-ID: <33ef6ea0-712b-25b6-6be9-c407ecbdb68f@gmail.com>
Date:   Tue, 30 May 2023 17:15:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] rust: kernel: add scatterlist wrapper
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
        Asahi Lina <lina@asahilina.net>,
        Niklas Mohrin <dev@niklasmohrin.de>,
        rust-for-linux@vger.kernel.org
References: <20230530064821.1222290-1-changxian.cqs@antgroup.com>
 <20230530064821.1222290-2-changxian.cqs@antgroup.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230530064821.1222290-2-changxian.cqs@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 03:48, Qingsong Chen wrote:
> Add abstractions for single `struct scatterlist` and chainable
> `struct sg_table`.
> 
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
> ---
>   rust/bindings/bindings_helper.h |   1 +
>   rust/helpers.c                  |  14 +
>   rust/kernel/lib.rs              |   1 +
>   rust/kernel/scatterlist.rs      | 478 ++++++++++++++++++++++++++++++++

I think that 478 line changes are a bit too much for a commit, I'd
suggest to split this patch into smaller parts for easier reviews,
like one for ScatterList, another for SgTable, one for iterator
implementations, etc.

>   4 files changed, 494 insertions(+)
>   create mode 100644 rust/kernel/scatterlist.rs
> 
> [...]
> +
> +/// A [`ScatterList`] table of fixed `N` entries.
> +///
> +/// According to the SG table design (form kernel ), the `page_link` field may contain
> +/// a pointer to the next sg table list, so this struct should be pinned. If the table
> +/// is chainable, the last entry will be reserved for chainning. The recommended way to

This comment has some orthographic, coherence (like "SG table",
"sg table") and grammatical, though, it's correct on its meaning.

> +/// create such instances is with the [`pin_init`].
This ([`pin_init`]) might point to nothing in `rustdoc`, though I'd
recommend to test it with `make rustdoc` and opening it in a browser
nonetheless.

> +///
> +/// # Examples
> +///
> +/// The following is examples of creating [`SgTable<N>`] instances> +///
> [...]> +
> +impl<'a, const N: usize> SgTable<'a, N> {
> [...]

This `impl` block has the same definition as the one above it. And
thus, wouldn't be worth to have the iter functions inside the same
block?

> +}
> +
> +/// Wrap the kernel's `struct scatterlist`.
> +///
> +/// According to the SG table design (from kernel), the `page_link` field may contain
> +/// a pointer to the next sg table list, so this struct should be pinned.
> +///
> +/// # Invirants
> +///
> +/// All instances are valid, either created by the `new` constructor (see [`pin_init`]),
> +/// or transmuted from raw pointers by the `as_ref` or `as_mut` function (usually used
> +/// to get an entry of [`SgTable`]).
> +///
> +/// # Examples
> +///
> +/// The following is examples of creating [`ScatterList`] instances.

Same as `SgTable` above.

> +///
> +/// ```rust
> +/// use core::pin::pin;
> +/// # use kernel::error::Result;
> +/// # use kernel::scatterlist::ScatterList;
> +///
> +/// // Prepare memory buffer.
> +/// let buf: Pin<&mut [u8]> = pin!([0u8; 512]);
> +///
> +/// // Allocates an instance on stack.
> +/// kernel::stack_pin_init!(let foo = ScatterList::new(&buf));
> +/// let foo: Pin<&mut ScatterList<'_>> = foo;
> +/// assert_eq!(foo.length(), 512);
> +/// assert_eq!(foo.count(), 1);
> +///
> +/// // Alloccate an instance by Box::pin_init.
> +/// let bar: Result<Pin<Box<ScatterList<'_>>>> = Box::pin_init(ScatterList::new(&buf));
> +/// assert_eq!(bar.as_ref().unwrap().length(), 512);
> +/// assert_eq!(bar.as_ref().unwrap().count(), 1);
> +/// ```
> +#[pin_data]
> +pub struct ScatterList<'a> {
> +    #[pin]
> +    opaque: Opaque<bindings::scatterlist>,
> +    _p: PhantomData<&'a mut bindings::scatterlist>,
> +}
> +
> +impl<'a> ScatterList<'a> {
> +    /// Construct a new initializer.
> +    pub fn new(buf: &'a Pin<&mut [u8]>) -> impl PinInit<ScatterList<'a>> {
> +        // SAFETY: `slot` is valid while the closure is called, the memory buffer is
> +        // pinned and valid.
> +        unsafe {
> +            init::pin_init_from_closure(move |slot: *mut Self| {
> +                (*slot).set_buf(buf);
> +                (*slot).mark_end();
> +                Ok(())
> +            })
> +        }
> +    }
> +
> +    /// Obtain [`Pin<&ScatterList>`] from raw pointer.

I'd rather say "Obtain a pinned reference to a scatter list from a raw
pointer.

> +    pub fn as_ref(entry: *mut bindings::scatterlist) -> Option<Pin<&'a Self>> {
> +        match entry.is_null() {
> +            true => None,
> +            // SAFETY: `entry` is non-null and valid.
> +            false => Some(Pin::new(unsafe { &*(entry as *const ScatterList<'_>) })),
> +        }

Another approach could be `NonNull::new` with `Option::map`, though if
you don't use it, no problem.

> +    }
> +
> +    /// Obtain [`Pin<&mut ScatterList>`] from raw pointer.

Same as `ScatterList::as_mut`.

> +    pub fn as_mut(entry: *mut bindings::scatterlist) -> Option<Pin<&'a mut Self>> {
> +        match entry.is_null() {
> +            true => None,
> +            // SAFETY: `entry` is non-null and valid.
> +            false => Some(Pin::new(unsafe { &mut *(entry as *mut ScatterList<'_>) })),
> +        }
> +    }
> +}
> +
> +impl ScatterList<'_> {
> [...]
> +
> +    /// Return the mapped DMA length.
> +    ///
> +    /// # Safety
> +    ///
> +    /// It is only valid after this scatterlist has been mapped to some bus address
> +    /// and then called `set_dma` method to setup it.
> +    #[cfg(CONFIG_NEED_SG_DMA_LENGTH)]
> +    pub fn dma_length(&self) -> usize {
> +        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
> +        unsafe { (*self.opaque.get()).dma_length as _ }
> +    }
> +
> +    /// Return the mapped DMA length.
> +    ///
> +    /// # Safety
> +    ///
> +    /// It is only valid after this scatterlist has been mapped to some bus address
> +    /// and then called `set_dma` method to setup it.
> +    #[cfg(not(CONFIG_NEED_SG_DMA_LENGTH))]
> +    pub fn dma_length(&self) -> usize {
> +        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
> +        unsafe { (*self.opaque.get()).length as _ }
> +    }
> +
> +    /// Setup the DMA address and length.
> +    #[cfg(CONFIG_NEED_SG_DMA_LENGTH)]
> +    pub fn set_dma(&mut self, addr: usize, len: usize) {
> +        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
> +        unsafe {
> +            (*self.opaque.get()).dma_address = addr as _;
> +            (*self.opaque.get()).dma_length = len as _;
> +        }
> +        self.dma_mark_bus_address();
> +    }
> +
> +    /// Setup the DMA address and length.
> +    #[cfg(not(CONFIG_NEED_SG_DMA_LENGTH))]
> +    pub fn set_dma(&mut self, addr: usize, len: usize) {
> +        // SAFETY: By the type invariant, we know that `self.opaque` is valid.
> +        unsafe {
> +            (*self.opaque.get()).dma_address = addr as _;
> +            (*self.opaque.get()).length = len as _;
> +        }
> +        self.dma_mark_bus_address();
> +    }

Please avoid boilerplate by putting those `cfgs` inside the function.
For example you can turn this...

     /// Setup the DMA address and length.
     #[cfg(CONFIG_NEED_SG_DMA_LENGTH)]
     pub fn set_dma(&mut self, addr: usize, len: usize) {
         // SAFETY: By the type invariant, we know that `self.opaque` is valid.
         unsafe {
             (*self.opaque.get()).dma_address = addr as _;
             (*self.opaque.get()).dma_length = len as _;
         }
         self.dma_mark_bus_address();
     }

     /// Setup the DMA address and length.
     #[cfg(CONFIG_NEED_SG_DMA_LENGTH)]
     pub fn set_dma(&mut self, addr: usize, len: usize) {
         // SAFETY: By the type invariant, we know that `self.opaque` is valid.
         unsafe {
             (*self.opaque.get()).dma_address = addr as _;
             (*self.opaque.get()).length = len as _;
         }
         self.dma_mark_bus_address();
     }

...into this...

     /// Setup the DMA address and length.
     pub fn set_dma(&mut self, addr: usize, len: usize) {
         // SAFETY: By the type invariant, we know that `self.opaque` is valid.
         #[cfg(CONFIG_NEED_SG_DMA_LENGTH)]
         unsafe {
             (*self.opaque.get()).dma_address = addr as _;
             (*self.opaque.get()).dma_length = len as _;
         }
         #[cfg(not(CONFIG_NEED_SG_DMA_LENGTH))]
         unsafe {
             (*self.opaque.get()).dma_address = addr as _;
             (*self.opaque.get()).length = len as _;
         }
         self.dma_mark_bus_address();
     }

> [...]
> +}
> [...]
