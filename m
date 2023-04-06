Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2916D9848
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbjDFNcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbjDFNcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:32:43 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2194761BA;
        Thu,  6 Apr 2023 06:32:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4563742553;
        Thu,  6 Apr 2023 13:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1680787958;
        bh=aEI0aURBjcZmrGJ/9aJsra7/owWOVAMMqi4NSiovp3U=;
        h=Date:Subject:To:References:From:Cc:In-Reply-To;
        b=e1y6iFkmRNoIrIBw8pzrMHQ0qglTHsizYwYKGNyIGig+wmRR50q5bItUSTFqFQQUr
         6QQa3xz6KLcqdXTLz99ig9SdCL5/N4SaW2H0sYjTMUqL5y6Zqs65drRFKGLSdEbXLf
         zcg8PL4MrXeP1TFMRZ9Jh7znsO+glM6Ue17Tolgf1SsSO1cbtMrSk8jrMGVfifq/GK
         zeR/+vQCasvRCdLDwM5vn5h3Qh6h70xlLi/Wo8Q8Xt6DI39JKLdPTVFPWlEVF+n8Pc
         bCZw3jnpMmbOhG72EJvRMrhl6tpDNhSxvhOgeQDqXrOFkELrls+z0+XTBYsYMihX9Z
         g80SjKWVfgWHQ==
Message-ID: <5330cde5-2d04-200f-d606-5467f20a5f7f@asahilina.net>
Date:   Thu, 6 Apr 2023 22:32:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Linaro-mm-sig] Re: [PATCH RFC 18/18] drm/asahi: Add the Asahi
 driver for Apple AGX GPUs
Content-Language: en-US
To:     Daniel Vetter <daniel@ffwll.ch>
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-18-917ff5bc80a8@asahilina.net>
 <ZC2JPR3fGm0uE9yW@phenom.ffwll.local>
 <6200f93d-6d95-5d03-cc1c-22d7924d66eb@asahilina.net>
 <ZC6sPBuH3vz7vMO2@phenom.ffwll.local>
From:   Asahi Lina <lina@asahilina.net>
Cc:     David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
In-Reply-To: <ZC6sPBuH3vz7vMO2@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 20.25, Daniel Vetter wrote:
> On Thu, Apr 06, 2023 at 02:02:55PM +0900, Asahi Lina wrote:
>> On 05/04/2023 23.44, Daniel Vetter wrote:
>>> On Tue, Mar 07, 2023 at 11:25:43PM +0900, Asahi Lina wrote:
>>>> +/// Look up a GEM object handle for a `File` and return an `ObjectRef` for it.
>>>> +pub(crate) fn lookup_handle(file: &DrmFile, handle: u32) -> Result<ObjectRef> {
>>>> +    Ok(ObjectRef::new(shmem::Object::lookup_handle(file, handle)?))
>>>> +}
>>>
>>> So maybe my expectations for rust typing is a bit too much, but I kinda
>>> expected this to be fully generic:
>>>
>>> - trait Driver (drm_driver) knows the driver's object type
>>> - a generic create_handle function could ensure that for drm_file (which
>>>     is always for a specific drm_device and hence Driver) can ensure at the
>>>     type level that you only put the right objects into the drm_file
>>> - a generic lookup_handle function on the drm_file knows the Driver trait
>>>     and so can give you back the right type right away.
>>>
>>> Why the wrapping, what do I miss?
>>
>> Sigh, so this is one of the many ways I'm trying to work around the "Rust
>> doesn't do subclasses" problem (so we can figure out what the best one is
>> ^^).
>>
>> The generic shmem::Object::lookup_handle() call *is* fully generic and will
>> get you back a driver-specific object. But since Rust doesn't do
>> subclassing, what you get back isn't a driver-specific type T, but rather a
>> (reference to a) shmem::Object<T>. T represents the inner driver-specific
>> data/functionality (only), and the outer shmem::Object<T> includes the
>> actual drm_gem_shmem_object plus a T. This is backwards from C, where you
>> expect the opposite situation where T contains a shmem object, but that just
>> doesn't work with Rust because there's no way to build a safe API around
>> that model as far as I know.
> 
> Ah I think I just got confused. I did untangle (I think at least) the
> Object<T> trick, I guess the only thing that confused me here is why this
> is in the shmem module? Or is that the rust problem again?
> 
> I'd kinda have expected that we'd have a gem::Object<T> here that the
> lookup_handle function returns. So for the shmem case I guess that would
> then be gem::Object<shmem::Object<T>> for the driver type T with driver
> specific stuff? I guess not very pretty ...

Ahh, uh... Yeah, so shmem objects are allocated their own way (the shmem 
core expects to kfree them in drm_gem_shmem_free) and 
bindings::drm_gem_shmem_object already contains a 
bindings::drm_gem_object. Since the composition is already done in the C 
side, we can't just do it again in Rust cleanly. That's why I have this 
weird setup with both a common trait for common GEM functionality and 
separate actual types that both implement it.

Honestly the whole GEM codepath is untested other than the bits 
inherited by shmem. I'm not sure I'll be able to verify that this all 
makes sense until another Rust driver comes along that needs something 
other than shmem. I just felt I had to do *something* for GEM since the 
hierarchy is there and I needed shmem...

This whole gem stuff is IMO the messiest part of the abstractions 
though, so I'm happy to turn it on its head if it makes it better and 
someone has an idea of how to do that ^^

>> Now the problem is from the higher layers I want object operations that
>> interact with the shmem::Object<T> (that is, they call generic GEM functions
>> on the object). Options so far:
>>
>> 1. Add an outer wrapper and put that functionality there.
>> 2. Just have the functions on T as helpers, so you need to call T::foo(obj)
>> instead of obj.foo().
>> 3. Use the undocumented method receiver trait thing to make shmem::Object<T>
>> a valid `self` type, plus add auto-Deref to shmem::Object. Then obj.foo()
>> works.
>>
>> #1 is what I use here. #2 is how the driver-specific File ioctl callbacks
>> are implemented, and also sched::Job<T>. #3 is used for fence callbacks
>> (FenceObject<T>). None of them are great, and I'd love to hear what people
>> think of the various options...
>>
>> There are other unexplored options, like in this GEM case it could be
>> covered with a driver-internal auxiliary trait impl'd on shmem::Object<T>
>> buuut that doesn't work when you actually need callbacks on T itself to
>> circle back to shmem::Object<T>, as is the case with File/Job/FenceObject.
> 
> Ok I think I'm completely lost here. But I also havent' looked at how this
> is all really used in the driver, it's really just the shmem:: module in
> the lookup_handle function which looked strange to me.

Ah, sorry, I misunderstood what you were talking about in my previous 
email then. That's just a default trait function. It comes from common 
functionality in the gem module, but shmem::Object implements the trait 
so it ends up offering it too (lookup_handle() is not duplicated, it 
only lives in gem, shmem only has to implement going to/from the 
drm_gem_object pointer so the rest of the methods can use it). That's 
part of why the type/trait hierarchy is kind of messy here, it's so I 
can share functionality between both types even though they are 
pre-composed on the C side.

In the end the object types are specialized for any given driver, so 
you're always getting your own unique kind of object anyway. It's just 
that drivers based on shmem will go through it to reach the common code 
and work with a shmem::Object<T>, and drivers using raw gem will use 
gem::Object<T> instead.

~~ Lina

