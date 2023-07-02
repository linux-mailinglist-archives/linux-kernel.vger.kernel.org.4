Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E88745190
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjGBTza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjGBTzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:55:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6662C4239
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 12:52:53 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D8691EC06FB;
        Sun,  2 Jul 2023 21:51:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688327509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=w0w8XPim6KMn9DZVnNkvLqAnmMWZmkQq6mxkDd+M/Ws=;
        b=nLSGLTePOIqxHe3Ow81qh5nCjy93v2Qx1T6n2v/X9UdfY9EazR6kHcFYz/QGBB7ilGT03i
        YIktuYNypMiW9JmEoeAwWfa1bFmMwvNJX4vD8Uh6V/oRODHuYIeA4v57T27ulBkuywSTas
        9Bh8eZE2dY5tU6SzlJkKML99tGdRPTY=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M_3_5DR8hx3p; Sun,  2 Jul 2023 19:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688327504; bh=w0w8XPim6KMn9DZVnNkvLqAnmMWZmkQq6mxkDd+M/Ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LY2p4/OrG4GjdS6xlm1/VRBypHrp3dPWcPbc3bP3MEjQb8K4vROZjEbJ/klY9e2Dz
         m8JkPA1J7uSmhriYf3F3KvI56bqMBuNIs6eCbVuBjkj08jLs9oKioVEZHYJors6aRD
         oMQA5uUmYTPoq2//nHlvhMC/F8IaUh+vdsuXJxn/6ttsOSMpIyDVFUKOfbntNjb+uC
         AYEhBb+Fp+YaJj3WMg5H9eMxTk3mZ/zNhQsUqCm5ZnDEidjOQcE6AK8IdLJyydUSvI
         D1xG1887QKbH1/tN9Jpz7BUd5d8+/SWRkX0tv3/VVqCeKT9geGu0Q57+NPFtqtv4Kj
         47DXotpFkbar26M7fnNb7lKKqsz/xNj7M4a9qR6GmQMzSMBf5IyqZcYoDbFP6KyFAJ
         ASdz3s/1qGoaVSDHF+DC0dxFXrw/frlEaWTDfEQHIJxFaWHzI74eoPyu0J3NU4MRgS
         UOG1G7XEX3uhK84TSxU4w5Ogknkymtj83wHrMFluaqajAfXR8LXqPQRH0Lqr+1MaMl
         F/hNzh5rbFFqsGeX3LtB7iAb3fI1eoJAYZxYl2QRx3Ta33nZK87sV8BSAAO2aa8/+T
         nGQoOG4ucHdoEaRnNi1UfTu4C8A4vcn8Cg3RTkRCHaRq0DD7/H9fnLc6eg3PF/mnFI
         7Yi1gpiyInI7Po2oGgjTQHs8=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A878440E0187;
        Sun,  2 Jul 2023 19:51:36 +0000 (UTC)
Date:   Sun, 2 Jul 2023 21:51:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     syzbot <syzbot+3ea47fc22e48e9ec4324@syzkaller.appspotmail.com>
Cc:     dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] upstream build error (20)
Message-ID: <20230702195130.GAZKHVQnvKIjc9FB05@fat_crate.local>
References: <0000000000003dab1305ff859d21@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000003dab1305ff859d21@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 11:56:57AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    77b1a7f7a05c Merge tag 'mm-nonmm-stable-2023-06-24-19-23' ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1701aabd280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dbdd409f194c6563
> dashboard link: https://syzkaller.appspot.com/bug?extid=3ea47fc22e48e9ec4324
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3ea47fc22e48e9ec4324@syzkaller.appspotmail.com
> 
> ./arch/x86/include/asm/mem_encrypt.h:23:20: error: static declaration of 'mem_encrypt_init' follows non-static declaration
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

#syz fix: 0a9567ac5e6a ("x86/mem_encrypt: Unbreak the AMD_MEM_ENCRYPT=n build")

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
