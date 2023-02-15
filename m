Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3BF697AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjBOLoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjBOLoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:44:19 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A0E9ED3;
        Wed, 15 Feb 2023 03:44:14 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id bx25so2106720uab.9;
        Wed, 15 Feb 2023 03:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=awt3h/BgoD85tVDVGLaiObMzjnTgyZo2ngbTA8DaEYU=;
        b=Wc8F944WuLNh5OLXFCwzLpu82agUA1DdtxO4DM/xZVfDI7qNhlIe8Z9xt2k0et87zz
         UIG7brxiHD9tdPTKt3APTRWX854e4hf6gdBUK16OuL22D48banvtPf3uk4X2XCSlZtTj
         Ow7jkBGX/8vEg/J9I27ZeocunKn/lOx6tPxj0Ml3DZvHPhQCYA0j31PagdnTG2ZqduAE
         wFDalZK+x1iW3TAPxyuCcLVponVRaO/MY9+ZoCL7iacGSABzZFKjevI3rXaRpMfJkF/3
         2gjQbzhql0uDX5Bomg1R1Mz02bCcwGC8riSpzNwcjvBADTq4nk9uL3JD7kRgmESsnow/
         Xb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awt3h/BgoD85tVDVGLaiObMzjnTgyZo2ngbTA8DaEYU=;
        b=TVhupVIocTpi93SGsP9r2ZobKgWo6fbp+UtgUxzrHd09Ou/4wRc1KMt7eNoglggnWn
         GJmadr0eUjAHFieJCfkvNY3gc4cM2vu9H9XsH6HqiZTeKpG9aG93GeUvPZ8+8jbWGZEs
         4rw0BdXaxh0IKoausR0A4mub77ekH/Bao9wmiG/2Xupx3j1NlaD16kog8h2ZW8kVfv6b
         97RTA1QpDGmYbU22GBW1qVAe4Fluds9QEr3hAvBu5K8XqFcqJrrFHP8Tv7JJptsMud5x
         puHAv8XLDAoguZMDsOVoxYtPyqDkIQPAKL+4SG94vDdq3qS6T3NWCfXV0uywfnHlj37m
         CUbQ==
X-Gm-Message-State: AO0yUKWmNpW8WpuNBzvpT6NDmNW/7suzWNtvyq7/gj6vGYiJEVizAeAL
        RFtJRPy/UoaODQgaLratxbq0EC9bQkHuR+U05vU=
X-Google-Smtp-Source: AK7set/cc8b3+yjQliSQxdGVVOWi0u4hi6UpB28JhdhTs5H7m2uu+c6gg9rdkck8h74qXS86Mag3LLrKkqbBVvuMbac=
X-Received: by 2002:a05:6130:2104:b0:68a:570a:8ddb with SMTP id
 cl4-20020a056130210400b0068a570a8ddbmr217187uab.4.1676461453461; Wed, 15 Feb
 2023 03:44:13 -0800 (PST)
MIME-Version: 1.0
References: <CACsaVZJvXpCt37nQOoe8qd1EPUpfdMM1HwHk9tVO8HdU_Azhhw@mail.gmail.com>
 <25578.37401.314298.238192@quad.stoffel.home> <CACsaVZJ-5y7U5xqwL9bof69EKbTk+wrHWFcBFYyP_BwVSt+CNA@mail.gmail.com>
 <CAM23Vxr8LkkcVDFfW1=qEYGgo7JG1qx62eWSV4WOw4_MnD+TZA@mail.gmail.com>
 <CAAMCDeeHxMBoVkNYAyssjgjo4=FYd2NonS-mqC7OUEL89B9Cig@mail.gmail.com> <CAM23VxpzY6qYsdTYxe01FT7AJvEbODf8X_vq8ALL35TfyrB8xQ@mail.gmail.com>
