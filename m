Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F1E6D9258
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbjDFJLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjDFJLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:11:48 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3778198
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:11:46 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id h27so33871997vsa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680772306;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nt5MWSzb3FbZtU+1uNYJNNSGTYcpJLDBXRXOFdKZxAk=;
        b=p0j/QrwKvGKeFXsTyQ8axk6zXJEsMnXjgqXaEcSxDEP5OgnoRYpJaAwAdgk2/2V2JZ
         X6lHoK/y5PKvufkguLAZ8w+Q+jugSLOw0uRgFOyRDt5hAKGd0Q3HU7jBCTj+o/UgziSy
         a5vcKYQsdqDcVHUwCJcFhyyS7ay6Gl8OMUcDF/WQDGIybh/0DzgmpzeUsgHqEL/O0cx6
         z0kqxXb356FphA3G1mEpbTLfebS3BmaRL8iBKnvJOpbuV6Xmk8zTJXoGaJWMjHnDQQoB
         0EWMmLDvyNHv1FYasyCGbk2aouSDcWcK3+thdXeFD4l9Al+S3+BAip+SqPnUanjqr4Og
         plMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680772306;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nt5MWSzb3FbZtU+1uNYJNNSGTYcpJLDBXRXOFdKZxAk=;
        b=n422JRfh7Kovk3jndRYB3eiNSCljh9k0pRZ8jAVuK6RlyMpIy1S/+RCtNV8tklQeRz
         B4yUDCAI5l+YFCBpszEbfvDw4ecIhMw1DmeBl3IpSfD6aH2pazNJWYspSweSwQcpOCdy
         5YZP8N/GUdRig6DsqrRXMaBz/WmnxguEWYjoAEl1txc/RSlEBXoDVWk/JWrRHwdJVs0e
         +jvCnIxGmXEuiYOZc63ZTZcoCF3ZeYSiVc0yE/xLqteVDa8qaI8ORyYOBPgBKTiTsAEk
         tzZuKYb2J5foIFxpP8WvZL9i4sMRik8uVnjRyhRFF+zenCLxNSCq+Tbf6O3nw0ZyjgEr
         aLxQ==
X-Gm-Message-State: AAQBX9eCFBjdx594HmSVMGhnVTwoNDjevgGjU7sy3SneBEHMDKd9lls4
        wXEG6evC2eqDwPcKW6AST7D5I7FxKHNQEN27BR3eA6oYqxrOkZE78EM=
X-Google-Smtp-Source: AKy350awbraktxUP5NPvPDY0O+gIHkJEnPyy5aZIhINoyPDxCVeaUMIQwJCYF1O9ZSiV15O+GLo+8potamG+HP54I30=
X-Received: by 2002:a67:d20f:0:b0:426:392a:92bc with SMTP id
 y15-20020a67d20f000000b00426392a92bcmr6977769vsi.1.1680772305562; Thu, 06 Apr
 2023 02:11:45 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 6 Apr 2023 14:41:34 +0530
Message-ID: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
Subject: LTP: list of failures on 32bit and compat mode
To:     open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, llvm@lists.linux.dev
Cc:     chrubis <chrubis@suse.cz>, pvorel@suse.cz,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following LTP syscalls failed on the i386 and arm environments with
Linux next / mainline kernels. The userspace is coming from Open
Embedded kirkstone.

Anyone seeing this problem on 32-bit i386 or arm ?
You get to see "segfault" in the following logs that have been noticed
on i386 only.

This is not a new problem. We have been noticing these failures for a
really long time.
Would it be worth investigating the reason for failures on 32bit architectures ?

