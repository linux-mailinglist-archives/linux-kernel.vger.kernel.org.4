Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17C66F1F40
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346239AbjD1U1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346158AbjD1U06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:26:58 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671AF2100
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713615; bh=HcSqGAscpSsz9QBmZ53aQY/RYhl+Z6flOcAIM/qd9ck=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=ljm1x81jXlvTAeYW4zWk+ExQrkxSSLe/l6iYf5YK5w4DRtkyuOZOF49OqNdh2/jrW68KabEvizv+UaljjH0bJ2/ifEocsfgSiHfxvMbkDFNukbEGUwF/68vMhJPRJiuIi6hZESVSUUMY+7iEOBnV+0uSvvv95+JXKZkdQkkjjBkruXfOYTzl0UeGXl/mWp8HElOyOYotFVUo7JNwAxXMtcK/748btaELsXkec/0RSnzMgPjf3oFkl/pjkdxqoGc54gRm1e2kNvR+ZDPOWSVzZ2txCEweLhtqUOdeWZEdVA29c1nDuvYAd4y7CsAII8ogmXAb5W2yp5bHAB2cNEyVSQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713615; bh=uNqtD4bSPdEXEQ20qM16nLb0mB5e/4NnVIMdWsQojYl=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=e2JuXv6+I6/PJb4LuVXnjncoIPNurI7bSX5KipTeEG101MihpqvxLNv0jbX+3ww6WsYQZNYADHqNwMf6HvaMfd1c04Oo+nRb0lNUzkPKIBbTsL4c2WUl+C8hPjIljZNSlwm2PhJR2ghRgdhDV6YAA9Crs9TqxAom6JtBeAkuxM0Oz75d32+jAqoyAgugiSHc/yFawBS/uapfhrrqAAaBF3CF8eUlPgiHiGkbSepzxFglN/Q2EmhOCyH39SYHhzHE8ImAc6XTv+FTiDZJK+u3ci2Ao1sHMq+N4hfnAxE/kb1QIrJwCkZf38G2Ggw9+CABCdTodwDNGfgyHXF9NHMrOg==
X-YMail-OSG: r4Ey42AVM1l0q80XI19Kai1M_picrrVzdH1jj5wsLSapbfXaUHltHG9LczZEh0.
 sRx8G.GCjaDdyglAnHGn0WnsDBArnJrb5CoXneyF_hvT9eYmu52WDRsrazhdFSGJFPPkrtlkLmYl
 vImWjkO5s1okBaYrz0x2o07UJggowlLq9oFydkfn3NRMZykB.VoJkzPmMTJ1r6XAYJyKGB__vc7i
 6OwY7_zJujJ189SwAWVi9CzS2YEamJvs03rCWxStptJzKgNEvCfndLzvqF9iMbOaLveuaWTOSICx
 sLddamtRnTMjIso8RCoVju8Plb_nLN407YATpl1jkoN2rILgrtFbYMUUw2p1SbhpMm1AfFSnZjTB
 ORpxN_40r6ZqIkAEPkwEI7g6ig1AAO6QSQX6AhYVQmJNV9DW3TmLcGZhqPYz5YVz4GftFCY1.Xkp
 7FGsOwncoDvWSfwnh4qdjBm1qQK.xxT5HIaaq5SneRAOq6xqFk20Wnqte0EMAa0LDgrZsqRS2Lqj
 hc6XbTC83OfWYEQhKzbDQzzav5vLIUFxZchqN_Iv3ZsUQWhpYzLLpP5LXvwCYCVcQebcDejFmukE
 zusNFJiI1V9NtAKbxbYEKm0lceTceSUI7OPyyIP5drn8BoEFAXaNugnX6Zp.mX6TqI19rzzCD4sr
 5ClOh2yMhV.Ed.BxBWsNRL_h84KrTNxRvopAkNhk5cNP5GobVJS6IhLdGvsScfAB1pxEBo0KJm8z
 QziU0JE1aJID0wLzJqEbRdCEn_SDVK6UGBfnRaASuRZk8rZRtVYhMla7z5ZrjJXNJtiAWiIJ6g2F
 nF7EEARYEDtrdGmENupqm_QW32hG2t1C67S1kjnTt.P22bTRSuNru1EqWhbgPoV.eTNhP7QLOYyq
 22jn1.BIk4GmWJ12A5IYA7.nwdwGoYYUNxPojuxKtHOUwyYCIFDdgK9QmECCa8fW85byl4NQuRtL
 fGtIm72qyZsd7oi3Jq_h1ZciuJUSbPUL8IgJmvXHerCZD4JLT9TOuThbsOWQmwt77J9_D8YtWHLA
 SkxcOpGXVBiMHpAqB5sjeFcYDJ_Q2vQ09WAVcpel_3lrCUs4DrrdVeyxHzW9ZZSR8BR_rkG0JH5f
 Cv4AvweRiJvFbUq2IiEE1MIge.mLk9xWz6FqzhJXGq8DHGNPi0zoMpnwQeTzk7kqOjCCFE4rxPZb
 oaTqLFDGhI1y_9rK6ntKXYp4zO3ZoRhJDrFKrqvbELXRAw4Cu_8d_G7T1yU53dw2YR4LREQYIKvG
 aq54jH9m_o0_zRLwzKu_tgZfpDq0jqQYIwie2y46HuNOQhXnLV3gxvpd8ujFtH9aANKL37SnTCQw
 fXfCJu6Zp98OK.2klJTQPwCw7LIqpr336AGJeseV42uYYAaetozM4eT1NpHDCa_MtkRVQ1x_nBRG
 d5ZTsetSlXZuHw.Ccqupxp5gkw5BRCSkzPDXW5H3KHH7x4KMeXWXkU6wzp94GOXbUjwlyNMUErQG
 wpas8Hs.pqZgQhfLFbJxOH4MX9DWk_oPScDfXDvIjugT138JPgj3ngjhFnQ_nyu_HR4TAcNqcyyL
 _N.aB3nVtYoTla715kKxVjmSRWWXv4YSAyh_QmSchHi1rl_Ni43EuQi7Dc619dNQVJ7V3ZYzU_k0
 LxpLgtqvHc2IlpTDwI6MFrXKx.1DBspq0Ngn3UVMGW4CJF6FMK1Av0OoZ9UK4M5Ih96JIhZL0OBc
 6cMz.teVLsaTPOxcnYaB04eRk1LPhRb1VPAAWUwIMYRpSVC_0LeJ2fa0kXVjBvWFGxEd1WfgdJsB
 opX4ib7uR5Xid_.PX.CFIQWFAvv7f5wBzrHL9_MV.lJSNfu3thec1o3MpVSZ2OIgnemqqUIC1h2h
 o0Dpg95PSqUPHDd2IXW_oFsI67rRvwaXhjCE8ZewEWurSQU1qd._AjFx6ibrKISRW4qCyF_xVzma
 l1flQrWXJZo98qCzoA1YP5BkDC0.1qDq.ohnbLM4QsXBN2tKUw24piQoqFYWXDS7FjDWUjD7.zwt
 VKf8BRAAFKL8YPptrBRTPrPC0g9WciM55hVqb_KhddaiyK0ax28qXmV0C0NsAKetnPQKodSUSQpa
 ckUYmvLAlYGMd0bunBJhM6ve_RdzB9QohG4CBcDOpqv36N0Q5yZ6Aub4x7E_U_aoTKQjJ1FnIZQR
 rLjyqi6CZGwT7GZ1Uyvp_.PYE37QiAOqJWAbe54YzzDC0D_M98jH8jf77mKOPaMHMWjQ9bfUq9AI
 RROXn0yA0n9Rr3I08CWYWlEz5rfUZhJuk6DHkRNovSdTESj1hztBPVQWwpbgfhRSJ3QqkE3I8qBx
 BnymJ2KJ0hxhKfQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 949a5b57-6953-4758-897d-1de89d9ed864
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:26:55 +0000
Received: by hermes--production-gq1-546798879c-dcj2l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a31e9fc13eb2c1a30c94ee11b9cd508a;
          Fri, 28 Apr 2023 20:26:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v10 00/11] LSM: Three basic syscalls
Date:   Fri, 28 Apr 2023 13:26:40 -0700
Message-Id: <20230428202651.159828-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230428202651.159828-1-casey.ref@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

