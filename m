Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302EF6837DD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjAaUsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjAaUs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:48:29 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05C55A815
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:47:22 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id w3so6111630qts.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNvDVbG7CFVraYi/TOfzOl0f+P6XVrld8Cgwy6F2tQc=;
        b=aT7z1cipAKQNdQuLqTIolehy8Wb7ovquQFARavyGxQuCN65ypefZSDXmcyQWWvPNmC
         +Rbf3MmNkzaJa7UkJKocqcjrgCJUS16TSF8um9lAeg/I4nSt1fbR6hpEqhhRJtlAlwsV
         rZeXQ+eY82bMQ1QqDW+H7udEhUjKgRWl6ODvxMd47aMix0K8qrpBKzKYQb4CQwyuhTCC
         9/oYGlOyb4oTw4q1yv3XxS2tw4iNzSKQI0ynwY92GfdgEdyq7i9enaOei62JwCOXOXjF
         g8ruWGKBWrigNJWc6ShTA0VeoaKFzCCyBtYrYzLTI3nWWpGjJL83PGcWADdf8XoATPPL
         dOkA==
X-Gm-Message-State: AO0yUKU5f0gJc++s89wB5LOuawUP2e9GL3gJ6/vV9JlP5WpjmByTpuRk
        A++92gr5ADQ3+usF6pRfBKAK
X-Google-Smtp-Source: AK7set+PDMu0N8Uwh8+1p7Os6/xZFQVW0hOeiq3lGbhmrIKFFcHBzzLNY8AXEKM3pGHUO+UzcSRu3Q==
X-Received: by 2002:ac8:5f89:0:b0:3b6:2fba:3d46 with SMTP id j9-20020ac85f89000000b003b62fba3d46mr125295qta.42.1675198041743;
        Tue, 31 Jan 2023 12:47:21 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id eb10-20020a05620a480a00b007112aa42c4fsm10494479qkb.135.2023.01.31.12.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 12:47:21 -0800 (PST)
Date:   Tue, 31 Jan 2023 15:47:20 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com
Subject: Re: [PATCH v2 00/21] blksnap - block devices snapshots module
Message-ID: <Y9l+WIDSrVhRhPME@redhat.com>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <Y8cNVv4O+vjL+aAy@redhat.com>
 <15ffd4bb-cb87-4bc9-53fc-4e0b941db0b7@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15ffd4bb-cb87-4bc9-53fc-4e0b941db0b7@veeam.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24 2023 at  6:34P -0500,
Sergei Shtepa <sergei.shtepa@veeam.com> wrote:

