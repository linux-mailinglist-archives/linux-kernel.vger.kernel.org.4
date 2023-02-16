Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9B86988FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBPACM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBPACL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:02:11 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B337C23105;
        Wed, 15 Feb 2023 16:02:09 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id s21so60866uac.13;
        Wed, 15 Feb 2023 16:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H7+6qQa+p0mgRiuJ1OJVWY0HGLNJgAvVISPrwm3CHGc=;
        b=m86yl/jTnKDAQhPT8CBgNAVrMu/wDCZ9+rJw6NvBHDt7EmyGxFY+Mnk0L/D+rtskpk
         9MspfmW4Htg2xemcw6CxRgPHR3PJXkm/YA9OzW9XljVJmRLOtRBtUO4JXdWrdp4mBbPM
         mTDcRYIuWWedFsaeB9xw03SYrSbblx1+/kv6R/d//rnFs2a0PpL6KrOP0HmKm5jkQIQc
         s+flfuC6MRco1zkUeHy282IDnGpjT0e2RWe/yaggKYsd0i1dU4MZ3UFoFQvete/mBW47
         6ov4oUNCQ/cJL6G36C9t+VcNwitF7fsDBaj+95I180IRz2mz2ELGIbHmvEYsmH8JH5vj
         UFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7+6qQa+p0mgRiuJ1OJVWY0HGLNJgAvVISPrwm3CHGc=;
        b=konoQvyfzdZeqtA9V+uEiIG7kBiX8DAl39d35+OFziCi1Ou4jzFl+xzprGon2nLgPB
         R96+7OEwbEbDiugLTIO0+n8JvYmSNMbgqvlfp3nAErRemcAS8H+8ciByBB7Cjf1McAfX
         EpSLnb4CcsyE0bQziSn3eooMpqHtOR6zKavy/8P7rC803gY/Pf3ahWTR9sJFaZJSpzE9
         Wtjs/gb998btVcDDyx60kPylHYVQCBIFZAUIH4xBX4UGuseVn15/061SaFaAzbPbzqKC
         8saCgZO6myq/tiiBfXY9kiae7ZAF2nkW+kXXlzx9d4otTSvePCYj2lxDC+Ogy9/RCvkY
         onKQ==
X-Gm-Message-State: AO0yUKXr5lgGUR7FWp/xfIWkTL0KdRbsXEpuj3l0GwrJ6oneFGIQSqFA
        uXqoDal0RggatK1RY8qTTlHv/sO1te8y2HdCSH4=
X-Google-Smtp-Source: AK7set8i0RSR1WbmCEWS/0IYke3YKLUGyjLlsV0tEdHcrXVBsL3AafZ/9/47K8J2wttvP+cHORFMXNhXBoVdW8o0Njc=
X-Received: by 2002:ab0:7e8e:0:b0:68a:57ea:ca48 with SMTP id
 j14-20020ab07e8e000000b0068a57eaca48mr379751uax.77.1676505728700; Wed, 15 Feb
 2023 16:02:08 -0800 (PST)
MIME-Version: 1.0
References: <CACsaVZJvXpCt37nQOoe8qd1EPUpfdMM1HwHk9tVO8HdU_Azhhw@mail.gmail.com>
 <25578.37401.314298.238192@quad.stoffel.home> <CACsaVZJ-5y7U5xqwL9bof69EKbTk+wrHWFcBFYyP_BwVSt+CNA@mail.gmail.com>
 <CAM23Vxr8LkkcVDFfW1=qEYGgo7JG1qx62eWSV4WOw4_MnD+TZA@mail.gmail.com>
 <CAAMCDeeHxMBoVkNYAyssjgjo4=FYd2NonS-mqC7OUEL89B9Cig@mail.gmail.com>
 <CAM23VxpzY6qYsdTYxe01FT7AJvEbODf8X_vq8ALL35TfyrB8xQ@mail.gmail.com> <CAAMCDee2hV1YP=119Rorz1uGTnyBD5q9hb20PvMq89FHow2wPw@mail.gmail.com>
In-Reply-To: <CAAMCDee2hV1YP=119Rorz1uGTnyBD5q9hb20PvMq89FHow2wPw@mail.gmail.com>
From:   Kyle Sanderson <kyle.leet@gmail.com>
Date:   Wed, 15 Feb 2023 16:01:56 -0800
Message-ID: <CACsaVZJeC=6f4aGmnfdh1iSj77YQuTduQyXeADKJHnpC1aNWLQ@mail.gmail.com>
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

> On Wed, Feb 15, 2023 at 3:44 AM Roger Heflin <rogerheflin@gmail.com> wrote:
>
> I think he is wanting the parity across the data blocks on the
> separate filesystems (some sort of parity across fs[1-8]/block0 to
> parity/block0).

Correct.

> On Wed, Feb 15, 2023 at 3:44 AM Roger Heflin <rogerheflin@gmail.com> wrote:
> it is not clear to me what this setup would be enough better than what
> the current setups.    Given that one could have 8 spin + 1ssd or 12
> spin for the same price.    And 2 6 disk raid6's would have the same
> usable space, and be pretty safe (can lose any 2 of the 6 and lose no
> data).

