Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D25659338
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 00:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbiL2XfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 18:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiL2XfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:35:07 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1BC17426
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 15:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1672356905; bh=eMM5TLC9Aqrkg5FQc2uR5cmo2F3T/7tnqRHt4FcNnDM=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=D6ignrdVkD2HT1d5MAvgmsM4bfCSPBsU/RHPKPXlqjscR+yRAWag+GFcMfco0m2dPV6T2YtERCEEjcyqik3nJpQOxOWqDByqyG89bQwGHlFCRAOdF7rZgmjpz2CAM0z2orPofepnGY3oxrirId63+47y4keIlJLBzSn7GunWMHU4QHxjDTJ9N/7Pyy9NOVep7xuUaFsGd9pYdR+5a676ELFkgFSECylwkBsJO+EU/Wc1TCAfW3Fk6N2vxkG5bONqb/lQMSmPDbWuWgXBu8YxC4jN1HIUuqb2DZXoxEVLpuYQUnsTXV09uWJNEV+8XLCgwsTxcss5le7Qp6qkwn2Nbw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1672356905; bh=mvmcAwdSu7jxnRlsxvgcF/UkZDpL1sE5+eupfi14k6f=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FZDZw/acdXbQMHjokZxU2Ip+H69sioZMB+N+9UevB80xoUUXj1rV+ANqth8ooVR+N339xwqU1fZAp+w3dJTSsP2b5htP8UB/58nONFnf+Nte+qJv7Z/HFTKExcxLWAe3+wsMwLKiJh0Tz6RQXRQcEtxZLfJMHuQktqHoLyjgogyKXDafLoE+L6L6SMJOMRrOcBglX88nnOugZg/eBJxHJztENzxouC/GIXTwIK+JZGbAL+gmzZvaYNwozFgtK+NBrTfl3k7wvutwC7q+3iTU7G8C4p3XCIASN7/jhdUfniY1apEmSFI7MGADe95+L4mAhB/658Qi8hcf+fNp4ALmlw==
X-YMail-OSG: hSiORmsVM1mZz0rwHGQ3hgKCEDDwnFqDBfXlTo9Mga13aqPyrBAwGP0qOjllOkx
 mmBElowT1KEWFMculEShOTZgcA7dzra8R2q1QbfuXhgw3jZExDbD_ysIL8bilCTQ0yGCyHuWPEoh
 tAW0Dj55SgEKcsSrz0j.FpN4CeRmLHVnZMlBsMd85mIHRWNglrHo0voGmMBjMdlxLlvHjFebBscu
 r1BWFYGMbFglA_kOzVhRlbfYdQ6hVJVEDsfRA5ilRWT4fCjq50l0HbfN.3P8mHpSp1BhPmLM9ymd
 7DD7llIbeMSLNJUCXvWMBhhKp7aArVK3KFYquQBI944IBchqzf7eBfBR9DyLWx1cS.R806XjJgfc
 cUHE9Al4aUuVa60tGUPxAcWzpwG_dxUD5O2kI.2FH0ruE2qZoL4x.FiVpZUbRxD88WBMnRzGk2VY
 crqK3ikNchotbA0nW0lx4.yTFyhxeMOpXrcmWKOvC76L.T0qGx94CLxCfZKEYJA1oS_hKm4MHo6l
 A038hCYqWCAZXDHSIyxjAFJqklE5P3kkThsO_EMSHYlNRCMb_rN_z1_chcjSS_2OkJ1OnlJqsuDY
 pMA3bQOzOa5nRXLYza7CYbNAhydS6FNBTCrdvQ16q4bczc0ckMLxLpNiCKL1WWeP9MIg4lK3dXoW
 qdF0xwQUaWqYmZWuq51ZFTZOQnzqZNFrOQVqa_QPId8XQyjcbqlIOhpeAsq_iB10LRp6vg4WMFC9
 rTiDVr2JwsWGvVE6QHveSkG_8PER.yvqlyLOl5g34wHepUGvnpDgUg3I240d3CtXrp0XvHOuAKAR
 IKd.SBtRkv5Ki_lM4QSg5M79MNMlgGac.dzs6ioyRKfdMwYjfE8YqMoncaQbAzoTvdZ1fyOsbGlS
 faNWFNW3dBISVRacUJA_rJk11jZCL0aK7VwVp1ciImOi.5PSwROFk8om7paL3KsUE6Q5z5nGuCDN
 _oJ34dqK.TGVzGBPq5fqxjALzK1YslE0WenPDmjhTWL5MesR9yh5GMlUW1F3lPjRfHm8Q0ROfi1h
 _weO2ObgK65zd9n.0lRDs_lIsDQGMzhQxTzwYaDJSgpHaO56J9IZ_NXgSrmWvrbnbS1WYBTtrjnt
 eBsJ08CFPw_cUPtGY_zM6Jlmmb0lG3HCr0gFQ9vyeTSaQNuCQSAReMj64XpfMT107Btq0r5L6Tmv
 FoXJUQJuN.em_aekgQ1B5pGALdLg8.4d0_upr.lajSKfsT1VTeFMGRVCaKnz4UhMNAUf3sPrvO2D
 NuxaTHGOCSjAdvcKr6rBf5es_bZeywNDFkXTNF9pXGIbx2VOrDXXhz5G5Hi.lGe.IF9TTFBjMDDP
 NEEahBGj939fmXxVgv2Rv_JqBxbb6w92GEUXprjv7_wojuizOb_mbQN70xF6sWMZEbQSPf3soayP
 Xr8AHWjZpeRucxJBEyt_XFV6klqLUYOUuHRr1oG5ByUWdwWf7zFqEjiiTcb6wRW8Vw55aiQFxXVK
 Q59iCtKXHX4F.TOVwKRkBY9cVCs4X0AN3SNgJ46._IGrsawirz7QCNb20Y2sxRp7lOMNPVGtIKH.
 _6QuGDUow5_J1f6QnS872GO3KQlzCu0C_zG8oIZUJyJVq9Q3BR5053uHK7sIUGXOzjJICy5pILIB
 VlhdKW_sXLnuhCv9561gqKMAr1lYEqAAh3VLRFfRoYsfGc3G.iIkHKmQjdEtOEHUO1uFcICdAOUH
 KUOhNXTt3jzPZ0sXugHF86DzsjcDtik7AR8sNrAHEsUqcMPHiE1nIDnLloa1138UERTBf6CyPMJY
 bmkilI4cUaJy01vb_UH9NyZOT3PVbalYyhSxxJbeSlTihUBWiLa70CHnY4alh92kEr6Ovxv8GxF3
 9G8YJsljTXJ4TtJheS0K7PLOVBMpoq1L4eEyanE0N.ssALiiIo_s5n7gjnOo.fSuB3tmFwdw5IqV
 tzpryhUYUq3sFz39AruDHPWK2Axb.wfeKCghvjk4pxaElNz8niG01QdIUNv82ueEY67Dyqp6dQla
 _MfBddJZ8mFqqpR2._HGFvOKrlnpzDbI5VCqpCtWyNJPwxLZYj5vxi_q1jOxlQeOfBE_U68z9XTw
 TyVXI16Mp7Qs0dMIf9aKM1T1D6xDlKfCESOwq.2Q4VxV5NOiEa8N0Tecg3Mfe7HVYsn3gk8wVDh3
 huyovBOCnhk_fBbjsJaZax.6qPqi5OndDTbSdU7zDlA5N0hf0pXz4NlY.26Ch.X2NomZooZXozWu
 zQOpi1hfM82Pa0SQcOyWdNboBfkrqiCk-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Dec 2022 23:35:05 +0000
