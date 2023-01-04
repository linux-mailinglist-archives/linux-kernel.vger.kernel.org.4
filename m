Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CDE65D7E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbjADQHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239757AbjADQGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:06:55 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15B91573E;
        Wed,  4 Jan 2023 08:06:53 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DACE5C012E;
        Wed,  4 Jan 2023 11:06:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 04 Jan 2023 11:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crisal.io; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1672848413; x=
        1672934813; bh=HgshSoO5gw8yYEeQSi81/W1v7g4XA2r8QMVrsjONx5I=; b=z
        I7x+LH720P0gZVa8KHWvcshG7XaXO9NS2yuLvwOuNA6i3jT7Pl5MrWLx+frLTlly
        66m+WsYaVzm82TdZ++2AzIKbrtW01p6CjxemIIoyJPubrcfw+vL84DDJrtdJKjCy
        xT+7qaY6suCw0SFETHT9XRdOxBbE6JK3iWpTs1eeq6/zaSgZTvFq9C5OC3W0zAxq
        tW/Q45yveERsaqdbBvDZ6pzH+cNzMT+gDpLt9AZPGGaaHf+M0PkTRkajjZgYOXDR
        4CKur/3YukbmH2iYmIrZp3xWhJwGE9YzqbptjSnInHp9w80TRRhn3ll7xzT6nYoD
        Wdo/mIB0W96RrElX7Kxxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672848413; x=
        1672934813; bh=HgshSoO5gw8yYEeQSi81/W1v7g4XA2r8QMVrsjONx5I=; b=Q
        vAdZRdUhTX5t2vVNYWgqUCPXg+3e9v1+FCgBYbZ1y3aHIL1HJsfZlgK5vMp1L232
        yq2eRlwJ/jDWmtamXTfcU+nuDC9UH9fJ4oFaICz/uqwmzPEJksZLoVsaCwe2fnm1
        lpOAFqrJBTQaMdWAbLyVHF1VT0ntKxdIgNGiavxH+Bu9OhQPP37nV0Abqc/hB8El
        lN8OCS5wumqemM+BkjD4r5QZ5eDIskht3gtatBcNKlOMJuYpnV7nMVGlUFZmYPr+
        QwI0sFl1lehDGtvM0Q3aRnovPaEP4gaOZedxi1ucwnZd65y92iK0tmv2G1JCM/Q4
        uijqHrNk6Zr+n28IwXhrg==
X-ME-Sender: <xms:HKS1Y5ILR1fimQUTVL8r2BhrQ-9YTXvo4aZW26Vu9rs8u1I8QJgWMQ>
    <xme:HKS1Y1I1M4ybfGvg3wF0hU1VibLdQi7GJ1Ln7hHoeLqz7fVWMx2Hius6ItpUWH1cg
    Bpeb-wYcsfmEJG0PEQ>
X-ME-Received: <xmr:HKS1Yxu4re7fTD_htRg5CfatlJhCD1FDx5Il_qtSMbqh65xofy7WSjPZu0rRNM-JNtFN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepgfhmihhl
    ihhoucevohgsohhsucmllhhvrghrvgiiuceovghmihhlihhosegtrhhishgrlhdrihhoqe
    enucggtffrrghtthgvrhhnpeejfeehgfduudeuvddujedujeeliefgheethefhtedvfeel
    keeiuedvudeugeefkeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvghmihhlihhosegtrhhi
    shgrlhdrihho
X-ME-Proxy: <xmx:HKS1Y6YRJxu_BMnTO-F-W7dmol3WzGB0GNpHTRnjwyAIDsBrDyU5Mw>
    <xmx:HKS1YwZsyR5BVqeBbAv1agCAY3Nk4pC_Wrx1LnteGE8q5_8fo2EHDA>
    <xmx:HKS1Y-D-Pl1rJjyrZr6bz5uRgQ-dqIIEiOuamvwlhCAbJIwRLK_flQ>
    <xmx:HaS1Y1N5tmAGt_7eT_tflbS4oEEQy4U9voy6-dO5sTnUhQe7RcpJWQ>
Feedback-ID: i2e3c46c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jan 2023 11:06:51 -0500 (EST)
Message-ID: <df2f6c0b-fb4c-97e5-b607-7df626ea5933@crisal.io>
Date:   Wed, 4 Jan 2023 17:06:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Firefox/110.0 Thunderbird/110.0a1
Subject: Re: [PATCH 4/7] rust: sync: introduce `ArcBorrow`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-4-wedsonaf@gmail.com>
 <20221231194352.55cf0a26.gary@garyguo.net>
 <CANeycqrVsbNJ+A+A26LXkBezBNUHvnZU2Q3_whexCwwG5ZcgPQ@mail.gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>
In-Reply-To: <CANeycqrVsbNJ+A+A26LXkBezBNUHvnZU2Q3_whexCwwG5ZcgPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the drive-by comment, but maybe it saves some work.

