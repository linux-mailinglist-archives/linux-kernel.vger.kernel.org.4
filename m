Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFD16EB0EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjDURnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjDURnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:24 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AB7AF20
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682098988; bh=UWJcKqR1DObWnMZmjWycZG0T1ry4WVijmEromOGQ5+U=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=qPbsDPW6kW+PYO8xTG2/XsPFHajpV+CyQse2hz42p/aZa8yAO+CkhqYBi8BUPNlNgmCvnIxdoCQ5m7rp1HWlKTNroIkWmNaAExcyg+R5SDfCH55npw83GnKVm9egdDU0/rxo93PJbKhblPX1HuxneDXQhm5RpqKg48/eZYFbBzZA7e4TLDz4aCE/iDpfxUw+qVGyUbIhPIkWxpFReligzVmNBXFRMxmR+X5igMsnb1DpcnRKQRUUPlEeGRcf/vWCicpGkZVhwMQAT/vINX9xt1+Z8MIC5JuJd50ZVTEix5bvm9526SE6EOxbcoQGlUsWsoNe15/G5tyfJBbxtVciGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682098988; bh=mJyCNkvTDF16zWI0Ya935GdZhv5aCnwftZiHVqet5Uq=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VINc/hMR4V7PkoJNi8JBuDqbvkBvQ1knNH7Bj25yY74Q2oinnulGKB/DbMt8wo7ecMSt+My1vQqGrfn42eDierXDbpr+xVcl67vtsjydSsuxvK+XCpEc6ZfWFOTzXNLcdyMUdfK4wbrO0Vz13f5YtpkA+DuyYTX9Oc1r/VOoOu3e3j3HgVMSWn7zSmN891wlQP9EwNuVfHCsrKkMzk2oGmiTg2xsHE7YnNiAqcDNb/wonbQfKCMrIZt9A+2hGSdgK+9HTwjnmq2YJhsYOwmPxQEi31iCTjXXPHpWOGgMkN1OpVqeQ0cJmKjaPZVJvquvHtx2hWB/SVdwQryWngJZ1g==
X-YMail-OSG: 668RWKUVM1kcvw31Shs8V_bU4FFxkxuKquR_qu9iA9S.tUtdwHDsl2PVXjXwmVd
 6Q.IEFsXX0ZEaLgh.ySVDUKsBJGufQxhFVelvDUAKxM7wWOVFvTqcvzGduLIy3v6Nv.mcY7i6.2c
 i4yhqaJ3PKg4arD5Z5e6PNDQX5KSPiFSLywhtHbuPtErLRjw1.L93p_QZ02ayVUvco2ZYN9EzLGa
 i82GLoQWDC9qdN1gDfMRzTuApDIsUICEjfX3V2lJGZ80g2FPHNeRTXTjwEtokpHP_cWUvGfbO.VT
 mpBfbdvPRPt86bJTl0Q0tRCBCLDq60GVFFQb2rXZxNQNdDSt0WIJh1Wcxk2d1bmHX3RfJL.JWkTe
 CO2vE7OemHWkB88IE8D0CxxGAn5QsVmxSARWnFuXcA8O.YXHuSR.oZxwsMY3luLw8f5ayoMWCxz9
 MmEwhPL9M_boIONLmDM_yg9l6AKThEdVZPhOJg_6NzJY_JP_mHnkYEuCKyPg4NhGxK83z.UUxVRy
 _fh.g8Xq2crZD.dmKQA2KwWMImqHGyScUrU6DQfzTxqAkTIQRo_TOHVnkqO8UVErHE7dsQaR7EkB
 BKJLU5I70.D.ukWD_ucOpGd5N2Ld0Tmtz5MN9Fl1BI95AEzRZ86Fmxzj8FjiCSeTdRnLska48feG
 TL7RYksjXSi1kyguRFDTBizdynMzWX2eDBQw.u7Kv_DRvSHkzEDzJunzs.HlhIJ15bPLPj1nvVb2
 sbwetqcRDV1VlgCLW3RH7el3gPVxEaD0WW8kvRE6.z.QjaUDp5abo9azlT_Rkz1LCnHDrAWASA0D
 xeDfdTeQkvJHpg6HX632mr.HilvDYyLlk3S90NuhGFSokver6bQi6xGmoAAwermDwrDKhCdje3jr
 ik.3Zf01Ud4Nv5f42sFIfRzHfVrSQ3LYt5PVc978RMPnrmRtn_fdSdPz_J4uLZyAHCwSbiITGOyq
 C7zubWTmCnGV_gH4CzfLJqG._4Yb2GpXnHPLgsEce1LBQY_Q9aad.IeI.h_ndyWghntNzcIBIE6S
 Y4c4cucsFtkzd7EXRPabZ2DNGcj7wtN.FuBjkein21hErdIHSPYVL_iQjj8jaxiGr8De4JlCK34l
 DnE67JqdeTC.Ub5ioQJKcUdztzm2EHMWp3J8NgxhnQVWZNtf2g6t3T0YcEAFm.DaUmgI9FHCiw4q
 W42v1SmR8ynibfYsWdYBaGiOz3LIR6o8H9vXrmM2Ge3VjYnUONbWojjDgpntOJXL5dVRGuHKdBR4
 Aeyx6G.8K8IcRi2m695g40x5ApQ80sGelx0ymnE0MDi5ch1gdzD5Cxd6N.YsrR4HD85VlNnfi9XZ
 lF6yykTR8KpMlXV0EtSKayH0iAiVmpMI4uLOjSf197vUrFl1vPUjm6PgFl7sbkzkQiE7CeD6b.a.
 Jh8_L0Mt9arQHnxYHAIIzi0ogvz4Cnw41L_cXessRO9y1jWsN4Wwx0POEy_2eg8B5kuliC7lY6JJ
 gufUy1pXsbQAwyarZNUeB_lWxLJrACTeaj85RKXdMgv49QZeLOvcbOLCUFw2yB2FlLOIYXJWS1Sc
 9NJc2wUnrRcmfnpPxA2FUYr.ybrdyY3vU2ovaJ2lODrUxCybu_.mavSB_UO6ugFlR0.n4ukqz2J2
 74rCTcSEHpFPo.u.FsPquGXRPH.iC7o.H0Wwolhj3sfGss_7vwFxs5xy5LwbhQK5oarzhqvoadt3
 .Gdcg85aUfjVwA.Joa0rYm1r1mrmEAAzV8EcWtd_fLIHOijv2VTpISshdw.jj2QfchA10eMAoUvw
 iYWXWUY2z5lPPGRqo660o_g9_EcSpTCyxwo5M1SdtTP4gIAcMn_4CuvfYUzfYBhXBk_firM78DV7
 Gd90GgGm3nx5VtYISvYQfZYb1bB2uiUsMRRJdGBQGqjJAvcNgxZgbwSA7Agpet325OJZplAh3Orw
 ydKK49WGxnvSFaXTj21ca9RFvSB0mW0cESf5_6VkNJMISvKWHSgOd2CLS8nB6YOrFrwr1K0cE1ql
 mwQ.77Myu4ln640oMrxMdej6xiGtTiPr6Yizb2PHZ3SavlqFTyc9UFcXWP.rLoFFYu5B4IdV_x9A
 cQpDy1GH9r_cVV6rA.czzbude378yd9s0AG_n936x_NoEzDpZgdcZodlvKHaWqV0hDo9GDymnUPP
 NBO9uCxYTEqu59mkF036LqNoM2pLIbUMM8WkwFbuM1ahsVr7MXlAPNKkyNoRcrAlt7C9jGcE9O1t
 9D0_A30eKLuZU02bgX9u2QO.85lFGYs_43wit9MBVuG5L9NS5e2p7MSkMTbZX1OMcAkCtbPiPdT9
 XQIoSw6TU1QNW5Q--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 71b9d165-8d3c-491e-882a-d2612406bc9d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Apr 2023 17:43:08 +0000