Received: by hermes--production-gq1-d898c4779-9jfqr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6aa36badf2bf5369937c84807e956853;
          Thu, 29 Dec 2022 23:35:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v4 0/8] LSM: Three basic syscalls
Date:   Thu, 29 Dec 2022 15:34:46 -0800
Message-Id: <20221229233454.43880-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20221229233454.43880-1-casey.ref@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LSM: Three basic syscalls

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

lsm_module_list() provides the LSM identifiers, in order, of the
security modules that are active on the system. This has been
available in the securityfs file /sys/kernel/security/lsm.

lsm_set_self_attr() changes the specified LSM attribute. Only one
attribute can be changed at a time, and then only if the specified
security module allows the change.

Patch 0001 changes the LSM registration from passing the name
of the module to passing a lsm_id structure that contains the
name of the module, an LSM identifier number and an attribute
identifier.
Patch 0002 adds the registered lsm_ids to a table.
Patch 0003 changes security_[gs]etprocattr() to use LSM IDs instead
of LSM names.
Patch 0004 implements lsm_get_self_attr().
Patch 0005 implements lsm_module_list().
Patch 0006 implements lsm_set_self_attr().
Patch 0007 wires up the syscalls.
Patch 0008 implements selftests for the three new syscalls.

https://github.com/cschaufler/lsm-stacking.git#lsm-syscalls-6.2-rc1-v4

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

Casey Schaufler (8):
  LSM: Identify modules by more than name
  LSM: Maintain a table of LSM attribute data
  proc: Use lsmids instead of lsm names for attrs
  LSM: lsm_get_self_attr syscall for LSM self attributes
  LSM: Create lsm_module_list system call
  LSM: lsm_set_self_attr syscall for LSM self attributes
  LSM: wireup Linux Security Module syscalls
  LSM: selftests for Linux Security Module syscalls

 Documentation/userspace-api/index.rst         |   1 +
 Documentation/userspace-api/lsm.rst           |  70 ++++
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
 include/linux/lsm_hooks.h                     |  18 +-
 include/linux/security.h                      |  29 +-
 include/linux/syscalls.h                      |   6 +
 include/uapi/asm-generic/unistd.h             |  11 +-
 include/uapi/linux/lsm.h                      |  76 ++++
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
 tools/testing/selftests/lsm/Makefile          |  12 +
 tools/testing/selftests/lsm/config            |   2 +
 .../selftests/lsm/lsm_get_self_attr_test.c    | 268 ++++++++++++++
 .../selftests/lsm/lsm_module_list_test.c      | 149 ++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    | 328 ++++++++++++++++++
 56 files changed, 1435 insertions(+), 48 deletions(-)
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

