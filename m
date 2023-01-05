Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BB265EFC2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjAEPPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAEPP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:15:27 -0500
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF8A4FCE2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:15:24 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 969D2652; Thu,  5 Jan 2023 09:15:22 -0600 (CST)
Date:   Thu, 5 Jan 2023 09:15:22 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v3] fuse: In fuse_flush only wait if someone wants the
 return code
Message-ID: <20230105151522.GA4600@mail.hallyn.com>
References: <CAJfpegvrd2nsydG26stcmeEkdO1JLyeu69KrZs4dvVxXtoz42Q@mail.gmail.com>
 <20221114160209.1229849-1-tycho@tycho.pizza>
 <Y4TNI8+QVHFuzeZC@tycho.pizza>
 <CAJfpegtckCReg7V6ET4a8EW_X-WfmANQdc4hP26bV9zoRrk7Wg@mail.gmail.com>
 <Y5IjpyLHIF8PgQ6l@tycho.pizza>
 <Y6C4ni3wpkaYxmLw@tycho.pizza>
 <Y7RA6pzP82mNWxOQ@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7RA6pzP82mNWxOQ@tycho.pizza>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 07:51:22AM -0700, Tycho Andersen wrote:
> On Mon, Dec 19, 2022 at 12:16:50PM -0700, Tycho Andersen wrote:
> > On Thu, Dec 08, 2022 at 10:49:30AM -0700, Tycho Andersen wrote:
> > > On Thu, Dec 08, 2022 at 03:26:19PM +0100, Miklos Szeredi wrote:
> > > > On Mon, 28 Nov 2022 at 16:01, Tycho Andersen <tycho@tycho.pizza> wrote:
> > > > >
> > > > > Hi Milkos,
> > > > >
> > > > > On Mon, Nov 14, 2022 at 09:02:09AM -0700, Tycho Andersen wrote:
> > > > > > v3: use schedule_work() to avoid other sleeps in inode_write_now() and
> > > > > >     fuse_sync_writes(). Fix a UAF of the stack-based inarg.
> > > > >
> > > > > Thoughts on this version?
> > > > 
> > > > Skipping attr invalidation on success is wrong.
> > > 
> > > Agreed, that looks like my mistake.
> > > 
> > > > How about the attached (untested) patch?
> > > 
> > > It passes my reproducer with no warnings or anything. Feel free to
> > > add:
> > > 
> > > Tested-by: Tycho Andersen <tycho@tycho.pizza>
> > > 
> > > if you want to commit it.
> > 
> > Ping, thoughts on landing this?
> 
> Happy new year all. Any update here?
> 
> Thanks,
> 
> Tycho

Thanks for pushing on this, Tycho.  I'd suggest sending a clean new version
incorporating Miklos' fix.

-serge
