Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7634E6952C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjBMVMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBMVMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:12:01 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08D7113E2;
        Mon, 13 Feb 2023 13:11:58 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id g12so2440136uae.6;
        Mon, 13 Feb 2023 13:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZPCAt9iaKl4ylawbJPz9x0jubQ10EQyn5A2P4OMHS0=;
        b=KHZF2RfEz3aIRS0Ud7LiZqgSXGeHQD2MfEuW+c3FIPzOu/ZmDnHNYY2pZkX6PnkR1W
         yOV1Xq87osdoywcxQUlBPh7C8HgA33pn4x2GSHVhVTCaPFU9wDwsre3DHIUEVJKW4ZcB
         pViZQV/SheTRJ/RVbeOgYPiJxCMi4u8jXS+X4vm5Sn0lMX4pa0sjlVGs8QBS11QKByyQ
         7ZUUikInjUX7dbo1a6sx9n3JhRcUgkosYrJuaPpjgt8Fb4zGnG8s/IsalMzMG+1dxOx8
         SQljnwpivgpTeZ6XXwC77QiEOaWi5afU+5jUZLGo3dMdbyiIrTIcqJd292/F1clRjSwm
         zK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZPCAt9iaKl4ylawbJPz9x0jubQ10EQyn5A2P4OMHS0=;
        b=kwiJ4GKNvPBZKf/vjyJGdNgFoU/cHoHtKZUIinnHqmt0pcta4LME/FTUnfHq4/gvRR
         p6wGtsofjMm5FtLdvApnvlssCKIP45UKg3D1B7sXXSn8UegK/P7mjG4XkacjrpOUYdWK
         F+YdZYXQyYfQzxxjW663JCEfrcX6848JM2QmgXEcrSAINkpPtpDybdbPvRQgmwSONmKF
         PRXisfn5UyzScmY6WjyidmF0vIPw2Ab/qg6WzNOz+9eaL/aCsHP/Rblu+sJkJyFpUxrB
         dy5cBIDpawlTglkygBYdHfT6qq30Y2tAjzJRRWY3Hr0uQLwNwtB1iWGPOdDLSDjKr59b
         roJg==
X-Gm-Message-State: AO0yUKXuOw8dCQUqd5Lupy0MssLmjQi22rUU4V7oGL6OGmHpNxvcDfz+
        rZN7D0DnnWtZW57mh8j8FgZqP+MdO2Ru0CfpAgM=
X-Google-Smtp-Source: AK7set8kt3Gm3Fjyrsk+SHSRAkLbF+kb36gCT23fpnOZEtp6+i2RwapdbYhRkB2ndxJH5fQML7xJQPtv8XqMWI1eqNE=
X-Received: by 2002:ab0:2841:0:b0:632:a75f:8b40 with SMTP id
 c1-20020ab02841000000b00632a75f8b40mr4429715uaq.72.1676322717768; Mon, 13 Feb
 2023 13:11:57 -0800 (PST)
MIME-Version: 1.0
References: <CACsaVZJvXpCt37nQOoe8qd1EPUpfdMM1HwHk9tVO8HdU_Azhhw@mail.gmail.com>
 <25578.37401.314298.238192@quad.stoffel.home>
In-Reply-To: <25578.37401.314298.238192@quad.stoffel.home>
From:   Kyle Sanderson <kyle.leet@gmail.com>
Date:   Mon, 13 Feb 2023 13:11:46 -0800
Message-ID: <CACsaVZJ-5y7U5xqwL9bof69EKbTk+wrHWFcBFYyP_BwVSt+CNA@mail.gmail.com>
Subject: Re: RAID4 with no striping mode request
To:     John Stoffel <john@stoffel.org>
Cc:     device-mapper development <dm-devel@redhat.com>,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
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

> On Mon, Feb 13, 2023 at 11:40 AM John Stoffel <john@stoffel.org> wrote:
>
> >>>>> "Kyle" == Kyle Sanderson <kyle.leet@gmail.com> writes:
>
> > hi DM and Linux-RAID,
> > There have been multiple proprietary solutions (some nearly 20 years
> > old now) with a number of (userspace) bugs that are becoming untenable
> > for me as an end user. Basically how they work is a closed MD module
> > (typically administered through DM) that uses RAID4 for a dedicated
> > parity disk across multiple other disks.
>
> You need to explain what you want in *much* beter detail.  Give simple
> concrete examples.  From the sound of it, you want RAID6 but with
> RAID4 dedicated Parity so you can spin down some of the data disks in
> the array?  But if need be, spin up idle disks to recover data if you
> lose an active disk?

No, just a single dedicated parity disk - there's no striping on any
of the data disks. The result of this is you can lose 8 data disks and
the parity disk from an array of 10, and still access the last
remaining disk because each disk maintains a complete copy of their
own data. How the implementations do this is still expose each
individual disk (/dev/md*) that are formatted (+ encrypted)
independently, and when written to, update the parity information on
the dedicated disk. That way, when you add a new disk that's fully
zero'd to the array (parity disk is 16T, new disk is 4T), parity is
preserved. Any bytes written beyond the 4T barrier do not include
those disks in the parity calculation.

> Really hard to understand what exactly you're looking for here.

This might help https://www.snapraid.it/compare . There's at least
hundreds of thousands of these systems out there (based on public
sales from a single vendor), if not well into the millions.

Kyle.

On Mon, Feb 13, 2023 at 11:40 AM John Stoffel <john@stoffel.org> wrote:
>
> >>>>> "Kyle" == Kyle Sanderson <kyle.leet@gmail.com> writes:
>
> > hi DM and Linux-RAID,
> > There have been multiple proprietary solutions (some nearly 20 years
> > old now) with a number of (userspace) bugs that are becoming untenable
> > for me as an end user. Basically how they work is a closed MD module
> > (typically administered through DM) that uses RAID4 for a dedicated
> > parity disk across multiple other disks.
>
> You need to explain what you want in *much* beter detail.  Give simple
> concrete examples.  From the sound of it, you want RAID6 but with
> RAID4 dedicated Parity so you can spin down some of the data disks in
> the array?  But if need be, spin up idle disks to recover data if you
> lose an active disk?
>
> Really hard to understand what exactly you're looking for here.
>
>
> > As there is no striping, the maximum size of the protected data is the
> > size of the parity disk (so a set of 4+8+12+16 disks can be protected
> > by a single dedicated 16 disk).When a block is written on any disk,
> > the parity bit is read from the parity disk again, and updated
> > depending on the existing + new bit value (so writing disk + parity
> > disk spun up). Additionally, if enough disks are already spun up, the
> > parity information can be recalculated from all of the spinning disks,
> > resulting in a single write to the parity disk (without a read on the
> > parity, doubling throughput). Finally any of the data disks can be
> > moved around within the array without impacting parity as the layout
> > has not changed. I don't necessarily need all of these features, just
> > the ability to remove a disk and still access the data that was on
> > there by spinning up every other disk until the rebuild is complete is
> > important.
>
> > The benefit of this can be the data disks are all zoned, and you can
> > have a fast parity disk and still maintain excellent performance in
> > the array (limited only by the speed of the disk in question +
> > parity). Additionally, should 2 disks fail, you've either lost the
> > parity and data disk, or 2 data disks with the parity and other disks
> > not lost.
>
> > I was reading through the DM and MD code and it looks like everything
> > may already be there to do this, just needs (significant) stubs to be
> > added to support this mode (or new code). Snapraid is a friendly (and
> > respectable) implementation of this. Unraid and Synology SHR compete
> > in this space, as well as other NAS and enterprise SAN providers.
>
> > Kyle.
