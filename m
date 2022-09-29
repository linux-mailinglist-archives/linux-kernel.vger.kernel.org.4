Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B025EF5B9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiI2MwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiI2MwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:52:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EA01616E3;
        Thu, 29 Sep 2022 05:52:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2F54B82454;
        Thu, 29 Sep 2022 12:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457CFC433D7;
        Thu, 29 Sep 2022 12:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664455938;
        bh=3KXnx140+ebopzLRmDbNTOZQnfZyF3doal4gX+uG4oM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yv9p6QBxDvM+CZttMUth9pzgGkFJL/JBlulx/GS/E8DkdMvay1l4zSL2ld9lVkXlJ
         yg0Z0kfft896qQoQKvjan3krO/40utFU7JcnrMXome48UwaOIsJtmYXGtasJwngUzT
         AxcWSUJDI7oHja/Z0hY4f+zDkl3KkwTNA9F/H1Zg=
Date:   Thu, 29 Sep 2022 14:52:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <YzWVJpqNq4UeeaoH@kroah.com>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:22:35PM +0000, Artem S. Tashkinov wrote:
> Let me be brutally honest here, if you're working on the kernel,
> specially for a large company such as e.g. Intel, you're _expected_ to
> address the issues which are related to the kernel component[s] you're
> maintaining/developing otherwise it's not "development" it's "I'm
> dumping my code because my employer pays me to do that". That also means
> you're expected to address bug reports.

I wish that were the case, unfortunately it is quite rare that
maintainers of subsystems of the kernel are allowed to work on upstream
issues like this all the time.  Heck, part of the time would be
wonderful too, but that is also quite rare.  So while maintainers would
love to be able to work like this, getting their management to agree to
this is not very common, sadly.

> AFAIK, the kernel bugzilla is a Linux Foundation project and the
> organization receives funding from its very rich members including
> Google, Meta, Intel, and even Microsoft. The fact that no one is
> seriously working on it looks shameful and sad. We are not talking about
> a minor odd library with a dozen users we are talking about the kernel.

bugzilla.kernel.org is _hosted_ by the LF, and does a great job of
keeping it running and alive.  The LF has nothing to do with the content
of the bugs in it, the reporting, the response of people to reported
bugs, assigning bugs to anyone, getting them fixed, or anything else
related to the content in the database at all.  Please don't get
confused with the resources provided to host the system vs. the people
who actually do the kernel development itself.

Note, the LF does sponsor a few kernel developers to do work on the
kernel, including myself, but we are a tiny drop in the bucket compared
to the 4000+ developers who contribute to the kernel every year.

thanks,

greg k-h
