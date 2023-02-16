Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CBF699CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjBPSvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBPSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:51:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C4E3B222
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:51:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90584608C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 18:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EA1C433D2;
        Thu, 16 Feb 2023 18:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676573507;
        bh=0vkG1604mNKj30mORp4ANujiqD1+lxA0mSHLsIgsBL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ccanwSeu9wCRnb5sOuQ+/0dooora8umvOhL739raJ36eYeWQLriHnOAfcwi8jv9gm
         6Ta+OMxSKwy7CLz4vf1j48hJxpkmX37BGWkyixhrAITWSXJqW9An+3geipXKE06eV5
         RgvU5a+hZPI3zUbZE6y9CCsAgXlJElqwl21RO16fUF0VHifejmIxC640z1I3Wsrx9k
         IgbPtSUSEHQ1rUn4YrieYpyIt/BnDjCWKAEdArnDEAaA/esKRHIB7KVAh3qmOLGTcj
         Q7y/IdOXoKr2jbezOlAGgN06clv043X7IPCcaBrNFpqyK+tc3J3+5yDthi4SAeGE9T
         6CXEqOI+FBvuQ==
Date:   Thu, 16 Feb 2023 10:51:44 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+dac365e3ce07c3d0e496@syzkaller.appspotmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [syzbot] WARNING: can't access registers at
 entry_SYSCALL_64_after_hwframe
Message-ID: <20230216185144.u5zijpev6o77xhaz@treble>
References: <000000000000ff304105f4d1cd36@google.com>
 <CACT4Y+Yq1knodAhoBnUe-Tf6QLrQCrGV5gyWC7An8poQDcfv6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Yq1knodAhoBnUe-Tf6QLrQCrGV5gyWC7An8poQDcfv6g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 04:14:25PM +0100, Dmitry Vyukov wrote:
> On Thu, 16 Feb 2023 at 15:13, syzbot
> <syzbot+dac365e3ce07c3d0e496@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    9d9019bcea1a Add linux-next specific files for 20230215
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=144edcc8c80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a64cbb8ad0da425e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=dac365e3ce07c3d0e496
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/70f0c6bb5351/disk-9d9019bc.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/7eed8686df34/vmlinux-9d9019bc.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/84bb6da6b00e/bzImage-9d9019bc.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+dac365e3ce07c3d0e496@syzkaller.appspotmail.com
> >
> > WARNING: can't access registers at entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> 
> This is another splat of reports we started getting recently. Looks
> like this may be ORC unwinder related as well.

Yeah... Also:

  https://lkml.kernel.org/lkml/202302161616.85f13863-oliver.sang@intel.com
  https://lkml.kernel.org/lkml/CACT4Y+YzZb2vscjBLiJ-p-ghbu77o851gbESfE=nZebXqfgE4g@mail.gmail.com

The problem seems to be commit ffb1b4a41016 ("x86/unwind/orc: Add
'signal' field to ORC metadata") but right now I don't know why.

We may need to pull it out (or revert it) and its followup ffb1b4a41016
("x86/unwind/orc: Add 'signal' field to ORC metadata").

-- 
Josh
