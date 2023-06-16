Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8DA733696
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbjFPQvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345694AbjFPQvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:51:14 -0400
Received: from sonic313-14.consmr.mail.ne1.yahoo.com (sonic313-14.consmr.mail.ne1.yahoo.com [66.163.185.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F79359D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934264; bh=CMh/O4Va6lFO299EbeFgoGej81squOzAXAC4SSVd7YM=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=HXzY8LISbEe+Fq4ahYnk4O/Grck1j1bdiCSVKd8Ft+fjw36BC1Vq+pfP4hzPfgalXWNmQqpa4T04yquLCPGDOtm9qsHEex98jLW533iNN1bKo9A63UY8JTpP1juD13Mu5wnj4S7deKalfEw8RJ5Wf3V9NTTpLSD3z/5ZR6ZAJoP3sVj24zlx2bvZEnj4FS9uRauXSMu18FSLooa9UyYwzC0U2/kFMo68Wq5Y95WIRF3NbROZyVqYtha6lhRZHr+FtlJqQYTSyBvjxzlTwGLphyOwawK9es7wEkWiBKHf7w1t7HEMTlKsWnafTvJl6Ko4PazOTklW5zi5RZs0FsNtMg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934264; bh=6wfi6FPMPZmRB8llbNB44RYJO7s39kp9S8W1FfwNxlW=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=iH6nGO5e+HnPdK5TkT3OJZyJSmBAdFs7X/b1qxLQAYoaM4mvuBz7+fvmoSJSXbVRddcz+NMLCDRyx8q6pwPPRcRz8qiCt9i5vWEz2pABdmO6zusdNc6mUFi44qyA38E5C9wfsEkAH0U0LRd6ppd4COaIEDX8UO8WtiWr8wrdhROZvptC2vy9OyrZO38Tar2EG2S4KAaAwzs36JwNO5W9OYHPTkYxhYHtoPEJmfqXaUV6r+wFcM16Ju98Ttp9DZ0BKK1zSKjD0yZkLdy7zoUAQpa2gqfKBJ7a4WswLZaLWDHUhbcMuOi49COqQdEozZ0BXXFqXlQJqCg9HOGUL2rmJQ==
X-YMail-OSG: MshBjkwVM1nd33w1Ky2vLfijY2mkH2a_UU0Z9l6mREYs7r.kLL9z24z71qn.zBj
 WdbEJ19k1K3jSxCTxt6D9a38R8mlUUC7FEIxuHjpW4XzBxX8RYWfoUOMUCsxyShInwd_hAhzey6V
 3BMW5u5zBTIRgIXvfAvd4hCVFRgpAJ5h.Al8gLTdQ5f7czZiL20TBSmlMXO7utv9Wdtul2tbbPBR
 xWBswZiQsvTcfCHY5No50wTaoEQbapiKCE.hNvdIKWG1jSmWyh3BbQAUXbRE7A07NDH.ln7RpADD
 DB.jzmIZut4vq9VpBO42aHepul.g0J_Bh2R.ajrKgcJNXGglq4hi7cZc2qRPPHvutgoRflH1Pz9F
 lWT6LhP.HQ1EC0hxR4HtZlxlTaVINaVHNltaT2h6tBMyL7m1.y534Yu4kG6nMGMRweeh56flMgtf
 DdEY_bzoiNfhhbEW4p4ZcaIyF1YA5gxntj3_d7H0sRJPUi1eTd_iWfPJF1_k99AoXrkNs8gLhCjK
 5RBeREluTus3IN93Htts8lm7EbzS8BEAx5vVKd83bcJy.RbCHwfU5jiXO3UQ6EsFwghzFJj0wI8B
 0POYdRWOhplKNAU75OwUJtRC4s5zuT46njDQ7ZQa5jnA0dA4Yw_Op7K6PeqUesmlPKO1ouSpZnPt
 OAtlkNE6mE01HhYu.x69LBqwkoU2athYnqse.gKyRf9K8ezCvYhG47CEyrvu9w92ScurXSRpPQbK
 u8ovZmrYYbd_8Dz6Prt22pbiKNLwqLc6TjmmLidCk9LXQGy_b7imcd6109.4f.ut16lgd7QRxedT
 sMhXQ692v72EpEAzkdUE_WfgEjEPtdA5c4udaPjaFi7Lbx2yCdHyfpItxhP7ozi0KOsd8rxjeTRa
 y4Q1tLJ2B1ItW2dy99D2IzxIkdHIOMksnxhmAD5fATiCgk_ROWBqYKtuPCUR8mO_eWyZ5SyClKWP
 0f4.fCTn8zOSWi.KKp007RtPS8LPR0bJlN.LARls40c5x1Pg1TW1FfXa3w5mf8byfMdhSxSdO.SG
 93Q0oGEAhYtyq9mSebqv8VGzJstcQi3nlEiKT6oG27Pe2sniXt0lS82sOtNBG2CSKs8cNbLTzb6J
 vnnhhxgUNgZza1BOze0b2jCfnJpXXpJZiiXGmQgtb6L0xnDgAOg0OrznBP7OZV1ISJY8QIjS3TTS
 D2aJP0gGN3IiQ3WZV5Y1BXeizfeWGP427BtETbfQ7fRnyvvJD8bREObe6F8.7pRL55K1DNu5dnAo
 VX72cGeTkhCBMhyLNFAlZXGB796yDSW0vXZ3tbmQxp8tq0FhJneMhh5.i4fq3fxt74zSnIYs0SZK
 22b1dqZzGtwFLxGk0HcojF4IRyQveLmTAOlgWSaNMCgghDwlSsWC4s6VqKWZrq1JHrHrpHAUy39j
 l0gy1Ste2_nicFjD.FpIKBzrOKzv3RaELvb.hw80gbLb3pdx_r9tzsCno_SIaaem2.6r2QNY._Kh
 O9_dhbtDHwt70CoveDuUg7ffbK.Xo6fwzA_2I0HH6b3Kg7TiI2KBvCOIQHM0Ohi98ytaSnmE46rs
 yPHX9z4CfjIHhk5g0IkG4szoDGRM6.bF6px5nS_fP0qlpE9xPjkAOYkBDffhFzrnmEqjUPAw0sff
 J4i17Dc7WsB80xBfYQoNdGIfXA_TjzOUDW56ikt_7hgUBwNVF9yqGCT1qzhmdIqtA9yQwl7foI1v
 GGANaZ.QAs4zBueKAvE5WZKANN5Ip0c6zhOBKiwNhwEkBdqyrKCYTN8IiseW2.buIgeJv0CLSVXZ
 ibTfZKI3qoXuwHIimCtkKKJgm8Ph.E6AFswbjmVodue._lW97UQMSjeHXRlP1dREmzlc2THy2IJo
 lU9gTrtnupZGVXwxNzomckVz4EUOFZHnqy9geBGCx5P7VbyHvrifCrtNn9LgAgb4edOoKg.7tlUw
 T8rubGQbgQ8slINcDjCY9DoFo2coixl_x2qO5NAoi5F2N_mahk2SrsbuQpXknm0DFKxypjR8YvHb
 goU3hI1rtAREclhujMKI.ToXBUYdhMvEslIO5Yi1ARRRzu8Niquu56ZOx5_P_KpDa2MXeNDNM5pY
 WN7OemO_iMQY74S_yosU0tTqz0u78KmC4PpXA9gTG9a5_cUXNPOGDqZmNUs0ihKJHuC0ZmzpYoud
 Y8GszozFoeuA8IIZm2dQ.dLonDA1YXrlSor_LqDyE4.eHTHpJwyB2VdX7CHt7oQOlGmvAWdRexlS
 SUJu9sBLus2tg.J3159BBOK5h8Vf3QUE3ZracjltURywnRcVEoJgUqXnI7cBXdI4RptZhCn9vRvK
 suGrGbxwVXDqn7Q--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3fa1f643-c619-429c-8c52-3fee4712993c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Jun 2023 16:51:04 +0000
Received: by hermes--production-ne1-574d4b7954-tvjss (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b70d58d7ec5b436008cc3a1dab4c00b9;
          Fri, 16 Jun 2023 16:50:58 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v11 00/11] LSM: Three basic syscalls
Date:   Fri, 16 Jun 2023 09:50:44 -0700
Message-Id: <20230616165055.4705-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230616165055.4705-1-casey.ref@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
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

https://github.com/cschaufler/lsm-stacking.git#lsm-syscalls-6.4-rc1-v11

v11: Remove redundent alignment code
     Improve a few comments.
     Use LSM_ATTR_UNDEF in place of 0 in a few places.
     Correct a return of -EINVAL to -E2BIG.
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
 include/linux/lsm_hooks.h                     |  17 +-
 include/linux/security.h                      |  46 ++-
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
 security/security.c                           | 215 +++++++++++++-
 security/selinux/hooks.c                      | 157 ++++++++--
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
 60 files changed, 1568 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/userspace-api/lsm.rst
 create mode 100644 include/uapi/linux/lsm.h
 create mode 100644 security/lsm_syscalls.c
 create mode 100644 tools/testing/selftests/lsm/Makefile
 create mode 100644 tools/testing/selftests/lsm/config
 create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c

-- 
2.40.1

