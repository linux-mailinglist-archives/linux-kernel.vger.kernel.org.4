Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182856BC005
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjCOWrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjCOWrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:47:18 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1291CBDB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920432; bh=hqLxQ4FWwbjlveCRO+9/+fSo9XdwYZ4nASM8wmlD7tw=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=dXG2MVvoMRnNH2GJrQmLvuahE6GOaz87uSuFIEjqrNcQEx45uKQ6Cf5IpL4+HyOWUlRn9QoJwZQFQhZhySXctmtNXW57e9uJkZlyoMZ5XF1XiRvB+H8MGQY7VsQ1mUY2egb+kdhYjVqX8Vap84kxLvOS9AgttqGcc+joCXAS2f6Jo/ORZzP8luPSS8JizeSRR0TaVanPJ8vXgZ8gMuPr8omgtrXwC7iPUIX1faU64iSY47N2W7gPDmGe9BQ/UaaVeC1HunSAofsWrbamNWqZxluGgaqs7flT6bJdQ91wslL2fqRmmmvVEUVlJVlfH9vxkK6/1plh2NEwLwjRfF+SzA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920432; bh=QnuWlcKPzNVdljOl5S1yDqLuIN/hi23aiLncCZzP3g9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EnFxBCEtYHPcTJzrUT63WiJe43zWeaK5sEiSbJRvXzyvoHfTlimUuuHSg3q+36d1UvlMXBgAvAi0OsUgU6YVYaanrJLNJPUw5ItW96kthkFQHKnVELrDda84BfR9wH3fphf5ox5g5rbGFO9H4w+r4gcBT0NNUZHQf2VuEhPtCB/3OPrcO3kzCbh7CxknDUZxP56CayFRrEt1ViAOTmhbtcjN/Kw4lno8FaS7CWklrp2LwrM55QHDxGIjjA+UhO+BR1OR17wgH5EwnF0DMHUBWYQKNeA0XK2pt4NhBTZtLqPaE4LGjSlnI/Bjd5pQJwZwWBdwoWCM+qx04q7JvdQhjA==
X-YMail-OSG: l7n.hGUVM1k0j2smTkPtrQ0ImAE2OBxa2FghX9kRoS6unbXTFdIM0vL.DFItabE
 dB1mtoz.W1IwJEy2EDiGWCMbpLeKEfuVyIBl4DbLimJVDKohgmQiZrv2.FtR.AW4LRJrYWMeIUNa
 LikMULSfqtwKX0DAT9jvejtk7KHezx7cHemVFxcj86LvX4FVhUQxVBCd2z9sjzazuX0JssEElABU
 VUHxzpko8U32o4gh_zcRa3uknHv5Vd9MvKm8aLNyFt0LnqLXL11IfIESgu5eGTZ37yyF1_l8dZ2i
 rRM7AitYoz4ogwI0NzNnk6bQO8KhINIVeUNw3WEKs6Cs_mgynoiWZv2gLPQV4egPIraNZ8NvnI_F
 NtYOAfvwp4PB9j29kD_LVT77EW974dcVvmVqDgDFfTtYlY_Nc_8IkWxCoWfrxVjb_cIqbRMn0jkX
 TONDjJVVtLLQhCkEyCksHlQJlQb7E8JUNz3QRqcqFqwYd7urVVII5DNfwEgV6fpGx8TYPqW2mcbr
 GB1lTtTI3qGC98nPXa2J0iTiNrCHOMllxOLn_XwL8vJDZjWY8Z8R4DxzYdNwIHLlmXVpXRoIqLWk
 G6pvDFaorZ2P6B2QMaALoJ.qrf8k3o214F65.0qKUVvvE1rIqxbHaxAWJD2FTetUouUXafRVdFTn
 RVZx7C_guPEoAzJ_9Ay825zDyrrXcPLWrwXaYToQRUDh8g8vvtl_ZSyXcV0ibRV2SjBAZ7fP_b0z
 5TxGvUKup49zYb2QqCobTkMhLxP4eQcroco1L7ZrbcQQUkCgD7WMJp_O0NfFyNTwx2pPpCLlu0I9
 HlgDgEyRgxmQsujdP1LoYAHzrGnxj1v77WW8OjTDR6nsykJZKaOn.9qdTqDNCCCE9q9Dq5SxyYPV
 Z7BrIkJTZHhV31S.RCMSOlL_9XOzCbblJb1OWVouMCa6_n9i6hlfkEkoWz530AAiI58.COHeO7RB
 aGUe3Jb_FneIRBR2uj4hcVMzimGdbzZN3YNwjHP.KRTVGXAyxSri5MIbAfCP5yxXoiWJhl1plQ1l
 8z_4LTTjXPCDisWOsg.Emr.KbtmN_qq.EtpQdu1ah5wFxRmMA8J5WickGxgf64yAKtUOJ7Mla6NA
 Xho3LVHeCXd2fNwy8Kc50PL4WOHMRGQqrDMWtXvNJJotQKt1an_7G2ZrmQIA3WEFkQ9CdN4x76xQ
 7ZipJ0wedDc3_b5Kz2WxznZQKMcINcorOrojGa7oa4XwKfN_sAcYzwE5AymcBmazLKQJ4NuvTCO2
 laBNN._lRcwCWvq_eBNLWuApYV_.1LIuFtS.vmOvJ36uHaid8sKJSrdKwqshmkUyNJErgGyKM0z4
 GdOegguIMCa_430XtEL9Qx6LIxNkbUyIaY23Yase3ud16jUEnx1TlpY2Pn3fEHthk.fjQ0_1aGWX
 cSgEVRUVxZuvmIV811IfjnwOMlj9BDpwlYMXkp6TBTmcd.GQdmXnQEtGM_Z9VeuqkS0VIkVqWu8N
 X1qbJrD34DbBO3YzUBU6eFZjlNWe5wezsPP5DgOPuZlIylCVoBaLeCb30ZRW9vDW3AXbkqgNe.FI
 zduDK880okL2MyQeQ7FBSHGJeTiDwdnA6MSC_iWqVkdmyJYSfqp842e7JFFOiGchH9nSD9rCFh1B
 v0c47dvv.gghKBW_GZM1tdt1KhERK8bcjEvoSM.iMGpe3AFed_7bIa_JWZE7oesT9CQVSHrN312r
 7FQZf2GhRswZotPkHQtiXOzyzHNLH_zYAB_cRky4VXsrdoDWSKfjWSEETDjJvn1nbRlKrlUhIc3G
 5WmYX6P2mENEnYPucJsAcRWrZLvtAsiZQCUsYCx3BJcyv8pI4MXhBb_zSf64q0tFqXKIiYF6CLy8
 EBkBleTcJdGcGZY_eOFXYZe__uEWVlymiFQDrH9SrYUVwjKyRK_WKatHH7g10HQvO6OdyydAkGN6
 Fcs9V1jXO7DnixLAfxIhAbGJAz6HUTHr9nAKj4FnAbFCCk_..faFjFkADbuabqjyLYRbSCCHyVQS
 9WOHDOamatnIcwXPIB5oYCyXJA1JBuKh5yY5ynDYDHjxOAVUordrudG_75OsuGWEJ.DI0wbEjXLm
 SYwNTtuuO0RfU2tgx7u0ompzpWwMbgVDPcMC_7NJvrRDIqzum7L7x7SLcTJZer3Cj.cO9O15b2kV
 lugmf2Nca8AAVZ0AoazbHpVHdPsY_b.Zy8kiPK2dEh8l2u8GSjDC42Hq8COR9rh6Q6K0MRR6Irqt
 XX5qL7U.Iam_lHXF4_JZ8sGo39RHjPmGhA5.4e01LJ8YmyUKoqleER1ZJb8zdbDXo_B8PiV8cd3k
 7y2TucyemqQvC
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ae3fde3a-1c6f-469f-8de5-13c60be5ac0a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 Mar 2023 22:47:12 +0000
Received: by hermes--production-ne1-759c9b8c64-7lgm5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a598a9259311ec92faa24ca803c3eea5;
          Wed, 15 Mar 2023 22:47:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v7 00/11] LSM: Three basic syscalls
Date:   Wed, 15 Mar 2023 15:46:53 -0700
Message-Id: <20230315224704.2672-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230315224704.2672-1-casey.ref@schaufler-ca.com>
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

https://github.com/cschaufler/lsm-stacking.git#lsm-syscalls-6.3-rc2-a

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
 include/linux/lsm_hooks.h                     |  27 +-
 include/linux/security.h                      |  45 ++-
 include/linux/syscalls.h                      |   6 +
 include/uapi/asm-generic/unistd.h             |  11 +-
 include/uapi/linux/lsm.h                      |  86 ++++++
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
 security/lsm_syscalls.c                       | 145 ++++++++++
 security/safesetid/lsm.c                      |   9 +-
 security/security.c                           | 191 +++++++++++--
 security/selinux/hooks.c                      | 156 ++++++++--
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
 .../selftests/lsm/lsm_get_self_attr_test.c    | 268 ++++++++++++++++++
 .../selftests/lsm/lsm_list_modules_test.c     | 149 ++++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    |  70 +++++
 60 files changed, 1555 insertions(+), 101 deletions(-)
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

