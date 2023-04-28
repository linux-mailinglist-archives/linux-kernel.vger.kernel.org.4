Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D766F1F73
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346619AbjD1Uem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjD1Uek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:34:40 -0400
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3FA3C35
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714062; bh=HcSqGAscpSsz9QBmZ53aQY/RYhl+Z6flOcAIM/qd9ck=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=V4e9e7aJau6MrPWf4S3dlMyDES9uhv9nAln8TrgGRYGAUdooTMxOuMip58XRu+vx5RIrDgDIq+Iz3zfoDQQKVHvkRmr2RmmT6dEr8QTsRg4cRmY0hwRA+T4Z0w8nUkB9bDaHGPUgZOHHTSmX37PNY4E2YmmUKZnTKhdpgdYd9a46u6zxvdqaPRuCwvZ6GhPGMn3FzyVayVhVDkCSosBiIf6ag6znVANdA/81CCIJyPVmadR/Dkib6fR5GdMIj0FW9h6GXfR1TVa29So5nv2xHMLCMAmnpEwirnKV0U81c0XqK9z0CnTfvzdpA1BFjl8PZNMzc8NmpgFQz271uMhlWA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714062; bh=5id+1uXYntxt14jg305Yoy5EwXgtoU7qflFThG+2CGd=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sv3MFxZhwrqNaQIuUE7gWzgCL2Y7xjqaq0ScUnAohsc0/ohrpSGu8t1fdSk/FxNvpXPo/c/0pvhgSUV0k5jsspoeGXGb88zszRe4KK96Qh4ofaV7sgXA7p+WvCVf0Sc1fUak78zDB+EAtTq6jXlMhJ0C/o6NPAZFJXTWQNcK46bAQXhvujQNO/yk1WoGF2uNon8BtKAIuW6jKLXb6M8oxv+kVbTNyGd5zMmpaF/qlJdriXaFNi3DWsSADs5D6Lw1swoTZNQBW4xmxcZe9Km7BkCZFexLZPqOoQVYkqR9lD4TmC/sTYBXmJeJpBEZ5+hw8Suinbq5aEDLkf4dPWNh4Q==
X-YMail-OSG: miG5BBsVM1lOXCRKqNVwfnwN.s3WgHQZZLJTbuXPfs5vJBQS5Zg34nc.q9Poqiy
 Zlr_BpnudyTtMzRYhEhUgjxD5pDQ.OxE3P3WjQYAZH5GL97P1oVJercjOdJ6iz__dK.Zi0AXrl_W
 m1EhzZhT7tABCtU7BKJFg6xrRimbDanp9wT8rpEOPQRNgduncfC9DQAeE1renI.vT3gWjbO7NNjN
 9k8g3LloVZUvSssbOzHIrwfdh88.KXZEYqa_ueyBMiMoiLNb2bhcLha7n1qQqezJTPf6iFo.vUBB
 VHAsAQWa5pxDd6ewuYjOffVHsEsPijDiRRS8cRl9g.5DjR4gLpbMgJKQ7o5b5i3z8oQ3h1Lmzryh
 HEM0YRHjNg5ZIG8vGxTwd.zVlq2lF1tT0A_SWlNYNciXg.qrStHoQmJkC.euvROpNrZIcjvn2ARV
 S6PZEnCSlmnFkbsWwyIdlcn9GsEP5Y4bqDXOpOKRiVIuOn651baEAnhsGngWyKbBd_iqKADuBPYw
 bbAjpA5Vl97VKMgMf3LjZfRVVq5lhRXfSRjPEaw0VIm08rUZpEh9Lt1Kc.8Z6dnNNZEgQDjZYiGl
 660uDK4uLatuJIVCVF2JU_3tKAg7v3h329X0_m1MEPNaERkHxuTeWjMxpUPkCkoQm_xWPp7Jk0fS
 t_pPCVb6eNQUemRuUl1gGvihDXKZwftGcDP0PqoiN8qlAfK4tWctUi0mWlOuRA.4Rt.ves2R2ag4
 tgJGwcQ3qloE2n1O1Ut14JULu3vMk93km6vQOu9p5Z6Sj6iIfEeypjTB_ixjlLN4umHsOZVPrSzs
 8IPnzalYDKxO0eB2yT6ypEhe0uaCGrgGjCg6Eiht_GRGmG_Z5wsZIzxpvVdspih.SBFm6juc_Kia
 BB5UkSvGSCvKFIaJAdqniabv7ovltwVfCwZ0lAn315dAKWzkIP.dosWQBksO3SVwz2EqxlTXm.p2
 DWj6L09CNpAFa.g0.u4vFi4aiHZW16R3M6Yu3SbRr_sXbVg_rx4.45Rb5D71IPkZoV5D3p63W7DK
 dQE9zAYP17o3FZoa9n8DSFjRe1fJChVIpnBovfisFuxc25qqG8mg2JhWJR2nJNdmpWJFTA0fg8Qy
 KCnfNTvTBssdvkUnnGmenmiTSECsFey1tzhJFxmMKXqkpbanNdAZNRI65qeCYdmKomaQkmfeLw.k
 ugRXDiZGmP1fNV7fqapv51DqdybZp4RMI08so.MOfd50IlBvBAQd2ejngpY6dy7C7DPyTYctpHs4
 PmNV3ymGVGlq9heAwlYNT8BQdolw.avp5EwmrgbwLmCJAXKD2x.pAUyd4wrmqimzTVkYOGqsBcOo
 PII57ZiXA.EXb8rKHVxhcb1odf26Z31UPoPj3mFKoXseSw.Q2LI7oEzolzq.GJQGtUOybymp7Z3v
 Y5m8iJrgtSVW0bPJOvFG_bivzAHLP4GzriJHFcT4dJ3nJvef.c1t0zjVJtmZeOeXTKCkDRxyXDTb
 0DK8jiWgoWXAezG8S2t4qXmtNkKy8zx5TDcxz6BhztV.LVrRM_XoTUdIuCE6IgzNkI71_mRf37rK
 Z4ZK3uVP7gfr3L._JlAFuyjw_UEH2YyPE24b95oSLVEtnQVN9.qF8ju8OjaRN07WpNu3A9ky.MyR
 1GbT_kTRTRURPb4pb5NRKqqAtQLyL.2d00HJ1H0C6QWneroEDf28ZLY25xbIgM0SsgHOCXo11793
 pGH7zhES99.RTCYH5sSlIkyapSWqSSjy_88CU2.uSLiL2o8z7YRYfIS2IvGGApWUtpPys806Y5.b
 2Y0soILhVCXWPGvMyu7YFJpqvpm.i9wtlLqlj7f3h9lVf.qfwjarZziBruKO8Liqp0oZ6iH4lhbB
 .ruLrg4djXPgB9jumZlCi7q78Dej4NbAyDumPhBsBipcgQ5ldge912paog_z359ialvohIycE.bl
 EYgfPcHv7qxksuyns7YNhlqWhR6311bbb98tNzgmorOj92M8V32VXEGXEOTlHwTri5Qn.K85_dEQ
 AVpfeSACjPZGBn0ldSn15NAgAfDAFUTxlQVFlOlsBk5gb1HcOAcIFqZSYLjjfDwhoQXOIIlLCwmG
 eeoNfJmGp1ifQ9GJfZStxOKtJg7D15PSqsNIjSrC6REYKXNtrP9Orm0kHyrCqjnsurD8fjdA3FLs
 UXcdy0UIyJYUo2Q7A2YT_25IMyFPVJ4n0MzPnmlr5fwKwxSvGNf7CHlkkOPOU3STgXjK1_hAHDHq
 dpiGG1g8J_kkhgIA7wAsqZU4Y4BurMN_eRzSF15Y3P_bbaEhfEyhqIUPeDFMzCGqDpWcyBzqQbQq
 zk4R4LPvDAYFcABiYK86NdgDd0S1HqlQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 516b36b4-1826-43e8-9c6b-ae302a9b8283
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:34:22 +0000
Received: by hermes--production-ne1-7dbd98dd99-84p8v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1804015e38ebd45733da2d1b7adda460;
          Fri, 28 Apr 2023 20:34:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 00/11] LSM: Three basic syscalls