> DearMike
> 
> I am very glad that you noticed my patch version 2.
> I'm sure your experience will help.
> 
> On 1/17/23 22:04, Mike Snitzer wrote:
> > Subject:
> > Re: [PATCH v2 00/21] blksnap - block devices snapshots module
> > From:
> > Mike Snitzer <snitzer@redhat.com>
> > Date:
> > 1/17/23, 22:04
> > 
> > To:
> > Sergei Shtepa <sergei.shtepa@veeam.com>
> > CC:
> > "axboe@kernel.dk" <axboe@kernel.dk>, "corbet@lwn.net" <corbet@lwn.net>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
> > 
> > 
> > On Fri, Dec 09 2022 at 9:23P -0500,
> > Sergei Shtepa wrote:
> > 
> >  > Hi Jens. Hi Jonathan. Hi all.
> >  >
> >  > I am happy to offer a modified version of the Block Devices Snapshots
> >  > Module. It allows to create non-persistent snapshots of any block devices.
> >  > The main purpose of such snapshots is to provide backups of block devices.
> >  > See more in Documentation/block/blksnap.rst.
> >  >
> >  > The Block Device Filtering Mechanism is added to the block layer. This
> >  > allows to attach and detach block device filters to the block layer.
> >  > Filters allow to extend the functionality of the block layer.
> >  > See more in Documentation/block/blkfilter.rst.
> >  >
> >  > A tool, a library for working with blksnap and tests can be found at
> >  > https://github.com/veeam/blksnap.
> >  >
> >  > The first version was suggested at 13 June 2022. Many thanks to
> >  > Christoph Hellwig and Randy Dunlap for the review of that version.
> >  >
> >  > Changes:
> >  > - Forgotten "static" declarations have been added.
> >  > - The text of the comments has been corrected.
> >  > - It is possible to connect only one filter, since there are no others in
> >  > upstream.
> >  > - Do not have additional locks for attach/detach filter.
> >  > - blksnap.h moved to include/uapi/.
> >  > - #pragma once and commented code removed.
> >  > - uuid_t removed from user API.
> >  > - Removed default values for module parameters from the configuration file.
> >  > - The debugging code for tracking memory leaks has been removed.
> >  > - Simplified Makefile.
> >  > - Optimized work with large memory buffers, CBT tables are now in virtual
> >  > memory.
> >  > - The allocation code of minor numbers has been optimized.
> >  > - The implementation of the snapshot image block device has been
> >  > simplified, now it is a bio-based block device.
> >  > - Removed initialization of global variables with null values.
> >  > - Only one bio is used to copy one chunk.
> >  > - Checked on ppc64le.
> >  >
> >  > The v1 version was suggested at 2 November 2022. Many thanks to Fabio
> >  > Fantoni for his for his participation in the "blksnap" project on github
> >  > and Jonathan Corbet for his article https://lwn.net/Articles/914031/.
> >  > Thanks to the impartial kernel test robot.
> >  >
> >  > Changes:
> >  > - Added documentation for Block Device Filtering Mechanism.
> >  > - Added documentation for Block Devices Snapshots Module (blksnap).
> >  > - The MAINTAINERS file has been updated.
> >  > - Optimized queue code for snapshot images.
> >  > - Fixed comments, log messages and code for better readability.
> > 
> > [this reply got long...]
> > 
> > I think it is important to revisit how we've gotten to this point.
> > The catalyst for blkfilter and now blksnap was that I removed the
> > export for blk_mq_submit_bio -- which veeam was using for enablement
> > of their commercial backup software product, the offending commit was
> > 681cc5e8667e ("dm: fix request-based DM to not bounce through indirect 
> > dm_submit_bio")
> > 
> > The way veeam started to address this change was to request Red Hat
> > modify RHEL (by reverting my change in RHEL8, whereby restoring the
> > export) to give them a stopgap while they worked to identify a more
> > lasting solution to them having depended on such a fragile interface
> > with which to hijack IO for all Linux block devices.
> > 
> 
> Thank you so much for your help with the function blk_mq_submit_bio().
> This fix helped the veeamsnap module to continue working on RHEL 8
> with a minimal set of crutches. But besides RHEL 8, there are other
> distributions that required support.
> 
> The catalyst was the optimization of Christoph and the removal of
> the make_request_fn() callback function in v5.9. See:
> https://elixir.bootlin.com/linux/v5.8.18/source/include/linux/blkdev.h#L406
> Overriding this function allowed handling I/O units.
> 
> > They then came up with blk-interposer. I tried to be helpful and
> > replied quite regularly to blk-interposer patchsets, e.g.:
> > https://listman.redhat.com/archives/dm-devel/2021-March/045900.html
> > https://listman.redhat.com/archives/dm-devel/2021-March/045838.html
> > (I won't dig out more pointers, but can if you doubt this assertion).
> > The last reply I got on this topic was very dense and so I
> > tabled it with the idea of revisiting it. But I dropped the ball and
> > never did reply to this:
> > https://listman.redhat.com/archives/dm-devel/2021-April/046184.html
> > 
> > Sorry. But that wasn't out of malice. I was just busy with other
> > things and blk-interposer took the back seat. I never imagined that my
> > inaction would foster completely abandoning the approach.
> > 
> 
> And yes, I’ve spent several months trying to refine the DM in order to
> implement the feature of attaching DM devices on the fly, that you said you
> would like to have in DM. Alas, I have not achieved success. I figured that
> it would take a lot of changes in the DM code before its non-persistent
> snapshots can be used for backup, and some architectural changes will be
> required. Although you have been very helpful for a while, at some point
> you stopped providing any feedback and thus I started to explore other
> possibilities to solve the problem.
> 
> Seeing your annoyance now, I wonder what would be the better way to continue
> my work in the given circumstances? What kind of action would you expect from
> me in such situation? Being left without any feedback and guidance on DM,
> I decided to work directly with the community to find better solution.
> 
> That is, I took another route (blksnap) not because I thought the initial 
> DM-based approach proposed by you was inferior or bad, but because only this
> direction remained available to me.

I'm late to respond to your email again because Red Hat now imposes
gmail and its mail filtering is abysmal. I should just use
snitzer@kernel.org since it is able to ensure I am aware of
replies.. anyway, that's my problem to sort out! ;)

You're fine to approach the implementation however you and others
think best.  I have a couple core points I'll raise in the block core
patch.

But yes, I was hoping we could effectively make it so that any block
device could be augmented to remap bios (either in terms of existing
DM targets or a more minimalist approach that meets your snapshot
needs).

Feels somewhat like failure to not be able to make that advancement,
but nothing is "done" yet... let's see what we can do.

> > But my thanks is I'm now made to defend myself on LWN:
> > https://lwn.net/Articles/920245/
> > https://lwn.net/Articles/920249/
> > 
> > I happened to trip over that LWN thread because I saw Hannes reference
> > "blksnap" as something that somehow is a tolerated advance but other
> > efforts are not:
> > https://lore.kernel.org/linux-block/06e4d03c-3ecf-7e91-b80e-6600b3618b98@suse.de/
> > 
> > blksnap really needs to stand on its own merits and it could be that
> > in conjunction with blkfilter it does. But the way it has evolved has
> > been antithetical to how to properly engage the Linux community and
> > subsystem mainatiners like myself. The PR campaign to raise awareness
> > with LWN became more important than cc'ing me. That says it all
> > really.
> > 
> 
> As for the article on LWN:
> 
> I am very grateful to Jonathan for his article. It attract some attention
> to my work. However, it’s wasn’t a deliberate PR company from Veeam.
> In fact, Veeam has nothing to do with the article.
> 
> Yes, I work for the company, but the company has neither requested the
> article, nor has started any other PR regarding the matter.
> 
> If I were organizing a PR campaign, the article would be similar to this:
> https://github.com/veeam/blksnap/blob/master/doc/Something-wrong-with-snapshots-for-Linux.md
> But be careful! In the article I try to change the reader's opinion about
> snapshots. Feedback, as usual, is welcome.

We can just move past all that. No lasting issue. I took the comments
about DM in that lwn article too personal.

> > But hopefully you can take my words as my truth: I think what you're
> > wanting to do is useful. I never intended to act as some gatekeeper. I
> > don't have a problem with what your goals are, I just ask that _how_
> > you achieve your goals be done with care and consideration (the
> > attempts I reviewed prior to your most recent work were lacking).
> > 
> 
> Mike, I assure you, I have one goal. Snapshots of block devices in the
> Linux kernel for backup.
>
> I think we got off to a good start initially, but then something went wrong 
> (miscommunications, misunderstanding, and a lack of time) so here we are.
> If you could clarify what could have been the proper way of dealing with
> that situation from my side, I would really appreciate that.

I will have to look closer at how you're able to ensure consistency
between upper layer (FS) and the block layer.  The fsfreeze hooks were
added long ago with FS-to-block consistency (ensuring IO flushed and
halted, etc).
 
> > But my one and only request for this line of development would be: I
> > _really_ want DM code to be able to used as an endpoint for IO
> > remapping associated with any new block core hook added to accomplish
> > dynamic remapping of IO. If I need to take an active role in the
> > development of that capability, so be it.
> > 
> 
> I am sure that this is quite achievable. If the dm-dev team has special
> needs when attaching DM devices via blkfilter, we will be able to upgrade it.
> At the moment I don't see any problems with this.
> I can promise you to add you to СС when sending next patches.
> 
> Sounds good?

Sure.

> > I've yet to look closely at all this code (but wow there is quite a
> > lot under drivers/block/blksnap). I'll have a look at the block-core
> > changes and then try to make sense of things from there.
> >
> 
> Yes, that's right. There are quite a few changes in block-core.
> From the blksnap, it is enough to view tracker.c. I/O handling is
> implemented there.
> But it's probably better to wait for the next version of patch that takes
> into account Christoph's comments. There are a lot of changes, and first
> of all in the interface.

OK, I'll still reply to the block core patch now-ish.

> > But you've already bypassed me, my hope is that Jens and Christoph
> > agree that we need this line of development to be in service to other
> > areas of the Linux block subsystem and its drivers that were
> > established for the purposes of remapping IO. It cannot just be
> > the subset needed to cement veeam's ability to use Linux for its
> > purposes (but I completely understand that is the point of veeam's
> > exercise).
> 
> It’s not about Veeam at all. I am sure that my work will help many backup 
> vendors and average users to build more robust and efficient backup tools.
> So, the argument that I do it just because Veeam needs it does not hold
> any water – I know that many people need the feature, not just Veeam.

No other snapshot consumers have shown themselves. Using them as some
sort of implied consensus on what is needed for generic Linux snapshot
is a bit of a leap. All you really have are your requirements. Doesn't
really help to say you represent the interests of all interested
parties if they remain nameless and in the background.

Mike
