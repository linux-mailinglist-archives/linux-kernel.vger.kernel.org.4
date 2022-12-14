Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC8764CCF7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbiLNPT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238760AbiLNPTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:19:53 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C00B8F18
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:19:52 -0800 (PST)
Received: (qmail 927420 invoked by uid 1000); 14 Dec 2022 10:19:51 -0500
Date:   Wed, 14 Dec 2022 10:19:51 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+33d7ad66d65044b93f16@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, hbh25y@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mingo@kernel.org, rdunlap@infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Write in gadgetfs_kill_sb
Message-ID: <Y5npl6gtsuf3+FKB@rowland.harvard.edu>
References: <Y5kgHgl2dU6fkr3p@rowland.harvard.edu>
 <00000000000066fb0905efc09dd1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000066fb0905efc09dd1@google.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 06:37:17PM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+33d7ad66d65044b93f16@syzkaller.appspotmail.com

I'll take this as an indication that the previously reported RCU stall 
was caused by something unrelated to the patch.  The patch will get 
submitted in the next few days.

Alan Stern

> 
> Tested on:
> 
> commit:         830b3c68 Linux 6.1
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> console output: https://syzkaller.appspot.com/x/log.txt?x=10f5988b880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5a194ed4fc682723
> dashboard link: https://syzkaller.appspot.com/bug?extid=33d7ad66d65044b93f16
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=12208bc0480000
> 
> Note: testing is done by a robot and is best-effort only.
