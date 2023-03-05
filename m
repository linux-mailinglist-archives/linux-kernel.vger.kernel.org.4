Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4636AAE6F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 07:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjCEGwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 01:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEGwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 01:52:20 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAD2113D4;
        Sat,  4 Mar 2023 22:52:19 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id bj30so4838811oib.6;
        Sat, 04 Mar 2023 22:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677999139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uVPCnciNS5UZdaDKXjKP9xlP21Nb8O+zMC4ml8/L0BE=;
        b=Otq9kyRrj+cERFj9zBbxZ3XMskEYcjMSQqfHClhw8AyqWN0n9kBSpBQBYSFyrN0dp4
         HAB6YOADZidfExEXXd8HmtRrP3PljVPl4Ig2ghTYfrl1yjOmMA1lLSYJjnpXF62xVu9g
         ecElRrCWr6s1GpWN/89Ns5uc6wbHoXO2gzz5qXdJGj8ba47dWXI4Ard1lICB7fw5YwJM
         XrOyh2xANNL7WPrursHSAeHYp0YJmcQjEAHWkjB/uWrHm0AOhLjozYNIviyoE0abQUjC
         Bj7Zqwp53kHFpgEmiVZ/3lNzfteWd2X0gZPWYOVwlznXoHfqvD1wZXPblKFELyi9IY86
         Oc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677999139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVPCnciNS5UZdaDKXjKP9xlP21Nb8O+zMC4ml8/L0BE=;
        b=VjpvJ/u+gLdoBQi2Tl1rO0wOg1SBYtAVDhnYxLI4kdQel2tGnXnPCQXk4xmfncRfk4
         xVLjsoKNiN3bQ8EjBkw6xJ03cQhLSJhoAgdCfpJPASxJUpqbm9Zw6tp+mNZ9DGZBK78Y
         a9WlwBQNfOapAZQiAWaGkMmzT0VdsrsVqja4VPgA5000eHX676j/LZT15JLSYwRMzkLd
         8cun420tnYCHa/ThcFvU9cyN2flLa4q4nxo6Tz2KZoqTtQi8wwe7GjjeOwuAzcp8q17A
         U+eic65RiUb1BK+2+TTf8eYSBKhJtONnIgH9Pr3yYqrEMs2O2pjrmJTNOgnbRwfob8t5
         5ivA==
X-Gm-Message-State: AO0yUKWN2ma/h/vNxtIW8tsi4UEWxb2xGiABHXrgt8d+vos0YVPKP3eu
        xTCwujlaxluM1BIQmI1YrF1fznHk39xhvgw9Bfo=
X-Google-Smtp-Source: AK7set+6LvV9fYr6gHRrlz/uyOOYWP1W1jPR1mFFdAraWk23w+NeGmQWl5YWkuiv8Wrv2dhMYsvKHxPTEq5kxQEHwdU=
X-Received: by 2002:a05:6808:484:b0:384:21e7:977c with SMTP id
 z4-20020a056808048400b0038421e7977cmr1941121oid.8.1677999138710; Sat, 04 Mar
 2023 22:52:18 -0800 (PST)
MIME-Version: 1.0
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-2-49ced3391295@asahilina.net>
 <Y/ieQ0UX/niAG1Hg@kroah.com> <ef3a3638-6381-87ab-d674-644306b6b6ce@asahilina.net>
 <Y/jFeZzZVCpBGvGv@kroah.com> <e6d6d928-4514-55b9-346d-2e5e82220729@arm.com>
 <87de1cd0-a57a-3391-a4b8-599ee0307491@asahilina.net> <59a61ddc-4a96-c846-c12b-0d1e3789683c@arm.com>
 <5a00dcb1-8368-c3ce-6fcb-5932f5eb50a5@asahilina.net>
In-Reply-To: <5a00dcb1-8368-c3ce-6fcb-5932f5eb50a5@asahilina.net>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Sun, 5 Mar 2023 03:52:08 -0300
Message-ID: <CANeycqpYXOdLbUmTce_o6FhSC1rg8TZqe5MkLpsF8E4Dr9352A@mail.gmail.com>
Subject: Re: [PATCH 2/5] rust: device: Add a minimal RawDevice trait
To:     Asahi Lina <lina@asahilina.net>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
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

On Fri, 24 Feb 2023 at 13:23, Asahi Lina <lina@asahilina.net> wrote:
>
> On 25/02/2023 00.14, Robin Murphy wrote:
> > On 2023-02-24 14:48, Asahi Lina wrote:
> >>
> >>
> >> On 2023/02/24 23:32, Robin Murphy wrote:
> >>> FWIW the DMA API *has* to know which specific device it's operating
> >>> with, since the relevant properties can and do vary even between
> >>> different devices within a single bus_type (e.g. DMA masks).
> >>>
> >>> In the case of io-pgtable at least, there's no explicit refcounting
> >>> since the struct device must be the one representing the physical
> >>> platform/PCI/etc. device consuming the pagetable, so if that were to
> >>> disappear from underneath its driver while the pagetable is still in
> >>> use, things would already have gone very very wrong indeed :)
> >>
> >> There's no terribly good way to encode this relationship in safe Rust as
> >> far as I know. So although it might be "obvious" (and I think my driver
> >> can never violate it as it is currently designed), this means the Rust
> >> abstraction will have to take the device reference if the C side does
> >> not, because safe rust abstractions have to actually make these bugs
> >> impossible and nothing stops a Rust driver from, say, stashing an
> >> io_pgtable reference into a global and letting the device go away.
> >
> > If someone did that, then simply holding a struct device reference
> > wouldn't guarantee much, since it only prevents the pointer itself from
> > becoming invalid - it still doesn't say any of the data *in* the
> > structure is still valid and "safe" for what a DMA API call might do
> > with it.
> >
> > At the very least you'd probably have to somehow also guarantee that the
> > device has a driver bound (which is the closest thing to a general
> > indication of valid DMA ops across all architectures) and block it from
> > unbinding for the lifetime of the reference, but that would then mean a
> > simple driver which expects to tear down its io-pgtable from its .remove
> > callback could never be unbound due to the circular dependency :/
>
> I'd like to hear from the other Rust folks about ideas on how to solve
> this ^^. I think it might fit into the Revocable model for device
> resources, but it's going to be a bit of an issue for my driver because
> for me, the io_pgtable objects are deep in the Vm object that has its
> own refcounting, and those are created and destroyed dynamically at
> runtime, not just during device probe...

Our bus abstractions all require that driver data stored in devices
implement the `DeviceRemoval` trait, which has a single function:
device_remove. The idea is that this function will do something to
relinquish access to resources that shouldn't be accessed after the
device is unbound (device_remove is called, for whatever reason). This
mechanism is generic and allows us to break circular dependencies.

One way to implement the `DeviceRemoval` trait is to hold all
resources in "revocable" wrappers (of which we have several that have
different constraints/requirements), and then revoke access when
`device_remove` is called (this results in blocking while concurrent
users are running, then running "destructors" when they're all done
and before returning). The part that isn't great about this approach
is that we introduce error paths everywhere these resources are used
(because they may have been revoked).