In-Reply-To: <CAM23VxpzY6qYsdTYxe01FT7AJvEbODf8X_vq8ALL35TfyrB8xQ@mail.gmail.com>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Wed, 15 Feb 2023 05:44:01 -0600
Message-ID: <CAAMCDee2hV1YP=119Rorz1uGTnyBD5q9hb20PvMq89FHow2wPw@mail.gmail.com>
Subject: Re: [dm-devel] RAID4 with no striping mode request
To:     Heinz Mauelshagen <heinzm@redhat.com>
Cc:     Kyle Sanderson <kyle.leet@gmail.com>, linux-raid@vger.kernel.org,
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

I think he is wanting the parity across the data blocks on the
separate filesystems (some sort of parity across fs[1-8]/block0 to
parity/block0).

it is not clear to me what this setup would be enough better than what
the current setups.    Given that one could have 8 spin + 1ssd or 12
spin for the same price.    And 2 6 disk raid6's would have the same
usable space, and be pretty safe (can lose any 2 of the 6 and lose no
data).  And given the separate filesystems requirement that would
require some software above the filesystems to manage spreading the
disks across multiple filesystems.   The risk of another disk going
bad (while one was failed) and losing a disk's worth of data would
push me to use the 6-disk raid6.

WOL: current SSD's are rated for around 1000-2000 writes.  So a 1Tb
disk can sustain 1000-2000TB of total writes.  And writes to
filesystem blocks would get re-written more often than data blocks.
 How well it would work would depend on how often the data is deleted
and re-written.   If the disks are some sort of long term storage then
the SSD is not going to get used up.   And I am not sure if the rated
used up really means anything unless you are using a STUPID enterprise
controller that proactively disables/kills the SSD when it says the
rated writes have happened.   I have a 500GB ssd in a mirror that
"FAILED" according to smart 2 years ago and so far is still fully
functional, and it is "GOOD" again because the counters used to
determine total writes seems to have rolled over.

On Tue, Feb 14, 2023 at 8:23 PM Heinz Mauelshagen <heinzm@redhat.com> wrote:
>
> Roger,
>
> as any of the currently implemented 'parity' algorithms (block xor/P-/Q-Syndrome) provided by DM/MD RAID
> have to have at least two data blocks to calculate:  are you, apart from the filesystem thoughts you bring up, thinking
> about running those on e.g. pairs of disks of mentioned even numbered set of 8?
>
> Heinz
>
> On Tue, Feb 14, 2023 at 11:28 PM Roger Heflin <rogerheflin@gmail.com> wrote:
>>
>> On Tue, Feb 14, 2023 at 3:27 PM Heinz Mauelshagen <heinzm@redhat.com> wrote:
>> >
>>
>> >
>> >
>> > ...which is RAID1 plus a parity disk which seems superfluous as you achieve (N-1)
>> > resilience against single device failures already without the later.
>> >
>> > What would you need such parity disk for?
>> >
>> > Heinz
>> >
>>
>> I thought that at first too, but threw that idea out as it did not
>> make much sense.
>>
>> What he appears to want is 8 linear non-striped data disks + a parity disk.
>>
>> Such that you can lose any one data disk and parity can rebuild that
>> disk.  And if you lose several data diskis, then you have intact
>> non-striped data for the remaining disks.
>>
>> It would almost seem that you would need to put a separate filesystem
>> on each data disk/section (or have a filesystem that is redundant
>> enough to survive) otherwise losing an entire data disk would leave
>> the filesystem in a mess..
>>
>> So N filesystems + a parity disk for the data on the N separate
>> filesystems.   And each write needs you to read the data from the disk
>> you are writing to, and the parity and recalculate the new parity and
>> write out the data and new parity.
>>
>> If the parity disk was an SSD it would be fast enough, but if parity
>> was an SSD I would expect it to get used up/burned out from all of
>> parity being re-written for each write on each disk unless you bought
>> an expensive high-write ssd.
>>
>> The only advantage of the setup is that if you lose too many disks you
>> still have some data.
>>
>> It is not clear to me that it would be any cheaper if parity needs to
>> be a normal ssd's (since ssds are about 4x the price/gb and high-write
>> ones are even more) than a classic bunch of mirrors, or even say a 4
>> disks raid6 where you can lose any 2 and still have data.
>>
