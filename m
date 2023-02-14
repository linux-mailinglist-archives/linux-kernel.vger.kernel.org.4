Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8DF6970BE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjBNW2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBNW2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:28:48 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EE5265B5;
        Tue, 14 Feb 2023 14:28:47 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id d66so18033020vsd.9;
        Tue, 14 Feb 2023 14:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676413726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=plqHRAI8Pfx3LpYamylhfhBOqt+fLpnOArGMZObrn2U=;
        b=jT58V1SM8NDSjV4vkW9fRK0Lqw/waIGvOwskkhzhojXB82nrKvVMJQGwzBvI3iHRFL
         gry/nNrTImt2DSKPWAfL1clGjA0Mo68DXH9pL8NgqRv9i0gz3oPvr/NJYUZK0wsRsvXf
         fvTRBgNmVQYTKaoB6StOVR2k6AfxHpfL78Rv2uuAplNVFxgddeelRhg7ZPcT5cJjasDu
         mAd5JYO/HvyYYv0IF0Um3T93uuTzfuB01XJggWYCRJObpPWDNchJLI+wyKWSv47pgIML
         xCnQJWmxlLOqsxMSGH7NBsJBr/+YLxk8Mi3ldhRTDqI2gR+GRwzPcwMOArwauThEKALS
         z7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676413726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plqHRAI8Pfx3LpYamylhfhBOqt+fLpnOArGMZObrn2U=;
        b=Ll0Wn6wfYt4RPafxzF+FbCE/iY6+5l6GKgoeC90pzdYwPqI7rBPPsrXsI4eSVkjcZz
         TuvGbAj5tOYhekX1yUuI1XzeDZ+pXvGRIHm3U5H3neUDHTI4d0fPqq54chVTKF21utWo
         662YZMt5P2im1wpro741y0kpL2+mUVa9Z5DRwrYMF/Tu+1vdY2tJLwErymhwA1LHkZbA
         0Xp/PAVXL0SUliy9DywdgpJWFpW80wFyGaJP7316d3BJC98QS2qV7RhkdjSQxFaScCAg
         AFMiaoDgduFSuTmIFRSZaXeW1TAmohuxuhZhRQ4OAQUKsXsQTDgrrW3rFrMjHd7Q5zQY
         HP2A==
X-Gm-Message-State: AO0yUKXYezB+hk2zSBRtvdNu6DkvIW+aDk7hY3g6vW7/SKvprsDOGQZY
        2zd5m9szTdzVr1FlN4FRWH3JP11uejgt6XotKsGY2vwFMd0=
X-Google-Smtp-Source: AK7set/44hMy5ENsS6Z0/yejw8yOcoTBn/fVLjtxEYcM/BoKHwiJZY7crwQgI4SNayyqUDqO7Ab9vCsO4V6WthLRU8c=
X-Received: by 2002:a67:e0cf:0:b0:3fc:3a9e:3203 with SMTP id
 m15-20020a67e0cf000000b003fc3a9e3203mr73221vsl.84.1676413726415; Tue, 14 Feb
 2023 14:28:46 -0800 (PST)
MIME-Version: 1.0
References: <CACsaVZJvXpCt37nQOoe8qd1EPUpfdMM1HwHk9tVO8HdU_Azhhw@mail.gmail.com>
 <25578.37401.314298.238192@quad.stoffel.home> <CACsaVZJ-5y7U5xqwL9bof69EKbTk+wrHWFcBFYyP_BwVSt+CNA@mail.gmail.com>
 <CAM23Vxr8LkkcVDFfW1=qEYGgo7JG1qx62eWSV4WOw4_MnD+TZA@mail.gmail.com>
In-Reply-To: <CAM23Vxr8LkkcVDFfW1=qEYGgo7JG1qx62eWSV4WOw4_MnD+TZA@mail.gmail.com>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Tue, 14 Feb 2023 16:28:36 -0600
Message-ID: <CAAMCDeeHxMBoVkNYAyssjgjo4=FYd2NonS-mqC7OUEL89B9Cig@mail.gmail.com>
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

On Tue, Feb 14, 2023 at 3:27 PM Heinz Mauelshagen <heinzm@redhat.com> wrote:
>

>
>
> ...which is RAID1 plus a parity disk which seems superfluous as you achieve (N-1)
> resilience against single device failures already without the later.
>
> What would you need such parity disk for?
>
> Heinz
>

I thought that at first too, but threw that idea out as it did not
make much sense.

What he appears to want is 8 linear non-striped data disks + a parity disk.

Such that you can lose any one data disk and parity can rebuild that
disk.  And if you lose several data diskis, then you have intact
non-striped data for the remaining disks.

It would almost seem that you would need to put a separate filesystem
on each data disk/section (or have a filesystem that is redundant
enough to survive) otherwise losing an entire data disk would leave
the filesystem in a mess..

So N filesystems + a parity disk for the data on the N separate
filesystems.   And each write needs you to read the data from the disk
you are writing to, and the parity and recalculate the new parity and
write out the data and new parity.

If the parity disk was an SSD it would be fast enough, but if parity
was an SSD I would expect it to get used up/burned out from all of
parity being re-written for each write on each disk unless you bought
an expensive high-write ssd.

The only advantage of the setup is that if you lose too many disks you
still have some data.

It is not clear to me that it would be any cheaper if parity needs to
be a normal ssd's (since ssds are about 4x the price/gb and high-write
ones are even more) than a classic bunch of mirrors, or even say a 4
disks raid6 where you can lose any 2 and still have data.
