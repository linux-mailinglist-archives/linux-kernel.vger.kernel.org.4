Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68CB6796F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjAXLo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbjAXLoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:44:54 -0500
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Jan 2023 03:44:40 PST
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1A13FF0E;
        Tue, 24 Jan 2023 03:44:40 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id ADBE840959;
        Tue, 24 Jan 2023 06:34:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1674560092;
        bh=jA2l3cFKmlF7rxnk2lzG/Ltsz1rHVfCSvsUajt501c8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=AC8ZIxd+Q3fSY+zjgCO5UYIJG96cc1Ul1e//ZmOfE7NX2WnR8ilEjIJvp1G6mYCg0
         JkvmJkyv5pjVtMTRIMQhw75v9IyRBwi6ln3XErn9CZ2SWChBEhIH4I+G3QhxnqVJHg
         /bhqeqsf1ApHLddv78nDH2fA4n6qeiNQyQocfw1iPrUjHY5vp3vMZDFYvCsfMdhAUG
         H1Qjaujd2wZ6C5fo6/Vel2rHGrZz7gHnIb9l5nKfzGM164qZBT48XE6xYWrT42ixwa
         OteWsYxwjDwH4YZjmjL2kCZ13YaRg2lL3SiZuxIrU5eyfk/6Xr4r9Dvnd6kv4SB7aB
         /kOLXmQUvBoxg==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Tue, 24 Jan
 2023 12:34:49 +0100
Message-ID: <15ffd4bb-cb87-4bc9-53fc-4e0b941db0b7@veeam.com>
Date:   Tue, 24 Jan 2023 12:34:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 00/21] blksnap - block devices snapshots module
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <Y8cNVv4O+vjL+aAy@redhat.com>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <Y8cNVv4O+vjL+aAy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031555677D6B
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DearMike

I am very glad that you noticed my patch version 2.
I'm sure your experience will help.

