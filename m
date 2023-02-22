Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF8569FCBC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjBVUJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjBVUI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:08:59 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1D51A96D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096532; bh=cIKOO9r2wqTmeyYq9QU+7bBeRSW9vmbA6bdOk3O6M78=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=qgpu6rIbbJYDj4dwPLDniuJ76YqGYdw4xIdZY1vIvJ/musbFIMf11eSQn+EHMY3ve+eg0cxmHKy9hbB9GWGJyY6eqYCPFa/dy7bgUpkLja6AuV5rF7UGtlWOgp1pki9Wwh5cHM03Lbr96Ua+MGG7/iXW3fU9t2AJX/a3IRj4F6XSUsJDHgMXLIV6Bc1bQzlbDKoDx7joIQhnFeUso+n8FSm0nFFB12h7p8/BwDVrFn9sNoh7gSvF2YRBkT46acm4ws6Fowy7lWUDCRmVrAEYfLIe/wH/TqiWpD/8hYrrFzjfM4LcHEm2xavjIeA23zTvJi0EfNkZbxOCSDUlbb1zWw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096532; bh=xA4RBVGrsK60nrHAidWpXpXLOlndP7FsRVLIXKcVdF5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=eKqvoWdJNtfB9moZgxNoJx9VyuJ7kFPZcOh6AONJyiyRWUz5Y8UpaaYrTw07fW/hkd0Q/CwI3DgcU5qx9Cm/qwWH1zujePygynJ4TRqqsgh5rCFwwjJmNjL1yuDjRQnyCO/HTh5f9IZb7Kcx8iQ8WhOoAgAgAxCvhX6RMHM3MJSTRgSmaXCYlVfXrodameeGlr8xlngmPga4etLa1AUPhEI4gG2nTOZL0JB8bMuRrnIOPGj5rHoM61FXPvdZ65W3Y9KrfqkpErafJlNHpjqSkjJgesScgEvGncp78D0j29bqGXYJ49MG8seGTNnzktwXIiKnyFY9e+qcpBn0AZ/ofQ==
X-YMail-OSG: 4O1ld8cVM1lxBroL9LH2FM2xNeRl44doWmVsSkDvibu6lKwzDX3.uiJPyLdyFr9
 l3Y6Rdjhu40CJVIUDsnqaJxOSnZ3s0WN90CPC_cqutwmA.fsuf5k8rHKchj8cv1AuJwHafxzq7My
 ghHDHeWYmBrt8lrxJ9WkM3N4kd_EJzBhNY0V_rlJSJgbBlK07InLWPsm3MhGZtVR0C4JcnFrGP3r
 UA66ULl4GuLkxsCOlOK.ox5iXyhNX8svS9J2zKyGb3WmYnNUoHOG07XBbf85Lya3audTSDyCzHvT
 rn4SaL2sZitdtoJoYc3HmtMCB4p60rmWcky_loScDgViFd3cg8d5uOsm7GdTTX5pscU.Nbc5EpQB
 IjaLGm9p0ZBPChMaIiBN7UgzwBQX6PYhqFIOHyV16s1CMfsbKBbF33XL99agIodKbiZTkzRhVOYH
 gxnZZKP6BwgvTVhfJTVntz.XP7WtoS26shJxtuc1iFTcO2qwwHEqQKO31SnaifLb5xrngnniL9LH
 vcvNBIwSqRgUSSOnWD35JQkUcfckMHKM8XPBAxvQyEnjjMDAJTRpvSEmYqh8COVspE2XPIn4WAwH
 a3MGmgNZnnRhBCSk1eW.aXbjRJ1RIGb3AeDKhxCCXqFW1.gECTAj.X33KN9Y_Ghdw.R.PjDJMfOU
 eHQ4uMjvaFmMWuagECQGbyFVJQ87Qd2pQ7inCqb5KTkkw.IUztxXkc0QJMfFtVL.ILMaU0DTQzvj
 F794MnFknMzOay0NiDly8PM7VdHJSQhZrwxIDQ.wuzvfOsm21s.AKR0OlHQxw25c6jGA9lJdg0Ay
 nDaFH3IypjFdgPiNRXLfPBwze1_tOYrK16EwT_AsXIWU3Ay_f.GtV0exOoOV069mOSOSzqjGVDKr
 QSa.cL5EzNJZG4GbW5l0GSg7jI2ocBrWBkRiACLXUmwYs3N8ZdpRCPVuGlyAJti0qawiR4N9ziCz
 YbxVRZHUaFXaB2YRCfS0TIMflwm0ZFYO7pWGO.rNnwQpN6PAB6CzVGdkGsYHndIGR1v0dTjNA48J
 dbfbyq5avFL1Ogy7sKGB_LX7UI_TBIYPyV5SVd1_T1rXVJC6p58q96aM00bDXmgdV1nu2Y0px6nc
 fz79M3Dtj06DAUwhm_DUkMjHegDO7hbYMvZ8YyFsjSfSpwSIOmYSexpmhZFUB3ktrO91buN.aYyE
 kFBlbG04djrJzAj43q_R8bRawX2ScdC1uc1SGbJgenYI4iFPxFgnLsan03vlR.cGqR1Bsn3_49pT
 6hNvNVwliDpGnFOjwg4uEiaCx239zVil__P8sAhj42Nk1oD2KTGfEMHnB8JHmkg66pJFIj_hRhse
 qkpspj.aD18RYvus4QPWHnuIBVGETGReoA8gAsqthLy.CSEnWBDtbkloyprHUmTwEp.BQ4oCJ8mL
 SUK1ib7KlsCVoK4dW9NitnAIGei_YughbnWlGQRZASj6AgpgLGVQbBnkB0q__E4suoHL5sN43fqk
 cm4sUpm7oY2B9pf5WE62GBQi.qnHif6hGQFc4dPDE7g.h8FoiWzXN_o5459v18pNxhqhHyVV8aGy
 D83sqO_BLGvasRP8TBbTwx3ixsJOMdDzgCMFa4rCAKRQnohFd5aKjtLJ1JOjVAkFloNxJTktDQp3
 Wx_DSqwdUtA6q6OBhEQOYbft23hP6IEFYOhmDkeIQaneI3SDSIGnqqf8qbZYLRaDTZm8_5rIA.iK
 6m81eptjCDq_B2G1_BBAg6.gPgo7qDQDwmqoPKGEgLwpw6gAlZMgLf2OVJE1NA1LpKEWBaFPgYjq
 S2KHLRXiXu8HljWgjURmuEoyBcydI_GEYsnVcm4WBltnJeypobgydEUblmplsfkAlnOOg9MFz6uv
 FAXWh_iLL5cJRt1KWSc.PgtNpxuXdVV2MX4JQrCjLsGThlCCZcxjEleY5MGfIOKETWLpH61YiRHd
 joX0D6T0fGgEE1wZQCkiK9EnpBpXRlLJ_pOORNxrA7V6L2cN.PMfSDaa4QzCu7bO6jSzLbdw5KzN
 SppKsH4u.nhPvZtY0yhF.AvTQMCWZScmWxEbrRa663RrEjIBfn4evQK9vg_kQY1OSY3VW0eeeKBb
 4hBRukekHA4xftUNoX6tpD9.ptSww8AzrvHb4jv8jGCShLQasrfoBtQR83bJHMy5PfqFqIbrwZQK
 _wAaQJ3UwUcnRXRS9ajyamUnvYBVWFp3lJa27j43WqwdLcky2eUX8XyaTuprefPimDMpeg2qcP4R
 BDT.Ta1lp_E7vqLxGdbUq.tJixQJeY4R_6IWID9CaAg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Feb 2023 20:08:52 +0000
