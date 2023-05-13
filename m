Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7BD701779
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 15:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbjEMNmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 09:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjEMNmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 09:42:43 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8E3A019A9
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 06:42:40 -0700 (PDT)
Received: (qmail 729531 invoked by uid 1000); 13 May 2023 09:42:39 -0400
Date:   Sat, 13 May 2023 09:42:39 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+1cb937c125adb93fad2d@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] WARNING in shark_write_val/usb_submit_urb
Message-ID: <bc3011b3-e742-4576-989a-e360a936182b@rowland.harvard.edu>
References: <000000000000121ea5058e445936@google.com>
 <00000000000047c61c05fb85d44e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000047c61c05fb85d44e@google.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 02:31:34PM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 76e31045ba030e94e72105c01b2e98f543d175ac
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Mon Apr 10 19:40:05 2023 +0000
> 
>     media: radio-shark: Add endpoint checks
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17cfcfca280000
> start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2f98d9171d58550f
> dashboard link: https://syzkaller.appspot.com/bug?extid=1cb937c125adb93fad2d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17070aa6880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177ab2da880000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: media: radio-shark: Add endpoint checks

> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
