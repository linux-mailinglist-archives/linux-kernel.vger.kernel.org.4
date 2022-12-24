Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45948655A44
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 15:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLXOAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 09:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiLXOAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 09:00:43 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20044CEC
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 06:00:40 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso9586198pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 06:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JXM0KAhlws+0VmPex6+ZlzFQeInZVdFj7LBU8Zn+Dc=;
        b=QoltfF8hkLYSIcmgc9MnXP5eiZB/nYMrUPEXWwdxpC31gwooM1FCX9US6x66b0dOK1
         8G5UE8BwI1WBjd0utuBH7vcaypL2yvbPnfB5Vd2a6LrhOovzDZ5FwX9vuFrMQlsLYQxc
         MZs9yMsPaLhVruG1aURprOVPwwKyYqTGZZXFm2nVrkq0cZc19OimCNM5uvyqIDAaSOPy
         hU3sca/Cb0rryCrlv88uta0+Jg3BNSGkiZRZPojBM/sW3OiHDDQJCfIoHyTvwlakc2fM
         f97AMVi6ZIZm8Fix/Qv1c865G6v3friwurGd6DS430pUeczoEuC3RPy2oDZb04jHc3q2
         NUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JXM0KAhlws+0VmPex6+ZlzFQeInZVdFj7LBU8Zn+Dc=;
        b=GyWbOgg1kSRAqBr0T/yNxnJaqMFJLOc6PukpO2sur7fN76k0Lnj4hgHQZhqk4CiGs4
         Wibpj8FTd7uyArOFWWLnmneMwMOYzmYyTRYetCdMg9Sm4kRjMjoScipERBKOsSqkk9sb
         moKKXeKL6LPabMDkNipCy0kthjXnbFVSfGceabKtcIpL+QppsNt1CpZe/4NuG2i5+cLJ
         Y1HJSSjfomBi92ZQwL5ev1jp/5tHMOSKdO4MfikGw3jWxJHoWCCIdHLJighdAeiNUoaI
         U+ncooPnSifbq3QsK9NmmFIX/RYEawr/Lv5mU837xZwPSaqABKrixDrabRVoBS/AuPeQ
         J0Pw==
X-Gm-Message-State: AFqh2kr+x4rFDYgKK3BYnAAP8aChuFLQMXhhk5o37OpcYRahr0/3iKmA
        Ykqb3CBztS5OJ09pXpTzK7TcOnumpuY=
X-Google-Smtp-Source: AMrXdXvBxPeQMBBLe4NDEv+BsucJYDxppcvPdxwNY5Fngy+HFMhYlZwOyzCVPZbSV34dU/SK1aPzbw==
X-Received: by 2002:a17:902:ca14:b0:185:441e:222c with SMTP id w20-20020a170902ca1400b00185441e222cmr12326548pld.39.1671890439108;
        Sat, 24 Dec 2022 06:00:39 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-28.three.co.id. [180.214.232.28])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902d18c00b00186bc66d2cbsm4181746plb.73.2022.12.24.06.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 06:00:38 -0800 (PST)
Message-ID: <0c70ba66-ef00-7242-d198-844f803662fa@gmail.com>
Date:   Sat, 24 Dec 2022 21:00:33 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: f2fs write error Linux v6.2
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jeff Chua <jeff.chua.linux@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        F2FS Development <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Regressions <regressions@lists.linux.dev>
References: <CAAJw_Ztzyh-GNTJYpXbA0CeJv2Rz=fLZKE6_Q=7JMmM+s9yHXQ@mail.gmail.com>
 <CAAJw_Ztb0mJVkHtBhryf=9g8CA0fZZRa8HVio8GCGUSLOvqa7A@mail.gmail.com>
 <Y6bz4wOC0nwu2yGU@debian.me>