Date:   Fri, 28 Apr 2023 13:34:06 -0700
Message-Id: <20230428203417.159874-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230428203417.159874-1-casey.ref@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add three system calls for the Linux Security Module ABI.

lsm_get_self_attr() provides the security module specific attributes
that have previously been visible in the /proc/self/attr directory.
For each security module that uses the specified attribute on the
current process the system call will return an LSM identifier and
the value of the attribute. The LSM and attribute identifier values
are defined in include/uapi/linux/lsm.h

LSM identifiers are simple integers and reflect the order in which
the LSM was added to the mainline kernel. This is a convention, not
a promise of the API. LSM identifiers below the value of 100 are
reserved for unspecified future uses. That could include information
about the security infrastructure itself, or about how multiple LSMs
might interact with each other.

A new LSM hook security_getselfattr() is introduced to get the
required information from the security modules. This is similar
to the existing security_getprocattr() hook, but specifies the
format in which string data is returned and requires the module
to put the information into a userspace destination.

lsm_set_self_attr() changes the specified LSM attribute. Only one
attribute can be changed at a time, and then only if the specified
security module allows the change.

A new LSM hook security_setselfattr() is introduced to set the
required information in the security modules. This is similar
to the existing security_setprocattr() hook, but specifies the
format in which string data is presented and requires the module
to get the information from a userspace destination.

