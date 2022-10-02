Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28CA5F25F7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 00:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJBW26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 18:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJBW24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 18:28:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6863F3868F;
        Sun,  2 Oct 2022 15:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9959B80C03;
        Sun,  2 Oct 2022 22:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C97C433D6;
        Sun,  2 Oct 2022 22:28:51 +0000 (UTC)
Date:   Sun, 2 Oct 2022 18:28:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <20221002182850.38deeb02@rorschach.local.home>
In-Reply-To: <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
        <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
        <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com>
        <YzgY9X/DM9t/ZuJe@kroah.com>
        <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
        <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
        <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
        <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
        <Yzg7pHspc72I7TAb@mit.edu>
        <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
        <YzmBjgXq9geMnL1B@mit.edu>
        <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
        <20221002141321.394de676@rorschach.local.home>
        <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
        <20221002180844.2e91b1f1@rorschach.local.home>
        <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2022 22:20:40 +0000
"Artem S. Tashkinov" <aros@gmx.com> wrote:

> Opt-in will work, except I've no idea how to make it work. Mass email
> all the kernel developers and politely invite them to sign up? Most will
> simply ignore it.

Why not? The people who will ignore it will be the same people you are
asking to go and unsubscribe. But at least with just a single email
invite all they need to do to not be set up is to ignore a single
email. For those that want to be involved, they will make the effort to
do so.

> 
> It's been mentioned here several times already that even collecting
> their public email addresses in public git logs could be considered illegal.

I would do it with the MAINTAINERS file if you were to do that. The
purpose of the MAINTAINERS file is to send email to those listed.

-- Steve
