Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41600651559
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiLSWKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiLSWKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:10:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CCA15722;
        Mon, 19 Dec 2022 14:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iD7BpxEaWGuy9CQnI2WjXYNcUeX7//NhEChm1ql7rCk=; b=uMHXHAU0yvkrsxG9oduHvNGzAH
        aQCgxcdBI2JTBzkfArGCots01pzjHDMTSqfO+Ma3KCoQPhcyryS5P2u60lD8oQgjMtiZD4I6lr1q3
        UohpRvfqhBCzWdvZfVG2jxYhdhr4Y7Ova+vYloyId2DOzYNG2mst28JJuKVcqh9jdv8bRtDEkTIO1
        eUKt2gx/TBRhrlrqJVxu9fymdn0NA369WiY5ZW7HurtN0BTrptodwxaN86LH90lw2Omrr4msKFqwH
        vh12iomSEAdDTMPByR/4wdOrCCQ4l8+cvU0vabwq4m1RMqba741UDCKXw3aV5cqvAIrqmO/TrUrPD
        hsH5S7TQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7OIV-004GEb-Rw; Mon, 19 Dec 2022 22:07:48 +0000
Date:   Mon, 19 Dec 2022 14:07:47 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v9 10/10] docs: Include modules.builtin.alias
Message-ID: <Y6Dgs5WcK2A77ulS@bombadil.infradead.org>
References: <20221219191855.2010466-1-allenwebb@google.com>
 <20221219204619.2205248-1-allenwebb@google.com>
 <20221219204619.2205248-11-allenwebb@google.com>
 <Y6DWaODE5F9x+Qq1@bombadil.infradead.org>
 <CAJzde07K0siUs-eKfXxVp7R47hF8TdADGeTEvFtwxHVg9NV7FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJzde07K0siUs-eKfXxVp7R47hF8TdADGeTEvFtwxHVg9NV7FA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 03:40:42PM -0600, Allen Webb wrote:
> On Mon, Dec 19, 2022 at 3:23 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Mon, Dec 19, 2022 at 02:46:18PM -0600, Allen Webb wrote:
> > > Update the documentation to include the presense and use case of
> > > modules.builtin.alias.
> > >
> > > Signed-off-by: Allen Webb <allenwebb@google.com>
> > > ---
> > >  Documentation/kbuild/kbuild.rst | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> > > index 08f575e6236c..1c7c02040a54 100644
> > > --- a/Documentation/kbuild/kbuild.rst
> > > +++ b/Documentation/kbuild/kbuild.rst
> > > @@ -17,6 +17,12 @@ modules.builtin
> > >  This file lists all modules that are built into the kernel. This is used
> > >  by modprobe to not fail when trying to load something builtin.
> > >
> > > +modules.builtin.alias
> > > +---------------------
> > > +This file lists all match-id based aliases for modules built into the kernel.
> > > +These are intended to enable userspace to make authorization decisions based
> > > +on which modules are likely to be bound to a device after it is authorized.
> >
> > What is an example? This sounds obscure.
> 
> Many of the devices that match the usb_storage driver only specify the
> vendor id, product id, and device id (VID:PID:D) and do not match
> against device class, interface class, etc. Here are some examples
> from modules.alias: A grep for wildcards in these fields yields 6136
> matches:
> grep 'dc\*dsc\*dp\*ic\*isc\*ip\*in\*'
> /lib/modules/5.19.11-1rodete1-amd64/modules.alias | wc -l
> 6136
> 
> To write USBGuard policy that only authorizes devices that bind to a
> particular module the policy needs to be aware of all these VID:PID:D
> which can change between kernel versions.
> 
> This is done at runtime rather than excluding modules from the build
> because some devices are not needed at or before login or when a
> device is locked. By not authorizing new devices that would bind to a
> set of modules, these modules become unreachable to an attacker who
> seeks to exploit kernel bugs in those modules.
> 
> I could add this detail to the documentation file, but I was trying to
> keep the description to about the same length as the others around it.

How about the second sentence you wrote say something like:

An example usage of the built-in aliases is to enable software such as
USBGuard to enable / disable specific devices outside of just the
vendor, product and device ID. This allows more flexible security policies
in userspace.

  Luis
