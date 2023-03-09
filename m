Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE996B2B44
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjCIQzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCIQz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:55:27 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F8D22C8E;
        Thu,  9 Mar 2023 08:46:50 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id g6-20020a056830308600b0068d4b30536aso1383816ots.9;
        Thu, 09 Mar 2023 08:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678380410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cZWG9NcS5ykP9v/z+VYKPHVgXZgQF/ixQK++XhQHyv0=;
        b=ROhuLW1vwLot6HIlrXjC/U39b1KB/ymFHAULRVmJmYTHvQjO2s536s27znTD6vYQWu
         AFu2hEHRsx9Qnn6RFoma3Ym/Y1zU978Ai1Ga1plXa8U8t1GehznhbW3QR4/760ZuEVVz
         Bn24Hsb0UDrAjjix9GZ6HUhr81ejX5H2Fc97HDN4N0c9nHwD7w0korwz8LG+GU2a5aer
         wUMfHXWPnDHqJa2UjK2LVVPfwNI9iV5bCBDnUHwms9DB52WgfElnVq2wA2VlLQXelcXf
         ixwsnVIu4g4TXIvLwCf5cwB7YdTBqUUAEDuaTxCveN6UMFJY1HyXdrT+yr5d8rlV5rlq
         Np/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678380410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZWG9NcS5ykP9v/z+VYKPHVgXZgQF/ixQK++XhQHyv0=;
        b=r6gEXw4rfqavQ/vIr6i5VDIivN0eFfJ1ZmrS6QyTVSId0d6BX5ulTkTSmNDVU8CBGy
         ASYPdGAHsqzrZ6HVa+wdHf3JXkI2rqH5dQ7itBhFCEZeh1VBu1pz4Y8hRFr2yedYpvFG
         k8O3Eo0yY4bq3sjPHd4B/Dhg8HVC+d2JNrkEL/IiA3AGtx5/DJwbud0C2QIP9D6cIndN
         DVLtCK9DSebfysanbylQ0EYLEP9BUMydhyUo8Haade9TCwuS9sRObmY3ZyHWfk5qbBF3
         q9Bhmqza5qOm2A/t+OhL3igDttHp/7UMCxjzZzvxIyRtMeWNlN9tg64Z/wIkpiSoJxXo
         Gmcw==
X-Gm-Message-State: AO0yUKXDjqpPfOWRq4aTEFZeQzYrBoOMnf8I9T+e7aBT1jLJplnafRdL
        COFhMv7kgdi4pPwPuirf8bsrZUUvH0AnI4F2s/8=
X-Google-Smtp-Source: AK7set+M1B7ieaN3AXAypWhbsj8RaNdd+DzdWjfKY2U1mxetJaLWjUxzCk5xH6bVhSDST/9lCqB7H2rmHqpUQGycVd4=
X-Received: by 2002:a05:6830:26ca:b0:690:d39d:ee41 with SMTP id
 m10-20020a05683026ca00b00690d39dee41mr7090562otu.7.1678380410066; Thu, 09 Mar
 2023 08:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
 <Y/idMBIOfFZxXnVM@kroah.com> <CANeycqoHwp3URSPGvnNZx+9PdbC90UVFWLwg4w=JBHQnjnGUPA@mail.gmail.com>
 <ZAnB/DozWsir1cIE@kroah.com>
