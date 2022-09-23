Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E775E7A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiIWMEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiIWMCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:02:18 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1E7138F24
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:58:30 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id m66so13397783vsm.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=QeQ7A4/9L+jEYAB7JYehSX041AgzGfugJpwYzn3Do9w=;
        b=VquBpd+zr50F8AZS1TFzN1h5qDzc9WwVKODyal6EIJnH4X+/1gwiBObkfNpNRSEMG9
         KSaeUgxbA+liR8gK2VrcRrCXWMvWfBUGMgIKV5hNJSCzUu06XDr1y45DAdH4CsdUfQpj
         7AzRKSqiPK5Dg3vYt/iyOssCnuU5vBqxce+PAEOJZblV0YapdYwk5XX2MxDFc68uu1j0
         O3q72XiOZ4pijjM4e7SXtPKyr7RwWbP3IwHe2MZmWQiZUSeLgqF90DDKvOSwQmrxRcpe
         NCcgEwc0Stxhd6DtszFOHvua7Qm9vR+eqShUyTkvsY9uZZjFyx8+r0EKTASKu6aOH379
         OaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QeQ7A4/9L+jEYAB7JYehSX041AgzGfugJpwYzn3Do9w=;
        b=NKrlxsTUTkHoDWoijIRWBZwKReeTaEoizFsMbTPIHu7dql0LvsXHpWw81AHy/4QKnU
         0Ul6I0etgmWKImtDjrW2bGXxRy2NaE7wRIeWvxJdoDTiJpxsiOSLGSl64Uc1MaYcrizp
         M5aetU0ijegWCTUJEbTJ7Td6zsvTzT80W7X1jShng8s+lp2hO5k7ihtBjVZLa58X5QyH
         IX1ynuMCHNF1000wwFWmxSpv8LYEHIIDohwJPqJC0p8y4gvj1HUADt3LsbDOA3I9QQPC
         22rX/HUO6uHQpWdfi9OwFbL5UQIKTt15ujVx0GxL/NSrVQEQx5897JcdiezUjWWQFyuW
         eIlg==
X-Gm-Message-State: ACrzQf1nN/mEm6GtpfXtWiuGxrT0DCq4TFjd6bO7dH3g6KW6q8XEGw19
        NegqllzS9dAdI5zWTyDzSjBz6uDIj5JhCo9C+kNFmw==
X-Google-Smtp-Source: AMsMyM4wNBgRFhR9QN2CLs+N2DMAyXkeajMXUi7qhlHpVLRsXH+CQLu+0IC3/E+9n3rhEt1e/aLHqj9Lz4KjioPoAuQ=
X-Received: by 2002:a67:a202:0:b0:39b:181d:bd20 with SMTP id
 l2-20020a67a202000000b0039b181dbd20mr3110464vse.51.1663934309305; Fri, 23 Sep
 2022 04:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f8b5ef05dd25b963@google.com> <4b37f037-3b10-b4e4-0644-73441c8fa0af@I-love.SAKURA.ne.jp>
 <e0173c17-3837-a619-4bcc-7a0ba4843cc4@infradead.org> <423b1fa6-10fa-3ff9-52bc-1262643c62d9@I-love.SAKURA.ne.jp>
In-Reply-To: <423b1fa6-10fa-3ff9-52bc-1262643c62d9@I-love.SAKURA.ne.jp>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 23 Sep 2022 13:58:18 +0200
Message-ID: <CANp29Y7fSsjqKbFiMZDG_w-ERigQOk_6Zw3L9rw5erpP3rRU0g@mail.gmail.com>
Subject: Re: [PATCH] fs/ntfs3: fix negative shift size in true_sectors_per_clst()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Shigeru Yoshida <syoshida@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com>,
        "'Aleksandr Nogikh' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>, ntfs3@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tetsuo,

Thank you very much for providing the feedback!

On Fri, Sep 23, 2022 at 3:26 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2022/09/23 9:38, Randy Dunlap wrote:
> > I slightly prefer the earlier patch:
> >
> > https://lore.kernel.org/all/20220823144625.1627736-1-syoshida@redhat.com/
> >
> > but it appears that the NTFS3 maintainer is MIA again. :(
> >
>
> Shigeru Yoshida posted a patch against https://syzkaller.appspot.com/bug?extid=35b87c668935bb55e666
> and I posted a patch against https://syzkaller.appspot.com/bug?extid=1631f09646bc214d2e76 .
> We didn't realize that these are the same problem.
>
> It seems that sending to not only syzbot+XXXXXXXXXXXXXXXXXXXX@syzkaller.appspotmail.com
> but also syzkaller-bugs@googlegroups.com is required for proposed patches to be recorded
> (in order to avoid duplicated works) into a page linked from "Status:" in each bug page.

We do have plans to start inspecting LKML messages for the patches
that mention syzbot-reported bugs. It will be possible then to display
them all on the bug page and somehow mark bugs with a PATCH sent on
the list.

>
> Since https://syzkaller.appspot.com/upstream does not have a column for tracking intermediate
> status between "Open" and "Fixed" (e.g. cause identified, patch proposed) because it can take
> long time until patches are accepted into one of git trees syzbot is tracking, we need to
> utilize "Last activity" in the list page and a page linked from "Status:" in each bug page.
> Time to boost priority for implementing user-supplied comment column (e.g. "#syz memo:" command)
> to each bug?

And then syzbot should just display all such received comments on the
bug's web page, right?

--
Best Regards,
Aleksandr

>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/423b1fa6-10fa-3ff9-52bc-1262643c62d9%40I-love.SAKURA.ne.jp.
