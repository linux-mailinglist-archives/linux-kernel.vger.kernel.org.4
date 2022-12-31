Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4278F65A422
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 13:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiLaMls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 07:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiLaMlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:41:47 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4268BDD5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:41:46 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id m129so17858029vsc.11
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dhd/1RDPWdGhndisco2GPJg8lagzsvfapqotzaFZeN0=;
        b=KlA6GR9uSv47bhi4irs+lJ4qtPQXyHlhcdsEplotgdA8ieXoiqtcqMlxIAyrX/s3mH
         gvETGpe5A9WF70ZvC1D2WGI+Q65qrB891YSRIJR5/PIOhjARH4NzsHQUqMqtz1HaNCM3
         OI35+HdTcKpNWFXdH5/5nd7L5P4gYz9N6wNz5QmQfgCuuV9tCmoTlV5t+9VQTAtSCePk
         3WvXlOQaWd53SMvgvV0d2AjQpyd9ak9OAJ8vq1Az9YpailVU6xAIfeIJ8f3tgDUBlVBj
         0trUHKAazvVf2iQUTV6b8xyLM6b6/FkIpAc92DqPQve3g64iJLw2Cui6h41Fxiq9xtwA
         sTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dhd/1RDPWdGhndisco2GPJg8lagzsvfapqotzaFZeN0=;
        b=GPlADY0FKQv/5Lq7LD4rGDN6wwK0EUunz5Mv98FjZHbOX9fVuhjhl6bFmjPn1mdx3c
         oIYakMwDsthTQPnIR16UF1RTDpzP6qRQeM4Tz5Otj7G4i/Wszc8CU4mj+B6dkOKgid28
         Mo7mZoqetPoBFhwoObtNwXRqcGWmww6C0wuN/DKOTxeM6oJspcaJomA65UZsTtpiU/UW
         D8RqNLU4dI4NuV+1ftg8vi8PB5EEdsVD0jikO/Kco4LDEccRraFg8cILTG5f26VofPUd
         Hn2EYb5fjByg3xD1ygCq0HxlIzFvKISHuFm0dqfWUfd//7l2bzGjRSTQJgrQqz9nC9Hh
         o1dw==
X-Gm-Message-State: AFqh2kpgIpvotjNDZ8kdEhJDxeLASjTph+A/jp5dkGNKLPYHsyVR0Av3
        jUGXEh0av/RQFncwioqbwZPmteoa2KJ/IBaJLGk=
X-Google-Smtp-Source: AMrXdXssK+4FN6JAbwXkx/gRsPfboiOtjxI12zKDRLjV4MNwgLqRUEvHm2L2Mw5x7Vn2TeD4PxatDeWhe7wfdR2sQ7M=
X-Received: by 2002:a67:fd48:0:b0:3c9:59f7:2486 with SMTP id
 g8-20020a67fd48000000b003c959f72486mr1795232vsr.50.1672490505235; Sat, 31 Dec
 2022 04:41:45 -0800 (PST)
MIME-Version: 1.0
References: <CAAJw_Ztzyh-GNTJYpXbA0CeJv2Rz=fLZKE6_Q=7JMmM+s9yHXQ@mail.gmail.com>
 <CAAJw_Ztb0mJVkHtBhryf=9g8CA0fZZRa8HVio8GCGUSLOvqa7A@mail.gmail.com>
 <Y6bz4wOC0nwu2yGU@debian.me> <0c70ba66-ef00-7242-d198-844f803662fa@gmail.com>
 <CAAJw_Zv0iBg4rkzxQ2UOOLS9JQZ4cCmM7gSoDXec_gm-GggB6A@mail.gmail.com>
 <f500d64b-c26d-ee34-092a-421c64c69f9e@leemhuis.info> <Y66Hk6waTeXQDz1/@sol.localdomain>
 <3dd9808e-ffbd-7959-2111-a9f13f2031f1@kernel.org> <CAAJw_ZsLjw=+_oju-8Mxy-nEErUYc9ZPfDyX204yiJ7mA8u5gA@mail.gmail.com>
In-Reply-To: <CAAJw_ZsLjw=+_oju-8Mxy-nEErUYc9ZPfDyX204yiJ7mA8u5gA@mail.gmail.com>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Sat, 31 Dec 2022 20:41:34 +0800
Message-ID: <CAAJw_ZvFvKx+mVd+pWMPVvEnOPkmBBETMqrA_P-3wRGW5HRkDw@mail.gmail.com>
Subject: Re: Fwd: f2fs write error Linux v6.2
To:     Chao Yu <chao@kernel.org>, Yangtao Li <frank.li@vivo.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Eric Biggers <ebiggers@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        F2FS Development <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Regressions <regressions@lists.linux.dev>
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

On Sat, Dec 31, 2022 at 7:57 PM Jeff Chua <jeff.chua.linux@gmail.com> wrote:
>
> On Sat, Dec 31, 2022 at 10:51 AM Chao Yu <chao@kernel.org> wrote:
> >
> > Hi Jeff,
> >
> > On 2022/12/30 14:39, Eric Biggers wrote:
> > > If you could provide the mkfs and mount options you are using, and any other
> > > relevant details, that would be helpful.  Bisection would also be very helpful,
> > > as Thorsten mentioned.
>
> I was just preparing my environment so I could hit the same issue
> before I go for the bisect, so I don't need to reboot every time. Got
> to a point where I could just qemu kvm + initrd ramdisk with / (f2fs)
> and I could hit the problem almost every 8/10 runs just by doing
> "mount -o remount /" and the system would freeze. That's good. I've a
> good test case! ... and then I see Chao Yu's patch ...
>
> > Other than that, I found some cases which can cause similar issue, so I figure
> > out a patch for possible fixing, if you can have a try with it to check whether
> > it can fix your issue, that would be helpful as well.
> >
> > https://lore.kernel.org/linux-f2fs-devel/20221230154332.5082-1-chao@kernel.org/T/#u
>
> Ok, the patch seems to fix the problem. I'll run my qemu kvm
> environment a few more times before I switch the real system. Because
> it's not a that I could cause a real "mount -o remount /" freeze or
> "vi /etc/passwd" fault all the time,
>
> Will feedback soon. This would a very nice year end celebration so I
> could move to 6.2.0-rc1.

Ok, no more freeze, no more errors! All good. I'm finally on the
latest linux-6.2.0-rc1 with the patch.

Happy new year!

My best,
Jeff
