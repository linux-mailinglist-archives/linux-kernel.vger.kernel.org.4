Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9A27054E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjEPRXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEPRXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:23:43 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21231195
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:23:42 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-335d6260e9bso10685ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684257821; x=1686849821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtLDMIe167B85U/+GfK+jGRGZasQjZejfPs58zT2nPo=;
        b=wTc2x7001d8gBrfDrm+5jQkRDAjYgsBFeRgu1lN7P4Sox5fk/y11Wdh/ge45c1aAXt
         DpGFODbpp3VrBb64VCHyh5e2EKkjsBEDGuqkseD+j5BZhmyOlsPNb7JEy1vi0bKX8ByO
         twedDomMdgmcHRS0hoF49Zq3ZHAvcs0JW7Ga07dt/rF2VsoFkR0fJPFssK68PBERL5jJ
         nTdJov1eSvobo3/f2b24SqBV+NZz+KyPsuJyF1PuU+g5XP/ZzSAp2jPUIZJ6RFHZXQtH
         jOi6n7ZBsRSuJqY0cMwdHRSZXCokCiGVvWYcf0G2XTB24EpE38gWg8OU4vdzc4yeijhd
         Ae8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684257821; x=1686849821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtLDMIe167B85U/+GfK+jGRGZasQjZejfPs58zT2nPo=;
        b=WO4Diyk4IV0jQeKlHwyFnhG4K/fcKLeGlfyfXBW+Qs5fJC1o8/EPvgfHun2tS9W845
         eRDeHinOYh2AQ5vsXfOxdP7Dm7SCRFaUStivYGZ7lEx4p5Kc0emNXeCT+6w8YSeZ8mML
         VOzX57QKpYo6MBGrxoBAwEv3vUI2xhTQP3vRmlmMyOtOSVvQxqKMZ1Fm094nACPEr1I3
         5KHt1LrXv2D+DAorzqRoFpWuA+OzFBczvxWNPPlpIQRuUF8ApYNW3xBCrBQMaE6uyx5v
         YFrCqKFK+MVoOBsf//HQ2yPJRv+tTKEVS3G1q+TGDR1EoThedTBFvHkWAiHSdV0vxXJb
         Q+7w==
X-Gm-Message-State: AC+VfDxaUaoDWB1zgS+vXj7OXiSl5rp6MogLm7dMmN0GZ8kxVWXP7Mtd
        AIodNGRBbd3WoM4/CTc6H6ILng3bqWTCOazjVnTJ1g==
X-Google-Smtp-Source: ACHHUZ7+MXQY9FJvb+Jjv5Z5fAz6w/bKyOgU/LvgEVB1XBAqnx5OkYRYC0MW/bS6u9VrrsaWcBpvYyxo7Ernz9EYzmU=
X-Received: by 2002:a05:6e02:1bc3:b0:335:5c4b:2f8a with SMTP id
 x3-20020a056e021bc300b003355c4b2f8amr246921ilv.5.1684257821269; Tue, 16 May
 2023 10:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bff72505fbcd1f74@google.com> <000000000000bc152005fbcd1fa2@google.com>
 <20230516-saftig-einbog-ef2981f0dec2@brauner>
In-Reply-To: <20230516-saftig-einbog-ef2981f0dec2@brauner>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 16 May 2023 19:23:30 +0200
Message-ID: <CANp29Y7ktmz=W5F+uavDa1KzSnUnBHtrH2abHRqAjuWZkJdgxw@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] Internal error in should_fail_ex
To:     Christian Brauner <brauner@kernel.org>
Cc:     syzbot <syzbot+c84b326736ee471158dc@syzkaller.appspotmail.com>,
        syzbot <syzbot+729f1325904c82acd601@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 2:32=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, May 16, 2023 at 03:35:03AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    457391b03803 Linux 6.3
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15671fa2280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D385e197a58c=
a4afe
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc84b326736ee4=
71158dc
> > compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110=
, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/c35b5b2731d2/non_bootable_disk-457391b0.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/2a1bf3bafeb6/vmli=
nux-457391b0.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/21f1e3b4a5a9=
/zImage-457391b0.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+c84b326736ee471158dc@syzkaller.appspotmail.com
>
> On Tue, May 16, 2023 at 03:35:02AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    457391b03803 Linux 6.3
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D134e0b01280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D385e197a58c=
a4afe
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D729f1325904c8=
2acd601
> > compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110=
, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D118f964e2=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16f6e776280=
000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/c35b5b2731d2/non_bootable_disk-457391b0.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/2a1bf3bafeb6/vmli=
nux-457391b0.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/21f1e3b4a5a9=
/zImage-457391b0.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+729f1325904c82acd601@syzkaller.appspotmail.com
>
> Not complaining but why am I blessed with an explicit Cc on this?
>

You were Cc'd because syzbot incorrectly identified the guilty file
for the bug, I've sent a fix [1].
Sorry for the noise.

[1] https://github.com/google/syzkaller/pull/3905

--=20
Aleksandr
