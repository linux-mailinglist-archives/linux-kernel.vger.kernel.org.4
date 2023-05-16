Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E58704DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjEPMcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjEPMcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:32:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD6C5FCF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:32:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C16CC60F5A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05BBC433D2;
        Tue, 16 May 2023 12:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684240328;
        bh=5maVUb07MOPzI7fH1YK4LLKkRTaKZEtXvS/UR5ZRwW4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HhA2I+MV7c9Xe/O2JFZUptT3YXLa8o9q4RdunpnRAa8afSK40C2Oa/iCDVe7KRxkm
         GeVk/2TWh8PCaX67QOToFkCyS97BkvA8/WvqUW6U7WX1SlK4yGi9PDjWBVNTs0avZ+
         Nra1iN6P+21PN3mrhEK6cxoBgExJQ4ZW0E7cv69O4FlbyZLMwkKSSgJonuQ76SMkhY
         hZ1IGNarwECDzxojSWmQefcABDLmkHLzvYJd9O8cO2L1mK1z6nOrI7HYVw5QfOzUBC
         dV52zlm7FS4D0pCwQp0J4DqBpQd8VB0utIWdUlc5TSjtPiDVBFSnrhdQQRQoK+IOaf
         3ACa5RMq/hD7Q==
Date:   Tue, 16 May 2023 14:32:03 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+c84b326736ee471158dc@syzkaller.appspotmail.com>,
        syzbot <syzbot+729f1325904c82acd601@syzkaller.appspotmail.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] Internal error in should_fail_ex
Message-ID: <20230516-saftig-einbog-ef2981f0dec2@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000bff72505fbcd1f74@google.com>
 <000000000000bc152005fbcd1fa2@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 03:35:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    457391b03803 Linux 6.3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15671fa2280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=385e197a58ca4afe
> dashboard link: https://syzkaller.appspot.com/bug?extid=c84b326736ee471158dc
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/c35b5b2731d2/non_bootable_disk-457391b0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2a1bf3bafeb6/vmlinux-457391b0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/21f1e3b4a5a9/zImage-457391b0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c84b326736ee471158dc@syzkaller.appspotmail.com

On Tue, May 16, 2023 at 03:35:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    457391b03803 Linux 6.3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=134e0b01280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=385e197a58ca4afe
> dashboard link: https://syzkaller.appspot.com/bug?extid=729f1325904c82acd601
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118f964e280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f6e776280000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/c35b5b2731d2/non_bootable_disk-457391b0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2a1bf3bafeb6/vmlinux-457391b0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/21f1e3b4a5a9/zImage-457391b0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+729f1325904c82acd601@syzkaller.appspotmail.com

Not complaining but why am I blessed with an explicit Cc on this?
