Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DB765157A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiLSWVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiLSWVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:21:02 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238EB2BF1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:20:54 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id j1so23337uan.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RxmiHkv6ivmfj+H9tJK9BeQ/nWwt/l17Ya2JZVqxw18=;
        b=GeaxoSCsdWRkS1gBKP9Q3x2laDi6HJWzi8GQh4o2QPcKMi2mxVifqDLh3aGZNCNNSq
         H+MXOteLfoOEgLKMDxmvuY9Jb6B+aQNdDT/CLwpvHKhRu9uGnXZrkf7++a+y4Ss0/Bgr
         992zONuEnjRt0DWcwRa546wGFU3r1aFcTiEJfCb15ul3rmm5mjfJ96HE115JiJzK3WuP
         05SpxULmHn3UtTAUQTt4rVDUGi9xfFvyEaGB6BRH9+mykBqK6CN/pm4awdX91FZywAId
         u2EbFhEqwEbQZYC90zJRgbEaeU458Ez04UVjk4jBYyHu9/yXkewiW1ywXuzcC9F+UizO
         i2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxmiHkv6ivmfj+H9tJK9BeQ/nWwt/l17Ya2JZVqxw18=;
        b=McMosFE1T0ZUco+UrbvMvgarMHHvJDTA030iNW0WNusWKbK6SvP36x46LDDEh+Qwb/
         UP45XhHfv42BRovJA9xuTGID1pLO9/tjMs3CapXGPSnk/0Jl0YbJ4DdQSDy2NHYJGCc0
         kDTLCwbeBv7l8yuZAngYrj6w7ifYhu1+oQXLYacjdzyb+H7xHM3bbGuWP+D2Me/02gIw
         D7uuFr9o5qk/PskAqn/PYEAxTJEb8lHslAiOTUeC9QiCQotWWu8wWe8BNlW0WxpKv6yM
         IJiaL8Rb1MkPkXZ/++jYWgnmpLMNbMNzlx8GItOCYv71zcXD4qnw3WfkL7NEOOG9sxvc
         9lrw==
X-Gm-Message-State: ANoB5pkZjTcIBVkGMU1KRI8BFWmir9K8e27vbNtUew0sH/1fqKrWQTSA
        xmi7gZ4xCFLeDLY7WEtUj0+jocumcKxR3BuI2h0FAg==
X-Google-Smtp-Source: AA0mqf4d3NSdAFEU16BBWwd1hMKFYpR21hucmXNh8IEHv5SxpHHPbzliagZ8LC9LipaUVe9ESUV0/RApyZV6irEEvbY=
X-Received: by 2002:ab0:2841:0:b0:411:7c09:b011 with SMTP id
 c1-20020ab02841000000b004117c09b011mr58868113uaq.95.1671488453061; Mon, 19
 Dec 2022 14:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com>
 <20221219204619.2205248-1-allenwebb@google.com> <20221219204619.2205248-11-allenwebb@google.com>
 <Y6DWaODE5F9x+Qq1@bombadil.infradead.org> <CAJzde07K0siUs-eKfXxVp7R47hF8TdADGeTEvFtwxHVg9NV7FA@mail.gmail.com>
 <Y6Dgs5WcK2A77ulS@bombadil.infradead.org>
In-Reply-To: <Y6Dgs5WcK2A77ulS@bombadil.infradead.org>
From:   Allen Webb <allenwebb@google.com>
Date:   Mon, 19 Dec 2022 16:20:41 -0600
Message-ID: <CAJzde06qg3FQTO9KrHnScEkvVy1OEwyzbfArqXoLxOKCjr6CWQ@mail.gmail.com>
Subject: Re: [PATCH v9 10/10] docs: Include modules.builtin.alias
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 4:07 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Dec 19, 2022 at 03:40:42PM -0600, Allen Webb wrote:
> > On Mon, Dec 19, 2022 at 3:23 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Mon, Dec 19, 2022 at 02:46:18PM -0600, Allen Webb wrote:
> > > > Update the documentation to include the presense and use case of
> > > > modules.builtin.alias.
> > > >
> > > > Signed-off-by: Allen Webb <allenwebb@google.com>
> > > > ---
> > > >  Documentation/kbuild/kbuild.rst | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> > > > index 08f575e6236c..1c7c02040a54 100644
> > > > --- a/Documentation/kbuild/kbuild.rst
> > > > +++ b/Documentation/kbuild/kbuild.rst
> > > > @@ -17,6 +17,12 @@ modules.builtin
> > > >  This file lists all modules that are built into the kernel. This is used
> > > >  by modprobe to not fail when trying to load something builtin.
> > > >
> > > > +modules.builtin.alias
> > > > +---------------------
> > > > +This file lists all match-id based aliases for modules built into the kernel.
> > > > +These are intended to enable userspace to make authorization decisions based
> > > > +on which modules are likely to be bound to a device after it is authorized.
> > >
> > > What is an example? This sounds obscure.
> >
> > Many of the devices that match the usb_storage driver only specify the
> > vendor id, product id, and device id (VID:PID:D) and do not match
> > against device class, interface class, etc. Here are some examples
> > from modules.alias: A grep for wildcards in these fields yields 6136
> > matches:
> > grep 'dc\*dsc\*dp\*ic\*isc\*ip\*in\*'
> > /lib/modules/5.19.11-1rodete1-amd64/modules.alias | wc -l
> > 6136
> >
> > To write USBGuard policy that only authorizes devices that bind to a
> > particular module the policy needs to be aware of all these VID:PID:D
> > which can change between kernel versions.
> >
> > This is done at runtime rather than excluding modules from the build
> > because some devices are not needed at or before login or when a
> > device is locked. By not authorizing new devices that would bind to a
> > set of modules, these modules become unreachable to an attacker who
> > seeks to exploit kernel bugs in those modules.
> >
> > I could add this detail to the documentation file, but I was trying to
> > keep the description to about the same length as the others around it.
>
> How about the second sentence you wrote say something like:
>
> An example usage of the built-in aliases is to enable software such as
> USBGuard to enable / disable specific devices outside of just the
> vendor, product and device ID. This allows more flexible security policies
> in userspace.

I tweaked it a tiny bit, but that makes the whole description:

This file lists all match-id based aliases for modules built into the kernel.
An example usage of the built-in aliases is to enable software such as
USBGuard to allow or block devices outside of just the vendor, product, and
device ID. This enables more flexible security policies in userspace.

>
>   Luis