Received: by hermes--production-gq1-546798879c-qx24x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 347f67eb1ff988d02ff1c10aa50548d0;
          Fri, 21 Apr 2023 17:43:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v9 00/11] LSM: Three basic syscalls
Date:   Fri, 21 Apr 2023 10:42:48 -0700
Message-Id: <20230421174259.2458-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230421174259.2458-1-casey.ref@schaufler-ca.com>
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

https://github.com/cschaufler/lsm-stacking.git#lsm-syscalls-6.3-rc7-v9

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
 include/linux/lsm_hooks.h                     |  25 +-
 include/linux/security.h                      |  45 ++-
 include/linux/syscalls.h                      |   6 +
 include/uapi/asm-generic/unistd.h             |  11 +-
 include/uapi/linux/lsm.h                      |  90 ++++++
 kernel/sys_ni.c                               |   5 +
 security/Makefile                             |   1 +
 security/apparmor/include/procattr.h          |   2 +-
 security/apparmor/lsm.c                       | 104 ++++++-
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
 security/lsm_syscalls.c                       | 118 ++++++++
 security/safesetid/lsm.c                      |   9 +-
 security/security.c                           | 215 ++++++++++++--
 security/selinux/hooks.c                      | 162 +++++++++--
 security/smack/smack_lsm.c                    | 113 +++++++-
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
 .../selftests/lsm/lsm_list_modules_test.c     | 149 ++++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    |  70 +++++
 60 files changed, 1559 insertions(+), 101 deletions(-)
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