In-Reply-To: <ZAnB/DozWsir1cIE@kroah.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Thu, 9 Mar 2023 13:46:39 -0300
Message-ID: <CANeycqrtjKMfpae_DUp-VrDZugJVO7mcbBvUBB+zAc=E6aU4tw@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: device: Add a stub abstraction for devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 at 08:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Mar 05, 2023 at 03:39:25AM -0300, Wedson Almeida Filho wrote:
> > > > +    /// Returns the name of the device.
> > > > +    fn name(&self) -> &CStr {
> > > > +        let ptr = self.raw_device();
> > > > +
> > > > +        // SAFETY: `ptr` is valid because `self` keeps it alive.
> > > > +        let name = unsafe { bindings::dev_name(ptr) };
> > > > +
> > > > +        // SAFETY: The name of the device remains valid while it is alive (because the device is
> > > > +        // never renamed, per the safety requirement of this trait). This is guaranteed to be the
> > > > +        // case because the reference to `self` outlives the one of the returned `CStr` (enforced
> > > > +        // by the compiler because of their lifetimes).
> > > > +        unsafe { CStr::from_char_ptr(name) }
> > >
> > > Why can the device never be renamed?  Devices are renamed all the time,
> > > sometimes when you least expect it (i.e. by userspace).  So how is this
> > > considered "safe"? and actually correct?
> > >
> > > Again, maybe seeing a real user of this might make more sense, but
> > > as-is, this feels wrong and not needed at all.
> >
> > This requirement is to allow callers to use the string without having
> > to make a copy of it.
> >
> > If subsystems/buses are not following what the C documentation says,
> > as you point out in another thread, we have a several options: (a)
> > remove access to names altogether, (b) leave things as they are, then
> > those subsystems wouldn't be able to honour the safety requirements of
> > this trait therefore they wouldn't implement it, (c) make a copy of
> > the string, etc.
>
> How about we fix the documentation in the .c code and also drop this as
> you really don't need it now.
>
> Want to send a patch for the driver core code fix?

Sure, will do.

> > > > +        // owns a reference. This is satisfied by the call to `get_device` above.
> > > > +        Self { ptr }
> > > > +    }
> > > > +
> > > > +    /// Creates a new device instance from an existing [`RawDevice`] instance.
> > > > +    pub fn from_dev(dev: &dyn RawDevice) -> Self {
> > >
> > > I am a rust newbie, but I don't understand this "RawDevice" here at all.
> >
> > Different buses will have their own Rust "Device" type, for example,
> > pci::Device, amba::Device, platform::Device that wrap their C
> > counterparts pci_dev, amba_device, platform_device.
> >
> > "RawDevice" is a trait for functionality that is common to all
> > devices. It exposes the "struct device" of each bus/subsystem so that
> > functions that work on any "struct device", for example, `clk_get`,
> > `pr_info`. will automatically work on all subsystems.
>
> Why is this being called "Raw" then?  Why not just "Device" to follow
> along with the naming scheme that the kernel already uses?

Because it gives us access to underlying raw `struct device` pointer,
in Rust raw pointers are those unsafe `*mut T` or `*const T`. I'm not
married to the name though, we should probably look for a better one
if this one is confusing.

Just "Device" is already taken. It's a ref-counted `struct device` (it
calls get_device/put_device in the right places automatically,
guarantees no dandling pointers); it is meant to be used by code that
needs to hold on to devices when they don't care about the bus. (It in
fact implements `RawDevice`.)

 How about `IsDevice`?

Then, for example, the platform bus would implement `IsDevice` for
`plaform::Device`.

> > For example, as part writing Rust abstractions for a platform devices,
> > we have a platform::Device type, which is wrapper around `struct
> > platform_device`. It has a bunch of associated functions that do
> > things that are specific to the platform bus. But then they also
> > implement the `RawDevice` trait (by implementing `raw_device` that
> > returns &pdev->dev), which allows drivers to call `clk_get` and the
> > printing functions directly.
> >
> > Let's say `pdev` is a platform device; if we wanted to call `clk_get`
> > in C, we'd do something like:
> >
> > clk = clk_get(&pdev->dev, NULL);
> >
> > In Rust, we'd do:
> >
> > clk = pdev.clk_get(None);
> >
> > (Note that we didn't have to know that pdev had a field whose type is
> > a `struct device` that we could use to call clk_get on; `RawDevice`
> > encoded this information.)
> >
> > Does the intent of the abstraction make sense to you now?
>
> A bit more, yes.  But I want to see some real users before agreeing that
> it is sane :)

Fair enough.

Cheers,
-Wedson
