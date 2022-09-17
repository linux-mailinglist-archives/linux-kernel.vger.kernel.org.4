Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96265BB5E6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 05:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIQD0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 23:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQD0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 23:26:19 -0400
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F989AA374;
        Fri, 16 Sep 2022 20:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1990; q=dns/txt; s=iport;
  t=1663385177; x=1664594777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZQ67lmBemx5MvvGEfsScTKcejlbMkSnwr5EpEXpZvMw=;
  b=gbV0SRtcIlNe1rYoMMq7BF12eyqfYEkoE/3NvXCM6JdpX6i6NihmAKR1
   0CwifDs5bKQFfXp8CEu55z+Byk+Zj9EXiH/BXbbdpPlk/w7JUyr4a45Y6
   J6hSA5CebQRbzW95i9ACzyg245PybL+Uy2MDum50LcJyjDd2EAzzvM7dp
   8=;
IronPort-Data: =?us-ascii?q?A9a23=3A72pbo6v79hAFZ23LkVpVEqfvEefnVN5cMUV32?=
 =?us-ascii?q?f8akzHdYApBsoF/qtZmKWqFb6zYY2SjeIgiYYzkoEgFscDXnYJnHQY4riwyR?=
 =?us-ascii?q?CNHgMeUXt7xwmUckM+xwmwvdK/shiknQoGowPscEzmN/39BDpC79SMmjfzRG?=
 =?us-ascii?q?OKlYAL5EnkZqTFMGX9JZS1Lw4bVsqYw6TSIK1vlVeHa+qUzC3f9s9JACV/43?=
 =?us-ascii?q?orYwP9ZUFsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRp?=
 =?us-ascii?q?gs1/j83Ad+j1738aEBPHPjZPBOFjTxdXK3Kbhpq/3NplP1kcqtHLx4K1F1ln?=
 =?us-ascii?q?PgpoDlJnZC5TwYkOrLFsO8cSBJfVSp5OMWq/ZeWcSHl6JPOlBOun3zEhq8G4?=
 =?us-ascii?q?FsNFYkZ/PtnRGJD7/oVLBgTYR2ZweG72rS2Tq9rnMtLBMXmIoIUt216wDzxE?=
 =?us-ascii?q?/krW9bATr/M6Nse2y0/7uhUGvzeJMYFQTlidhLNZ1tIIFh/IIo3mvulgnjkN?=
 =?us-ascii?q?TRetFWTpK0qy2vUyhds1LvqdtHSf7SiS99SgU+eqiTC/n/lKh4fPd2bjzGC9?=
 =?us-ascii?q?xqRakXn9c/gcJgZGLv9/flwjRjNgGcSExYRE1C8pJGEZoeFc4o3AyQpFuAG9?=
 =?us-ascii?q?MDeLHCWc+Q=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A/94Ja6txklqy1qiBrlXxcxJT7skDTdV00z?=
 =?us-ascii?q?EX/kB9WHVpmwKj+PxGuM5rsCMc6QxhOk3I9urrBEDtex7hHNtOkO0s1NSZLW?=
 =?us-ascii?q?rbUQmTTb2KhLGKq1bd8m/FltK1vp0PT0ERMrHN5HFB/KHHCM3SKadY/DFBm5?=
 =?us-ascii?q?rY49vj8w=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DgDADea4Ji/51dJa1aHAEBATwBAQQ?=
 =?us-ascii?q?EAQECAQEHAQEVgU8CgimBSz2Td4IlA5FHix0UgWgLAQEBDQEBEjAEAQGBToM?=
 =?us-ascii?q?0AoU+AiU0CQ4BAgQBAQESAQEFAQEBAgEHBIEJE4V1hkMBBScTPxALDgQGLkk?=
 =?us-ascii?q?OBoYoq1Z4gQEygQGIGYFlFBCBGAGOXyccgUlEhAg3PoQqhlUElWM7A1SBBRK?=
 =?us-ascii?q?BIXEBCAYGBwoFMgYCDBgUBAITElMeAhMMChwOVBkMDwMSAxEBBwILEggVLAg?=
 =?us-ascii?q?DAgMIAwIDIwsCAxgJBwoDHQgKHBIQFAIEBg0fCwgDGh8tCQIEDgNDCAsKAxE?=
 =?us-ascii?q?EAxMYCxYIEAQGAwkvDSgLAxQPAQYDBgIFBQEDIAMUAwUnBwMhBwsmDQ0EHAc?=
 =?us-ascii?q?dAwMFJgMCAhsHAgIDAgYXBgICcQooDQgECAQcHiUTBQIHMQUELwIeBAUGEQk?=
 =?us-ascii?q?CFgIGBAUCBAQWAgISCAIIJxsHFjYZAQVdBgsJIxwsCwYFBhYDJlIGIgGXXh8?=
 =?us-ascii?q?Cel8CWQpgGKM2niqDVoFDjCGSDEsRg2SkYpZmoiWEWQIEBgUCFoFhPIFZMxo?=
 =?us-ascii?q?IGxWDJFAZD44sFo5OJGwCBgsBAQMJkRoBAQ?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="981217536"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 17 Sep 2022 03:26:13 +0000
