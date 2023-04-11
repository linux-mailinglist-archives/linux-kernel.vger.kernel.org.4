Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378BF6DE03A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjDKP7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjDKP7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:59:35 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07A6526C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681228770; bh=cNPBlBcQEWEFPAd6JwE+/jlTATsJ+XtuLDahnpFZ6N0=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=cv/tFG9hTQtUaUPfg695VzWqKpKCxyNT9i45hN9AmJ4NYonWBiB3egkgtnFKIBj/LbnC3Horalb6AqcKwVv9e87CWGxjSDikHokUv8rk+oMVgSlIuZSelqsFtXXm2D3uu2uzx1SLYVAwsCZfjvt90263dmCAVfWsIzkCxeHnXJOklB/4eSo1WgHovKmcuxXHtM4XY/MjPi1Fu5To0Oq2Xjykdxnbx37iX84LBnRgloFSYhPvK2D7VnOLcL0NqND8jhZQLLwnoczBKGC9sbSsz/e/Gsu7josqFXMl6y76Oz5SkSTlNqkXfQusXsrjSdpYap1hhuDfAyBsdxo5Kwehig==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681228770; bh=uN9E5JRe3NbyDcki+x+wQZPtkwQ+id1+mKyzqDppqX5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DpQ9tMAynPhGItFp2/Kwe6JCMCfFMu7kfFM2JIt857DFvduOYk7GDj2tZlLhTHEKlAXDQEP3K72GQSt2eMHJV+ner7KZJP+GmhEg3QzRbZ/DdYh4+8KFLJN0X0k+5+mQDgGwgoOxZsoMNO470CUX2KzKowcudrmqDNCZdreKXkBr+nZsJ8oYClpVlw5XRV1C0HXqflYa4yCwINFXGy+I36VT7/WN2k9wI143A0c1XYPPbW69cBhawq4PWGLELfHIottYyqQgeQWlGXoDefMV1SJVNHlty1+ueO7+YHDyr/MtCRBqn36Ed+PpuaYkNaPSSirhpwEsdy9YNPrlLyCVCA==
X-YMail-OSG: KnG4LPgVM1l2oe.eb525KVCDJoLLByKwNtmRPNxZ3kdR2UrVtQAlo9e5dsaVRQ.
 MrQtpqLZTozfHOYGfJ6CmR25MP2w6eMXAuv3aKdEmVcmV0zOvTjrn4chEw0n9xBYgytSdguVsBOt
 pJhgrWtnIG4mdml2_YLS0RBr7rH99RfPiUTlYONWk5gsDSZ6ns7E2tYyPhiAvOWpblxhzfmloLpI
 A1fRz78sE.LBz3gGrtWuej8SnWTSdy5S1lATqtVyh6gokRior9sG8c_gJ1ovlb8aozAZ5EJKuIYy
 BEab5QbC4V7801K_QzUfEnBBZi2wmY9LaMzzuIsPXMLgYCp_EEtsQClCm1BnG5DEdRdfMnIxNHDE
 LAY7vhf7BPUvkiIY3TLz7Lcp3HRA9a2pqya50H8CYdJoYtZibMPsm0Pu2j7wmnMGY94g10ugK22a
 nryYk3FhWncauuBe.70b5iMs8UnU202odGp4q5KujHcc1_.vaqViwIhOTxvvjd1DX0MQQvt48bcm
 wkctKUmoU71jkEPJ6tJASTv3mEgZUk4G1X.nlTsmO0mVRr87ADsYI77upDEEme45_bh4EPWBaniN
 mdNs7CLvOBusPC1PDU7QkeyT9di1wBaSo989odm3Ys3OfkzOf4DKJ50pkVctpdCOS47.BTHim0zC
 WPHWutLyojNyz6QL19PAe06i1fbgjuTnS8MrEoN.spWarkbtCC3OzHJSOvA68LIwfE2WSeZpNPtx
 UPLY0L8XsVZeGKZbxRgdzXD2IPPDtt94_dOfrHuX6RA4JpV36MdSuAn2dTRnAfiRtWzT0YZBGGNH
 ohgkypLjHFsD71LcttcMVRJrfjwTmB0o96A048EwaOIyeRKrtXX4_sMAQws8QJqbilWLZ.7jkCQN
 SD9HMPWudRA.lENwVv9K3Kd1n4Db4N84XWsitvIys2SYCOZnmgO1Of.jpa4nHUpNcji64e7XFeqH
 aHHF5n49vb2NUAW6wE3d8R99cbISfdnCqrxyV3nKc3_VlC6lPpg8E8gtvrOSfzJLc_KxA.1xiXPB
 mtKTM.drJndyj.ftepOlgwKJxbCDOs52UjzZVy6O5Jh6vFWngPKek4OgJ2NiVqwu4HlZmaDQCCIB
 q2drSQXWpU05TXg1FYMIe9oZ.chvGcBB_NhDsoatPqQEO3HTtVJf8CW5dB9B57.m5dwbNTbBMA_.
 hC_.cqDfJ2nsd0Ayb_Mm91XaZ3iJUYA60pktT8vMxXHJDH.uXwuff4sWs16FHK3sbhZw17gpg_gH
 Ozop9jhB3KMCORNNcGNnLAvT2jx4yTdipQ0rIj7XqHcwvwNFUu7nAKvy2wpjNZrpCagBOquXv0nV
 ri3OsTFnwc8JWsrQna6w2KrfngUNGaCLGUnhPeuweIPiam1I3ZlqEAARL00ZOkPiodMoh3eyRczM
 Be.LLDmA1LU5G7tJrLFRmfxoL2tNhevbutqlJS1AostdNE4FIqQFfQZrGokKPJaUFwPgBBdpZ.Dz
 _UjUdCzAhKwJcJTPmLGiRVMxFwzwNl4GGVv0QV19zwTDGFtgLygk.gzPTVD3d5lKIStpb7VZUFLz
 RRJn6xWhrjGWECQO0yhfH7.CKDkxsthC2KfkMfP3BZ6hHMWIhVAaXHb6IRd77y3bPuA65_HPzXtK
 _3PVHv0lLfhrAMuBd584phg9cFuucSX8dvGcNC_mLTXKZAnqmL__9GNx_hpnImekZHChFAVCg9Mz
 GSZUWR7nYyGU376PPwai3l2IEZJUcDnHJqBYip9Tpw.zEkFELLbXBxam_OhXhY8j7uPzoJcIA2Vf
 uFVoks.rRthG3P8mKiV5Tkf9TC4O46UBjslSvbd5de9dy1k5Hh8CTOmg66_1i8YoLF2wWMu75zJQ
 c2Xcsl5hoPZpGBgQIer_7rjR4bX4N6wlAW9l0TS9mawRSCMkiappf4p0imzdFvuFNUb0CG7fnhQV
 xPYJVlIIsZBv5xijDqdIF1UACA._4z1QBfMld.O3MaZvTrJiLkMzX4IkFBpNEnS2zlQCSMYP24C.
 K8.8XPTMF8HIzcfQX.zPRYNjuacFiKqf0JDAdpIWWxVFmJMZO0Y9nuX3Pkq_ZwJw30ph5SFXFRFd
 yObx7xGC_YOf7Jf8KSM0gRcEx_t8T_drzsg28J.77ZhzQwHWvPAm1IN9QRHK0Vwva0BFFbiFXgTO
 b6Gtkn2HuCZath7iSWAy6YJJHtyjoaz712KR1gqUARjJD0weROPekps_sZK93fwYH5Jv_e1pbLJw
 FtJIUdb22ZXj2.p3rRQ2OgIfSJQ9KxRPqaz6cvJRT2ovjKjxp1OKr8Id8La3VMdUfLz7ce.BfwXz
 8S42nPix2
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b726709a-3f78-4bad-8320-6c0227b354f1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Apr 2023 15:59:30 +0000
Received: by hermes--production-bf1-5f9df5c5c4-84ds6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bb1a3f7a7b49e6371e007077b829a9fe;
          Tue, 11 Apr 2023 15:59:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v8 00/11] LSM: Three basic syscalls
Date:   Tue, 11 Apr 2023 08:59:10 -0700
Message-Id: <20230411155921.14716-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230411155921.14716-1-casey.ref@schaufler-ca.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
 include/uapi/linux/lsm.h                      |  84 ++++++
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
 security/security.c                           | 208 ++++++++++++--
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
 .../selftests/lsm/lsm_get_self_attr_test.c    | 268 ++++++++++++++++++
 .../selftests/lsm/lsm_list_modules_test.c     | 149 ++++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    |  70 +++++
 60 files changed, 1547 insertions(+), 101 deletions(-)
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

