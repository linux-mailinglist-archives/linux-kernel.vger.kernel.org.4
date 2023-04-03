Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0AB6D4FC2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjDCR6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjDCR6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:58:05 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633383A8E;
        Mon,  3 Apr 2023 10:57:35 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DB3F05C01C7;
        Mon,  3 Apr 2023 13:57:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Apr 2023 13:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680544646; x=1680631046; bh=zQJWXe21ZtGhz7ERfdBSQKRhyX9hHVQosnD
        sirMnv1Q=; b=GtH56V66t/qGKx2bjgDzOhNcjfnWapZbXtA8eZ22WaZElr3zShL
        mrbS9gluykAi+YRxTURgG2MMjA7bP6prpaBjG5LqbrO0m9JDDaizkgKWm8ZPzUn2
        hZ1ZMku+q+G+hITKyzJcwuIhxZYeHn7hSGPdwVM+TjNOKTEGKN8qs3lP7irTEeAm
        Fp+cowLnEcPKKZr54FactmTEj7hrrx10dV1MK+G7d0z+/7RmOsn/S9QhYYn1Wyen
        STWfi3hP9Mp2qnm6kUUY50yYwhQ2GmA1AXFZZWiTFCY1luBHEyGKyFY2SRDxDscY
        TbxIufqYbKeHpSb00O8nNRdj/sZCyv7W1Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680544646; x=1680631046; bh=zQJWXe21ZtGhz7ERfdBSQKRhyX9hHVQosnD
        sirMnv1Q=; b=JnG99aZU1ugvgpvgtPl1G55vxhYhYcVerkBBasZ99ifhR4dNJso
        zR2eURmEGmG1Zuxr/muOp9+/GMhAo4YQLU0veOHcZItF9i6CudFOihYIQhuQJzGa
        J+3KbW1TKwrxIrHzd8heJ5FfRha1HYEG1RmKptyxfwBD2kCTbAifIdrnFXAqBinw
        /UOFgLalr5hCUJk/M2eIDvzzx55bqRhw+/an/Kf6JvAZnh1Te7Qtf0SkTPlZb4Lp
        0S6uwSChmSvAvltnQEp1b7u5dVCy2CSnra19GaNMPUJurrfqrbYG3gTz1bsnmaUr
        3fQUlbu5eGk4RAjklhG/Y768vikBLNImS0w==
X-ME-Sender: <xms:hhMrZOdp0c73nFMXMU-NjK_RV_OiWhZOLEZWY7kmDMI75JIB1fbm3A>
    <xme:hhMrZIO9OW8qpqQLxFwL6MmE9O8YcFqcml1UjGD4jPHvuw0H-mwEPBGzi7WJ7_332
    -AqOsrTHdAYPTASIg>
X-ME-Received: <xmr:hhMrZPi6_YGcyLhfC0oGAGjd00MdYTu32zBCKo75yjKuswKQwI4UanTb65lrpIF1FKJ3-PIq8MHmbLyA9BOQYVg99w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfhuffvvehfjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    ephfehueeileevjeefkeetvdffveffudeuhffgtedvuefgiefgiedvjeegvdejleejnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:hhMrZL_XhgBdBvq7QqMFfwE__u_5ilsP_uz4UCL0tTASYPeo1PmB8Q>
    <xmx:hhMrZKs6lyEeLZZFqkh0FaK42wer7KfrKZ4mAwds7CpU4NF2MUrzJQ>
    <xmx:hhMrZCE5pAza4DkYtjTRff5gfbh3Rj7m8c2Ar_F9o8S4vsDapCVPMA>
    <xmx:hhMrZLnNvfvxcsPW1s3VkS-XYyx8im2ZdvB_C5_ehEKmCjhlx0MY3Q>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 13:57:24 -0400 (EDT)
Message-ID: <d50b28f0-e989-7392-505b-2dd9f00abef6@ryhl.io>
Date:   Mon, 3 Apr 2023 19:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH v5 14/15] rust: sync: reduce stack usage of
 `UniqueArc::try_new_uninit`
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230403154422.168633-1-y86-dev@protonmail.com>
 <20230403160511.174894-7-y86-dev@protonmail.com>
Content-Language: en-US
In-Reply-To: <20230403160511.174894-7-y86-dev@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 18:05, Benno Lossin wrote:
> `UniqueArc::try_new_uninit` calls `Arc::try_new(MaybeUninit::uninit())`.
> This results in the uninitialized memory being placed on the stack,
> which may be arbitrarily large due to the generic `T` and thus could
> cause a stack overflow for large types.
> 
> Change the implementation to use the pin-init API which enables in-place
> initialization. In particular it avoids having to first construct and
> then move the uninitialized memory from the stack into the final location.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> 
>       /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
>       pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
> -        Ok(UniqueArc::<MaybeUninit<T>> {
> +        // INVARIANT: The refcount is initialised to a non-zero value.
> +        let inner = Box::try_init::<AllocError>(try_init!(ArcInner {
> +            // SAFETY: There are no safety requirements for this FFI call.
> +            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
> +            data <- init::uninit::<T, AllocError>(),
> +        }? AllocError))?;
> +        Ok(UniqueArc {
>               // INVARIANT: The newly-created object has a ref-count of 1.
> -            inner: Arc::try_new(MaybeUninit::uninit())?,
> +            // SAFETY: The pointer from the `Box` is valid.
> +            inner: unsafe { Arc::from_inner(Box::leak(inner).into()) },
>           })
>       }
>   }

I'm curious - do you know whether this compiles to the same machine code 
as this?

pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
     let inner: Box<MaybeUninit<ArcInner<T>>> = Box::try_new_uninit()?;
     let ptr = Box::into_raw(inner) as *mut ArcInner<T>;
     addr_of_mut!((*ptr).refcount).write(bindings::REFCOUNT_INIT(1));
     Ok(UniqueArc {
         inner: Arc {
             ptr: unsafe { NonNull::new_unchecked(ptr) },
             _p: PhantomData,
         }
     })
}
