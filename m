Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40FA70F094
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbjEXIY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbjEXIYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:24:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1C01A4
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:24:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f1217f16e9so1212e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684916684; x=1687508684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RtszprC6DzRLbG0ispzYFYS8wzl447D3eL8AdqyasE=;
        b=R1Ngd5KfBHhoR+GO+dvWzGuur8Vrd6c4NYVGe7aruFtF47hE+4EHPplsEx9Ggh5wwm
         7QLP9lURwE6Tbvkus/tYEPxzKjzisveZlORA6QtKKz0hRwrn5AGjU4RLB8hlW5rm90p1
         ljUqXRRd5Cz+V2wXIKvhr99niFRkauTOBvOBkn3oiLWyphNqFjF5AWZ9Oq8PzGMRwpb/
         FaxJX63CqnWtV48RD4LilzOQC516Waq48onYtDAwr5Zb5EU50NMomkZgyXZAs96xhRGD
         VqIwPbDzoA7ho/XgYwPaRzSCGSUgRk7TV9/iQOGmniAwDWX8ySyxhxX0GaCswAG5lwSe
         vvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684916684; x=1687508684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RtszprC6DzRLbG0ispzYFYS8wzl447D3eL8AdqyasE=;
        b=Fm1AQE/vtxWVNYdT5w45X+lUbJJEPslVJvHLDcYY8xtumLZzrl1f3EvIsD02rCTLGr
         5Fcrilgs8x/OWaPHf0v8G0zBeLxJWXnNsf1RzeFg0ofnMv8MDPX59tGQf0oukmwQWgVj
         1YgA9jh9b11F1P1mrU/Az/gNwDTGZCJbCEJ1nyslql54ZrJc3Rmhjvc2N4mxopQw0V4i
         cCMpGpeHnuovRimQKttJY7hBy+X/Kq1NUXlWBR2PPZWnIlVck0jNc6hBUcsAiX5idcAb
         Wx9iTYVoFA1espHlShJ9Sw6UVXfugWLrYI54Ub3MIo4IJmeOywOleebGi/CusSgBbgrj
         6NIg==
X-Gm-Message-State: AC+VfDwTe5A/4CgapJdaycU0L1NGJiT6vlp3HW/fO8JTzWtdS72blZx8
        DHJayrTq9yJsvzu4b1onW3ys6/z1yYnFiTkOIB0uaQ==
X-Google-Smtp-Source: ACHHUZ6tGZ0d+SHBtkkFPVWYkItO9PJtj5bJYjh8QNcwjAwNan5vTxwhzhMX7pQTPHXPZyQIZObczBy/rQ0vasV0OyE=
X-Received: by 2002:a05:6512:799:b0:4f2:5cf0:36fd with SMTP id
 x25-20020a056512079900b004f25cf036fdmr54112lfr.5.1684916684162; Wed, 24 May
 2023 01:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c0b11d05fa917fe3@google.com> <ZGzfzEs-vJcZAySI@zx2c4.com>
 <20230523090512.19ca60b6@kernel.org> <CANn89iLVSiO1o1C-P30_3i19Ci8W1jQk9mr-_OMsQ4tS8Nq2dg@mail.gmail.com>
 <20230523094108.0c624d47@kernel.org> <CAHmME9obRJPrjiJE95JZug0r6NUwrwwWib+=LO4jiQf-y2m+Vg@mail.gmail.com>
 <20230523094736.3a9f6f8c@kernel.org> <ZGzxa18w-v8Dsy5D@zx2c4.com>
 <CANn89iLrP7-NbE1yU_okruVKqbuUc3gxPABq4-vQ4SKrUhEdtA@mail.gmail.com> <CANn89iKEjb-g1ed2M+VS5avSs=M0gNgH9QWXtOQRM_uDTMCwPw@mail.gmail.com>
In-Reply-To: <CANn89iKEjb-g1ed2M+VS5avSs=M0gNgH9QWXtOQRM_uDTMCwPw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 24 May 2023 10:24:31 +0200
Message-ID: <CACT4Y+YcNt8rvJRK+XhCZa1Ocw9epHg1oSGc28mntjY3HWZp1g@mail.gmail.com>
Subject: Re: [syzbot] [wireguard?] KASAN: slab-use-after-free Write in enqueue_timer
To:     Eric Dumazet <edumazet@google.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jakub Kicinski <kuba@kernel.org>,
        syzbot <syzbot+c2775460db0e1c70018e@syzkaller.appspotmail.com>,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, wireguard@lists.zx2c4.com, jann@thejh.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 at 19:07, 'Eric Dumazet' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Tue, May 23, 2023 at 7:05=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, May 23, 2023 at 7:01=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4=
.com> wrote:
> > >
> > > On Tue, May 23, 2023 at 09:47:36AM -0700, Jakub Kicinski wrote:
> > > > On Tue, 23 May 2023 18:42:53 +0200 Jason A. Donenfeld wrote:
> > > > > > It should, no idea why it isn't. Looking thru the code now I do=
n't see
> > > > > > any obvious gaps where timer object is on a list but not active=
 :S
> > > > > > There's no way to get a vmcore from syzbot, right? :)
> > > > > >
> > > > > > Also I thought the shutdown leads to a warning when someone tri=
es to
> > > > > > schedule the dead timer but in fact add_timer() just exits clea=
nly.
> > > > > > So the shutdown won't help us find the culprit :(
> > > > >
> > > > > Worth noting that it could also be caused by adding to a dead tim=
er
> > > > > anywhere in priv_data of another netdev, not just the sole timer_=
list
> > > > > in net_device.
> > > >
> > > > Oh, I thought you zero'ed in on the watchdog based on offsets.
> > > > Still, object debug should track all timers in the slab and complai=
n
> > > > on the free path.
> > >
> > > No, I mentioned watchdog because it's the only timer_list in struct
> > > net_device.
> > >
> > > Offset analysis is an interesting idea though. Look at this:
> > >
> > > > The buggy address belongs to the object at ffff88801ecc0000
> > > >  which belongs to the cache kmalloc-cg-8k of size 8192
> > > > The buggy address is located 5376 bytes inside of
> > > >  freed 8192-byte region [ffff88801ecc0000, ffff88801ecc2000)
> > >
> > > IDA says that for syzkaller's vmlinux, net_device has a size of 0xc80
> > > and wg_device has a size of 0x880. 0xc80+0x880=3D5376. Coincidence th=
at
> > > the address offset is just after what wg uses?
> >
> >
> > Note that the syzkaller report mentioned:
> >
> > alloc_netdev_mqs+0x89/0xf30 net/core/dev.c:10626
> >  usbnet_probe+0x196/0x2770 drivers/net/usb/usbnet.c:1698
> >  usb_probe_interface+0x5c4/0xb00 drivers/usb/core/driver.c:396
> >  really_probe+0x294/0xc30 drivers/base/dd.c:658
> >  __driver_probe_device+0x1a2/0x3d0 drivers/base/dd.c:800
> >  driver_probe_device+0x50/0x420 drivers/base/dd.c:830
> >  __device_attach_driver+0x2d3/0x520 drivers/base/dd.c:958
> >
> > So maybe an usbnet driver has a timer_list in its priv_data.
>
> struct usbnet {
> ...
> struct timer_list   delay;

FWIW There are more report examples on the dashboard.
There are some that don't mention wireguard nor usbnet, e.g.:
https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D17dd2446280000
So that's probably red herring. But they all seem to mention alloc_netdev_m=
qs.
Let's do for now:
#syz set subsystems: net