Received: from zorba ([10.25.129.98])
        by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 28H3QAFI010600
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 17 Sep 2022 03:26:12 GMT
Date:   Fri, 16 Sep 2022 20:26:10 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: of: overlay: demote message to warning
Message-ID: <20220917032610.GM4320@zorba>
References: <973f7127-8165-45f6-071f-04360046b7d7@gmail.com>
 <20220908003510.GE4320@zorba>
 <c0c66918-f55e-83e4-edea-b2d32fdb27a7@gmail.com>
 <3fcea82c-f5cf-f066-67b9-08669c44a9c6@gmail.com>
 <20220912170524.GX4320@zorba>
 <75e803f8-2b25-22c8-0831-e90d0c889da1@gmail.com>
 <20220913005153.GZ4320@zorba>
 <00850627-7ada-3a02-158c-30f3b8334d51@gmail.com>
 <20220916225646.GK4320@zorba>
 <b6a43df4-e5d8-06d2-a6b9-3626f2677161@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a43df4-e5d8-06d2-a6b9-3626f2677161@gmail.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.129.98, [10.25.129.98]
X-Outbound-Node: rcdn-core-6.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 09:47:19PM -0500, Frank Rowand wrote:
> On 9/16/22 17:56, Daniel Walker wrote:
> > On Fri, Sep 16, 2022 at 05:47:54PM -0500, Frank Rowand wrote:
> >>>
> >>> Maybe you could add a flag or other indicator which would indicate the overlay will never be
> >>> removed. Then your code could rely on this property to inform on if the author
> >>> has consider the removal issues related to overlays.
> >>
> >> No.  I guess I wasn't clear enough above, where I said:
> >>
> >>    "And I will not accept a
> >>     change that suppresses the message if there is no expectation to remove the
> >>     overlay."
> >>
> >> There are multiple reasons for this, but the most fundamental is that if a
> >> new overlay is not removable, then any overlay already applied can not be
> >> removed (because overlays must be removed in the reverse order that they
> >> are applied).  It would be incredibly bad architecture to allow an overlay
> >> to block another overlay from being removed.
> > 
> > So how about an option to turn off removable overlays entirely? As far as I can
> > tell it's not used currently by the tiny number of implementation I've seen.
> > 
> > Cisco doesn't need it, and we could have a smaller kernel without it.
> > 
> > The issue is that the error log on blast is log level abuse in my opinion. If
> > there's no way to fix it, it should not be an error.
> 
> The way to fix it is to not have a construct in the overlay that triggers the
> message.  In other words, do not add a property to a pre-existing node.  (At
> least I think that is what is the underlying cause, if I recall correctly.)
> 
> -Frank

Here's the check,

 if (!of_node_check_flag(target->np, OF_OVERLAY))

If the print shows when the modifications is made to a non-overlay, I'm not
sure how you could construct a device tree where you only modify other overlays.

It seems like this should print on the vast majority of overlays.

Daniel
