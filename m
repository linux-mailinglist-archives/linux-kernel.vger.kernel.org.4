Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EC05E8BFF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiIXL6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIXL6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:58:34 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ABAA0338
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:58:32 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id v192so1343872vkv.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ulv52h01BeD+LbKgL2nyw8oj8QW0rWAKMvPugrpWKDY=;
        b=XkZi9+/FLg58USiQ1yiS/W1E1fh3yJs3M11SkCDaZ2Za9huah3cl4yDlawj/frnQ8D
         dqa7ISCyQFi+n+HieOUtfB07o27oqJaY1Q4TnXE4/dFUPXiGR55JtWC6dRnKec/peFET
         UbCFZQm2shpV8d3OAhbfhTCnP6pxswaYXK31lD0qDfwbMo6J+kKnT6ow0CpyrJu5Tquh
         L3iXNSAeLgRXF97p5jbSLuXFc/ee3lND+ryCr6VPJOKKm07/MUHvpXQK7G0NlL6tVc/T
         NOBu1q1f3NZyTmEyXCaiX5MlOxmTqEyFswAcEa+sKbHoz8hlCPJEWO9Rveb9EhWxHXIz
         XH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ulv52h01BeD+LbKgL2nyw8oj8QW0rWAKMvPugrpWKDY=;
        b=RNaY2ULOBlzlVstGdWe9zsX4adTM9vCkEXgcEy0pOOlIwVzEtxTUZiYQaYqXtRyLdP
         KBcUH5nTeY9IICJqZ/guE3NcmdWKvwg5d7gGs3jC8byvN9tJHXObjPef9DMKUhsRhUkU
         8tOWblXNz3sA7Tne81aXa21HTjKzlMcNbFx6RzeSsvBZcSWronTId64Fr8eugMfPhnzE
         U2NmauhSx5GHrVDtm9QOAfhNU4DNE2/H9fTUTvv9BnZuHXqLdrrnn+G46jBrZN+EA3j8
         2htDvO+uDVVnZplDsPUd9eDBKPfYrsDdTdJ286wM/2maa5DEeMJsFy3ILe+kU1FtHBov
         HCgw==
X-Gm-Message-State: ACrzQf3OwWsLidXmXCTO+QjRcUSFl4tXFFaWDMU0dMllDdIlSIWM3dki
        nGfaSi/PmGhw8yR8no5WKjFNTA0FwJYzweakP/Dlqw==
X-Google-Smtp-Source: AMsMyM7Hn/CLa0VUKl79qdj67WGG17aQ0MlY6VrADLa0oC+Gmo5y38rsJw50HPrvBn8rtQD9xZCNdSsqQ8bBf1oMIiI=
X-Received: by 2002:a05:6122:b51:b0:3a1:f70e:d48 with SMTP id
 17-20020a0561220b5100b003a1f70e0d48mr5270846vko.29.1664020711684; Sat, 24 Sep
 2022 04:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f8b5ef05dd25b963@google.com> <4b37f037-3b10-b4e4-0644-73441c8fa0af@I-love.SAKURA.ne.jp>
 <e0173c17-3837-a619-4bcc-7a0ba4843cc4@infradead.org> <423b1fa6-10fa-3ff9-52bc-1262643c62d9@I-love.SAKURA.ne.jp>
 <CANp29Y7fSsjqKbFiMZDG_w-ERigQOk_6Zw3L9rw5erpP3rRU0g@mail.gmail.com> <ea7c00c1-07d7-c23e-80f0-0693016e9731@I-love.SAKURA.ne.jp>
In-Reply-To: <ea7c00c1-07d7-c23e-80f0-0693016e9731@I-love.SAKURA.ne.jp>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Sat, 24 Sep 2022 13:58:20 +0200
Message-ID: <CANp29Y4xHHKXAYFiORACqLHDCmF8XkqQSMy5QfjFSag6UFVojQ@mail.gmail.com>
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

On Fri, Sep 23, 2022 at 4:35 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2022/09/23 20:58, Aleksandr Nogikh wrote:
> > We do have plans to start inspecting LKML messages for the patches
> > that mention syzbot-reported bugs. It will be possible then to display
> > them all on the bug page and somehow mark bugs with a PATCH sent on
> > the list.
>
> I interpret it as an attempt to automatically show "Patch proposed" state.
> But since not all patches have Reported-by: tag, and/or a proposed patch
> with Reported-by: tag might be withdrawn via review, that state should be
> also manually changeable.

Yes, it is meant to be manually changeable.

To be honest, I'm a little bit worried about making the syzbot
communication protocol more and more complex - e.g. how will other
developers figure out that such a feature exists at all.. Though,
there are anyway no other options than to extend the protocol.

>
> > And then syzbot should just display all such received comments on the
> > bug's web page, right?
>
> Whether "all comments" or "last comment" needs some decision. It might be a few words
> indicating culprit subsystem (probably "last" should overwrite), it might be memo
> describing how far debugging went (probably "all" is helpful), it might be some
> URL where discussions/patches are (probably "all" is helpful), it might be trying to
> show or hide "Patch proposed" state (probably "last" should overwrite).
>

It seems that even displaying all patch sending attempts (regardless
of their status) should be already very helpful in preventing the
situations like you described earlier. E.g. it's very likely that
syzbot won't be promptly notified about withdrawn patches, so it's
anyway necessary to look at all previous attempts.

>
>
> By the way, a possible improvement on "Patch testing requests:" table.
> Although the "Patch" link showing diff output after applying proposed patch is OK,
> I'd like to also see a link to original "#syz test:" mail, for the intent of diff
> (which would be in patch description part if it was a formal patch) is dropped from
> diff output in the "Patch" link.

Interesting!
I created an issue to keep track of this:
https://github.com/google/syzkaller/issues/3392
The presence of the link will, though, depend on whether the user did
Cc some public mailing lists while making the patch testing request.

>
> For example, https://syzkaller.appspot.com/bug?extid=9ca7a12fd736d93e0232 was forgotten
> for 1000 days after 7 patch testing requests. I can't easily find the intent of each diff
> (e.g. just debug printk() or proper fix). It seems the last one was about to formal submit,
> but I can't find why it is not yet applied.

Btw there was recently deployed an old repro retesting feature that
retests old reproducers and obsoletes bugs if all of them are no
longer working. It has already closed > 150 bugs this way (more to
come) and in quite a lot of such closed bugs I see a patch testing
request from some developer that was done several months or even
several years ago. And syzbot was not notified about these fixes.

So yes, the presence of a patch testing request can be a strong
indicator that the bug is already fixed and syzbot just doesn't know
about that.

>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/ea7c00c1-07d7-c23e-80f0-0693016e9731%40I-love.SAKURA.ne.jp.
