Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8E76163CB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiKBNZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiKBNZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:25:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A08B2AC67
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 06:25:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y69so26416436ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KEANnS33bEO9OComS/RfvaYbha1mUhYu9cgHQ8+qg/0=;
        b=FCQDy4HbShLeWvIZlbdkC2Q3p5fx7HFY/HXd8tx6GDkvFlRvBOPNpxWBtfIkz1mqN9
         SOiJttinWCsV22FCARRdgrpkM/4ALl7nEZozp/qnSGDPMTW8CtKlqfupe5weq/q9P4xi
         Pzz37MFLvww7+uKQpTmC5Y6mCFAgvVaUQaObG5E11NsvyOvzaIJ/F6q4q8B7B+MpG06g
         CQkI9j9AFZKWoGruA5H7Qw3cQ8JU1jsNnarBNCcKxyN7EfpNFiK9A66TI7I401minacH
         8phPXyr5gij6FtTuKT6cqf/N7g1Gj9YVNGLDVFZzRP1Uj73JOuphdrycfvs2iIfSmlJ1
         Z9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KEANnS33bEO9OComS/RfvaYbha1mUhYu9cgHQ8+qg/0=;
        b=wZNXf2HDwBE8yKXhdUp1ZM2Tv9uEC6/IAs2fQfiVwBVWVrcL35QS3qYEiWTmP8EEt0
         f0ike0CXdHfSwwxF07J8dVIzLqRXQQO0CCP9QSQ06K6AmpPXXIA9WB308q0UgtY0bkRa
         uw6qmI4F/mSppKz2Vy19oj8Z2S0rq4JdYPYdv1O5ZvPaeFfuLtD/x97GsvqvqEJ1zBjG
         no6sPZdp6oDhjNcxmhTmq6XM2w4wB/rTAoz7l8xP7H3HOSoA4roqP9EKT4cAw+M2ds6S
         ayXuUb2ZZ1qDol89C7xBCWcKT5PTF0IZdr80m/zJo0LkckSCJmmSat7Zno8kuhzVQU6V
         1/Pg==
X-Gm-Message-State: ACrzQf08n9vcaC+355N/oNhogW4LmUWpymNEbQPL/S8DITEP+s/Kctkl
        VHwMyC1J6UnPfAnnnoXHKMReOI4OBQ+X8Airio7TaEsU3eS8IA==
X-Google-Smtp-Source: AMsMyM4xyAtrQjybBdpzAvkdZbmdZ+ueFu9DZG1carlBouNuAcheTbLP3cjnTJLDPbra1KE9cZDMXYtKBf2n4paFcDY=
X-Received: by 2002:a05:6402:1c0a:b0:463:3cda:3750 with SMTP id
 ck10-20020a0564021c0a00b004633cda3750mr18971921edb.341.1667395528856; Wed, 02
 Nov 2022 06:25:28 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 2 Nov 2022 18:55:17 +0530
Message-ID: <CA+G9fYv_4MwuRWsejvf6rMGp3u2uZntvH5QKKYd+05Y0PmKQJw@mail.gmail.com>
Subject: selftests: memfd: run_hugetlbfs_test.sh: invalid opcode: 0000 [#1]
 PREEMPT SMP
To:     open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Greg Thelen <gthelen@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        zhangyiru <zhangyiru3@huawei.com>, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel crash noticed while running selftests: memfd:
run_fuse_test.sh noticed on stable-rc 6.0.7-rc1 on qemu-i386
the image is built with gcc-11.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

# selftests: memfd: run_fuse_test.sh
# opening: ./mnt/memfd
# fuse: DONE
ok 2 selftests: memfd: run_fuse_test.sh
# selftests: memfd: run_hugetlbfs_test.sh
[  131.233621] run_hugetlbfs_t (1230): drop_caches: 3
[  131.455691] invalid opcode: 0000 [#1] PREEMPT SMP
[  131.456932] CPU: 1 PID: 1234 Comm: memfd_test Tainted: G
     N 6.0.7-rc1 #1
[  131.459108] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  131.461089] EIP: hugetlb_file_setup.cold+0x0/0x33
[  131.462221] Code: b8 ea ff ff ff e9 b2 91 2b ff 0f 0b c7 04 24 40
8a 3d de e8 a7 4a ff ff b8 ea ff ff ff e9 b7 9a 2b ff 0f 0b 0f 0b 0f
0b 0f 0b <0f> 0b 64 a1 58 88 96 de c6 05 b5 db 7f de 01 8b 90 ec 03 00
00 05
[  131.466509] EAX: c405fe18 EBX: 00000000 ECX: 00000020 EDX: 00000000
[  131.467628] ESI: 80000004 EDI: 00000005 EBP: c4433ecc ESP: c4433eac
[  131.468489] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010212
[  131.469378] CR0: 80050033 CR2: b7e123d0 CR3: 04e19000 CR4: 003506d0
[  131.470205] Call Trace:
[  131.470515]  __ia32_sys_memfd_create+0x196/0x220
[  131.471079]  __do_fast_syscall_32+0x77/0xd0
[  131.471589]  do_fast_syscall_32+0x32/0x70
[  131.472075]  do_SYSENTER_32+0x15/0x20
[  131.472524]  entry_SYSENTER_32+0x98/0xf6
[  131.473095] EIP: 0xb7ed5549
[  131.473459] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01
10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f
34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
8d 76
[  131.475774] EAX: ffffffda EBX: 0804b486 ECX: 80000004 EDX: 080493de
[  131.476527] ESI: b7cb3220 EDI: b7da98e0 EBP: bfb06748 ESP: bfb066dc
[  131.477299] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[  131.478100] Modules linked in: configfs fuse [last unloaded: test_strscpy(N)]
[  131.478927] ---[ end trace 0000000000000000 ]---
[  131.479606] EIP: hugetlb_file_setup.cold+0x0/0x33
[  131.480192] Code: b8 ea ff ff ff e9 b2 91 2b ff 0f 0b c7 04 24 40
8a 3d de e8 a7 4a ff ff b8 ea ff ff ff e9 b7 9a 2b ff 0f 0b 0f 0b 0f
0b 0f 0b <0f> 0b 64 a1 58 88 96 de c6 05 b5 db 7f de 01 8b 90 ec 03 00
00 05
[  131.482391] EAX: c405fe18 EBX: 00000000 ECX: 00000020 EDX: 00000000
[  131.483167] ESI: 80000004 EDI: 00000005 EBP: c4433ecc ESP: c4433eac
[  131.483937] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010212
[  131.484778] CR0: 80050033 CR2: b7e123d0 CR3: 04e19000 CR4: 003506d0
# ./run_hugetlbfs_test.sh: line 60:  1234 Segmentation fault
./memfd_test hugetlbfs
# opening: ./mnt/memfd
# fuse: DONE
ok 3 selftests: memfd: run_hugetlbfs_test.sh


metadata:
  git_ref: linux-6.0.y
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
  git_sha: 436175d0f780af8302164b3102ecf0ff99f7a376
  git_describe: v6.0.6-241-g436175d0f780
  kernel_version: 6.0.7-rc1
  kernel-config: https://builds.tuxbuild.com/2GyMVgOGkjCgZnY68fHRZ9jp3Y4/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc/-/pipelines/683032123
  artifact-location: https://builds.tuxbuild.com/2GyMVgOGkjCgZnY68fHRZ9jp3Y4
  toolchain: gcc-11


full test log,
https://lkft.validation.linaro.org/scheduler/job/5799502#L2038

--
Linaro LKFT
https://lkft.linaro.org
