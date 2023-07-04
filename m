Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6966746ABB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGDHew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGDHeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:34:50 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1D611C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:34:48 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-791c27bb91dso3728988241.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688456087; x=1691048087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mJqu4MH4w3vfALtTNhkmRyJFrd9odC7gG1kZYwrkj3g=;
        b=nC5R+wzr0QFEuuwTxTKE0Frtc55EV8ODK3z1Mb0blxg+FxA91Ovwl3GsG2EMfK3sEY
         yPYOPM6+Al60SBACIZIBZ59WS9UOE3LbkHEZ2CeG5ABCVt1Ce94d8FBu1qY3IH25+CsY
         GZ+R/LIWKAWvAL0Q25RcmKpOhtbP6De4wX0CtAuS9jh3v1NXCYYcpzqSanDsJXm1rmVc
         QzplY3luljtnOsiqu8UB3KnqBYfEW3Bm6hhwBTKQ7VpjiPCWrtxxYVVikxJrm6OF3zWr
         z2n51tr9hN/ycVW6souav+CG6EV1k7LW8mGUiV3rGynnLz20aaTWL0zD6pWMjRBHuYpO
         HhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688456087; x=1691048087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJqu4MH4w3vfALtTNhkmRyJFrd9odC7gG1kZYwrkj3g=;
        b=YAgddOjS4PZFR6Xw1o1M+J3BYt/41/iKt3Uasm8q52mXcej/jL32Up6Kcbtt3l3jE8
         wvkwu+aqYPP5KSaYUzZdTFTVfs94cY8JkQ0+eauqnlxKMFhwHpOf54Yb1l3EAmECyMS7
         GkfsQresK8PE5hID0AHrnIAjYhgebcCp6Z6g8kQUn3xmWIszkv/M4yU+QoXv8y+xvnaP
         fZ0XYi7jpuNqBgtzU2XJS9UFT+mP+OnIUjxwg77spwt0BWkLNVtAqQuJqBfD3KIs9fR2
         AmR4p739H7dCqHUJD0vnEsfnOUmJ6uNVeUArDakX6SOSSTFzd4hUMa5tfJZe7HyYaCtP
         0UtA==
X-Gm-Message-State: AC+VfDwfQPaMBSeJf2/9WE5CnKXq3Cg8Ah382C/v08MaKIxkQ4xiTey+
        qlz0R9Wd+6VlWYc0c1VDFxoZxMY8gmsKJqJ0pbQHVw==
X-Google-Smtp-Source: ACHHUZ5bgZVPH/lYSfqTf808oLZGMRah1WWUdu34AEAZBpmk1vjWJB04VHPIVp49jmuK8Jl2REycj6tkOjlqNpTax28=
X-Received: by 2002:a05:6102:3e29:b0:443:5524:8f8b with SMTP id
 j41-20020a0561023e2900b0044355248f8bmr7077458vsv.4.1688456087354; Tue, 04 Jul
 2023 00:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230703184519.206275653@linuxfoundation.org>
In-Reply-To: <20230703184519.206275653@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Jul 2023 13:04:36 +0530
Message-ID: <CA+G9fYvf-sw8tCHjxhoMvHrtzzdE69EwvB2PmypUkGDdCFFASA@mail.gmail.com>
Subject: Re: [PATCH 6.3 00/13] 6.3.12-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 at 00:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.3.12 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 05 Jul 2023 18:45:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


