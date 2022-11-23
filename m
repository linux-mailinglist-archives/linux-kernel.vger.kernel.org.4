Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27457636AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbiKWUQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiKWUQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:16:06 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52B86A75E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234561; bh=q7y8qz7WnRTekbSyTmq303ezVvyMqwg3OkXXsHNN7BQ=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=GDtvZV7W+OCDt2TWV7k9Ies9jiLF5sAhTo2dQYpKrTFntBDC9TW8L1YfxyV5quzYk4EBR3mU1EGlM5ETzOxvmeCq1EvDzmIbC1EFGuShHcQ6C3dg/tv69GUJDdIuYgsdAGHFgPCgjCoNZHZnJnfs8R7hjQuM5C+EBQjlg4GNqWAi9Bl7zUkgXhEI7N06rQZKHlNMOJpX64Rqs94LLNbAiJmI5jPIOvtPsgtOgdDp0EDpxRr6L3wRJzHcEOp3wJXaB3K+/ofzvthIhTnxlCHa/LtmjKcIAVKtflXdKsGRzwoxztPO0VOLyEbhruFwnQhiXKu/rg9xkAPBUPg23WbNrw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669234561; bh=VZyi8Wj2D8QiV81kZCgROgg7rjTIjP32MWKr2XQS7a/=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YJUPZN7wwN7r/39qNps4G94kI7/t1BOjWbmwV46T9GkjFPgg7EmZsfEYDqnmLxefYNiybW56MUqeW62+KMG79oNTnNPJgAgHmLvTPyT94erc5zMO94unP0Q4GOV80lGYVncha0CsQADvcB2iygUI5GAyojGTlAyVdgNh8ATxbtpYnTO3BkyazQl+DU0s2p8jdPuda3+t3+KSa9BD9vtQOPgf50yzvTl5a9cnVVy50iMdjW0hQo3p8y6SBu27jLAr8Z5pwTcLTyZpFWXeH8K5ZTcmPhZqUcWcIbn8aab94Tzi+ME8apZQ3Oeg06tcrWEqT7WxM2CDZxpqxjJlP9XK+w==
X-YMail-OSG: bslc1sUVM1n5.uFFiCBfpeIOgovbPH0CNvAkgxMtLLFX6wYF.cS.hL6cI8NzPkj
 OYfxwMbNEBkFBniMsvZ7POo7yaK04cjFJw8Vm7xPyDVdPTEYMy5tTsbXtgDP731bsBd0Hjx7Ztmn
 MCC_Ez_u2O58caVyg2sdYEjiPhcDK5Nva_LgUdXtZ38aRJSDXeBzFt2UF9zTZxKcYolJ_nBUl0Kv
 .hu58bUdZ6O1Lz9cmNeVDC3hX2ESqeXycqibiMiiCUQ0axKQRoHnqbJdqpjRceTULxNkJyMmBfvH
 S4HNdz0Fbj1zDXvGZ91U9Aa70yPQ9Bq5FGyZYq5HbMPcQwstbtfFjtsbHsTRZ8ObGg84Y37Rtli_
 BoJO9NF4bEVEXAkwc6kr34HuNTcyJ1RgHoE3yPJTew__MFc11P9RTzNlzrFv08t6RP49GxwND5qB
 oePxAESgAabCVjQbprhqnk81lc2wQGDTMoAN9HuU7xndWC9tAfYPFwcjgjA8gp5jGr3abnskBit5
 1rYsR3PmV9FmTBTBDjctWQZPHyv1sVgLnXIr8nOSsBF_XRqK64w9NKrlc41YDKdmD9rlyqzIgCr9
 5shusfT8ZlUVoRbxugY7dn2fj4ZFng77wFMGD7KUQtQi0ehjvQQnNUeyPRs6SWM7K.9OzzBFPbQD
 YmKp4Xa5qmqH3pKtlvxg1n993J0KgpOS.ZO87xv8d_tFoeNDSZNUGrrJ4jSh5gogCeKteoX5gZuq
 Az.eQBgfTe.js5PrHkV0ID11YbtiOT3f2QsW0RwmKDzKboS.3TBRUuNtkFnZywiNh1BwAXCohSNg
 xGZ4vi_O5xtCMgfp3.GSwRQfal6lv7fssBvh8jQr_D0DoMguwwk2V0AoU6bvc0IQpdpnYHDKzjey
 2HJYq6NuvvYVgXg9jprrtMLplKpk1isdUhW3m4giI0CVMAkKT0WkQ8YIifzi1Lovae3ZpQPsgnlv
 w01_C3sCV5_3zVV.AEFP6OkGv1gOvJgVuqUIJi0aKSlwAqDuc1oY9oamJOWgHZGrt5WXSIDC3aRT
 oQoIYAvi8ff9Py_3XsnJ2rAbbYkJh3rQusfAipdcJIJGsSfZxQT4LHtOMTFGyU8f1599LvlMdZQA
 TQmDfGMuQOaxNxsnS02kYQPrmqQIx3RhYjFuAWcQ7YpBscfGbgX4PNP7VQErsm074BWmCjKDT.v4
 J4HbyYZGa4g.sW1R5i97Kuf74a.0IiIgydxKmgUYBbklxkG8i4dSbcJ4F4Jt0ViKpogJwDeUZOgC
 db06UMl1SDSn2aSOV6WThU9zozh_q6XBJpUCUMK5oR.tL7oL3iRDDhBjjUaCEEBRPTi.Hf6erF.y
 o.dWBBSKmjKEE.XqLk_TIk9GpLX4EJlgB5jxFMFIS72RgJ1jPRTac8VBDBUVahmoAnXqVqLk6kbj
 wD_84xVx2HD3dDP7aZVKBeEvgEXeYhpXd2EaOEvHbYlnBFxVsw5YheW7LedQeecJbl2XEHBY12bB
 zAENIbOYAV_NubifonzUhbUM7knlpg6PuF6v2rokfv3sL4kix88ST4vkD2P6Ts_EufH5girs0YDb
 QKLd1ko1rTy0HEVNxhldjwmI7akB7wKGL6c006WxKcL9xmzbUOOuHFszto0en.wBpR8_h9xor7QS
 uiHukMQl9xnddPsPeUwgipZjmariNyncDgLdnHBJ06R4jLKaHMPPmnQPrOllkd5fFoZRIsPMLvmA
 qJVM_MMF3cZjDOkeTooH3nM4T7CiGFM6eS_uTEas4cuUOCesDYxPLEaiFIxaCeRKgoa1m4d4gQJu
 BEGkBdgCqcFoO8h_IRTxT7q1hOocfT30E2kybnCn2rT4Z492yrDx.VwwEecPycPMyoQMFqE21prt
 YmPWdrT5MbVSxGEpDE5ONLlj6u_.ooB7iw6HLSu8UBE7368RK6_LTuQleIedZ5AlRFM1mV_ooIu0
 HwEcg7vdC8y.aivSYgBcGEm1CFLQy7fga5StFIeTvoZFHn63odi0l_9Qg1IqTGjopq3xAuf.KRPq
 xDjHbyn3jeVYzYSAa1o3Wa39Y5y4MbAR1CstddiLmOLseso96cv2d0kSaaQ6jA.9oJqWYhxjC8Kf
 tL4WQrQtqSMzMbDGIQxTGaxrcUQlsg6mTE.0R8o9LRTuHDtFCDZZXAEmVe9kKnMprD7bxMOMLxSA
 A4r2aYU4RD_tHhMh9WUqfaaMAxWQQ9K2dW0DYD0cyLRCikU0npBnubzTKpoVMB9E1AztjgKr.Hlk
 yxUZJeQ16wuzBx64nv14PR8hjvSJ.DLgWfJsP8Ap3dx5hOSXHhbsrY9Zj8T.42mav.qHETHrmEoe
 M91qfcc0GnorvI0fNQnr5OYlemw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 20:16:01 +0000