On 1/4/23 16:29, Wedson Almeida Filho wrote:
> On Sat, 31 Dec 2022 at 19:43, Gary Guo <gary@garyguo.net> wrote:
>>
>> On Wed, 28 Dec 2022 06:03:43 +0000
>> Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>>
>>> This allows us to create references to a ref-counted allocation without
>>> double-indirection and that still allow us to increment the refcount to
>>> a new `Arc<T>`.
>>>
>>> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
>>> ---
>>>   rust/kernel/sync.rs     |  2 +-
>>>   rust/kernel/sync/arc.rs | 97 +++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 98 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
>>> index 39b379dd548f..5de03ea83ea1 100644
>>> --- a/rust/kernel/sync.rs
>>> +++ b/rust/kernel/sync.rs
>>> @@ -7,4 +7,4 @@
>>>
>>>   mod arc;
>>>
>>> -pub use arc::Arc;
>>> +pub use arc::{Arc, ArcBorrow};
>>> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
>>> index dbc7596cc3ce..f68bfc02c81a 100644
>>> --- a/rust/kernel/sync/arc.rs
>>> +++ b/rust/kernel/sync/arc.rs
>>> @@ -19,6 +19,7 @@ use crate::{bindings, error::Result, types::Opaque};
>>>   use alloc::boxed::Box;
>>>   use core::{
>>>       marker::{PhantomData, Unsize},
>>> +    mem::ManuallyDrop,
>>>       ops::Deref,
>>>       ptr::NonNull,
>>>   };
>>> @@ -164,6 +165,18 @@ impl<T: ?Sized> Arc<T> {
>>>               _p: PhantomData,
>>>           }
>>>       }
>>> +
>>> +    /// Returns an [`ArcBorrow`] from the given [`Arc`].
>>> +    ///
>>> +    /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
>>> +    /// receiver), but we have an [`Arc`] instead. Getting an [`ArcBorrow`] is free when optimised.
>>> +    #[inline]
>>> +    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
>>> +        // SAFETY: The constraint that the lifetime of the shared reference must outlive that of
>>> +        // the returned `ArcBorrow` ensures that the object remains alive and that no mutable
>>> +        // reference can be created.
>>> +        unsafe { ArcBorrow::new(self.ptr) }
>>> +    }
>>>   }
>>>
>>>   impl<T: ?Sized> Deref for Arc<T> {
>>> @@ -208,3 +221,87 @@ impl<T: ?Sized> Drop for Arc<T> {
>>>           }
>>>       }
>>>   }
>>> +
>>> +/// A borrowed reference to an [`Arc`] instance.
>>> +///
>>> +/// For cases when one doesn't ever need to increment the refcount on the allocation, it is simpler
>>> +/// to use just `&T`, which we can trivially get from an `Arc<T>` instance.
>>> +///
>>> +/// However, when one may need to increment the refcount, it is preferable to use an `ArcBorrow<T>`
>>> +/// over `&Arc<T>` because the latter results in a double-indirection: a pointer (shared reference)
>>> +/// to a pointer (`Arc<T>`) to the object (`T`). An [`ArcBorrow`] eliminates this double
>>> +/// indirection while still allowing one to increment the refcount and getting an `Arc<T>` when/if
>>> +/// needed.
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// There are no mutable references to the underlying [`Arc`], and it remains valid for the
>>> +/// lifetime of the [`ArcBorrow`] instance.
>>> +///
>>> +/// # Example
>>> +///
>>> +/// ```
>>> +/// use crate::sync::{Arc, ArcBorrow};
>>> +///
>>> +/// struct Example;
>>> +///
>>> +/// fn do_something(e: ArcBorrow<'_, Example>) -> Arc<Example> {
>>> +///     e.into()
>>> +/// }
>>> +///
>>> +/// let obj = Arc::try_new(Example)?;
>>> +/// let cloned = do_something(obj.as_arc_borrow());
>>> +///
>>> +/// // Assert that both `obj` and `cloned` point to the same underlying object.
>>> +/// assert!(core::ptr::eq(&*obj, &*cloned));
>>> +/// ```
>>> +pub struct ArcBorrow<'a, T: ?Sized + 'a> {
>>> +    inner: NonNull<ArcInner<T>>,
>>> +    _p: PhantomData<&'a ()>,
>>> +}
>>> +
>>> +impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
>>> +    fn clone(&self) -> Self {
>>> +        *self
>>> +    }
>>> +}
>>> +
>>> +impl<T: ?Sized> Copy for ArcBorrow<'_, T> {}
>>
>> Couldn't this just be derived `Clone` and `Copy`?
> 
> Indeed. I'll send a v2 with this.

I'm not sure this is true. Deriving will add the T: Copy and T: Clone 
bound, which I think is not what you want here.

i.e., I assume you want an ArcBorrow to be Copy even if the underlying T 
is not.

See <https://github.com/rust-lang/rust/issues/26925> for the relevant 
(really long-standing) Rust issue.

Cheers,

  -- Emilio