They're not the same price though. Remember these disks are mixed
sizes and various ages, exposing their entire data value
(4d+8d+12d+12p gives you 24T of usable storage) all protected by the
single parity disk.

Yes, higher levels of RAID will always be better. However, that's not
how these millions of appliances are developed by a number of
manufacturers and sold at your local retailer. The proposal (and ask
for help) that I've raised is to have an open-source solution to these
proprietary MD implementations, as opposed to being trapped with buggy
MD drivers on firmware that's glitchy and breaks other aspects of the
kernel.

> On Wed, Feb 15, 2023 at 3:44 AM Roger Heflin <rogerheflin@gmail.com> wrote:
> And given the separate filesystems requirement that would
> require some software above the filesystems to manage spreading the
> disks across multiple filesystems.   The risk of another disk going
> bad (while one was failed) and losing a disk's worth of data would
> push me to use the 6-disk raid6.

This is long solved by a number of FUSE filesystems, as well as
overlayfs (which would be nice if it could gradually spool data down
into layers, but that's another ball of wax).

Hopefully that makes sense. The only thing that's coming closer to
this is bcachefs, but that's still looking like a multi-year long road
(with the above being deployed in homes since the early 2000s).

On Wed, Feb 15, 2023 at 3:44 AM Roger Heflin <rogerheflin@gmail.com> wrote:
>
> I think he is wanting the parity across the data blocks on the
> separate filesystems (some sort of parity across fs[1-8]/block0 to
> parity/block0).
>
> it is not clear to me what this setup would be enough better than what
> the current setups.    Given that one could have 8 spin + 1ssd or 12
> spin for the same price.    And 2 6 disk raid6's would have the same
> usable space, and be pretty safe (can lose any 2 of the 6 and lose no
> data).  And given the separate filesystems requirement that would
> require some software above the filesystems to manage spreading the
> disks across multiple filesystems.   The risk of another disk going
> bad (while one was failed) and losing a disk's worth of data would
> push me to use the 6-disk raid6.
>
> WOL: current SSD's are rated for around 1000-2000 writes.  So a 1Tb
> disk can sustain 1000-2000TB of total writes.  And writes to
> filesystem blocks would get re-written more often than data blocks.
>  How well it would work would depend on how often the data is deleted
> and re-written.   If the disks are some sort of long term storage then
> the SSD is not going to get used up.   And I am not sure if the rated
> used up really means anything unless you are using a STUPID enterprise
> controller that proactively disables/kills the SSD when it says the
> rated writes have happened.   I have a 500GB ssd in a mirror that
> "FAILED" according to smart 2 years ago and so far is still fully
> functional, and it is "GOOD" again because the counters used to
> determine total writes seems to have rolled over.
>
> On Tue, Feb 14, 2023 at 8:23 PM Heinz Mauelshagen <heinzm@redhat.com> wrote:
> >
> > Roger,
> >
> > as any of the currently implemented 'parity' algorithms (block xor/P-/Q-Syndrome) provided by DM/MD RAID
> > have to have at least two data blocks to calculate:  are you, apart from the filesystem thoughts you bring up, thinking
> > about running those on e.g. pairs of disks of mentioned even numbered set of 8?
> >
> > Heinz
> >
> > On Tue, Feb 14, 2023 at 11:28 PM Roger Heflin <rogerheflin@gmail.com> wrote:
> >>
> >> On Tue, Feb 14, 2023 at 3:27 PM Heinz Mauelshagen <heinzm@redhat.com> wrote:
> >> >
> >>
> >> >
> >> >
> >> > ...which is RAID1 plus a parity disk which seems superfluous as you achieve (N-1)
> >> > resilience against single device failures already without the later.
> >> >
> >> > What would you need such parity disk for?
> >> >
> >> > Heinz
> >> >
> >>
> >> I thought that at first too, but threw that idea out as it did not
> >> make much sense.
> >>
> >> What he appears to want is 8 linear non-striped data disks + a parity disk.
> >>
> >> Such that you can lose any one data disk and parity can rebuild that
> >> disk.  And if you lose several data diskis, then you have intact
> >> non-striped data for the remaining disks.
> >>
> >> It would almost seem that you would need to put a separate filesystem
> >> on each data disk/section (or have a filesystem that is redundant
> >> enough to survive) otherwise losing an entire data disk would leave
> >> the filesystem in a mess..
> >>
> >> So N filesystems + a parity disk for the data on the N separate
> >> filesystems.   And each write needs you to read the data from the disk
> >> you are writing to, and the parity and recalculate the new parity and
> >> write out the data and new parity.
> >>
> >> If the parity disk was an SSD it would be fast enough, but if parity
> >> was an SSD I would expect it to get used up/burned out from all of
> >> parity being re-written for each write on each disk unless you bought
> >> an expensive high-write ssd.
> >>
> >> The only advantage of the setup is that if you lose too many disks you
> >> still have some data.
> >>
> >> It is not clear to me that it would be any cheaper if parity needs to
> >> be a normal ssd's (since ssds are about 4x the price/gb and high-write
> >> ones are even more) than a classic bunch of mirrors, or even say a 4
> >> disks raid6 where you can lose any 2 and still have data.
> >>
