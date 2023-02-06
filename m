Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA2468B9EC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjBFKVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBFKVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:21:43 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7302330C0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:21:02 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id x21so618627uaf.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OeqUBf5wnWMgK5bQ3i9vK8qME5Qe9yR54Mq4WwOswZ0=;
        b=oqdBL/0nO4ayR2sHB2g8ZoJ/XpkmutFbpiVA9R3cG3qLSySLNK2laPi3Nai9r8b1MX
         wyiMylSja5N9hv4tH2OaT1k1JnkZ53U36QjzxpRpFhXn2Did3fJPmn6EeNNyID4Y5PZC
         rEKtFHTL4oSZouHAHYozzrYqxqE6WBtDKVubTv8P925FWmXWyPfHH7aSEX6jlBVPSDHi
         VKiXAbin/mSELXZ0Ke2WYurg4+gjzE5AOO8WUuTlhO6rkjbtV3dMU71yarLmqGl14Aoa
         mOYEBYFLgxlvOr9X0zvOQtMVCTh6Uny+DHSGjjnntv5U6E9hWsrayAOA0IcnLFE2vsT+
         RBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OeqUBf5wnWMgK5bQ3i9vK8qME5Qe9yR54Mq4WwOswZ0=;
        b=OSFrLMQ15ROxnL9BdVVtQYjxWmIhTCNdE5w+/W4/KBR92cLZhWOZkWNLH89hZEaqzr
         7MG0zqo55+1qzBXjPNHNLSEE4B/aTl0k7qekkCjeBMptnA6U5xP20KMvkEq9dmd6aJHH
         7INmOjTuIaliuInVbtlErF7E05jzbsf/OBsHSX9aBEuV9NU0CUZ4L2NGzJbrlFrHY1eL
         N5VfGFFQijaOzeNLa5TqHeJRcAWZax6eoLGGLup29TtWIWRBwhAr7zyrw34Mko8FXrxc
         PKnF4F2tCluvUGVTusDKuqzS+xyqav/bpbtV4wRkgh7hCZkdGarQBuY0Dr6TwfaMdkgy
         of0w==
X-Gm-Message-State: AO0yUKV9t9njzNIipxJFIoYttM/KmaFkrhWk9Sa9Hr+wybJgIg8NY10G
        dPoYUEtQusPA16JFkFUNnSLjgDETe0efQJC5kf3PBg==
X-Google-Smtp-Source: AK7set/qRKnFrqx1vRhHLjmK1fGBoeerB4wIelaOaOYs+BJ0yf7p9HBZYntx15dGAPCrmF2R4FtINGq93+2AXWpQ9mo=
X-Received: by 2002:ab0:2618:0:b0:683:cba5:ad90 with SMTP id
 c24-20020ab02618000000b00683cba5ad90mr66938uao.59.1675678861528; Mon, 06 Feb
 2023 02:21:01 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009a318805e6ff48a4@google.com> <00000000000009570005f3f92b86@google.com>
In-Reply-To: <00000000000009570005f3f92b86@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 6 Feb 2023 11:20:48 +0100
Message-ID: <CANp29Y4vi+5X+3otv3JzWG9Ph=hVuUME9O+NZERsXvyZDq0z1Q@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in ni_find_attr
To:     syzbot <syzbot+69d15cab6309bffae739@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com, edward.lo@ambergroup.io,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 5, 2023 at 8:46 PM syzbot
<syzbot+69d15cab6309bffae739@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 2681631c29739509eec59cc0b34e977bb04c6cf1
> Author: Edward Lo <edward.lo@ambergroup.io>
> Date:   Sat Aug 6 17:05:18 2022 +0000
>
>     fs/ntfs3: Add null pointer check to attr_load_runs_vcn
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=110ad78d480000
> start commit:   b7b275e60bcd Linux 6.1-rc7
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
> dashboard link: https://syzkaller.appspot.com/bug?extid=69d15cab6309bffae739
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b3fb9b880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101313bb880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fs/ntfs3: Add null pointer check to attr_load_runs_vcn

Looks correct.
#syz fix: fs/ntfs3: Add null pointer check to attr_load_runs_vcn

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000009570005f3f92b86%40google.com.