While running LTP hugetlb testing on x86 the following kernel BUG noticed
on running stable-rc 6.3.12-rc1.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Crash log:
=========
[   54.386939] hugefallocate01 (410): drop_caches: 3
g tests.......
tst_hugepage.c:83: TINFO: 2 huge[   54.396708] BUG: kernel NULL
pointer dereference, address: 0000000000000034
[   54.404495] #PF: supervisor write access in kernel mode
[   54.409718] #PF: error_code(0x0002) - not-present page
[   54.414849] PGD 800000010394a067 P4D 800000010394a067 PUD 1033ba067 PMD 0
[   54.421721] Oops: 0002 [#1] PREEMPT SMP PTI
[   54.425900] CPU: 3 PID: 411 Comm: hugefallocate01 Not tainted 6.3.12-rc1 #1
[   54.432860] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.5 11/26/2020
[   54.440244] RIP: 0010:hugetlbfs_fallocate+0x256/0x580
[   54.445296] Code: 3d 6f 37 06 02 89 c3 48 c1 e3 05 48 01 df e8 71
fa cb 00 31 c9 31 d2 4c 89 e6 4c 89 f7 e8 72 a6 de ff 48 3d 00 f0 ff
ff 77 53 <f0> ff 48 34 74 43 48 03 1d 3d 37 06 02 48 89 df e8 25 f0 cb
00 48
[   54.464041] RSP: 0018:ffffab24409f7dc0 EFLAGS: 00010207
[   54.469260] RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
[   54.476390] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9fe006b253c0
[   54.483514] RBP: ffffab24409f7ec0 R08: 0000000000000000 R09: 0000000000000000
[   54.490640] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[   54.497762] R13: ffff9fe006a68010 R14: ffff9fe006a68188 R15: 0000000000000000
[   54.504887] FS:  00007f8bec2ff740(0000) GS:ffff9fe367b80000(0000)
knlGS:0000000000000000
[   54.512965] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.518702] CR2: 0000000000000034 CR3: 0000000101cd2003 CR4: 00000000003706e0
[   54.525826] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   54.532950] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   54.540075] Call Trace:
[   54.542519]  <TASK>
[   54.544618]  ? show_regs+0x6e/0x80
[   54.548022]  ? __die+0x29/0x70
[   54.551080]  ? page_fault_oops+0x154/0x470
[   54.555186]  ? do_user_addr_fault+0x2f3/0x580
[   54.559551]  ? exc_page_fault+0x6b/0x170
[   54.563502]  ? asm_exc_page_fault+0x2b/0x30
[   54.567686]  ? hugetlbfs_fallocate+0x256/0x580
[   54.572164]  vfs_fallocate+0x156/0x360
[   54.575921]  __x64_sys_fallocate+0x47/0x80
[   54.580018]  do_syscall_64+0x3c/0x90
[   54.583590]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   54.588642] RIP: 0033:0x7f8bec402baa
[   54.592213] Code: d8 64 89 02 b8 ff ff ff ff eb bd 0f 1f 44 00 00
f3 0f 1e fa 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 1d 01 00
00 0f 05 <48> 3d 00 f0 ff ff 77 5e c3 0f 1f 44 00 00 48 83 ec 28 48 89
54 24
[   54.610952] RSP: 002b:00007fff3fa4bcd8 EFLAGS: 00000246 ORIG_RAX:
000000000000011d
[   54.618515] RAX: ffffffffffffffda RBX: 00007fff3fa4bcf8 RCX: 00007f8bec402baa
[   54.625639] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
[   54.632765] RBP: 0000000000000002 R08: 0000000000000007 R09: 0000000000fd82a0
[   54.639889] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
[   54.647011] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   54.654151]  </TASK>
[   54.656364] Modules linked in: x86_pkg_temp_thermal
[   54.661244] CR2: 0000000000000034
[   54.664554] ---[ end trace 0000000000000000 ]---
[   54.669186] RIP: 0010:hugetlbfs_fallocate+0x256/0x580
[   54.674235] Code: 3d 6f 37 06 02 89 c3 48 c1 e3 05 48 01 df e8 71
fa cb 00 31 c9 31 d2 4c 89 e6 4c 89 f7 e8 72 a6 de ff 48 3d 00 f0 ff
ff 77 53 <f0> ff 48 34 74 43 48 03 1d 3d 37 06 02 48 89 df e8 25 f0 cb
00 48
[   54.692972] RSP: 0018:ffffab24409f7dc0 EFLAGS: 00010207
[   54.698190] RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
[   54.705315] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9fe006b253c0
[   54.712447] RBP: ffffab24409f7ec0 R08: 0000000000000000 R09: 0000000000000000
[   54.719578] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[   54.726703] R13: ffff9fe006a68010 R14: ffff9fe006a68188 R15: 0000000000000000
[   54.733827] FS:  00007f8bec2ff740(0000) GS:ffff9fe367b80000(0000)
knlGS:0000000000000000
[   54.741904] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.747641] CR2: 0000000000000034 CR3: 0000000101cd2003 CR4: 00000000003706e0
[   54.754765] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   54.761890] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   54.769012] note: hugefallocate01[411] exited with irqs disabled
page(s) reserved
tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
tst_test.c:1612: TINFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1614: TBROK: Test killed! (ti[   54.791850] hugefallocate02
(412): drop_caches: 3
meout?)