Received: by hermes--production-ne1-746bc6c6c4-z5pmw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 38997703594d64a58154546cd21056fe;
          Wed, 22 Feb 2023 20:08:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v6 00/11] LSM: Three basic syscalls
Date:   Wed, 22 Feb 2023 12:08:27 -0800
Message-Id: <20230222200838.8149-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230222200838.8149-1-casey.ref@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

lsm_module_list() provides the LSM identifiers, in order, of the
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
Patch 0005 implements lsm_module_list().
Patch 0006 wires up the syscalls.
Patch 0007 implements helper functions to make it easier for
security modules to use lsm_ctx structures.
Patch 0008 provides the Smack implementation for [gs]etselfattr().
Patch 0009 provides the AppArmor implementation for [gs]etselfattr().
Patch 0010 provides the SELinux implementation for [gs]etselfattr().
Patch 0011 implements selftests for the three new syscalls.

https://github.com/cschaufler/lsm-stacking.git#lsm-syscalls-6.2-rc8-v6

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
  LSM: Create lsm_module_list system call
  LSM: wireup Linux Security Module syscalls
  LSM: Helpers for attribute names and filling an lsm_ctx
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
 include/linux/lsm_hooks.h                     |  27 +-
 include/linux/security.h                      |  45 ++-
 include/linux/syscalls.h                      |   5 +
 include/uapi/asm-generic/unistd.h             |  11 +-
 include/uapi/linux/lsm.h                      |  82 ++++++
 kernel/sys_ni.c                               |   5 +
 security/Makefile                             |   1 +
 security/apparmor/include/procattr.h          |   2 +-
 security/apparmor/lsm.c                       | 100 ++++++-
 security/apparmor/procattr.c                  |  11 +-
 security/bpf/hooks.c                          |   9 +-
 security/commoncap.c                          |   8 +-
 security/landlock/cred.c                      |   2 +-
 security/landlock/fs.c                        |   2 +-
 security/landlock/ptrace.c                    |   2 +-
 security/landlock/setup.c                     |   6 +
 security/landlock/setup.h                     |   1 +
 security/loadpin/loadpin.c                    |   9 +-
 security/lockdown/lockdown.c                  |   8 +-
 security/lsm_syscalls.c                       | 145 ++++++++++
 security/safesetid/lsm.c                      |   9 +-
 security/security.c                           | 176 ++++++++++--
 security/selinux/hooks.c                      | 154 ++++++++--
 security/smack/smack_lsm.c                    |  96 ++++++-
 security/tomoyo/tomoyo.c                      |   9 +-
 security/yama/yama_lsm.c                      |   8 +-
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |   3 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |   3 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   3 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   3 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/lsm/Makefile          |  12 +
 tools/testing/selftests/lsm/config            |   2 +
 .../selftests/lsm/lsm_get_self_attr_test.c    | 267 ++++++++++++++++++
 .../selftests/lsm/lsm_module_list_test.c      | 149 ++++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    |  69 +++++
 60 files changed, 1512 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/userspace-api/lsm.rst
 create mode 100644 include/uapi/linux/lsm.h
 create mode 100644 security/lsm_syscalls.c
 create mode 100644 tools/testing/selftests/lsm/Makefile
 create mode 100644 tools/testing/selftests/lsm/config
 create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_module_list_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c

-- 
2.39.0

