Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8B069774F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjBOHXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBOHXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:23:18 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE8A29173;
        Tue, 14 Feb 2023 23:23:17 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id g9so2237682vst.10;
        Tue, 14 Feb 2023 23:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676445796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tAyp2EwBTKDmkRSvi384rqVQ6cxfxzWF6zUVOpX2DOQ=;
        b=Il7oKIT0F0S5IRdBTqDAD8JpCLPt9m3QLOL8FIpxpNAkecdl6pZEIYm7KOOJed3IXK
         /1FoFUfedJIIzNAY+/qy7+TWvm7vJ91ed0q8WrmEUA5zp6xJzWtr3bWs+CORi9FgSPnr
         /+BU7kCMsiYcLVWm/dntByLjfIpqpL2URYTd4ZpJZSnh1y9+nht0xpSJDpdKAIJhnfZ8
         20viov4/NQvt2+15VWx5MGAFkBH21hhC2VSQ8nco93MViBqd7NbAYfl3ESkAthyDn/8z
         whXXBQoHd4Dp/Ix18wmHJ64VTNDnc2dFCjeUa11CdakL0wW/LQBOCdOuTCMXNluAUSaf
         HSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676445796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAyp2EwBTKDmkRSvi384rqVQ6cxfxzWF6zUVOpX2DOQ=;
        b=r8zyaM0+BXgUMHMe82HBwssvcFOZTf4M4t0tWOehlB1e+jGALuNkTYJSIyVbIaUs6u
         NG2R4FjDg+P2tJvi/uhK7YeWWss4cYG0w6AeIsuRSXRWjmBl1MuBEnnelke2IICQdtqb
         mVkNqPTUo9Qt5CJRxiKx9HH+5vZG9OeXHoB9JtZoZFMBCl3XfQIPBXrXibHQy0V2vidq
         DLVmhR0kmlSJg/Met9cA9q6BZk51UKsE6W+cvpkXdky7lH9/gGXhK/um3a12F0o595Pn
         EqyaBUdkJYRTifzRZdkjO9HRWPSoj/fsF/GKGA0ocGoadO/qoxAfSD04gT9065P+jvTh
         Fz/g==
X-Gm-Message-State: AO0yUKUgAmrb23sa94IUACUqfW28c93aH+Wg02/BargHUVjhvXa7mkB0
        xlepZzLXwVOiCHwpUpXym2MOUTN1LjuRlnsUFYE=
X-Google-Smtp-Source: AK7set9AudZ/Bhpl7dEpZejs4OV1t5b0SNb2UeQiGB7mYAUUz0OeGE3MPRX173q0QQTSMd9YxwPzTowXo2oIOryFI04=
X-Received: by 2002:a67:cb92:0:b0:412:2da0:b284 with SMTP id
 h18-20020a67cb92000000b004122da0b284mr235319vsl.26.1676445796123; Tue, 14 Feb
 2023 23:23:16 -0800 (PST)
MIME-Version: 1.0
References: <CACsaVZJvXpCt37nQOoe8qd1EPUpfdMM1HwHk9tVO8HdU_Azhhw@mail.gmail.com>
 <25578.37401.314298.238192@quad.stoffel.home> <CACsaVZJ-5y7U5xqwL9bof69EKbTk+wrHWFcBFYyP_BwVSt+CNA@mail.gmail.com>
 <CAM23Vxr8LkkcVDFfW1=qEYGgo7JG1qx62eWSV4WOw4_MnD+TZA@mail.gmail.com> <CAAMCDeeHxMBoVkNYAyssjgjo4=FYd2NonS-mqC7OUEL89B9Cig@mail.gmail.com>
In-Reply-To: <CAAMCDeeHxMBoVkNYAyssjgjo4=FYd2NonS-mqC7OUEL89B9Cig@mail.gmail.com>
From:   Kyle Sanderson <kyle.leet@gmail.com>
Date:   Tue, 14 Feb 2023 23:23:04 -0800
Message-ID: <CACsaVZLKEYWzr5zHwE+rCJpYKu0d8-fzQycvn8ow4b=kCSTtjg@mail.gmail.com>
Subject: Re: [dm-devel] RAID4 with no striping mode request
To:     Roger Heflin <rogerheflin@gmail.com>
Cc:     Heinz Mauelshagen <heinzm@redhat.com>, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        John Stoffel <john@stoffel.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Feb 14, 2023 at 2:28 PM Roger Heflin <rogerheflin@gmail.com> wrote:
>
> Such that you can lose any one data disk and parity can rebuild that
> disk.  And if you lose several data diskis, then you have intact
> non-striped data for the remaining disks.
>
> It would almost seem that you would need to put a separate filesystem
> on each data disk/section (or have a filesystem that is redundant
> enough to survive) otherwise losing an entire data disk would leave
> the filesystem in a mess..

Exactly, each disk operates completely independently (so a XFS
partition per disk on each md device). So I have 4 disks presently, 3
are data, and one is dedicated parity. I can scale up or down these
disks freely, changing the physical data disk sizes and still have
them all protected by the single parity disk by removing and adding
them to the array.

> On Tue, Feb 14, 2023 at 6:23 PM Heinz Mauelshagen <heinzm@redhat.com> wrote:
>
> as any of the currently implemented 'parity' algorithms (block xor/P-/Q-Syndrome) provided by DM/MD RAID
> have to have at least two data blocks to calculate:  are you, apart from the filesystem thoughts you bring up, thinking
> about running those on e.g. pairs of disks of mentioned even numbered set of 8?

Users of these appliances today gain "parity" by adding the second
disk (note it must be the equal to or the largest in the array), and
can scale by adding disk by disk individually (so 3, 4, 5, 6...).

Hopefully it's starting to make more sense now.

On Tue, Feb 14, 2023 at 2:28 PM Roger Heflin <rogerheflin@gmail.com> wrote:
>
> On Tue, Feb 14, 2023 at 3:27 PM Heinz Mauelshagen <heinzm@redhat.com> wrote:
> >
>
> >
> >
> > ...which is RAID1 plus a parity disk which seems superfluous as you achieve (N-1)
> > resilience against single device failures already without the later.
> >
> > What would you need such parity disk for?
> >
> > Heinz
> >
>
> I thought that at first too, but threw that idea out as it did not
> make much sense.
>
> What he appears to want is 8 linear non-striped data disks + a parity disk.
>
> Such that you can lose any one data disk and parity can rebuild that
> disk.  And if you lose several data diskis, then you have intact
> non-striped data for the remaining disks.
>
> It would almost seem that you would need to put a separate filesystem
> on each data disk/section (or have a filesystem that is redundant
> enough to survive) otherwise losing an entire data disk would leave
> the filesystem in a mess..
>
> So N filesystems + a parity disk for the data on the N separate
> filesystems.   And each write needs you to read the data from the disk
> you are writing to, and the parity and recalculate the new parity and
> write out the data and new parity.
>
> If the parity disk was an SSD it would be fast enough, but if parity
> was an SSD I would expect it to get used up/burned out from all of
> parity being re-written for each write on each disk unless you bought
> an expensive high-write ssd.
>
> The only advantage of the setup is that if you lose too many disks you
> still have some data.
>
> It is not clear to me that it would be any cheaper if parity needs to
> be a normal ssd's (since ssds are about 4x the price/gb and high-write
> ones are even more) than a classic bunch of mirrors, or even say a 4
> disks raid6 where you can lose any 2 and still have data.
