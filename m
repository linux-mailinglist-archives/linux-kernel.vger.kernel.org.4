Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F095EF8A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiI2P0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiI2P0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:26:12 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DF0367BA;
        Thu, 29 Sep 2022 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1664465170;
        bh=oOgcX0s8xJS2rgnvpBHiYekzzFcyDIbHRcoPvSVK0Zw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=WaElFH607ESo42Y7tCgfGymk0uHSGARUyOP2qqvssVYYzTyVUnXxV+8pFgsZ1WhPx
         nl+VYXSkeTsPxWurMP8G7vIWEfYF295ehJV2Bxk9LNsMZZJDE9uaGHlBkbvwaP8Nh3
         enhze5aDzMDxxGq1M54hxb8W5hhop6GjGZTw6hog=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4376A12886E3;
        Thu, 29 Sep 2022 11:26:10 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X6BZT3-rZbUO; Thu, 29 Sep 2022 11:26:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1664465169;
        bh=oOgcX0s8xJS2rgnvpBHiYekzzFcyDIbHRcoPvSVK0Zw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=nHoTdAGWmcK1SDyXqr5/KC4re+Ex4xtUZi91ddeIPbRLGQfyV4A51a33QAbkbpQMt
         b1w8rJn/ydplI93mCAjHxQozhk127bK8iIJM4/01s/tA7PbeXta6wjICJ7gNltoh5T
         O4wKrOvZ1y9gvCeDXg+P25oPYBmCRikCfNhy8a6w=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0DDBB12886E2;
        Thu, 29 Sep 2022 11:26:08 -0400 (EDT)
Message-ID: <238f5350125e618c323f42e3885b5ff887241ae0.camel@HansenPartnership.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Artem S. Tashkinov" <aros@gmx.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
Date:   Thu, 29 Sep 2022 11:26:07 -0400
In-Reply-To: <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
         <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
         <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-29 at 12:22 +0000, Artem S. Tashkinov wrote:
> Let me be brutally honest here, if you're working on the kernel,
> specially for a large company such as e.g. Intel, you're _expected_
> to address the issues which are related to the kernel component[s]
> you're maintaining/developing otherwise it's not "development" it's
> "I'm dumping my code because my employer pays me to do that". That
> also means you're expected to address bug reports.
> 
> It's correct I've tried to help people with bug reports posted on
> bugzilla.kernel.org but it's a tough task considering that absolute
> most kernel developers are not signed up, thus most bug reports are
> never seen by respective developers.

The never seen/never responded to metric is rather bogus.  The sad fact
is that a lot of bug reports aren't actionable, meaning the reporter
can't give a reproducer and also can't easily test patches  sometimes
by luck the maintainers can work out what the issue is but a lot of the
time they have no idea.  Then there are ton's of bug reports with
responses like "I think xxx commit fixes your problem, can you test it"
for which the conversation dies there.  There's also the thundering
herd problem: some bugs get reported by many different people (as
different bug reports) but usually the subsystem only engages with one
to fix the issue.  In theory bugzilla can mark the latter as dups, but
that requires someone to spend an enormous amount of time on evaluation
and admin.

That's not to say we can't improve our process, it's just to set
expectations that we're never going to approach anywhere near a perfect
bug process.  Most of the improvements that worked so far involve
having someone coach bug reporters through the process of either
testing patches or reproducing the problem in a more generic
environment ... which I think most people would agree can't really fall
wholly on maintainers.

Regards,

James


