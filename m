Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57F067FCB1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 04:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjA2DwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 22:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjA2DwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 22:52:17 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B55F21A39;
        Sat, 28 Jan 2023 19:52:16 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id x15-20020a4ab90f000000b004e64a0a967fso1036695ooo.2;
        Sat, 28 Jan 2023 19:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNe1ZfrB9gN4qvZF+GyocNHAMi8Evb0cvFax8j/a8ic=;
        b=BM0/rv2fkOGAn0SRPX81zEWc0ddv+Jsm1/n+zRLhdfiXkHr5JbBq66gkUV51ophLrL
         GYE4/hTSPbCbG87Jinl5sp5H13jUAkJzrMelTaOJWtGHnxfRfvPVt6AHMsRnxtwN49dP
         nqDkRfamASJxlyLYsFCW2e5dccewRJenJS9GtH+dwXpKmA3kwNCKy8P9DTgw+DI2BLqj
         fvvsonAkV01a/RYRdmIlGBWXcxRkkqbgLJMVTtDBfaWNzRag2ezVxsl6uz8/xDDtqeTN
         a/2b9Rip1D6vrHENA07HAbwlTE4wt32zMeegfW2ze1j6pygAnOkDMteNcMs6xN4cGIIp
         TxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNe1ZfrB9gN4qvZF+GyocNHAMi8Evb0cvFax8j/a8ic=;
        b=vVn/+rFF2PrQr/GKfb2NHxZwEFBzpcM7fWxMlKR+l0ONYGPLXrn8FNKeWDfzb8Hh60
         RVlIL4pyUA6tfkItBNLVyQ34KxDi0LIOd7WgLbGOxDBw6w/7Gs0aCcGW1CMfQeyXA/5t
         bscskEGO/3K63YPn51FelVkF+0dC2xMeuSWcdZ8qhppBo6D5F8UUQOTPUxOUX00A2Azp
         V63FKHUe5eI5vzkOD4Q6FnkhfBwjx5w6pYdDSnicBcDrOc+uIpyAhE/cuITKUjjnZ6xn
         111xWz1uf7UTjEJhZAF61nM01THWlvqQxxlG+gBvbKyMIlazbe+16DApC+sN5AeJBBHL
         UaQA==
X-Gm-Message-State: AFqh2kqjNbMxK7tGcSacEZwSsKF40opYPLXWk2vOn8ZGQ0iTm7ADTu5J
        tgbScZ6yeVraIdjwaAZTos3xdJgOoHU=
X-Google-Smtp-Source: AMrXdXukd8xhv5JfjQOYcDkW48+kI0Z5SDLDfdTkMVCKHRK/9ClsaJhl6YPOeusg7N0YYV2pyMUlQQ==
X-Received: by 2002:a4a:acc4:0:b0:4f2:a1c1:4dfc with SMTP id c4-20020a4aacc4000000b004f2a1c14dfcmr20577939oon.6.1674964335690;
        Sat, 28 Jan 2023 19:52:15 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id z15-20020a4ade4f000000b004fb9a65daf1sm3422170oot.43.2023.01.28.19.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 19:52:15 -0800 (PST)
Message-ID: <92aaf8d8-13f5-1fef-557e-013e91e5c97b@gmail.com>
Date:   Sun, 29 Jan 2023 00:52:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/5] rust: types: introduce `ForeignOwnable`
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     wedsonaf@gmail.com, alex.gaynor@gmail.com,
        bjorn3_gh@protonmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org
References: <20230119174036.64046-2-wedsonaf@gmail.com>
 <20230128145345.1770912-1-yakoyoku@gmail.com>
 <Y9VV4+KCkShRex9m@boqun-archlinux>
 <3dcd0379-b375-32d2-4956-c42afd451693@gmail.com>
 <Y9WchuzdL8HBrqq7@boqun-archlinux>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <Y9WchuzdL8HBrqq7@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/23 19:07, Boqun Feng wrote:
> On Sat, Jan 28, 2023 at 05:46:50PM -0300, Martin Rodriguez Reboredo wrote:
>> On 1/28/23 14:05, Boqun Feng wrote:
>>> On Sat, Jan 28, 2023 at 11:53:45AM -0300, Martin Rodriguez Reboredo wrote:
>>> [...]
>>>>> +    /// Borrows a foreign-owned object.
>>>>> +    ///
>>>>> +    /// # Safety
>>>>> +    ///
>>>>> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
>>>>> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
>>>>> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow_mut`]
>>>>> +    /// for this object must have been dropped.
>>>>> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
>>>>> +
>>>>> +    /// Mutably borrows a foreign-owned object.
>>>>> +    ///
>>>>> +    /// # Safety
>>>>> +    ///
>>>>> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
>>>>> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
>>>>> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
>>>>> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
>>>>> +    unsafe fn borrow_mut<T: ForeignOwnable>(ptr: *const core::ffi::c_void) -> ScopeGuard<T, fn(T)> {
>>>>> +        // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
>>>>> +        // `into_foreign`.
>>>>> +        ScopeGuard::new_with_data(unsafe { T::from_foreign(ptr) }, |d| {
>>>>> +            d.into_foreign();
>>>>> +        })
>>>>> +    }
>>>>
>>>> Could these three methods have a borrowing equivalent? When I was
>>>> working on some features for the USB module I've stumbled upon the case
>>>> of having to encode a pointer (with a pivot) and I cannot do it without
>>>> taking ownership of the pointer.
>>>>
>>>
>>> *const T is Copy, so you can still use it after pass it to a function or
>>> a new binding, e.g.
>>>
>>> 	pub fn use_ptr(ptr: *const i32) { .. }
>>>
>>> 	let p: *const i32 = some_func();
>>>
>>> 	let q = p;
>>>
>>> 	// q is just a copy of p
>>> 	use_ptr(p);
>>> 	// passing to a function parameter is just copying
>>> 	use_ptr(p);
>>>
>>> maybe I'm missing something subtle, but if you have an example I can
>>> help take a look.
>>>
>>> Regards,
>>> Boqun
>>>
>>
>> I'll use a much more simple example. If I want to take the byte offset
>> between two `ForeignWrapper`s I'd have to take ownership of them, but I
>> don't see it desirable in some cases.
>>
>>     fn byte_offset<P: PointerWrapper>(ptr: P, pivot: P) -> isize {
>>         unsafe {
>>             ptr.into_pointer().cast::<u8>()
>>                 .byte_offset(pivot.into_pointer().cast())
>>         }
>>     }
>>
>> But if there was an `as_pointer(&self) -> *const c_void` method then the
>> above function will be able to borrow both `ForeignWrapper`s.
>>
>>     fn byte_offset<P: PointerWrapper>(ptr: &P, pivot: &P) -> isize {
>>         unsafe {
>>             ptr.as_pointer().cast::<u8>()
>>                 .byte_offset(pivot.as_pointer().cast())
>>         }
>>     }
>>
>> Obviously those methods that borrow will announce invariancies in their
>> doc comments. If these can exist then great and if not then another
>> solution could be explored.
>>
> 
> For this particular use case, IIUC, what you need is exactly `AsRef`:
> 
>      fn byte_offset<T, P: AsRef<T>>(ptr: &P, pivot: &P) -> isize {
>          unsafe {
>              (ptr.as_ref() as *const _).cast::<u8>()
>                  .byte_offset((pivot.as_ref() *const _).cast())
>          }
>      }
> 
> or you can implement a as_pointer() helper function to avoid the
> duplicate `.as_ref() as *const _`:
> 
>     fn as_pointer<T, P: AsRef<T>>(ptr: &P) -> *const T {
>         ptr.as_ref() as *const T
>     }
> 
> Although, we need to `impl AsRef<T> for Arc<T>` to make it work for
> `Arc<T>`, which is currently missing.
> 
> Regards,
> Boqun
> 

Now that you say it I think that I can do what I wanted by further
constraining it to `ForeignOwnable` plus `AsRef`, so thanks for the tip
Boqun.

>>>>> +
>>>>> +    /// Converts a foreign-owned object back to a Rust-owned one.
>>>>> +    ///
>>>>> +    /// # Safety
>>>>> +    ///
>>>>> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
>>>>> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
>>>>> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
>>>>> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
>>>>> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
>>>>> +}
>>>>> +
>>>>>  /// Runs a cleanup function/closure when dropped.
>>>>>  ///
>>>>>  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
>>>>> -- 
>>>>> 2.34.1
>>>>
>>>> Aside from these comments I observe that there's a possibility to make
>>>> ForeignOwnable a const trait and have non const implementors. Otherwise
>>>> if these things are out of scope, no problem whatsoever and this has my
>>>> OK.
>>>>
>>>> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