Received: by hermes--production-bf1-5878955b5f-686fw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1f948ceb8dae6e5827701d3d40d1a9c3;
          Wed, 23 Nov 2022 20:15:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v3 0/9] LSM: Three basic syscalls
Date:   Wed, 23 Nov 2022 12:15:43 -0800
Message-Id: <20221123201552.7865-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20221123201552.7865-1-casey.ref@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

lsm_module_list() provides the LSM identifiers, in order, of the
security modules that are active on the system. This has been
available in the securityfs file /sys/kernel/security/lsm.

lsm_set_self_attr() changes the specified LSM attribute. Only one
attribute can be changed at a time, and then only if the specified
security module allows the change.

Patch 0001 changes the LSM registration from passing the name
of the module to passing a lsm_id structure that contains the
name of the module and adds an LSM identifier number to the lsm_id
structure.
Patch 0002 adds an attribute identifier to the lsm_id.
Patch 0003 adds the registered lsm_ids to a table.
Patch 0004 changes security_[gs]etprocattr() to use LSM IDs instead
of LSM names.
Patch 0005 implements lsm_get_self_attr().
Patch 0006 implements lsm_module_list().
Patch 0007 implements lsm_set_self_attr().
Patch 0008 wires up the syscalls.
Patch 0009 implements selftests for the three new syscalls.

