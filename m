Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18D75F2585
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 23:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJBVxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 17:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJBVxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 17:53:04 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B076A360AF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 14:53:03 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-131ea99262dso8866338fac.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 14:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uCRA476ZAmoARGY528Dr8G2lwbqlxMrHrdrYd8As2cY=;
        b=Vu8AMmr1rXWDuTzUFCxWM4PFvHSj7lqRHf3bdDHtGLs3oB1efx+kq+eZCQuUwmclP3
         4jUEhDv6NQ5zCSpozuwKHt+tbEwUJWjgZy+zoIWk+FrYEQS7tW0fbpAqEEf/uIs/nbnS
         FytV8O0ZL4Ji7bp1rpzXz7p1JU+DI2guvhxWhuBM86QCeN4cyZFF9QtgeTCBanpXAwDR
         FzvqemuiJ1I+ZiYnFUfOLi3VI31bPglQE4BQ5Sr5r1OwL6Albr5YyTGfYQFf52Iqfw17
         g42eLFpM0MiSF01Qdd44kxh57F9fgQoBGJm+7AfmQo0grqYe2UzGAHmyMiQppv9lVkWh
         LD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uCRA476ZAmoARGY528Dr8G2lwbqlxMrHrdrYd8As2cY=;
        b=E+6LeGuW65RUhiozB1smP06x2Yjbty5jt614d1kpyJ6Xe8LjXp2cpvVkhrNo5NAiUe
         VIE6hPo2TBnzmnoWpS0nxh/oOfKamaDQU/ECQ8QdjSAbtT6RE+dKPAt8i6A0OfUV0HNO
         WgmxFGQCuqmbKH3H2SwKCuxtGf5ypVzGg7bgJTJn5g2oIf/azTRKMrlFMzv49sMJP3Aa
         3Z1eKbEmtNc/+8x7lhBpGs3+cHfSP/44ZpUz18pCrParpU+JO3l4L4aDSTB9Rt2NStgX
         LOBTjUyuiho8N/YSu8HvRpMJ4/7J/DsHzXoqql9bKzMMyltr0mlmkiGLfS+48jo+fSbf
         F9/g==
X-Gm-Message-State: ACrzQf2s7Pp1tw7+//zticGCtar0U4YDZQmg6aDorenJHodOZ7BlER56
        vGuIiQnoD3pEgLJ8A+GJW21X7XVJ9hbVhUNAI93XrjayDqU=
X-Google-Smtp-Source: AMsMyM51ol9aCd1biy/P9mhuy4xTHsDitUqvKFHWQlKYgMTU/4iro6nWQPmY2SJBXmjY1UK/8//QaeGLTYMcdU6neB4=
X-Received: by 2002:a05:6870:d147:b0:126:d4a4:e99d with SMTP id
 f7-20020a056870d14700b00126d4a4e99dmr3698892oac.149.1664747582994; Sun, 02
 Oct 2022 14:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c2333105e9cc7b1c@google.com> <0000000000001f464d05ea07e1ec@google.com>
In-Reply-To: <0000000000001f464d05ea07e1ec@google.com>
From:   Kari Argillander <kari.argillander@gmail.com>
Date:   Mon, 3 Oct 2022 00:52:43 +0300
Message-ID: <CAC=eVgQSpoQq8qs=oioN0Rcdy=n0_YRoJ-R4=b0GJ2BdRpZLaA@mail.gmail.com>
Subject: Re: [syzbot] WARNING in wnd_init
To:     syzbot <syzbot+fa4648a5446460b7b963@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        pjwatson999@gmail.com, syzkaller-bugs@googlegroups.com
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

2.10.2022 syzbot (syzbot+fa4648a5446460b7b963@syzkaller.appspotmail.com) wrote:
>
> syzbot has bisected this issue to:
>
> commit fa3cacf544636b2dc48cfb2f277a2071f14d66a2
> Author: Kari Argillander <kari.argillander@gmail.com>
> Date:   Thu Aug 26 08:56:29 2021 +0000
>
>     fs/ntfs3: Use kernel ALIGN macros over driver specific
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11e776f4880000
> start commit:   49c13ed0316d Merge tag 'soc-fixes-6.0-rc7' of git://git.ke..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=13e776f4880000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15e776f4880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
> dashboard link: https://syzkaller.appspot.com/bug?extid=fa4648a5446460b7b963
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cad4e0880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1303781f080000
>
> Reported-by: syzbot+fa4648a5446460b7b963@syzkaller.appspotmail.com
> Fixes: fa3cacf54463 ("fs/ntfs3: Use kernel ALIGN macros over driver specific")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

I check what my patch actually changed. In my original patch I did

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index b5da2f06f7cbd..d4dd19b822bc2 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -900,7 +900,7 @@ static inline bool run_is_empty(struct runs_tree *run)
/* NTFS uses quad aligned bitmaps */
static inline size_t bitmap_size(size_t bits)
{
- return QuadAlign((bits + 7) >> 3);
+ return ALIGN((bits + 7) >> 3, 8);
}

QuadAlign was "buggy" so that it did always give a 32 bit result back. ALIGN
macro will give a 64 bit. So bitmap_size now gives different result. To me it
looks like my patch actually fix this behavior. I just didn't notice
this behavior
when I did the patch.

I have tested that if bitmap_size return u32 syzbot will not trigger the issue
anymore. You can see my test patch in the Syzbot dashboard [1]. That is not
prober fix imo, but just wanted to help anyone looking at this problem.

[1]: https://syzkaller.appspot.com/bug?extid=fa4648a5446460b7b963
