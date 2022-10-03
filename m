Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914025F330F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJCQD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJCQDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:03:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4204333840;
        Mon,  3 Oct 2022 09:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D421661130;
        Mon,  3 Oct 2022 16:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2CDC433D6;
        Mon,  3 Oct 2022 16:03:52 +0000 (UTC)
Date:   Mon, 3 Oct 2022 12:03:52 -0400
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
Message-ID: <20221003120352.06de4a83@gandalf.local.home>
In-Reply-To: <YzsG2uC70WfawKTs@pendragon.ideasonboard.com>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
        <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
        <63a8403d-b937-f870-3a9e-f92232d5306c@leemhuis.info>
        <534EB870-3AAE-4986-95F3-0E9AD9FCE45B@sladewatkins.net>
        <e9dd6af0-37ef-1195-0d3b-95601d1ab902@leemhuis.info>
        <20221003112605.4d5ec4e9@gandalf.local.home>
        <YzsDbeF8WQHy9Hat@pendragon.ideasonboard.com>
        <20221003115102.35bff30e@gandalf.local.home>
        <YzsG2uC70WfawKTs@pendragon.ideasonboard.com>
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

On Mon, 3 Oct 2022 18:59:22 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> > Sometimes, even if it prevents a laptop from working properly, it could be
> > ignored if a workaround is in place. Like just buying an external webcam if
> > you can't get the internal one working.  
> 
> That's an interesting example. https://lwn.net/Articles/904776/ shows
> how it made lots of users *very* unhappy.

I figured you would appreciate that example ;-)

-- Steve
