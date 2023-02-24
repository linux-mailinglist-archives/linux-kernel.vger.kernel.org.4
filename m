Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2A36A2015
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjBXQxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBXQx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:53:29 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9649FE9;
        Fri, 24 Feb 2023 08:53:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id EE7B941A42;
        Fri, 24 Feb 2023 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677257605;
        bh=SjYCJ/Ra7jZGfCPaVfmq+5xuUPidspNqrUSuQiT6if4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=yS8ZJgi88KewN/mgl+Ayivh7eQxJmG2PjwDQfr6y36BqFP07WQohSYswRYqlbF92O
         ccXOeANRz0CzVT1+IU938H6pAfXs8wbxqkMFPsoQMYRU2NWh9FNn2bwcnBTzQ6l/WL
         u8ki7uy5Mj/vYMsJSq0dBnV6yMtuMqpUuq3aIAdBNOJEPFAXzsl0mHVYp+8oeNhqGB
         LjaGLWSKXvgjXXCTDOhAmGD/OMqupfWtKCPzklDMl91RcohT+mvXP4cTDoQZTMmfOz
         BLPW+PSp+rslIAghJTqfDnSNpliv1nD1UXGn7fIl2UlTDQA8uawna/0tGQqf2f6rl8
         2/AsVopbInpvw==
Message-ID: <a861feaf-bf9f-e2ec-154a-bb1a917bb6a8@asahilina.net>
Date:   Sat, 25 Feb 2023 01:53:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/5] rust: device: Add a stub abstraction for devices
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
 <Y/idMBIOfFZxXnVM@kroah.com>
 <26fc1456-0244-a379-0af4-e6adc819545c@asahilina.net>
 <Y/jZCCl4jbKoOiPX@kroah.com>
 <bd93ed8c-b020-5883-4baa-f9743e395b97@asahilina.net>
 <Y/jmfR47ZdepTyf7@kroah.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <Y/jmfR47ZdepTyf7@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2023 01.31, Greg Kroah-Hartman wrote:
> On Sat, Feb 25, 2023 at 12:51:38AM +0900, Asahi Lina wrote:
>> On 25/02/2023 00.34, Greg Kroah-Hartman wrote:
>>> On Sat, Feb 25, 2023 at 12:10:47AM +0900, Asahi Lina wrote:
>>>>>> +impl Device {
>>>>>> +    /// Creates a new device instance.
>>>>>> +    ///
>>>>>> +    /// # Safety
>>>>>> +    ///
>>>>>> +    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count.
>>>>>> +    pub unsafe fn new(ptr: *mut bindings::device) -> Self {
>>>>>> +        // SAFETY: By the safety requirements, ptr is valid and its refcounted will be incremented.
>>>>>> +        unsafe { bindings::get_device(ptr) };
>>>>>
>>>>> You don't check the return value of get_device()?  What if it failed
>>>>> (hint, it can)?
>>>>
>>>> Really? I looked at the implementation and I don't see how it can fail,
>>>> as long as the argument is non-NULL and valid... (which is a
>>>> precondition of this unsafe function). Did I miss something?
>>>
>>> This function has changed a bit over time, but yes, it could fail if
>>> someone else just dropped the last reference right before you tried to
>>> grab a new one (look at the implementation of kobject_get()).
>>>
>>> Yes, if you "know" you have a non-zero reference count first, it should
>>> never fail, but how do you know this?  We have the ability to check the
>>> return value of the function, shouldn't that happen?
>>
>> Well, we know this because it is part of the invariant. If we don't
>> uphold invariants, things fall apart... that's why we create safe
>> abstractions that don't let you break those invariants after all!
>>
>> In this particular case though, I don't see what we can usefully do
>> here. `device_get()` is going to be part of Clone impls and things like
>> that which are non-fallible. At most we can assert!() and rust-panic
>> (which is a BUG as far as I know) if it fails... would that be preferable?
> 
> That's a good question, I don't know.  In thinking about it some more,
> I think we are ok with this as-is for now.
> 
> BUT, I want to see any code that is actually using a struct device, and
> I really want to review the heck out of the platform device api that you
> must have somewhere, as that might show some other issues around this
> type of thing that might be lurking.

The platform abstraction (which I didn't write either) is here [1],
though that's just pulled straight from RfL right now without proper
commit/attribution info and has a few other dependencies still.

But the refcounting is actually really boring on that one... there is
none! A platform::Device instance only exists during probe and cannot be
cloned or stolen, so it only represents a borrowed reference during that
time, and obviously the subsystem is guaranteed to hold a reference
while the driver probe callback runs (right? I mean, things would be
incredibly broken if that weren't the case and probe could randomly lose
the reference halfway through). There is definitely going to come a time
when this isn't enough, but right now with the device resource model
stuff it works, and of course it's really easy to review since it's so
simple!

More to the point though: I think it's probably okay if some things
can't be checked in these initial submissions, but then we check them as
more users (in `kernel` and drivers) come in later? As you mentioned
there's a chicken-and-egg issue, and also I'd say a mismatch between
"what you need to validate certain invariants/design decisions" and
"what is reasonable to submit as a single series". But at the end of the
day we're going to have to refer back to this code when reviewing
further code that uses it inside `kernel` anyway (especially this early
on), so it's probably okay to fix anything that we missed or discover is
broken then? I certainly don't mind adding a bunch of "fix broken thing"
patches at the head of later reviews if we run into issues ^^

[1]
https://github.com/Rust-for-Linux/linux/pull/969/commits/33770890aa71a491d81ec2cb2b7a45d953d1b7dd


~~ Lina
