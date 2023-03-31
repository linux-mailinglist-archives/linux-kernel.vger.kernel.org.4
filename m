Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F8D6D19A3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjCaISn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjCaISk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:18:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3FDB46F
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:18:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i5so86738481eda.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680250717;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=uMJy1C9/3QR5jjuw5Xv2+S7pMfTZMnWAxKSE4c5qidM=;
        b=fmzfl9IOs735tXSv5WRpDWImpl7qScBJ0TpByEkzL0uKL4RNFRy8fFPjWqyMz5M76F
         zlBJtzL56YDZmviRE03XGtIWzaq/Z5rnScnRHJi4Qf8YeWnlRV52yVtAGlxWwGzBnGV/
         3x06jpXMum2HJ7t4VmxOiJYCAte4E3jW9sPhA9FjXT2zUJbx3TdzfCKY23+b4HDb5fxA
         jLyy9mQd04BST5ySdlp+y4TF0gG+wy36ROKjnHL7FJ5FEEzjxEwid5sWV4SdY7iv7oMW
         rXHUoo2PfyxJE+hbktrKRbWfZ4hne/HlDFy8GGPTc0QVxS4CsKAUokZEVsnoFVcYBSPu
         4kGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680250717;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMJy1C9/3QR5jjuw5Xv2+S7pMfTZMnWAxKSE4c5qidM=;
        b=jBVDKiqriEidKTu7uKJPsEntzvl6M1ILcofOf0lDNuUNsxYoqQBaDnagdobrAmvXsW
         FtaxCymZezZnKt5axp8k/G9RteATvaHiOeCW6PLWpxHjD8+DGp1jojJhMzhmOZIJ4wyu
         Y6mbXbGBUagHwiz2TtARk6EzkKCUW7YBumfU2O5AV76YKk6z2iQUF4bv2eTyyTOfCLB8
         Ipyc5+QmpY06nm5WvpViG4JV3I3X0xHIHziQg9u9W/JAak+qRSBF74O7nembdLVPvqX7
         SFeWeShbOj0DRiVLt7Pw3atm9lLvX9V/hxOd2NMZXDrkxe4Ps5IiQSz4DncOFRzYJjhL
         Y3Qg==
X-Gm-Message-State: AAQBX9d/YlsIYwkFwI8GzFxfgIpfA/jy1UBL69zgJR1Lr6rxxak6ilRm
        8SMDnoCg0CFhhUj/N2DPnmcwqg==
X-Google-Smtp-Source: AKy350b3Wzo7SMpS0QCe0HFcHDRnX9Y5vwvxvTXiZ+KLr1OZAOTr3A0/ZUOsuDwzc/Tz3MJU6jY50A==
X-Received: by 2002:a17:906:5a94:b0:933:15c0:6e05 with SMTP id l20-20020a1709065a9400b0093315c06e05mr25588433ejq.7.1680250717477;
        Fri, 31 Mar 2023 01:18:37 -0700 (PDT)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id h13-20020a1709066d8d00b009475bd8f441sm719038ejt.60.2023.03.31.01.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 01:18:36 -0700 (PDT)
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-5-y86-dev@protonmail.com>
 <87h6u24bip.fsf@metaspace.dk>
 <6c3985d3-6b81-df0e-5c22-12a0d8044119@protonmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 04/13] rust: add pin-init API core
Date:   Fri, 31 Mar 2023 10:16:56 +0200
In-reply-to: <6c3985d3-6b81-df0e-5c22-12a0d8044119@protonmail.com>
Message-ID: <871ql549lv.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Benno Lossin <y86-dev@protonmail.com> writes:

> On 30.03.23 15:05, Andreas Hindborg wrote:
>>> +//! [`Arc<T>`]: crate::sync::Arc
>>> +//! [`impl PinInit<Foo>`]: PinInit
>>> +//! [`impl PinInit<T, E>`]: PinInit
>>> +//! [`impl Init<T, E>`]: Init
>>> +//! [`Opaque`]: kernel::types::Opaque
>>> +//! [`pin_data`]: ::macros::pin_data
>>> +//! [`UniqueArc<T>`]: kernel::sync::UniqueArc
>>> +//! [`Box<T>`]: alloc::boxed::Box
>>> +
>>> +use core::{convert::Infallible, marker::PhantomData, mem::MaybeUninit};
>>> +
>>> +/// A pinned initializer for `T`.
>>
>> "An initializer for a pinned `T`" instead?
>
> To me this does not really make sense, since the type `T` cannot be
> pinned, only an instance can be. But maybe I should use the term
> `pin-initializer` instead.

I see. Could be "An initializer for a pinned instance of `T`" then. Just
to clarify that the initializer itself is not the thing that is pinned.

