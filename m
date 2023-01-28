Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D169167FAF4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 21:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjA1Uq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 15:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA1Uq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 15:46:56 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4D02684;
        Sat, 28 Jan 2023 12:46:54 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id e21-20020a9d5615000000b006884e5dce99so3413317oti.5;
        Sat, 28 Jan 2023 12:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pnL4mJpthSV+odijMNG98AG6idR1nElPULqPEfy3zP4=;
        b=XFvmTOR7lBfQ9+zo9cdCWBXITbJHH4ckG8SgqOMrf7Ef1BiweJ5A0Swr0Z3RiGMouz
         JQIkIvzWtWfdPzSE9i17o6xyTyV+C7pJh7VT1R/3h3Pen2G5vLNMI0w21JpHmvAv6LeS
         OiQIXVScdvLkERjTUa5Apta5ztypxmN9XyHkGX5+BafHZZA3dInald/60vrtXX4hPO1a
         8uFNOUwm0FfhGtF3CvIiQR9Cq1/XhZdJ6l7T1gBMb6umAX2lFiQtzOB0LuPLKyP+5vk3
         uZrJGHrSx140dg1fr9Gw2+OSldw3kh1dwo03zqCc1taTguXdBJVUyFfNPlM7yV97iwHZ
         GuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pnL4mJpthSV+odijMNG98AG6idR1nElPULqPEfy3zP4=;
        b=XRk+f3hqgi7cuNWtVxFhkq+N7GRHvsjxuDQvkYl3HvVdU2rV62H/+WBHZLgSHQQ2W0
         XjcYy6DFkbHF2+zLBvgQ3dWTDZKrTXAwPG04pnIfY7KwKn2nFiAJuf0YBFoa3VkvYigF
         VogrtzAci489ssvDYq6hn6KIdW4TsR8WU840z08/fn+w/b+9udOb75SSpghiz2ltM1CL
         NcTAhonpUyxx3iwEZN8aSRDdBIuuAf8s91+fw9jSSUEUJ3kkXksIT1JZIChSiTZJtKSd
         zP832BEM9BIY6bgnF0iMDwnRh022RDTRj3iGVrEBP6jXmTUx1uloCV6LNQxcLWTvHZpb
         vu1w==
X-Gm-Message-State: AFqh2kqPzJQ3mqq+5EHol1bupel3+yu0T9OcgAoDw1Bmtz5ph78nggOq
        tI3zGQGnMrRRgJ9Qb7a4nqNkIGm16Ok=
X-Google-Smtp-Source: AMrXdXtC/D2i7Z08b41Zj5kfLpMAScywOMCfCqjWDUWnND9I6Ya6+ufp91J23gOtS3qf20JN9jw9KA==
X-Received: by 2002:a9d:7849:0:b0:670:85a7:564d with SMTP id c9-20020a9d7849000000b0067085a7564dmr22019495otm.2.1674938814123;
        Sat, 28 Jan 2023 12:46:54 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id db10-20020a0568306b0a00b006863c59f685sm3395307otb.28.2023.01.28.12.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 12:46:53 -0800 (PST)
Message-ID: <3dcd0379-b375-32d2-4956-c42afd451693@gmail.com>
Date:   Sat, 28 Jan 2023 17:46:50 -0300
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
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <Y9VV4+KCkShRex9m@boqun-archlinux>
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

On 1/28/23 14:05, Boqun Feng wrote:
> On Sat, Jan 28, 2023 at 11:53:45AM -0300, Martin Rodriguez Reboredo wrote:
> [...]
>>> +    /// Borrows a foreign-owned object.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
>>> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
>>> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow_mut`]
>>> +    /// for this object must have been dropped.
>>> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
>>> +
>>> +    /// Mutably borrows a foreign-owned object.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
>>> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
>>> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
>>> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
>>> +    unsafe fn borrow_mut<T: ForeignOwnable>(ptr: *const core::ffi::c_void) -> ScopeGuard<T, fn(T)> {
>>> +        // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
>>> +        // `into_foreign`.
>>> +        ScopeGuard::new_with_data(unsafe { T::from_foreign(ptr) }, |d| {
>>> +            d.into_foreign();
>>> +        })
>>> +    }
>>
>> Could these three methods have a borrowing equivalent? When I was
>> working on some features for the USB module I've stumbled upon the case
>> of having to encode a pointer (with a pivot) and I cannot do it without
>> taking ownership of the pointer.
>>
> 
> *const T is Copy, so you can still use it after pass it to a function or
> a new binding, e.g.
> 
> 	pub fn use_ptr(ptr: *const i32) { .. }
> 
> 	let p: *const i32 = some_func();
> 
> 	let q = p;
> 
> 	// q is just a copy of p
> 	use_ptr(p);
> 	// passing to a function parameter is just copying
> 	use_ptr(p);
> 
> maybe I'm missing something subtle, but if you have an example I can
> help take a look.
> 
> Regards,
> Boqun
> 

I'll use a much more simple example. If I want to take the byte offset
between two `ForeignWrapper`s I'd have to take ownership of them, but I
don't see it desirable in some cases.

    fn byte_offset<P: PointerWrapper>(ptr: P, pivot: P) -> isize {
        unsafe {
            ptr.into_pointer().cast::<u8>()
                .byte_offset(pivot.into_pointer().cast())
        }
    }

But if there was an `as_pointer(&self) -> *const c_void` method then the
above function will be able to borrow both `ForeignWrapper`s.

    fn byte_offset<P: PointerWrapper>(ptr: &P, pivot: &P) -> isize {
        unsafe {
            ptr.as_pointer().cast::<u8>()
                .byte_offset(pivot.as_pointer().cast())
        }
    }

Obviously those methods that borrow will announce invariancies in their
doc comments. If these can exist then great and if not then another
solution could be explored.

>>> +
>>> +    /// Converts a foreign-owned object back to a Rust-owned one.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
>>> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
>>> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
>>> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
>>> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
>>> +}
>>> +
>>>  /// Runs a cleanup function/closure when dropped.
>>>  ///
>>>  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
>>> -- 
>>> 2.34.1
>>
>> Aside from these comments I observe that there's a possibility to make
>> ForeignOwnable a const trait and have non const implementors. Otherwise
>> if these things are out of scope, no problem whatsoever and this has my
>> OK.
>>
>> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
