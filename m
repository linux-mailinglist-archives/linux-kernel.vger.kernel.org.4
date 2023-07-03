Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56907460E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGCQpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:45:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C79E4C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 09:45:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbd200d354so126645e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688402751; x=1690994751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIZi7WSUj5zt9VC6bktr7YIsYiDd+mTiSVUb4X7VtZ0=;
        b=jYXFWK6VOpcbn+eI6/P+dWhvQNc85l3QYtlgjNcpNGaVWfeh3UJvBx8ikx/gci5Lqp
         CWH+MVIBPZF2rmaHMyLs1frMOfPg1UbY6KbhFQDUHN3J4oMz7aKvix9uzLfmnlm6v6Hx
         YgNqx6qnHG3vJEclkN6NaOiiDGsCctGDPcrPLhyT+Xwo/5EDu4/FZLp8Ju+YJvBmy/Kb
         Y5D4O59TZlrt9x3puMA+/hVNMkJm2d+xxYF7l0hQpjjWvVV9MvBzhrUgnYVhU9XnRQZa
         yqbRR1gx4Gc+ltHUXfS5F0F8Q+SCnl+E0rgZn8i8Gwpj/on1h9z7U0UmIVe7ko5k5voK
         Aeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688402751; x=1690994751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIZi7WSUj5zt9VC6bktr7YIsYiDd+mTiSVUb4X7VtZ0=;
        b=YDtVyyZbQ0BvPpd9vG8v3ELoQQVnlqq6rMyuc41vkN4dTT8/c1IJYhrwVdNrmZLM0W
         1M0Es6WwKPAAUl1jhfmWIZbmXCq5YLXlGld0qQKen+kHzE1Yu2VXy2s7zmTnwfnMqyeV
         AHeBeys7Lh3TeYJwRbAlbJY/lhee3JLOzae2lV4YjhzVmlWBIP4E6fKR4hd9e5qIUdwn
         ynknDAmyZ6Dz1IBfuWmNEbgbEsa6zKtWBWoPOM9qW+Ix3Bttn/s03q1BH07o0GpHPLif
         Dy8U6VlGbwanakUYXG5nx9TPzmvLHQji13KEAkrOLsaJttAUt38NbG4z1LgDKQHNNOKY
         stng==
X-Gm-Message-State: ABy/qLYPyZfFiNVZ0zocyQ61qZer5wND6+pWiQH4Dif62iS8QfKs4vwh
        j9Jr8ScN/G85uuNq1SuiX2RNkXlo/AUv0eAKbFWXAg==
X-Google-Smtp-Source: APBJJlHX0y4s+ANB3JfUPXoeBFi0QrSiAmjRJP4Q82Rb+fE8gIq2PIexpyRlwOsJIBKCMdtRpRZ5fuWw7sWJmUqulrY=
X-Received: by 2002:a05:600c:3b08:b0:3fb:c838:c681 with SMTP id
 m8-20020a05600c3b0800b003fbc838c681mr197236wms.4.1688402751236; Mon, 03 Jul
 2023 09:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003dab1305ff859d21@google.com> <20230702195130.GAZKHVQnvKIjc9FB05@fat_crate.local>
In-Reply-To: <20230702195130.GAZKHVQnvKIjc9FB05@fat_crate.local>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 3 Jul 2023 18:45:39 +0200
Message-ID: <CANp29Y4ySB6_s8zqO3zgskzx5y6ECUVobYxje-k3V2hSEiULGQ@mail.gmail.com>
Subject: Re: [syzbot] upstream build error (20)
To:     Borislav Petkov <bp@alien8.de>
Cc:     syzbot <syzbot+3ea47fc22e48e9ec4324@syzkaller.appspotmail.com>,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 2, 2023 at 9:51=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Sun, Jul 02, 2023 at 11:56:57AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    77b1a7f7a05c Merge tag 'mm-nonmm-stable-2023-06-24-19-2=
3' ..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1701aabd280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ddbdd409f194=
c6563
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D3ea47fc22e48e=
9ec4324
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binu=
tils for Debian) 2.35.2
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+3ea47fc22e48e9ec4324@syzkaller.appspotmail.com
> >
> > ./arch/x86/include/asm/mem_encrypt.h:23:20: error: static declaration o=
f 'mem_encrypt_init' follows non-static declaration
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the bug is already fixed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to change bug's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the bug is a duplicate of another bug, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
>
> #syz fix: 0a9567ac5e6a ("x86/mem_encrypt: Unbreak the AMD_MEM_ENCRYPT=3Dn=
 build")

Thank you for letting syzbot know the fixing commit!
Syzbot expects to see only the title, so here's an update:

#syz fix: x86/mem_encrypt: Unbreak the AMD_MEM_ENCRYPT=3Dn build

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>
> --