On 1/17/23 22:04, Mike Snitzer wrote:
> Subject:
> Re: [PATCH v2 00/21] blksnap - block devices snapshots module
> From:
> Mike Snitzer <snitzer@redhat.com>
> Date:
> 1/17/23, 22:04
> 
> To:
> Sergei Shtepa <sergei.shtepa@veeam.com>
> CC:
> "axboe@kernel.dk" <axboe@kernel.dk>, "corbet@lwn.net" <corbet@lwn.net>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
> 
> 
> On Fri, Dec 09 2022 at 9:23P -0500,
> Sergei Shtepa wrote:
> 
>  > Hi Jens. Hi Jonathan. Hi all.
>  >
>  > I am happy to offer a modified version of the Block Devices Snapshots
>  > Module. It allows to create non-persistent snapshots of any block devices.
>  > The main purpose of such snapshots is to provide backups of block devices.
>  > See more in Documentation/block/blksnap.rst.
>  >
>  > The Block Device Filtering Mechanism is added to the block layer. This
>  > allows to attach and detach block device filters to the block layer.
>  > Filters allow to extend the functionality of the block layer.
>  > See more in Documentation/block/blkfilter.rst.
>  >
>  > A tool, a library for working with blksnap and tests can be found at
>  > https://github.com/veeam/blksnap.
>  >
>  > The first version was suggested at 13 June 2022. Many thanks to
>  > Christoph Hellwig and Randy Dunlap for the review of that version.
>  >
>  > Changes:
>  > - Forgotten "static" declarations have been added.
>  > - The text of the comments has been corrected.
>  > - It is possible to connect only one filter, since there are no others in
>  > upstream.
>  > - Do not have additional locks for attach/detach filter.
>  > - blksnap.h moved to include/uapi/.
>  > - #pragma once and commented code removed.
>  > - uuid_t removed from user API.
>  > - Removed default values for module parameters from the configuration file.
>  > - The debugging code for tracking memory leaks has been removed.
>  > - Simplified Makefile.
>  > - Optimized work with large memory buffers, CBT tables are now in virtual
>  > memory.
>  > - The allocation code of minor numbers has been optimized.
>  > - The implementation of the snapshot image block device has been
>  > simplified, now it is a bio-based block device.
>  > - Removed initialization of global variables with null values.
>  > - Only one bio is used to copy one chunk.
>  > - Checked on ppc64le.
>  >
>  > The v1 version was suggested at 2 November 2022. Many thanks to Fabio
>  > Fantoni for his for his participation in the "blksnap" project on github
>  > and Jonathan Corbet for his article https://lwn.net/Articles/914031/.
>  > Thanks to the impartial kernel test robot.
>  >
>  > Changes:
>  > - Added documentation for Block Device Filtering Mechanism.
>  > - Added documentation for Block Devices Snapshots Module (blksnap).
>  > - The MAINTAINERS file has been updated.
>  > - Optimized queue code for snapshot images.
>  > - Fixed comments, log messages and code for better readability.
> 
> [this reply got long...]
> 
> I think it is important to revisit how we've gotten to this point.
> The catalyst for blkfilter and now blksnap was that I removed the
> export for blk_mq_submit_bio -- which veeam was using for enablement
> of their commercial backup software product, the offending commit was
> 681cc5e8667e ("dm: fix request-based DM to not bounce through indirect 
> dm_submit_bio")
> 
> The way veeam started to address this change was to request Red Hat
> modify RHEL (by reverting my change in RHEL8, whereby restoring the
> export) to give them a stopgap while they worked to identify a more
> lasting solution to them having depended on such a fragile interface
> with which to hijack IO for all Linux block devices.
> 

Thank you so much for your help with the function blk_mq_submit_bio().
This fix helped the veeamsnap module to continue working on RHEL 8
with a minimal set of crutches. But besides RHEL 8, there are other
distributions that required support.

The catalyst was the optimization of Christoph and the removal of
the make_request_fn() callback function in v5.9. See:
https://elixir.bootlin.com/linux/v5.8.18/source/include/linux/blkdev.h#L406
Overriding this function allowed handling I/O units.

> They then came up with blk-interposer. I tried to be helpful and
> replied quite regularly to blk-interposer patchsets, e.g.:
> https://listman.redhat.com/archives/dm-devel/2021-March/045900.html
> https://listman.redhat.com/archives/dm-devel/2021-March/045838.html
> (I won't dig out more pointers, but can if you doubt this assertion).
> The last reply I got on this topic was very dense and so I
> tabled it with the idea of revisiting it. But I dropped the ball and
> never did reply to this:
> https://listman.redhat.com/archives/dm-devel/2021-April/046184.html
> 
> Sorry. But that wasn't out of malice. I was just busy with other
> things and blk-interposer took the back seat. I never imagined that my
> inaction would foster completely abandoning the approach.
> 

And yes, I’ve spent several months trying to refine the DM in order to
implement the feature of attaching DM devices on the fly, that you said you
would like to have in DM. Alas, I have not achieved success. I figured that
it would take a lot of changes in the DM code before its non-persistent
snapshots can be used for backup, and some architectural changes will be
required. Although you have been very helpful for a while, at some point
you stopped providing any feedback and thus I started to explore other
possibilities to solve the problem.

Seeing your annoyance now, I wonder what would be the better way to continue
my work in the given circumstances? What kind of action would you expect from
me in such situation? Being left without any feedback and guidance on DM,
I decided to work directly with the community to find better solution.

That is, I took another route (blksnap) not because I thought the initial 
DM-based approach proposed by you was inferior or bad, but because only this
direction remained available to me.

> But my thanks is I'm now made to defend myself on LWN:
> https://lwn.net/Articles/920245/
> https://lwn.net/Articles/920249/
> 
> I happened to trip over that LWN thread because I saw Hannes reference
> "blksnap" as something that somehow is a tolerated advance but other
> efforts are not:
> https://lore.kernel.org/linux-block/06e4d03c-3ecf-7e91-b80e-6600b3618b98@suse.de/
> 
> blksnap really needs to stand on its own merits and it could be that
> in conjunction with blkfilter it does. But the way it has evolved has
> been antithetical to how to properly engage the Linux community and
> subsystem mainatiners like myself. The PR campaign to raise awareness
> with LWN became more important than cc'ing me. That says it all
> really.
> 

As for the article on LWN:

I am very grateful to Jonathan for his article. It attract some attention
to my work. However, it’s wasn’t a deliberate PR company from Veeam.
In fact, Veeam has nothing to do with the article.

Yes, I work for the company, but the company has neither requested the
article, nor has started any other PR regarding the matter.

If I were organizing a PR campaign, the article would be similar to this:
https://github.com/veeam/blksnap/blob/master/doc/Something-wrong-with-snapshots-for-Linux.md
But be careful! In the article I try to change the reader's opinion about
snapshots. Feedback, as usual, is welcome.

> But hopefully you can take my words as my truth: I think what you're
> wanting to do is useful. I never intended to act as some gatekeeper. I
> don't have a problem with what your goals are, I just ask that _how_
> you achieve your goals be done with care and consideration (the
> attempts I reviewed prior to your most recent work were lacking).
> 

Mike, I assure you, I have one goal. Snapshots of block devices in the
Linux kernel for backup.

I think we got off to a good start initially, but then something went wrong 
(miscommunications, misunderstanding, and a lack of time) so here we are.
If you could clarify what could have been the proper way of dealing with
that situation from my side, I would really appreciate that.

> But my one and only request for this line of development would be: I
> _really_ want DM code to be able to used as an endpoint for IO
> remapping associated with any new block core hook added to accomplish
> dynamic remapping of IO. If I need to take an active role in the
> development of that capability, so be it.
> 

I am sure that this is quite achievable. If the dm-dev team has special
needs when attaching DM devices via blkfilter, we will be able to upgrade it.
At the moment I don't see any problems with this.
I can promise you to add you to СС when sending next patches.

Sounds good?

> I've yet to look closely at all this code (but wow there is quite a
> lot under drivers/block/blksnap). I'll have a look at the block-core
> changes and then try to make sense of things from there.
>

Yes, that's right. There are quite a few changes in block-core.
From the blksnap, it is enough to view tracker.c. I/O handling is
implemented there.
But it's probably better to wait for the next version of patch that takes
into account Christoph's comments. There are a lot of changes, and first
of all in the interface.

> But you've already bypassed me, my hope is that Jens and Christoph
> agree that we need this line of development to be in service to other
> areas of the Linux block subsystem and its drivers that were
> established for the purposes of remapping IO. It cannot just be
> the subset needed to cement veeam's ability to use Linux for its
> purposes (but I completely understand that is the point of veeam's
> exercise).
> 
> Mike

It’s not about Veeam at all. I am sure that my work will help many backup 
vendors and average users to build more robust and efficient backup tools.
So, the argument that I do it just because Veeam needs it does not hold
any water – I know that many people need the feature, not just Veeam.

> 
> 
> 
>  >
>  > Sergei Shtepa (21):
>  > documentation, blkfilter: Block Device Filtering Mechanism
>  > block, blkfilter: Block Device Filtering Mechanism
>  > documentation, capability: fix Generic Block Device Capability
>  > documentation, blksnap: Block Devices Snapshots Module
>  > block, blksnap: header file of the module interface
>  > block, blksnap: module management interface functions
>  > block, blksnap: init() and exit() functions
>  > block, blksnap: interaction with sysfs
>  > block, blksnap: attaching and detaching the filter and handling I/O
>  > units
>  > block, blksnap: map of change block tracking
>  > block, blksnap: minimum data storage unit of the original block device
>  > block, blksnap: buffer in memory for the minimum data storage unit
>  > block, blksnap: functions and structures for performing block I/O
>  > operations
>  > block, blksnap: storage for storing difference blocks
>  > block, blksnap: event queue from the difference storage
>  > block, blksnap: owner of information about overwritten blocks of the
>  > original block device
>  > block, blksnap: snapshot image block device
>  > block, blksnap: snapshot
>  > block, blksnap: Kconfig and Makefile
>  > block, blksnap: adds a blksnap to the kernel tree
>  > block, blksnap: adds a maintainer for new files
>  >
>  > Documentation/block/blkfilter.rst | 50 ++
>  > Documentation/block/blksnap.rst | 348 ++++++++++++++
>  > Documentation/block/capability.rst | 3 +
>  > Documentation/block/index.rst | 2 +
>  > MAINTAINERS | 14 +
>  > block/bdev.c | 70 +++
>  > block/blk-core.c | 19 +-
>  > drivers/block/Kconfig | 2 +
>  > drivers/block/Makefile | 2 +
>  > drivers/block/blksnap/Kconfig | 12 +
>  > drivers/block/blksnap/Makefile | 18 +
>  > drivers/block/blksnap/cbt_map.c | 268 +++++++++++
>  > drivers/block/blksnap/cbt_map.h | 114 +++++
>  > drivers/block/blksnap/chunk.c | 345 ++++++++++++++
>  > drivers/block/blksnap/chunk.h | 139 ++++++
>  > drivers/block/blksnap/ctrl.c | 410 ++++++++++++++++
>  > drivers/block/blksnap/ctrl.h | 9 +
>  > drivers/block/blksnap/diff_area.c | 655 +++++++++++++++++++++++++
>  > drivers/block/blksnap/diff_area.h | 177 +++++++
>  > drivers/block/blksnap/diff_buffer.c | 133 ++++++
>  > drivers/block/blksnap/diff_buffer.h | 75 +++
>  > drivers/block/blksnap/diff_io.c | 168 +++++++
>  > drivers/block/blksnap/diff_io.h | 118 +++++
>  > drivers/block/blksnap/diff_storage.c | 317 +++++++++++++
>  > drivers/block/blksnap/diff_storage.h | 93 ++++
>  > drivers/block/blksnap/event_queue.c | 86 ++++
>  > drivers/block/blksnap/event_queue.h | 63 +++
>  > drivers/block/blksnap/main.c | 164 +++++++
>  > drivers/block/blksnap/params.h | 12 +
>  > drivers/block/blksnap/snapimage.c | 275 +++++++++++
>  > drivers/block/blksnap/snapimage.h | 69 +++
>  > drivers/block/blksnap/snapshot.c | 670 ++++++++++++++++++++++++++
>  > drivers/block/blksnap/snapshot.h | 78 +++
>  > drivers/block/blksnap/sysfs.c | 80 ++++
>  > drivers/block/blksnap/sysfs.h | 7 +
>  > drivers/block/blksnap/tracker.c | 683 +++++++++++++++++++++++++++
>  > drivers/block/blksnap/tracker.h | 74 +++
>  > drivers/block/blksnap/version.h | 10 +
>  > include/linux/blk_types.h | 2 +
>  > include/linux/blkdev.h | 71 +++
>  > include/uapi/linux/blksnap.h | 549 +++++++++++++++++++++
>  > 41 files changed, 6452 insertions(+), 2 deletions(-)
>  > create mode 100644 Documentation/block/blkfilter.rst
>  > create mode 100644 Documentation/block/blksnap.rst
>  > create mode 100644 drivers/block/blksnap/Kconfig
>  > create mode 100644 drivers/block/blksnap/Makefile
>  > create mode 100644 drivers/block/blksnap/cbt_map.c
>  > create mode 100644 drivers/block/blksnap/cbt_map.h
>  > create mode 100644 drivers/block/blksnap/chunk.c
>  > create mode 100644 drivers/block/blksnap/chunk.h
>  > create mode 100644 drivers/block/blksnap/ctrl.c
>  > create mode 100644 drivers/block/blksnap/ctrl.h
>  > create mode 100644 drivers/block/blksnap/diff_area.c
>  > create mode 100644 drivers/block/blksnap/diff_area.h
>  > create mode 100644 drivers/block/blksnap/diff_buffer.c
>  > create mode 100644 drivers/block/blksnap/diff_buffer.h
>  > create mode 100644 drivers/block/blksnap/diff_io.c
>  > create mode 100644 drivers/block/blksnap/diff_io.h
>  > create mode 100644 drivers/block/blksnap/diff_storage.c
>  > create mode 100644 drivers/block/blksnap/diff_storage.h
>  > create mode 100644 drivers/block/blksnap/event_queue.c
>  > create mode 100644 drivers/block/blksnap/event_queue.h
>  > create mode 100644 drivers/block/blksnap/main.c
>  > create mode 100644 drivers/block/blksnap/params.h
>  > create mode 100644 drivers/block/blksnap/snapimage.c
>  > create mode 100644 drivers/block/blksnap/snapimage.h
>  > create mode 100644 drivers/block/blksnap/snapshot.c
>  > create mode 100644 drivers/block/blksnap/snapshot.h
>  > create mode 100644 drivers/block/blksnap/sysfs.c
>  > create mode 100644 drivers/block/blksnap/sysfs.h
>  > create mode 100644 drivers/block/blksnap/tracker.c
>  > create mode 100644 drivers/block/blksnap/tracker.h
>  > create mode 100644 drivers/block/blksnap/version.h
>  > create mode 100644 include/uapi/linux/blksnap.h
>  >
>  > --
>  > 2.20.1
>  >
> 
