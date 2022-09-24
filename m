Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3A35E8C09
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 14:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiIXMDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 08:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiIXMDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 08:03:19 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C372BC15
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 05:03:18 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id k2so2337382vsk.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 05:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7h3ia+vTGNs24al3PYoERBRlCHGoJd5FZ5bvI2kc6oc=;
        b=I+R+WNpo3kJ8BLJ3dquygRsm1UyjrNBaW51UzxN9clRO5nM5BXqlp/i9N+kBcz5gZ3
         Tx2DI3TQLQMO/1rThIA35GQJAtJnYGhdf2iOwqVg+yXs7ylLZ5356MHIMwebJvxhzGz2
         VKxIMCGCTb/sjPU1sLYofI3i8kK8re1qAlGZpTlTzvWQY2R50YCyHd+QrwBOgvRz2XVx
         9ITMbMacXmEh2FT6rx6vgYeK0s40zN914KLyb4Sho8TzzvH1b18BtI+TQsA+ZemaZdXk
         KIez+stMQ0alsNBn/gLl98puj7sj5hLivIYPoKFNWPq+SaTf9bFpnLT8/c0Gxq5Q7KN9
         MTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7h3ia+vTGNs24al3PYoERBRlCHGoJd5FZ5bvI2kc6oc=;
        b=qNAyjOk0z3QVKpV6bWCJ/N0UY0OrZCtq2tGgTnVJ5pPSNEIvUcO1o6z+iB9A5Ifsxm
         mIoOBAdKxKOfaO+HVBFByX5SS/D2poDq61tYQ9koZLIgJRG6GLdcHJOWoIp6EJ9nKyjF
         ETLyzrvl17lmbNhlT+yzbwbffDDnZt4fM4haYMmp5cp2gb7ku0cF7BwR3OdcitZ8Z4sc
         Agr3o8zbQjsnkcjpBKMnsnHHuUd3p8802wTxXyrC/bq/FA4dD3h7E67LX8JokMuaM6bS
         taclGFNGswL4JdLBJYcERWn/8mialLk2s8v+NkpXCcAmP4SRcHjRam2ZBhvJNb72f5Uc
         0X8g==
X-Gm-Message-State: ACrzQf07Fiv9lWvk2k6diaU31/fAGh1k3wsWdZIOgo3XiltDPOXlxSn0
        B7N+0OnLU6+IeEs7AEzU8McCNEPiQ+dxSA5WQy0ufw==
X-Google-Smtp-Source: AMsMyM6GrzCLMZtBHLSdQTz+cHrM0/jgq25M9vk/gQym7rXDY3T/1JRV7KAfmEdIak2yIHXzbU0a8m7sD5Rdy4IVldQ=
X-Received: by 2002:a67:a202:0:b0:39b:181d:bd20 with SMTP id
 l2-20020a67a202000000b0039b181dbd20mr5000194vse.51.1664020996807; Sat, 24 Sep
 2022 05:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f8b5ef05dd25b963@google.com> <4b37f037-3b10-b4e4-0644-73441c8fa0af@I-love.SAKURA.ne.jp>
 <e0173c17-3837-a619-4bcc-7a0ba4843cc4@infradead.org> <423b1fa6-10fa-3ff9-52bc-1262643c62d9@I-love.SAKURA.ne.jp>
 <CANp29Y7fSsjqKbFiMZDG_w-ERigQOk_6Zw3L9rw5erpP3rRU0g@mail.gmail.com>
 <ea7c00c1-07d7-c23e-80f0-0693016e9731@I-love.SAKURA.ne.jp> <CANp29Y4xHHKXAYFiORACqLHDCmF8XkqQSMy5QfjFSag6UFVojQ@mail.gmail.com>
In-Reply-To: <CANp29Y4xHHKXAYFiORACqLHDCmF8XkqQSMy5QfjFSag6UFVojQ@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Sat, 24 Sep 2022 14:03:05 +0200
Message-ID: <CANp29Y7cBbk8AbLq1z7w_PjQ-2fzG9FNyWyH+aH4oG9hfEm6nw@mail.gmail.com>
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

> > By the way, a possible improvement on "Patch testing requests:" table.
> > Although the "Patch" link showing diff output after applying proposed patch is OK,
> > I'd like to also see a link to original "#syz test:" mail, for the intent of diff
> > (which would be in patch description part if it was a formal patch) is dropped from
> > diff output in the "Patch" link.
>
> Interesting!
> I created an issue to keep track of this:
> https://github.com/google/syzkaller/issues/3392
> The presence of the link will, though, depend on whether the user did
> Cc some public mailing lists while making the patch testing request.

Upd from Dmitry:
https://github.com/google/syzkaller/issues/3392#issuecomment-1256952263

We actually do provide these links, but they're rarely present for the
reason I mentioned above.
