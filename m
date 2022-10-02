Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B96B5F2732
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 01:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJBXWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 19:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJBXWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 19:22:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAB624BD6;
        Sun,  2 Oct 2022 16:22:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 751EAB80D2D;
        Sun,  2 Oct 2022 23:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DCDC433C1;
        Sun,  2 Oct 2022 23:21:55 +0000 (UTC)
Date:   Sun, 2 Oct 2022 19:21:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>, Theodore Ts'o <tytso@mit.edu>,
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
Message-ID: <20221002192146.03993bb2@yoga.local.home>
In-Reply-To: <YzoY+dxLuCfOp0sL@ZenIV>
References: <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
        <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
        <Yzg7pHspc72I7TAb@mit.edu>
        <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
        <YzmBjgXq9geMnL1B@mit.edu>
        <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
        <20221002141321.394de676@rorschach.local.home>
        <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
        <20221002180844.2e91b1f1@rorschach.local.home>
        <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
        <YzoY+dxLuCfOp0sL@ZenIV>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon, 3 Oct 2022 00:04:25 +0100
Al Viro <viro@zeniv.linux.org.uk> wrote:

> And you keep moving along the same track - the usual reaction of some
> company after having pulled back a bloody stump and enjoyed the pile of
> explanations of the reasons why opt-out is *NOT* *ACCEPTABLE*, *EVER*
> is along the lines of "OK, we'll just spam everyone in our database once
> and ask them to opt-in - that must be OK, right?"

But a single spam that can be ignored is so much better than being
automatically added to something that you have to do work to get out of.

We get spammed a lot to participate in surveys and such. But for those one time
emails, they never bothered me. Sometimes, I actually do participate.

-- Steve
