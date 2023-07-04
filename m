Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3C8747A29
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 00:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGDW2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 18:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDW2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 18:28:12 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86EA410DA;
        Tue,  4 Jul 2023 15:28:11 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 364MRwdf022321;
        Wed, 5 Jul 2023 00:27:58 +0200
Date:   Wed, 5 Jul 2023 00:27:58 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Overly aggressive .gitignore file?
Message-ID: <20230704222758.GB22271@1wt.eu>
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
 <20230704211509.GA21834@1wt.eu>
 <CAHk-=wjH4O6v_EwVB=t_6Haky2jOiejHbCkCTvgNQWo1ghy8-w@mail.gmail.com>
 <20230704213415.GA21872@1wt.eu>
 <CAHk-=wjPEjrB7eCukREhWu-0qfjbFD-K8sk1TYYRgeHzYr1tuQ@mail.gmail.com>
 <20230704215600.GA22271@1wt.eu>
 <CAHk-=whMytacPBHfKKi8GYdgfadNy5LA-1TDHrTtz22eJr2B1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whMytacPBHfKKi8GYdgfadNy5LA-1TDHrTtz22eJr2B1Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 03:14:11PM -0700, Linus Torvalds wrote:
> But what do you think "git status" is supposed to do?
> 
> Here's a theory - it's supposed to tell me about the status of my git tree.

I agree with this and use it for the same purpose.

> Maybe it's supposed to tell me about extra files that maybe I should
> be aware of. Maybe I should delete them. Maybe I should commit them.
> Who knows?

Sure but apparently the point of that commit was precisely to avoid
*risking* to commit them for other users, or maybe just not seeing
too many of them when running git status to make sure the rest that
they consider more important is actually committed.

> And  *if* we pretend for a moment that this is what "git status" is
> supposed to do, then maybe it should have reminded me about stale
> random files in that directory that ACTIVELY BREAK MY WORKFLOW.

I agree with this.

> Maybe that isn't your workflow.
> 
> Maybe you're perfectly fine not getting a unique auto-complete,
> because you *want* your git directory filled with irrelevant crap.

It's not a matter of being fine or not fine, it's the way your question
was posed. I'm sorry, but I'm seeing so many times completion do nothing
on some distros when passing certain args to various everyday commands
(to the point that I learned to type "complete -r" to kill stupid rules),
that *my* understanding of "doesn't autocomplete" means exactly that. If
you say "it proposes me the whole list of old turds" I perfectly
understand how annoying that can be, exactly like when I leave plenty of
git-format-patch files and I want to git-am another one and can't spot
it. It's just that *for me* it's not the problem that was presented,
hence my suggestions about completion rules being faulty.

I understand that you might be angry due to a commit that broke your
workflow and that pisses you off, and that maybe your initial message
was written in a hurry to flush your anger, but please also accept
that not everyone possibly understood it the way you hoped it would
be, because it *was* ambiguous.

Anyway, you fixed it so now the problem is solved.

Willy
