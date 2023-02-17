Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691A369AA3A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjBQLXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBQLXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:23:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8813A498A6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:23:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 423F7338BE;
        Fri, 17 Feb 2023 11:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676632981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3hFXFGvzRSgqBeemjF+3MZjoJr+W6UfHdZuryaHksa8=;
        b=1DM6FyElUfnh1Ittd8Uc9BuntdmGk6371Di9J9ZWX6NEPLsTqXELbVgpWj3cxwqz2U0lTM
        2gR2tjrWrvg1Tv+J2FHPZ9oRnaXBF5n2tGsT3saVnDCi7wnn+YLBBFmmKPwkJhELqM70Wj
        VekiXK4Q8OIbXU3yHmfbRJin1uE6V1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676632981;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3hFXFGvzRSgqBeemjF+3MZjoJr+W6UfHdZuryaHksa8=;
        b=u9PeN2FWRdihfSt+zzv0KeucxqrpQXoq2o8RTm2XxzrXApx5wzZ6IO5sr/3yuokmviCREA
        9Eu6/8I0FgePujCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34FE8138E3;
        Fri, 17 Feb 2023 11:23:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QicODZVj72OVSAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 17 Feb 2023 11:23:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A7352A06E1; Fri, 17 Feb 2023 12:23:00 +0100 (CET)
Date:   Fri, 17 Feb 2023 12:23:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
Cc:     "jack@suse.com" <jack@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: Re: WARNING in udf_truncate_extents
Message-ID: <20230217112300.qxjqfcu5nw5ag2fh@quack3>
References: <IA1PR07MB9830389CD6BFD22047E8BA41ABA09@IA1PR07MB9830.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA1PR07MB9830389CD6BFD22047E8BA41ABA09@IA1PR07MB9830.namprd07.prod.outlook.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu 16-02-23 21:44:45, Sanan Hasanov wrote:
> We found a bug using a modified kernel configuration file used by syzbot.
> 
> We enhanced the coverage of the configuration file using our tool, klocalizer.
> 
> Kernel Branch: 6.2.0-rc6-next-20230203
> Kernel config: https://drive.google.com/file/d/1jWHyzy2KABqlRawd3FO2V2ZVNoMWpkZu/view?usp=share_link
> C Reproducer: https://drive.google.com/file/d/1zH4AtT1D3O-vqihwMy-kxrFW6Rni6bZ_/view?usp=share_link

Hum, so looking into the reproducer I don't see how it could trigger the
warning below because the reproducer just mounts UDF image and then forks
64 processes. In particular there is no write happening to the UDF
filesystem shown in the stacktrace. Are you sure this reproducer indeed
triggers this warning for you?

								Honza

> ------------[ cut here ]------------
> WARNING: CPU: 6 PID: 10426 at fs/udf/truncate.c:208 udf_truncate_extents+0x8a9/0x9d0
> Modules linked in:
> CPU: 6 PID: 10426 Comm: syz-executor.3 Not tainted 6.2.0-rc6-next-20230203 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:udf_truncate_extents+0x8a9/0x9d0
> Code: 84 d2 74 05 e8 e8 1e f9 fe 8b 44 24 20 be 07 00 00 00 48 89 df 89 83 cc fe ff ff e8 61 0b 13 ff e9 a5 fd ff ff e8 b7 23 aa fe <0f> 0b e9 1f fe ff ff e8 ab 23 aa fe 0f 0b 48 8b 7c 24 08 48 89 74
> RSP: 0000:ffffc9000c6f7050 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff888045252160 RCX: 0000000000000000
> RDX: ffff888114e53900 RSI: ffffffff82d5b399 RDI: 0000000000000007
> RBP: ffffc9000c6f7140 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000350 R11: 0000000000000001 R12: ffff8880530de000
> R13: 0000000000000350 R14: 00000000000000ff R15: ffffc9000c6f7100
> FS:  00007f601837e700(0000) GS:ffff888119f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000001ffffe40 CR3: 000000004c1b1000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  udf_write_failed.isra.0+0x173/0x1c0
>  udf_write_begin+0x2c5/0x370
>  generic_perform_write+0x259/0x580
>  __generic_file_write_iter+0x2ae/0x500
>  udf_file_write_iter+0x233/0x740
>  __kernel_write_iter+0x262/0x7a0
>  __kernel_write+0xc9/0x110
>  dump_emit+0x21d/0x340
>  elf_core_dump+0x215c/0x3720
>  do_coredump+0x2d30/0x3ce0
>  get_signal+0x1c11/0x25c0
>  arch_do_signal_or_restart+0x79/0x5a0
>  exit_to_user_mode_prepare+0x11f/0x240
>  irqentry_exit_to_user_mode+0x9/0x30
>  asm_exc_general_protection+0x26/0x30
> RIP: 0033:0x7f601728edd5
> Code: 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 48 3d 01 f0 ff ff 73 01 <c3> 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 84
> RSP: 002b:0000000020000040 EFLAGS: 00010217
> RAX: 0000000000000000 RBX: 00007f60173bc120 RCX: 00007f601728edcd
> RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000000
> RBP: 00007f60172fc59c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc959cbaaf R14: 00007ffc959cbc50 R15: 00007f601837dd80
>  </TASK>
> irq event stamp: 1369
> hardirqs last  enabled at (1379): [<ffffffff81643788>] __up_console_sem+0x78/0x80
> hardirqs last disabled at (1388): [<ffffffff8164376d>] __up_console_sem+0x5d/0x80
> softirqs last  enabled at (490): [<ffffffff814b2d7d>] __irq_exit_rcu+0x11d/0x190
> softirqs last disabled at (351): [<ffffffff814b2d7d>] __irq_exit_rcu+0x11d/0x190
> ---[ end trace 0000000000000000 ]---
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
