Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B136F846D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjEEOAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjEEOAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:00:14 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FE6160A5
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 07:00:11 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3ef31924c64so1068731cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683295211; x=1685887211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrLbgEypMXUR0be5NOYr7LBZ0MRW/RtqFqY+xIYHF24=;
        b=i30B8pR+6HSlbcWAO/EL84+Ac35ia7BV/4e2yziWa1ZBl47tfYezFk5Y+3rc20jb+p
         a1NeeB+Z84SK88DWkh1/WlkyZqfeYmSPptWtKzmQCd8PqbxZ7mSA4Om8JC1KhJBmz4Jk
         7FqzXjuVnqKM16sdjJkvoSBBZaX34Q5sMvDHLQUD6yRv2cFH29I31HbtHE15xOl7/gsO
         bnLI7blGxNvr1PitRj9/wPWjtg0YUIQK9x7Yj8gWEJRGpZzjEj2Ist3Rql9pVms95gxc
         QTr4LuidqL9hIi+dos/ZA0RYTgdB0k31RBasA2c7Lazs8FqtjTJHb9YZ5v+2NbvqkqH6
         ljnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683295211; x=1685887211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrLbgEypMXUR0be5NOYr7LBZ0MRW/RtqFqY+xIYHF24=;
        b=UYyGLUI/DngT7cqNnQYRAZoSXkUsTOv5yXC4m8Pcr+TKO//SrtTQvVtTdAVKzWq2gr
         diPWML5q7SZfbKnoi4OWD3HyaHQKfIUrgs/TNYabdLy3+W3H2bbT0DkcB582QKhSabtx
         JPfA0LIhqewrs2TlYQ6HYTRd1WPeCqSFFluK69y0uVkwq8bcSwWtGCQQfrzrJPeXgSTV
         4qvjaa9T8iJbz/rNnuKg8wKr3KipNillL0FWk40bjDbjOa9Np5up6zgRgW+7gk97Fq0l
         2NX6TkB5Kdr3NMWR6bDsl2H35LVPoQW+ZGVb5xFpricl//g+9jpJPM3e1l42tVJwq3fE
         m58w==
X-Gm-Message-State: AC+VfDxVMgIm8hNtK7ciXGwVmEouAdt3S//z+Z2EQo7RVwf6ILm5FgSb
        uj9Luq2HjRArUuvBR6EV5iy07sjktbf4npLgQ0tZQA==
X-Google-Smtp-Source: ACHHUZ7c2G+VcLtHXD244DrbWdPB++ALpPBmaOHsGtb5snqaD3lCh3tuVyrMTf+OTqJWHoigB7dTs0Kf1YRElcaAqaQ=
X-Received: by 2002:a05:622a:1a1b:b0:3ed:86f6:6eab with SMTP id
 f27-20020a05622a1a1b00b003ed86f66eabmr220534qtb.14.1683295210527; Fri, 05 May
 2023 07:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008acbdb05faf2961c@google.com>
In-Reply-To: <0000000000008acbdb05faf2961c@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 5 May 2023 15:59:59 +0200
Message-ID: <CANp29Y41R-h7oyE-Wva4FHrsK5vxTgO6AOXhwCact=y-qCXFRg@mail.gmail.com>
Subject: Re: [syzbot] Monthly xfs report (May 2023)
To:     syzbot <syzbot+list457a2ec8617806111bfa@syzkaller.appspotmail.com>
Cc:     djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Some of these bugs were previously triaged by Darrick J. Wong. Now
that it has become possible to disable reminders for individual bugs,
let's do it for the ones deemed "Not a bug" here:
https://lore.kernel.org/all/20230411013512.GX3223426@dread.disaster.area/

On Fri, May 5, 2023 at 3:51=E2=80=AFPM syzbot
<syzbot+list457a2ec8617806111bfa@syzkaller.appspotmail.com> wrote:
>
> Hello xfs maintainers/developers,
>
> This is a 31-day syzbot report for the xfs subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/xfs
>
> During the period, 3 new issues were detected and 2 were fixed.
> In total, 22 issues are still open and 18 have been fixed so far.
>
> Some of the still happening issues:
>
> Ref Crashes Repro Title
> <1> 560     Yes   INFO: task hung in xlog_grant_head_check
>                   https://syzkaller.appspot.com/bug?extid=3D568245b88fbae=
dcb1959

#syz set <1> no-reminders

> <2> 501     No    KMSAN: uninit-value in __crc32c_le_base (3)
>                   https://syzkaller.appspot.com/bug?extid=3Da6d6b8fffa294=
705dbd8
> <3> 128     Yes   KASAN: stack-out-of-bounds Read in xfs_buf_lock
>                   https://syzkaller.appspot.com/bug?extid=3D0bc698a422b5e=
4ac988c
> <4> 110     Yes   INFO: task hung in xfs_buf_item_unpin
>                   https://syzkaller.appspot.com/bug?extid=3D3f083e9e08b72=
6fcfba2
> <5> 89      Yes   WARNING in xfs_bmapi_convert_delalloc
>                   https://syzkaller.appspot.com/bug?extid=3D53b443b5c6422=
1ee8bad

#syz set <5> no-reminders

> <6> 12      Yes   KASAN: null-ptr-deref Write in xfs_filestream_select_ag
>                   https://syzkaller.appspot.com/bug?extid=3D87466712bb342=
796810a
> <7> 11      No    KASAN: use-after-free Read in xfs_inode_item_push
>                   https://syzkaller.appspot.com/bug?extid=3Df0da51f81ea0b=
040c803
> <8> 7       Yes   KASAN: stack-out-of-bounds Read in xfs_buf_delwri_submi=
t_buffers
>                   https://syzkaller.appspot.com/bug?extid=3Dd2cdeba65d32e=
d1d2c4d
> <9> 2       No    WARNING in xfs_bmap_extents_to_btree
>                   https://syzkaller.appspot.com/bug?extid=3D0c383e46e9b48=
27b01b1
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> To disable reminders for individual bugs, reply with the following comman=
d:
> #syz set <Ref> no-reminders
>
> To change bug's subsystems, reply with:
> #syz set <Ref> subsystems: new-subsystem
>
> You may send multiple commands in a single email message.
>
