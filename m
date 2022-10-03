Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A705F32E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJCPvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJCPvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:51:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552D42A73C;
        Mon,  3 Oct 2022 08:51:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09BA0B81180;
        Mon,  3 Oct 2022 15:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F8AC433C1;
        Mon,  3 Oct 2022 15:51:01 +0000 (UTC)
Date:   Mon, 3 Oct 2022 11:51:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Slade Watkins <srw@sladewatkins.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Artem S. Tashkinov" <aros@gmx.com>, workflows@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <20221003115102.35bff30e@gandalf.local.home>
In-Reply-To: <YzsDbeF8WQHy9Hat@pendragon.ideasonboard.com>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
        <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
        <63a8403d-b937-f870-3a9e-f92232d5306c@leemhuis.info>
        <534EB870-3AAE-4986-95F3-0E9AD9FCE45B@sladewatkins.net>
        <e9dd6af0-37ef-1195-0d3b-95601d1ab902@leemhuis.info>
        <20221003112605.4d5ec4e9@gandalf.local.home>
        <YzsDbeF8WQHy9Hat@pendragon.ideasonboard.com>
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

On Mon, 3 Oct 2022 18:44:45 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> > The sad part is that most people that are going to report a bug is not
> > going to read a full document to figure out how to do it. Usually when
> > someone hits a bug, they are doing something else. And it's a burden to
> > report it. Obviously, they want it to be fixed, but it's viewed as a favor
> > to the developer and not the user to get it fixed, as it's likely seen as a
> > mistake by the developer that the bug exists in the first place.  
> 
> It really depends on how badly the bug affects the reporter. I'm sure
> that a bug that prevents GPU or audio from working alone on a shiny
> brand new laptop will see lots of pings. A side issue noticed by the
> user that wouldn't really affect them is more likely to end up in a
> blackhole. I recently faced issues with a display controller. I sent
> patches for the problems affecting my use case, and only notified the
> maintainer for the other issues. Those have been "added to their todo
> list (TM)". But is that really a problem ? If I'm not affected and
> neither is the maintainer, there's likely better use of their time, at
> least until a user who is really affected by the problem shows up.

I guess that's the main question. If we see hundreds of bugzilla reports
ignored, are they the one offs that nobody really cares about, or are they
the ones where it's preventing someone from using their new laptop properly?

Sometimes, even if it prevents a laptop from working properly, it could be
ignored if a workaround is in place. Like just buying an external webcam if
you can't get the internal one working.

-- Steve