lsm_list_modules() provides the LSM identifiers, in order, of the
security modules that are active on the system. This has been
available in the securityfs file /sys/kernel/security/lsm.

Patch 0001 changes the LSM registration from passing the name
of the module to passing a lsm_id structure that contains the
name of the module, an LSM identifier number and an attribute
identifier.
Patch 0002 adds the registered lsm_ids to a table.
Patch 0003 changes security_[gs]etprocattr() to use LSM IDs instead
of LSM names.
Patch 0004 implements lsm_get_self_attr() and lsm_set_self_attr().
New LSM hooks security_getselfattr() and security_setselfattr() are
defined.
Patch 0005 implements lsm_list_modules().
Patch 0006 wires up the syscalls.
Patch 0007 implements helper functions to make it easier for
security modules to use lsm_ctx structures.
Patch 0008 provides the Smack implementation for [gs]etselfattr().
Patch 0009 provides the AppArmor implementation for [gs]etselfattr().
Patch 0010 provides the SELinux implementation for [gs]etselfattr().
Patch 0011 implements selftests for the three new syscalls.

https://github.com/cschaufler/lsm-stacking.git#lsm-syscalls-6.3-rc7-v10-e

v10: Correct use of __user.
     Improve a few comments.
     Revert unnecessary changes in module initialization.
v9: Support a flag LSM_FLAG_SINGLE in lsm_get_self_attr() that
    instructs the call to provide only the attribute for the LSM
    identified in the referenced lsm_ctx structure.
    Fix a typing error.
    Change some coding style.
v8: Allow an LSM to provide more than one instance of an attribute,
    even though none of the existing modules do so.
    Pad the data returned by lsm_get_self_attr() to the size of
    the struct lsm_ctx.
    Change some displeasing varilable names.
v7: Pass the attribute desired to lsm_[gs]et_self_attr in its own
    parameter rather than encoding it in the flags.
    Change the flags parameters to u32.
    Don't shortcut out of calling LSM specific code in the
    infrastructure, let the LSM report that doesn't support an
    attribute instead. With that it is not necessary to maintain
    a set of supported attributes in the lsm_id structure.
    Fix a typing error.
v6: Switch from reusing security_[gs]procattr() to using new
    security_[gs]selfattr() hooks. Use explicit sized data types
    in the lsm_ctx structure.

v5: Correct syscall parameter data types.

v4: Restore "reserved" LSM ID values. Add explaination.
    Squash patches that introduce fields in lsm_id.
    Correct a wireup error.