Content-Language: en-US
In-Reply-To: <Y6bz4wOC0nwu2yGU@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/22 19:43, Bagas Sanjaya wrote:
> On Sat, Dec 24, 2022 at 01:48:55PM +0800, Jeff Chua wrote:
>> Got the following error in latest linux-6.2-git with just vim (:w
>> file1). No problem with linux-6.1.1
>>
>> 2022-12-22T14:09:51.419409+08:00 [localhost] kernel: BUG: kernel NULL
>> pointer dereference, address: 0000000000000024
>> 2022-12-22T14:09:51.419422+08:00 [localhost] kernel: #PF: supervisor
>> write access in kernel mode
>> 2022-12-22T14:09:51.419423+08:00 [localhost] kernel: #PF:
>> error_code(0x0002) - not-present page
>> 2022-12-22T14:09:51.419424+08:00 [localhost] kernel: PGD 147b63067 P4D
>> 147b63067 PUD 177d5c067 PMD 0
>> 2022-12-22T14:09:51.419424+08:00 [localhost] kernel: Oops: 0002 [#7] PREEMPT SMP
>> 2022-12-22T14:09:51.419428+08:00 [localhost] kernel: CPU: 6 PID: 22891
>> Comm: vi Tainted: G     UD            6.1.0 #11
>> 2022-12-22T14:09:51.419428+08:00 [localhost] kernel: Hardware name:
>> LENOVO 21CCS1GL00/21CCS1GL00, BIOS N3AET69W (1.34 ) 12/05/2022
>> 2022-12-22T14:09:51.419428+08:00 [localhost] kernel: RIP:
>> 0010:f2fs_issue_flush+0x10e/0x180
>> 2022-12-22T14:09:51.419429+08:00 [localhost] kernel: Code: ba 01 00 00
>> 00 be 03 00 00 00 e8 ad e8 d5 ff 48 83 3b 00 74 1e 48 89 e7 e8 7f c1
>> 84 00 f0 ff 4b 24 8b 44 24 2c e9 66 ff ff ff <f0> ff 43 24 e9 4a ff ff
>> ff 45 31 ff 4c 87 7b 28 4d 85 ff 74 d6 44
>> 2022-12-22T14:09:51.419429+08:00 [localhost] kernel: RSP:
>> 0018:ffffc90000b13df0 EFLAGS: 00010246
>> 2022-12-22T14:09:51.419430+08:00 [localhost] kernel: RAX:
>> ffff888101caccc0 RBX: 0000000000000000 RCX: 0000000000000000
>> 2022-12-22T14:09:51.419430+08:00 [localhost] kernel: RDX:
>> 0000000010000088 RSI: 000000000005a844 RDI: ffff8881027bf000
>> 2022-12-22T14:09:51.419431+08:00 [localhost] kernel: RBP:
>> ffff8881027bf000 R08: 0000000000000000 R09: ffff8881027bf2a8
>> 2022-12-22T14:09:51.419431+08:00 [localhost] kernel: R10:
>> 0000000000000000 R11: 0000000000000000 R12: 0000000000000024
>> 2022-12-22T14:09:51.419432+08:00 [localhost] kernel: R13:
>> 000000000005a844 R14: 000000000005a844 R15: 0000000000000000
>> 2022-12-22T14:09:51.419432+08:00 [localhost] kernel: FS:
>> 00007ff03fdf0b80(0000) GS:ffff88883f380000(0000)
>> knlGS:0000000000000000
>> 2022-12-22T14:09:51.419432+08:00 [localhost] kernel: CS:  0010 DS:
>> 0000 ES: 0000 CR0: 0000000080050033
>> 2022-12-22T14:09:51.419433+08:00 [localhost] kernel: CR2:
>> 0000000000000024 CR3: 000000013d64e006 CR4: 0000000000770ee0
>> 2022-12-22T14:09:51.419433+08:00 [localhost] kernel: PKRU: 55555554
>> 2022-12-22T14:09:51.419434+08:00 [localhost] kernel: Call Trace:
>> 2022-12-22T14:09:51.419434+08:00 [localhost] kernel: <TASK>
>> 2022-12-22T14:09:51.419435+08:00 [localhost] kernel: ?
>> preempt_count_add+0x63/0x90
>> 2022-12-22T14:09:51.419435+08:00 [localhost] kernel: ?
>> preempt_count_add+0x63/0x90
>> 2022-12-22T14:09:51.419435+08:00 [localhost] kernel: ?
>> preempt_count_add+0x63/0x90
>> 2022-12-22T14:09:51.419436+08:00 [localhost] kernel:
>> f2fs_do_sync_file+0x489/0x650
>> 2022-12-22T14:09:51.419436+08:00 [localhost] kernel: __x64_sys_fsync+0x2f/0x60
>> 2022-12-22T14:09:51.419437+08:00 [localhost] kernel: do_syscall_64+0x35/0x80
>> 2022-12-22T14:09:51.419437+08:00 [localhost] kernel:
>> entry_SYSCALL_64_after_hwframe+0x46/0xb0
>> 2022-12-22T14:09:51.419438+08:00 [localhost] kernel: RIP: 0033:0x7ff03feef20b
>> 2022-12-22T14:09:51.419438+08:00 [localhost] kernel: Code: 3d 00 f0 ff
>> ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 a3 a2 f8
>> ff 8b 7c 24 0c 41 89 c0 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35
>> 44 89 c7 89 44 24 0c e8 01 a3 f8 ff 8b 44
>> 2022-12-22T14:09:51.419438+08:00 [localhost] kernel: RSP:
>> 002b:00007ffe6ecca530 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
>> 2022-12-22T14:09:51.419439+08:00 [localhost] kernel: RAX:
>> ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff03feef20b
>> 2022-12-22T14:09:51.419439+08:00 [localhost] kernel: RDX:
>> 0000000000000002 RSI: 0000000000000002 RDI: 0000000000000003
>> 2022-12-22T14:09:51.419440+08:00 [localhost] kernel: RBP:
>> 0000000000002000 R08: 0000000000000000 R09: 00000000024bcfb0
>> 2022-12-22T14:09:51.419440+08:00 [localhost] kernel: R10:
>> fffffffffffff4bf R11: 0000000000000293 R12: 00000000000006b7
>> 2022-12-22T14:09:51.419440+08:00 [localhost] kernel: R13:
>> 000000000000003d R14: 0000000000000000 R15: 00000000024a1680
>> 2022-12-22T14:09:51.419441+08:00 [localhost] kernel: </TASK>
>> 2022-12-22T14:09:51.419441+08:00 [localhost] kernel: Modules linked
>> in: [last unloaded: ecc]
>> 2022-12-22T14:09:51.419442+08:00 [localhost] kernel: CR2: 0000000000000024
>> 2022-12-22T14:09:51.419442+08:00 [localhost] kernel: ---[ end trace
>> 0000000000000000 ]---
>> 2022-12-22T14:09:51.419443+08:00 [localhost] kernel: RIP:
>> 0010:f2fs_issue_flush+0x10e/0x180
>> 2022-12-22T14:09:51.419443+08:00 [localhost] kernel: Code: ba 01 00 00
>> 00 be 03 00 00 00 e8 ad e8 d5 ff 48 83 3b 00 74 1e 48 89 e7 e8 7f c1
>> 84 00 f0 ff 4b 24 8b 44 24 2c e9 66 ff ff ff <f0> ff 43 24 e9 4a ff ff
>> ff 45 31 ff 4c 87 7b 28 4d 85 ff 74 d6 44
>> 2022-12-22T14:09:51.419443+08:00 [localhost] kernel: RSP:
>> 0018:ffffc90003903df0 EFLAGS: 00010246
>> 2022-12-22T14:09:51.419444+08:00 [localhost] kernel: RAX:
>> ffff888100106d80 RBX: 0000000000000000 RCX: 0000000000000000
>> 2022-12-22T14:09:51.419444+08:00 [localhost] kernel: RDX:
>> 0000000010000088 RSI: 0000000000b0e2ba RDI: ffff888116227000
>> 2022-12-22T14:09:51.419445+08:00 [localhost] kernel: RBP:
>> ffff888116227000 R08: 0000000000000000 R09: ffff8881162272a8
>> 2022-12-22T14:09:51.419445+08:00 [localhost] kernel: R10:
>> 0000000000000000 R11: 0000000000000000 R12: 0000000000000024
>> 2022-12-22T14:09:51.419445+08:00 [localhost] kernel: R13:
>> 0000000000b0e2ba R14: 0000000000b0e2ba R15: 0000000000000000
>> 2022-12-22T14:09:51.419446+08:00 [localhost] kernel: FS:
>> 00007ff03fdf0b80(0000) GS:ffff88883f380000(0000)
>> knlGS:0000000000000000
>> 2022-12-22T14:09:51.419446+08:00 [localhost] kernel: CS:  0010 DS:
>> 0000 ES: 0000 CR0: 0000000080050033
>> 2022-12-22T14:09:51.419446+08:00 [localhost] kernel: CR2:
>> 0000000000000024 CR3: 000000013d64e006 CR4: 0000000000770ee0
>> 2022-12-22T14:09:51.419447+08:00 [localhost] kernel: PKRU: 55555554
> 
> Thanks for the report! I'm adding this to regzbot:
> 
> #regzbot ^introduced v6.1.1..v6.2
> #regzbot title f2fs: kernel NULL pointer dereference when writing file
> 

Oops, I mean:

#regzbot introduced v6.1.1..72a85e2b0a1e1e

Also, Cc'ed other F2FS maintainers and relevant lists.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

