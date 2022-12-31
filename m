Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6770265A3D8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 12:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiLaL6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 06:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLaL6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 06:58:12 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016BD6456
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 03:58:09 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id s127so9622312vsb.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 03:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cOrnvI0ab6Sjve5sOQHxemo9n/r3kg6EiJp9vkQUJjM=;
        b=MtKezjvPIsHhRoyFqHNbSAluvUbAQU6kH+LAM/3u5vWixb6DiaWyZerKZFFQAg0LTQ
         fuO9GKZZprt6hTT+8iQS2E4OTIg0FmmmGdjk4MehZlxsd+OTZe+QYa9n10Skw5HAJUfA
         mQ5C1IIVo/HURbj1GJZ3nezHvleoDkvknhKsnHKiof3DXn/DfRQSAF0VpY1sCLZgXzv5
         9U/uasy4pimNgWibwyjcskQFYzAKTU+GKJyPr1S4MVedrfCugz67m6ao+9ukPscUHInX
         GCg8NoPMirml/W5MORry72hXqJDdQgWYsFNtsjNv0MkAdEVCvZ2WwUSbC7P/mCGKSRlN
         hFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOrnvI0ab6Sjve5sOQHxemo9n/r3kg6EiJp9vkQUJjM=;
        b=s/3aYjlEoIDTdTbgJ+jTj7MYC67UZ4QESKHcnqe9XeoXwo2cC1qbuXroRUBkQEOJLK
         IEgOhDGpDueEP7Sn0ZJpgHOIx+Qn/Mc/QwvxWRdR/VJovQM++xRM5HIESq0OwjWIm5LP
         EbztMzeAg6OMFMqcSqU17ZoOiUo7QlD7BwAqE+sDe8zAFs6+u5sTVpxZUp5tbF7j1RFA
         P2vpArLx1TprFHfrMK1TNTNU3MwSr7keXhwO7QzxyMEsNz2BhD3Z9WILPemnS6YinLSP
         t7CcBllSVVsSNV3HoiIHfMPqc3xmLQp7mwS4yIN+/MAdwBoePDUSoQrGWZy01CQntbJm
         wV4A==
X-Gm-Message-State: AFqh2kquoBs8A4kKyQRBiVMRGPA9PDiMLXkBPBHhO9rP+LMQXt8PDlI0
        fvP5zwoNhHkz3EBK+L/kJ0V7FpPd+1cEJ9on0SwRMTpe
X-Google-Smtp-Source: AMrXdXvmrFy/BahM6IhJ/dZcwp0qFkpovr9HhfOLOhDeYWbvUZXOjO5a/9D8fhZSd28YTNZEJ7ujRNGogWc/fSYVlSE=
X-Received: by 2002:a67:ee93:0:b0:3b2:a92d:a1f0 with SMTP id
 n19-20020a67ee93000000b003b2a92da1f0mr4111536vsp.46.1672487888989; Sat, 31
 Dec 2022 03:58:08 -0800 (PST)
MIME-Version: 1.0
References: <CAAJw_Ztzyh-GNTJYpXbA0CeJv2Rz=fLZKE6_Q=7JMmM+s9yHXQ@mail.gmail.com>
 <CAAJw_Ztb0mJVkHtBhryf=9g8CA0fZZRa8HVio8GCGUSLOvqa7A@mail.gmail.com>
 <Y6bz4wOC0nwu2yGU@debian.me> <0c70ba66-ef00-7242-d198-844f803662fa@gmail.com>
 <CAAJw_Zv0iBg4rkzxQ2UOOLS9JQZ4cCmM7gSoDXec_gm-GggB6A@mail.gmail.com>
 <f500d64b-c26d-ee34-092a-421c64c69f9e@leemhuis.info> <Y66Hk6waTeXQDz1/@sol.localdomain>
 <3dd9808e-ffbd-7959-2111-a9f13f2031f1@kernel.org>
In-Reply-To: <3dd9808e-ffbd-7959-2111-a9f13f2031f1@kernel.org>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Sat, 31 Dec 2022 19:57:58 +0800
Message-ID: <CAAJw_ZsLjw=+_oju-8Mxy-nEErUYc9ZPfDyX204yiJ7mA8u5gA@mail.gmail.com>
Subject: Re: Fwd: f2fs write error Linux v6.2
To:     Chao Yu <chao@kernel.org>
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

On Sat, Dec 31, 2022 at 10:51 AM Chao Yu <chao@kernel.org> wrote:
>
> Hi Jeff,
>
> On 2022/12/30 14:39, Eric Biggers wrote:
> > If you could provide the mkfs and mount options you are using, and any other
> > relevant details, that would be helpful.  Bisection would also be very helpful,
> > as Thorsten mentioned.

I was just preparing my environment so I could hit the same issue
before I go for the bisect, so I don't need to reboot every time. Got
to a point where I could just qemu kvm + initrd ramdisk with / (f2fs)
and I could hit the problem almost every 8/10 runs just by doing
"mount -o remount /" and the system would freeze. That's good. I've a
good test case! ... and then I see Chao Yu's patch ...

> Other than that, I found some cases which can cause similar issue, so I figure
> out a patch for possible fixing, if you can have a try with it to check whether
> it can fix your issue, that would be helpful as well.
>
> https://lore.kernel.org/linux-f2fs-devel/20221230154332.5082-1-chao@kernel.org/T/#u

Ok, the patch seems to fix the problem. I'll run my qemu kvm
environment a few more times before I switch the real system. Because
it's not a that I could cause a real "mount -o remount /" freeze or
"vi /etc/passwd" fault all the time,

Will feedback soon. This would a very nice year end celebration so I
could move to 6.2.0-rc1.

Thank you!

Jeff