Summa[   54.798824] BUG: kernel NULL pointer dereference, address:
0000000000000034
[   54.806185] #PF: supervisor write access in kernel mode
[   54.811402] #PF: error_code(0x0002) - not-present page
[   54.816532] PGD 8000000103ace067 P4D 8000000103ace067 PUD 1076d0067 PMD 0
[   54.823406] Oops: 0002 [#2] PREEMPT SMP PTI
[   54.827584] CPU: 1 PID: 413 Comm: hugefallocate02 Tainted: G      D
           6.3.12-rc1 #1
[   54.836015] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.5 11/26/2020
[   54.843400] RIP: 0010:hugetlbfs_fallocate+0x256/0x580
[   54.848478] Code: 3d 6f 37 06 02 89 c3 48 c1 e3 05 48 01 df e8 71
fa cb 00 31 c9 31 d2 4c 89 e6 4c 89 f7 e8 72 a6 de ff 48 3d 00 f0 ff
ff 77 53 <f0> ff 48 34 74 43 48 03 1d 3d 37 06 02 48 89 df e8 25 f0 cb
00 48
[   54.867215] RSP: 0018:ffffab24409f7dc0 EFLAGS: 00010207
[   54.872434] RAX: 0000000000000000 RBX: 00000000000000c0 RCX: 0000000000000000
[   54.879566] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9fe003b2c300
[   54.886689] RBP: ffffab24409f7ec0 R08: 0000000000000000 R09: 0000000000000000
[   54.893813] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[   54.900939] R13: ffff9fe004f3c010 R14: ffff9fe004f3c188 R15: 0000000000000000
[   54.908070] FS:  00007f8454bee740(0000) GS:ffff9fe367a80000(0000)
knlGS:0000000000000000
[   54.916189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.921928] CR2: 0000000000000034 CR3: 0000000106a24001 CR4: 00000000003706e0
[   54.929051] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   54.936193] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   54.943317] Call Trace:
[   54.945763]  <TASK>
[   54.947859]  ? show_regs+0x6e/0x80
[   54.951290]  ? __die+0x29/0x70
[   54.954341]  ? page_fault_oops+0x154/0x470
[   54.958435]  ? do_user_addr_fault+0x2f3/0x580
[   54.962818]  ? exc_page_fault+0x6b/0x170
[   54.966745]  ? asm_exc_page_fault+0x2b/0x30
[   54.970931]  ? hugetlbfs_fallocate+0x256/0x580
[   54.975407]  vfs_fallocate+0x156/0x360
[   54.979161]  __x64_sys_fallocate+0x47/0x80
[   54.983254]  do_syscall_64+0x3c/0x90
[   54.986832]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   54.991876] RIP: 0033:0x7f8454cf1baa
[   54.995449] Code: d8 64 89 02 b8 ff ff ff ff eb bd 0f 1f 44 00 00
f3 0f 1e fa 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 1d 01 00
00 0f 05 <48> 3d 00 f0 ff ff 77 5e c3 0f 1f 44 00 00 48 83 ec 28 48 89
54 24
[   55.014193] RSP: 002b:00007ffdbcb38428 EFLAGS: 00000246 ORIG_RAX:
000000000000011d
[   55.021752] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8454cf1baa
[   55.028877] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
[   55.036009] RBP: 0000000000000003 R08: 0000000000000040 R09: 00007f8454de10a0
[   55.043155] R10: 0000000000600000 R11: 0000000000000246 R12: 00007ffdbcb38448
[   55.050333] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   55.057459]  </TASK>
[   55.059641] Modules linked in: x86_pkg_temp_thermal
[   55.064513] CR2: 0000000000000034
[   55.067825] ---[ end trace 0000000000000000 ]---
[   55.072442] RIP: 0010:hugetlbfs_fallocate+0x256/0x580
[   55.077495] Code: 3d 6f 37 06 02 89 c3 48 c1 e3 05 48 01 df e8 71
fa cb 00 31 c9 31 d2 4c 89 e6 4c 89 f7 e8 72 a6 de ff 48 3d 00 f0 ff
ff 77 53 <f0> ff 48 34 74 43 48 03 1d 3d 37 06 02 48 89 df e8 25 f0 cb
00 48
[   55.096235] RSP: 0018:ffffab24409f7dc0 EFLAGS: 00010207
[   55.101458] RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
[   55.108584] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9fe006b253c0
[   55.115708] RBP: ffffab24409f7ec0 R08: 0000000000000000 R09: 0000000000000000
[   55.122838] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[   55.129962] R13: ffff9fe006a68010 R14: ffff9fe006a68188 R15: 0000000000000000
[   55.137087] FS:  00007f8454bee740(0000) GS:ffff9fe367a80000(0000)
knlGS:0000000000000000
[   55.145200] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   55.150937] CR2: 0000000000000034 CR3: 0000000106a24001 CR4: 00000000003706e0
[   55.158062] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   55.165194] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   55.172318] note: hugefallocate02[413] exited with irqs disabled
ry:
passed   0[   55.179411] hugefallocate02 (412) used greatest stack
depth: 12520 bytes left


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.11-14-gec916e7bb7e9/testrun/18102965/suite/log-parser-test/test/check-kernel-bug/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.11-14-gec916e7bb7e9/testrun/18102965/suite/log-parser-test/tests/
 - https://lkft.validation.linaro.org/scheduler/job/6568036#L1767
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.11-14-gec916e7bb7e9/testrun/18116377/suite/log-parser-test/test/check-kernel-bug/log