https://github.com/cschaufler/lsm-stacking.git#lsm-syscall-6.1-rc5-v3

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

Casey Schaufler (9):
  LSM: Identify modules by more than name
  LSM: Identify the process attributes for each module
  LSM: Maintain a table of LSM attribute data
  proc: Use lsmids instead of lsm names for attrs
  LSM: lsm_get_self_attr syscall for LSM self attributes
  LSM: Create lsm_module_list system call
  LSM: lsm_set_self_attr syscall for LSM self attributes
  LSM: wireup Linux Security Module syscalls
  LSM: selftests for Linux Security Module infrastructure syscalls

 Documentation/userspace-api/index.rst         |   1 +
 Documentation/userspace-api/lsm.rst           |  70 ++++
 arch/alpha/kernel/syscalls/syscall.tbl        |   3 +
 arch/arm/tools/syscall.tbl                    |   3 +
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
 include/linux/lsm_hooks.h                     |  18 +-
 include/linux/security.h                      |  29 +-
 include/linux/syscalls.h                      |   6 +
 include/uapi/asm-generic/unistd.h             |  11 +-
 include/uapi/linux/lsm.h                      |  65 ++++
 kernel/sys_ni.c                               |   5 +
 security/Makefile                             |   1 +
 security/apparmor/lsm.c                       |   9 +-
 security/bpf/hooks.c                          |  13 +-
 security/commoncap.c                          |   8 +-
 security/landlock/cred.c                      |   2 +-
 security/landlock/fs.c                        |   2 +-
 security/landlock/ptrace.c                    |   2 +-
 security/landlock/setup.c                     |   6 +
 security/landlock/setup.h                     |   1 +
 security/loadpin/loadpin.c                    |   9 +-
 security/lockdown/lockdown.c                  |   8 +-
 security/lsm_syscalls.c                       | 264 ++++++++++++++
 security/safesetid/lsm.c                      |   9 +-
 security/security.c                           |  37 +-
 security/selinux/hooks.c                      |  11 +-
 security/smack/smack_lsm.c                    |   9 +-
 security/tomoyo/tomoyo.c                      |   9 +-
 security/yama/yama_lsm.c                      |   8 +-
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |   3 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |   3 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   3 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   3 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/lsm/Makefile          |  13 +
 tools/testing/selftests/lsm/config            |   2 +
 .../selftests/lsm/lsm_get_self_attr_test.c    | 268 ++++++++++++++
 .../selftests/lsm/lsm_module_list_test.c      | 149 ++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    | 328 ++++++++++++++++++
 55 files changed, 1424 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/userspace-api/lsm.rst
 create mode 100644 include/uapi/linux/lsm.h
 create mode 100644 security/lsm_syscalls.c
 create mode 100644 tools/testing/selftests/lsm/Makefile
 create mode 100644 tools/testing/selftests/lsm/config
 create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_module_list_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c

-- 
2.38.1

