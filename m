Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29046D4FC1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjDCR6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjDCR5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:57:54 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6BA2134;
        Mon,  3 Apr 2023 10:57:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E390C5C00FD;
        Mon,  3 Apr 2023 13:57:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Apr 2023 13:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680544642; x=1680631042; bh=sS+MOVaDNMXFgxiahtgnHlNntb5kLKGWRvs
        A/jgg7hQ=; b=afzYgKG0aV7+pi1V5UGARP5Iz8LuehOTxGlDd/9zf2SrttyHwj6
        2NtOP6SlulHrUFxdFTPXT1QJ+nYmGxiABCzDPZ6yEKLZZznAgl2LaExk+VZG7as4
        NcSpPfmI0UwobjbIgn16XengzehciMWyXVNnqdXYJNjK0n5VRJHEMfmarR7/7Hen
        tunV30Hb7BqGv5e9XkK1OrjRiY5l+1SVtfWnVoNhtPj/P/6O+bWJcVhx/QsrSZeU
        4YMTsghqWBAItco1yeQ70Y+y1LpZYWMuTZ93KX+sN4VT36XbJu9oZleDiyAqasqL
        uuE1a5gIbmoyDYCmA21Q8TDox9DjpILrXCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680544642; x=1680631042; bh=sS+MOVaDNMXFgxiahtgnHlNntb5kLKGWRvs
        A/jgg7hQ=; b=qOb9nWogM2ZEOfNTFTnsXEzZcaFSWOw+y0iXSKqrnvBBS/EXtj0
        z1T8GO35tg96iB7ipxADMXmozu7xW2APBB8OYOPAu79obCwQGr2WebdEMy1LDEi7
        hZMS3RgUH78sPGObUr7Uo1pWBnS/mhC7bP0LtvJWDM/rMk2CJ+QAG5kXpFQVUtVg
        hoScmXaGIGdKPbpQmzKhketSIIIhTIkndk8+2bUwmdFDzjMPDjho8pAIsoL0dxkP
        w67sLc/7MIyc+Pk23jxrTB+BIl9m7o8yvlBU0822jgqaUTDBZcIv1y0Se7c/odwo
        8AiccpCdQnBaSKIJ50U3qPN/Twqw3daq22Q==
X-ME-Sender: <xms:ghMrZPXd8wcpqxMiFp-HdjdU94LmiNAz5HIJEb169DaSI7VdNtcDjA>
    <xme:ghMrZHm7EdizMAMoICOqw8fQqBONq97F0PTwuM_rQR3Ps5ue4PX5He6KGdnNNekMk
    RA0Ty3ymiQIbdP_og>
X-ME-Received: <xmr:ghMrZLbg56aPAJIhHncrCwDb8bqH1c3y5z4K62-yjk0D64ASGY_CkutAvtp8Z0vcxhtZm5xBmGJLUsn4OibXDQ9VCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfhuffvvehfjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    ephfehueeileevjeefkeetvdffveffudeuhffgtedvuefgiefgiedvjeegvdejleejnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:ghMrZKWdSaXaUdkItycGAS6k3A08z8xVBs1oXoYQfjuQJxNij-vXKQ>
    <xmx:ghMrZJkhWioRB_2UWV-dX4e7CRv-Dm93gtrKpq2VfQceSurUJ5e9fQ>
    <xmx:ghMrZHdggirzSDq8V5NMGQeE2bMzfm7hR0gT42AcxzDMObpeWg-mEQ>
    <xmx:ghMrZCdM4J7dwfXVZLnDjgy8EeLX7LQ_k8tpKJ9ZBKiPlqdCkTv5qA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 13:57:20 -0400 (EDT)
Message-ID: <dc983245-2de9-2aa4-16c3-ae11a8c20b6f@ryhl.io>
Date:   Mon, 3 Apr 2023 19:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Alice Ryhl <alice@ryhl.io>
Subject: Re: [PATCH v5 11/15] rust: init: add `Zeroable` trait and
 `init::zeroed` function
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
 <20230403160511.174894-4-y86-dev@protonmail.com>
Content-Language: en-US
In-Reply-To: <20230403160511.174894-4-y86-dev@protonmail.com>
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
> Add the `Zeroable` trait which marks types that can be initialized by
> writing `0x00` to every byte of the type. Also add the `init::zeroed`
> function that creates an initializer for a `Zeroable` type that writes
> `0x00` to every byte.
> 
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

I have two minor suggestions - take them or leave them.

> +pub fn zeroed<T: Zeroable + Unpin>() -> impl Init<T> {
> +    // SAFETY: Because `T: Zeroable`, all bytes zero is a valid bit pattern for `T`
> +    // and because we write all zeroes, the memory is initialized.
> +    unsafe {
> +        init_from_closure(|slot: *mut T| {
> +            slot.write_bytes(0, 1);
> +            Ok(())
> +        })
> +    }
> +}

You don't need `T: Unpin` here.

> +macro_rules! impl_zeroable {
> +    ($($({$($generics:tt)*})? $t:ty, )*) => {
> +        $(unsafe impl$($($generics)*)? Zeroable for $t {})*
> +    };
> +}
> +
> +impl_zeroable! {
> +    // SAFETY: All primitives that are allowed to be zero.
> +    bool,
> +    char,
> +    u8, u16, u32, u64, u128, usize,
> +    i8, i16, i32, i64, i128, isize,
> +    f32, f64,
> +
> +    // SAFETY: These are ZSTs, there is nothing to zero.
> +    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, Infallible, (),
> +
> +    // SAFETY: Type is allowed to take any value, including all zeros.
> +    {<T>} MaybeUninit<T>,
> +
> +    // SAFETY: All zeros is equivalent to `None` (option layout optimization guarantee).
> +    Option<NonZeroU8>, Option<NonZeroU16>, Option<NonZeroU32>, Option<NonZeroU64>,
> +    Option<NonZeroU128>, Option<NonZeroUsize>,
> +    Option<NonZeroI8>, Option<NonZeroI16>, Option<NonZeroI32>, Option<NonZeroI64>,
> +    Option<NonZeroI128>, Option<NonZeroIsize>,
> +
> +    // SAFETY: All zeros is equivalent to `None` (option layout optimization guarantee).
> +    //
> +    // In this case we are allowed to use `T: ?Sized`, since all zeros is the `None` variant.
> +    {<T: ?Sized>} Option<NonNull<T>>,
> +    {<T: ?Sized>} Option<Box<T>>,
> +
> +    // SAFETY: `null` pointer is valid.
> +    //
> +    // We cannot use `T: ?Sized`, since the VTABLE pointer part of fat pointers is not allowed to be
> +    // null.
> +    {<T>} *mut T, {<T>} *const T,
> +
> +    // SAFETY: `null` pointer is valid and the metadata part of these fat pointers is allowed to be
> +    // zero.
> +    {<T>} *mut [T], {<T>} *const [T], *mut str, *const str,
> +
> +    // SAFETY: `T` is `Zeroable`.
> +    {<const N: usize, T: Zeroable>} [T; N], {<T: Zeroable>} Wrapping<T>,
> +}

Arguably, it would make sense to just expand this macro. The code 
doesn't become that much longer, and it removes the need to understand 
the macro.