metadata:
  git_ref: linux-6.3.y
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
  git_sha: ec916e7bb7e9c20ced0d1fbf4caf972af2cecec9
  git_describe: v6.3.11-14-gec916e7bb7e9
  kernel_version: 6.3.12-rc1
  kernel-config:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2S4gySfB44bWUQMh7uOgHpyRaMP/config
  build-url:
    https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc/-/pipelines/919663089
  artifact-location:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2S4gySfB44bWUQMh7uOgHpyRaMP/
  toolchain: gcc-11



## Build
* kernel: 6.3.12-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.3.y
* git commit: ec916e7bb7e9c20ced0d1fbf4caf972af2cecec9
* git describe: v6.3.11-14-gec916e7bb7e9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.11-14-gec916e7bb7e9

## Test Regressions (compared to v6.3.11)

* qemu-x86_64, log-parser-test
  - check-kernel-bug
  - check-kernel-exception
  - check-kernel-invalid-opcode
  - check-kernel-kasan
  - check-kernel-kfence
  - check-kernel-oops
  - check-kernel-panic
  - check-kernel-warning

* x86, log-parser-boot
  - check-kernel-warning

* x86, log-parser-test
  - check-kernel-bug
  - check-kernel-oops

* x86-kasan, log-parser-boot
  - check-kernel-warning

* x86_64-clang, log-parser-boot
  - check-kernel-warning

* x86_64-clang, log-parser-test
  - check-kernel-bug
  - check-kernel-oops


## Metric Regressions (compared to v6.3.11)

## Test Fixes (compared to v6.3.11)

## Metric Fixes (compared to v6.3.11)

## Test result summary
total: 161897, pass: 132775, fail: 1650, skip: 27332, xfail: 140

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 144 passed, 1 failed
* arm64: 54 total, 53 passed, 1 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 25 passed, 1 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

## Test suites summary
* boot
* fwts
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-exec
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
