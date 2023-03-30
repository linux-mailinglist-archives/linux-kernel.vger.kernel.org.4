Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB3F6D0A51
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjC3PsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjC3PsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:48:20 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30A993F9;
        Thu, 30 Mar 2023 08:47:49 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:46:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680191248; x=1680450448;
        bh=TLUDrNmdKGfXY8JzBtXZFUEJp1pnuEMoVXaEZm0mHDE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=VvuPNklxOOPw6MsY85d7zG7QBg7+ulXX85QLBrMULrntA1URpCh7+EUWRgD0p2ODj
         sPVFUDFRKzmU3uCvphLrfU9uzgTmKqMgd4aujvZaL6XPh2Iz8JAwginXDpxuxCJYFG
         sXQ9ADf/ZLKRJxYjuSb36enVOhI50oljWaItEZh2PUvCGgmXJugcSvEugmzsbDpFcc
         yZnNZPTW9QtOo/SadHckBgCYPEoK/MdCkt4T4zeWvC175kCaLRlN7LpDNYIcKC0ELO
         cEZY6kqXfR8mzDRKy2VQO7qIFwWv4RqfxUv2rjfe6JJOaaOBtiCeViHnMf7RmYUHfR
         z74aHDQ1D8sbQ==
To:     Andreas Hindborg <nmi@metaspace.dk>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 04/13] rust: add pin-init API core
Message-ID: <6c3985d3-6b81-df0e-5c22-12a0d8044119@protonmail.com>
In-Reply-To: <87h6u24bip.fsf@metaspace.dk>
References: <20230329223239.138757-1-y86-dev@protonmail.com> <20230329223239.138757-5-y86-dev@protonmail.com> <87h6u24bip.fsf@metaspace.dk>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 15:05, Andreas Hindborg wrote:
>> +//! [`Arc<T>`]: crate::sync::Arc
>> +//! [`impl PinInit<Foo>`]: PinInit
>> +//! [`impl PinInit<T, E>`]: PinInit
>> +//! [`impl Init<T, E>`]: Init
>> +//! [`Opaque`]: kernel::types::Opaque
>> +//! [`pin_data`]: ::macros::pin_data
>> +//! [`UniqueArc<T>`]: kernel::sync::UniqueArc
>> +//! [`Box<T>`]: alloc::boxed::Box
>> +
>> +use core::{convert::Infallible, marker::PhantomData, mem::MaybeUninit};
>> +
>> +/// A pinned initializer for `T`.
>
> "An initializer for a pinned `T`" instead?

To me this does not really make sense, since the type `T` cannot be
pinned, only an instance can be. But maybe I should use the term
`pin-initializer` instead.

--
Cheers,
Benno