v3: Add lsm_set_self_attr().
    Rename lsm_self_attr() to lsm_get_self_attr().
    Provide the values only for a specifed attribute in
    lsm_get_self_attr().
    Add selftests for the three new syscalls.
    Correct some parameter checking.

v2: Use user-interface safe data types.
    Remove "reserved" LSM ID values.
    Improve kerneldoc comments
    Include copyright dates
    Use more descriptive name for LSM counter
    Add documentation
    Correct wireup errors


Casey Schaufler (11):
  LSM: Identify modules by more than name
  LSM: Maintain a table of LSM attribute data
  proc: Use lsmids instead of lsm names for attrs
  LSM: syscalls for current process attributes
  LSM: Create lsm_list_modules system call
  LSM: wireup Linux Security Module syscalls
  LSM: Helpers for attribute names and filling lsm_ctx
  Smack: implement setselfattr and getselfattr hooks
  AppArmor: Add selfattr hooks
  SELinux: Add selfattr hooks
  LSM: selftests for Linux Security Module syscalls

 Documentation/userspace-api/index.rst         |   1 +
 Documentation/userspace-api/lsm.rst           |  73 +++++
 MAINTAINERS                                   |   1 +
 arch/alpha/kernel/syscalls/syscall.tbl        |   3 +
 arch/arm/tools/syscall.tbl                    |   3 +
 arch/arm64/include/asm/unistd.h               |   2 +-
 arch/arm64/include/asm/unistd32.h             |   6 +
 arch/ia64/kernel/syscalls/syscall.tbl         |   3 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   3 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   3 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   3 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   3 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   3 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   3 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   3 +
 arch/s390/kernel/syscalls/syscall.tbl         |   3 +
 arch/sh/kernel/syscalls/syscall.tbl           |   3 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   3 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   3 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   3 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   3 +
 fs/proc/base.c                                |  29 +-
 fs/proc/internal.h                            |   2 +-
 include/linux/lsm_hook_defs.h                 |   4 +
 include/linux/lsm_hooks.h                     |  25 +-
 include/linux/security.h                      |  45 ++-
 include/linux/syscalls.h                      |   6 +
 include/uapi/asm-generic/unistd.h             |  11 +-
 include/uapi/linux/lsm.h                      |  90 ++++++
 kernel/sys_ni.c                               |   5 +
 security/Makefile                             |   1 +
 security/apparmor/include/procattr.h          |   2 +-
 security/apparmor/lsm.c                       | 110 ++++++-
 security/apparmor/procattr.c                  |  10 +-
 security/bpf/hooks.c                          |   9 +-
 security/commoncap.c                          |   8 +-
 security/landlock/cred.c                      |   2 +-
 security/landlock/fs.c                        |   2 +-
 security/landlock/ptrace.c                    |   2 +-
 security/landlock/setup.c                     |   6 +
 security/landlock/setup.h                     |   1 +
 security/loadpin/loadpin.c                    |   9 +-
 security/lockdown/lockdown.c                  |   8 +-
 security/lsm_syscalls.c                       | 118 ++++++++
 security/safesetid/lsm.c                      |   9 +-
 security/security.c                           | 211 +++++++++++++-
 security/selinux/hooks.c                      | 163 +++++++++--
 security/smack/smack_lsm.c                    | 114 +++++++-
 security/tomoyo/tomoyo.c                      |   9 +-
 security/yama/yama_lsm.c                      |   8 +-
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |   3 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |   3 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   3 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   3 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/lsm/Makefile          |  12 +
 tools/testing/selftests/lsm/config            |   2 +
 .../selftests/lsm/lsm_get_self_attr_test.c    | 270 ++++++++++++++++++
 .../selftests/lsm/lsm_list_modules_test.c     | 153 ++++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    |  70 +++++
 60 files changed, 1576 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/userspace-api/lsm.rst
 create mode 100644 include/uapi/linux/lsm.h
 create mode 100644 security/lsm_syscalls.c
 create mode 100644 tools/testing/selftests/lsm/Makefile
 create mode 100644 tools/testing/selftests/lsm/config
 create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c

-- 
2.39.2

