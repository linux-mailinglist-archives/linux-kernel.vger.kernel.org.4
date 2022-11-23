Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8937B63699A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbiKWTJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbiKWTJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:09:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0CCF3E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:09:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC0A2B82439
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD19C433C1;
        Wed, 23 Nov 2022 19:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669230592;
        bh=Fkx7NNxQpeQ/Bu04mLlsyHDFFetZUQoYudxuRd2fzf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/485IK0yk1tjvafssJ1B73k8Gb/Ed6Gmq2OtdzOQ6ZWFxp6gmNshuPC6VTjEOVEK
         2s/t5uj6D2rtj5lgiuTH+iOqK5gb06F6sPZ2u8hHnSouja74sYO7+MU8lmntIlUSFo
         ik9HvnXgaDXLiJ5MmJIcMTMBWwNySFBeQwU77a9U=
Date:   Wed, 23 Nov 2022 20:09:50 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Sanan Hasanov <sanan.hasanov@knights.ucf.edu>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        Paul Gazzillo <Paul.Gazzillo@ucf.edu>
Subject: Re: Syzkaller found a bug: KASAN: use-after-free Read in
 do_update_region
Message-ID: <Y35v/ieA0OrF510w@kroah.com>
References: <BN6PR07MB3185D3400510E9D395288D71AB0C9@BN6PR07MB3185.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR07MB3185D3400510E9D395288D71AB0C9@BN6PR07MB3185.namprd07.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 06:38:01PM +0000, Sanan Hasanov wrote:
> Good day, dear maintainers,
> 
> We found a bug using a modified kernel configuration file used by syzbot.
> 
> We enhanced the coverage of the configuration file using our tool, klocalizer.
> 
> Kernel branch: linux-next 5.11.0-rc1+ (HEAD detached at 6a4b1f2dff55)
> 
> configuration file: https://drive.google.com/file/d/18W-8umgZVSm-KwvIzcBQpxRn74Q1S_Fa/view?usp=sharing
> 
> Unfortunately, we have no reproducer for this bug yet.

Reproducer would be great, thanks.  Otherwise this goes on the thousands
of other "syzbot-found-bugs-with-no-way-to-reproduce" pile that we
have...

> ==================================================================
> BUG: KASAN: use-after-free in do_update_region+0x571/0x5f0 drivers/tty/vt/vt.c:664
> Read of size 2 at addr ffff888000100000 by task (agetty)/17350
> 
> CPU: 6 PID: 17350 Comm: (agetty) Not tainted 5.11.0-rc1+ #3

Wait, that's a VERY old and obsolete and known buggy kernel version.
Please test with something more modern, usually Linus's tree, or
linux-next or worst case, the latest stable release.  5.11-rc1 came out
almost 2 years ago, and over 150 thousand changes have happened since
then.

Not much we really can do about old obsolete kernels, sorry.

thanks,

greg k-h