Test logs,
-----
[    0.000000] Linux version 6.3.0-rc5-next-20230406 (tuxmake@tuxmake)
(i686-linux-gnu-gcc (Debian 11.3.0-11) 11.3.0, GNU ld (GNU Binutils
for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1680759389


Test environment: i386
Suite: ltp-syscalls
Toolchain: gcc-11


fstatfs02
fstatfs02    1  TPASS  :  expected failure - errno = 9 : Bad file descriptor
fstatfs02    2  TBROK  :  tst_sig.c:232: unexpected signal SIGSEGV(11)
received (pid = 17841).
fstatfs02    3  TBROK  :  tst_sig.c:232: Remaining cases broken

---
ioctl03
ioctl03.c:85: TFAIL: (UNKNOWN 0x40)


----
mq_timedreceive01

[  283.875014] mq_timedreceive[2354]: segfault at b7f5a004 ip b7dc1b0f
sp bfc4dde0 error 4 in libc.so.6[b7d52000+175000] likely on CPU 2
(core 2, socket 0)
[  283.894804] Code: 65 c7 07 4b 00 00 00 b8 ff ff ff ff e9 7b fe ff
ff 8d b4 26 00 00 00 00 8d 76 00 f3 0f 1e fb 83 ec 1c 8b 44 24 30 85
c0 74 1d <8b> 50 04 c7 44 24 0c 00 00 00 00 8b 00 89 54 24 08 89 04 24
c1 f8
[  283.913703] audit: type=1701 audit(1680761716.789:31):
auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=2354
comm=\"mq_timedreceive\"
exe=\"/opt/ltp/testcases/bin/mq_timedreceive01\" sig=11 res=1
   0

mq_timedreceive01
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINTR (4)
tst_test.c:1581: TBROK: Test killed by SIGSEGV!


----
mq_timedsend01

[  283.982220] mq_timedsend01[2357]: segfault at b7f06004 ip b7d6dd6f
sp bfb58fe0 error 4 in libc.so.6[b7cfe000+175000] likely on CPU 0
(core 0, socket 0)
[  283.996745] Code: 65 c7 07 4b 00 00 00 b8 ff ff ff ff e9 7b fe ff
ff 8d b4 26 00 00 00 00 8d 76 00 f3 0f 1e fb 83 ec 1c 8b 44 24 30 85
c0 74 1d <8b> 50 04 c7 44 24 0c 00 00 00 00 8b 00 89 54 24 08 89 04 24
c1 f8
lls/mq_notify/..[  284.015564] audit: type=1701
audit(1680761716.891:32): auid=4294967295 uid=0 gid=0 ses=4294967295
subj=kernel pid=2357 comm=\"mq_timedsend01\"
exe=\"/opt/ltp/testcases/bin/mq_timedsend01\" sig=11 res=1
/utils/mq.h:70: TINFO: receive 1/1 message

mq_timedsend01.c:210: TPASS: mq_timedsend() failed expectedly: EFAULT (14)
tst_test.c:1581: TBROK: Test killed by SIGSEGV!

---

pread02_64

tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
pread02.[  319.705083] /dev/zero: Can't open blockdev
c:44: TPASS: pread(3, 1024, 0) (null) : ESPIPE (29)
tst_test.c:1581: TBROK: Test killed by SIGSEGV!

---
recvmmsg01

[  369.451748] recvmmsg01[3821]: segfault at b7cb1004 ip b7dd7413 sp
bf992430 error 4 in libc.so.6[b7cda000+175000] likely on CPU 3 (core
3, socket 0)
[  369.466232] Code: 26 00 00 00 00 66 90 f3 0f 1e fb 55 57 56 53 83
ec 2c 8b 5c 24 50 8b 44 24 40 8b 54 24 44 8b 4c 24 48 8b 74 24 4c 85
db 74 55 <8b> 7b 04 c7 44 24 1c 00 00 00 00 83 ec 08 8b 2b 89 7c 24 14
8b 7c
[  369.485043] audit: type=1701 audit(1680761802.360:44):
auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=3821
comm=\"recvmmsg01\" exe=\"/opt/ltp/testcases/bin/recvmmsg01\" sig=11
res=1
[  369.496491] mmap: remap_file_page (3822) uses deprecated
remap_file_pages() syscall. See Documentation/mm/remap_file_pages.rst.


recvmmsg01.c:92: TPASS: recvmmsg() overflow in nanoseconds in timeout
: EINVAL (22)
tst_test.c:1581: TBROK: Test killed by SIGSEGV!


---
semctl03

[  441.271399] semctl03[6093]: segfault at 0 ip b7e53fc0 sp bf93c0a0
error 4 in libc.so.6[b7d56000+175000] likely on CPU 1 (core 1, socket
0)
[  441.284432] Code: 24 5c ff 74 24 5c e8 cf fd ff ff 83 c4 10 85 c0
78 0e ba 04 00 14 00 0f a3 fa 0f 82 ba 00 00 00 83 c4 40 5b 5e 5f c3
8d 76 00 <8b> 03 31 d2 89 e6 66 0f 6e ca 89 04 24 8b 43 04 89 44 24 04
8b 43
[  441.303267] audit: type=1701 audit(1680761874.178:46):
auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=6093
comm=\"semctl03\" exe=\"/opt/ltp/testcases/bin/semctl03\" sig=11 res=1



semctl03.c:73: TPASS: semctl() with invalid IPC command : EINVAL (22)
tst_test.c:1581: TBROK: Test killed by SIGSEGV!

semctl04
semctl04.c:69: TBROK: semget(1628514830, 10, 600) failed: EEXIST (17)

semctl05
semctl05.c:54: TBROK: semget(1628514830, 10, 780) failed: EEXIST (17)

semctl07
semctl07.c:41: TFAIL: sem_nsems = 10, expected 1

----
sigtimedwait01


[  486.624973] sigtimedwait01[6644]: segfault at 5 ip b7d9758f sp
bfda7290 error 4 in libc.so.6[b7d80000+175000] likely on CPU 1 (core
1, socket 0)
[  486.639052] Code: c7 03 4b 00 00 00 b8 ff ff ff ff e9 3b fe ff ff
8d b4 26 00 00 00 00 8d 74 26 00 f3 0f 1e fb 83 ec 1c 8b 44 24 28 85
c0 74 1d <8b> 50 04 c7 44 24 0c 00 00 00 00 8b 00 89 54 24 08 89 04 24
c1 f8
[  486.659213] audit: type=1701 audit(1680761919.535:49):
auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=6644
comm=\"sigtimedwait01\" exe=\"/opt/ltp/testcases/bin/sigtimedwait01\"
sig=11 res=1


sigwait.c:344: TPASS: Child exited with expected code
tst_test.c:1581: TBROK: Test killed by SIGSEGV!

---


statfs02

statfs02    4  TPASS  :  expected failure: TEST_ERRNO=EFAULT(14): Bad address
statfs02    5  TBROK  :  tst_sig.c:232: unexpected signal SIGSEGV(11)
received (pid = 6728).
statfs02    6  TBROK  :  tst_sig.c:232: Remaining cases broken

---

statx01

statx01.c:138: TPASS: stx_nlink(1) is c[  833.666410] /dev/zero: Can't
open blockdev
orrect
statx01.c:82: TFAIL: statx.stx_mnt_id(421) is different from
mount_id(34280324422697381)[  833.678950] /dev/zero: Can't open
blockdev
 in /proc/self/mountinfo
statx01.c:88: TPASS: /proc/12304/fdinfo/3 mnt_id: = 421

---
ustat01

tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
ustat01.c:39: TBROK: stat(/,0xbfb96278) failed: EOVERFLOW (75)

tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
ustat02.c:57: TBROK: stat(/,0xbfa11098) failed: EOVERFLOW (75)



Details log:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230406/testrun/16119999/suite/ltp-syscalls/test/fstatfs02/log

List of test cases failed:
i386:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230406/testrun/16119999/suite/ltp-syscalls/tests/

arm - x15 device logs:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230406/testrun/16120012/suite/ltp-syscalls/tests/
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230406/testrun/16120012/suite/ltp-syscalls/test/fstatfs02/log

Test environment: qemu_x86_64-compat
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230406/testrun/16119789/suite/ltp-syscalls/tests/

Test environment: juno-r2-compat
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230406/testrun/16120000/suite/ltp-syscalls/tests/

- Naresh
