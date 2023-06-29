Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCD6742DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjF2Tzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjF2Tzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:55:46 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E922705
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068543; bh=fcOP/+ma99x59j5scMYhAoPff/GBv9YsUUKEfvXJwEo=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=F1/HHR+GpfQmLZ9gBka6bSoTd7UsW7RhUKPq290mXq6lDawDVjp4aWaxRaCHJZG2ryUWaz+HTKlxr4yZWp1RFYLfCMmIL8cAZe2O/p+HvAruTkGhPEJqcEvTSY0sohX1pMmuHslTRosjJU9QQ6MEnpOro6keD9ySAdDvSkWoZ679z40Wi2VuyBVhUTh2FAsNSFcXbV0GrWlgcUJpxakOzxl2RO2z883+6pOZHYi4W7/CzC4CM6JEy/j1voLKLfGG7CosTL9G6a5pP3C54O6KmCi5VsIiJvdReAVRUlaBd/40hLDuOJrATM+dZ0NPYY8EU0SRkdAw0HnUj+JmpvWNaw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068543; bh=DOevV0HOh8+tYFVX1K/DwJ4ASEDRbRlE9/1K671GNZT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kXJSkTJ6TIshico8caHktXCXvz/LGO6KNV/FRHo/bXnHZ4hORJiXj7ChaBSmhynuAutYKSm52xaK5/ge++LfIRXrj59ijoDjGzviC1MpmKp2EvC6yzr/hw+OAyHMr4/kx/97JmaEGi72Qhe4gI4+tJlgkqO7YMygi0n3phgPYk4ypVFm2rwTD9JdRxD1/UipA56ktRQkArTLAVBGKQrQq5+kv8yiBURzWSNU/KIFc1bKlolSB0gq8oMdtOXlGCHEbQl8dcD0piZb2CIC1wFIzNBpm76UiTldgZyPnhxjT0/Rrq/OA4Qf8to4tQrQT2+pphPy9d+aGy81hV2hpS+kuA==
X-YMail-OSG: Js3YYuwVM1k20LYn8.sieiuitiBk4.WfBwhxIRnin3MbeMO8.obIC7XjeWvDYFH
 p.eC_f_IYT3to7vRgriTqARIm4TT5z9H4yYFv3Xs5Zi_yhPTCRz_cnVd2gG2wstvzXcPEngJT4iT
 ZunJ9GlLxDutSTPUqOYP78fKnhNxVWiwhoksadmf9ngiFIxfwJtz0XYbvAJcNYYL7yVdWk5wVAU0
 qZqdlbJ.ZcwDDGiPA4W8klQIspKVZtcIhAdrsmQkScK2Gm39WeqbkyFnnVNMyjoMmibz_TJwOI1i
 TwWOH6zPIziIJM4qD0OH_p1DtEk5oEegl0huvdSlMUaJyWdpum.pStj89NFD1X0AY8gFLE3GjwW2
 pfzMAVXm30.UcXuDEFv0ma5Fj_QXgz5WvXasE.NPjrZjpFw48puFO0TIq6MARg.Lr.UysGSI2nxi
 u4xL2ns4SMabXCym0aYar7CaJvK6zduGMRJXPKNQkXZNDgeF.I7Pp1hRORwd76jSElu.Px.Sqh1P
 IsF4Zz42TjGn_ekfdyeMdzMdinqrQgA2bcBuqKyGx0.5mxkWVoUZ5lWDDKEFDPMyNGbxQy.Kspbk
 jZTWO9bkNBj5c6aH9CthDJZXgBbz8Uv6wGL2or9xi9SDMlQIkVT664N1gUsRkqil4Ko8DfAR7syW
 Xg9z2pJ_TwSl1.H_ah8zdDjDYSXfla4u2XKBhJyOMskCUrBEfk5XynbdJzrDiViH0wI2p5Tdt6KA
 fyBOuRjWnLTDAFuLPNY8M2Jw_ru6mHbZawse9sDO6zAyA12x7AdDuYjJdDl6bCVX2lS.nNZZQ.HM
 tv939aNucPFzm9mUO1PWvUYKGVYZ4NY9uyyCCgke5SPqoWYuZQ.2wC.2qrV4LQcgvJS477NAaJWq
 mxgZmJxWTPztcWo5.pkEqpnHpkqEB4oAOzXti39oipp7_x3ppYnAHQPRkuV4CLIe0XrBABnRCtpF
 bn8W45TJzGzCOWsqXdPpiZvHEX3WU0o9Msk5uXM829Nlxv3vlCJ9WgiXzbm016ZnbRrgRcZFXKHW
 nHA8nZ4D72pHKsC4TXFnOjt6N80FEqzsxN54jKrjGxw8fR07qUadkzOhHqhtB9Tpe5rwxJW7UH27
 dnzjWUqa_mTVf4KOEzD6.Merji3BveVDrICyPICANOQSIeRZ7yy2pdEPSFdBcsQAkDEiO2SHUQYX
 jIuP5Gr4klWXiKwERUwmL2AKpBYTAMMIgO9uzrlpgSQApH.qBaRzkAllgm_hew2eReb26d4bu7_M
 uHcQofP4wFRNTPg2q6Stlry_K8J38vsb8vAd6h_0cwMSIL5qQYoh0DNGRekO5VBWLN2zRhAEWewu
 DsmdpcdhC6GKikeVW.PCvknuUHFBmEyoYggo2leOcj04XqRbYmeQ6Pb0ZMcAPHrqjZNEVGfPG8ii
 SupIIAn0BgeXGhqCo6YyZS6HYvZdYYKSLBWh9ouKVrUgBqiEpV_WKOLZfm1qxYlAK1rOhKTQGaIP
 8BJVRiUy.jzftfchOcz9.vaahmxDa7eFV97gCUzrBl8nBePBmd8wz06vrLAvrq.M4np3db8HBVIN
 7iU0q7s8hbk3eLrZkuYsQDsnc8v1mAz5ARvw5r.bpuq_Ua549RERg3r1OukSDIUgLmQyab9OqIuk
 U2BVHQWGOz3kZzSOeUn7iPNzWQNX_4sqy0cPK0SfA_mgvzJtHwnA.x.zPR5Q.RF4bx9j6ABt3wom
 LtGTCZsuK6eDGjMf2_beV89aTv4m7Wvhg7xiwReRSmF6grL0OPAzZfev2V9RCW.xp.S93Uwa6lOi
 dTqRVieUYVkcPVSl2nmEuSWafyDISY_x3K2bKkF6.6DvTxV_hkq3Ng9XF4rp2MJyUhULWpb.dLrX
 I4v3usQEHgioX6pfqOH7scLUZ3xzoxeIWvV_XHhbbozpEfeUb3nLqgi7K8e3pC9t3kSbvKb3_tqG
 u8kdCIFREVGH8K4c2qOfGgxH5CXHI2dLdvUoc3IE8Vgkd9j0q7ATk4tb.ZWPEvmvcVzdFDvWx8Jp
 AqEF7Itqod40.ORRTWUeX5A7BDQipMVUmelXggFdAJyYrrAWLQvkn3JJfByvk984R8SBvNg5C_lX
 w4t8ScCNBbuKC4hCHqOLkK.lwCP6sY9njAAZqdluQEO6CskpJKX1S.z_7OtVjSCVL5VW_pmZmUb0
 w0pnnbsxW6MNWiwe9qfx5WaC0xZ7whyjrDcAsF6NyX6IgGS_eUGWbQpAiGmfKXJqbMc9qOiopJn9
 Cft0q6bsvF_l_lK9k1XTdkMyv1WsMsl07vV.oumFlnXbkM2NaAfZcJebvjvAiOzuoBHcRh14XKT5
 PYkKzzenzarzZ
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e3fae37a-243b-4e6f-89a4-6bf2e21433cd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Jun 2023 19:55:43 +0000
Received: by hermes--production-gq1-5748b5bccb-dgd7m (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8413d56f5114fad294c4c94233ef2643;
          Thu, 29 Jun 2023 19:55:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v12 00/11] LSM: Three basic syscalls
Date:   Thu, 29 Jun 2023 12:55:24 -0700
Message-Id: <20230629195535.2590-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230629195535.2590-1-casey.ref@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
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

https://github.com/cschaufler/lsm-stacking.git#lsm-syscalls-6.4-v12

v12: Repair a registration time overflow check.
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
 security/security.c                           | 216 +++++++++++++-
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
 60 files changed, 1569 insertions(+), 93 deletions(-)
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

