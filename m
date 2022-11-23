Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA1E636A50
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbiKWT7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbiKWT5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:57:54 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252E221B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233470; bh=KGezVsV0Po7wkqsLTMkHH3Oi+nbFxChfwJVSfxR3dMA=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Ml6RS7b/q91w3NUyI9l+ulLb15yIe868ZH/FzDmVuIDMOklorbMYlTM7wocGkhQuRubK8HtvYX1I08q1oWSDaUZsW2W2t0iKqo62KF1G9THwRARNVImQVlHZpyqo1RRULgAwAgYeUnl/IPBfSn2b6rXHvVioxSlIe9gtKAVQ5naDoWTuw02dfx46MJmZauG5BK+Jt64YW2XkAuU4mSzmtO4vJ49JRtOq1MGqU0uNKQnBhVYqlSyti4I/PgnxUkIzHKVzrFlGz13GmomfpInGP8eDCZIY9lfLy1mHg7H+t/aIufEqbjY3ODCffl3HghDkVFP9VmvWlxjTsSg02Czd/Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669233470; bh=iDdE/f5HexrxIf1Jz1p61NqQ3OaTQvJBYgQ9RSJ1nkK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LThMiHdfh4IsyOqVdNIeQVDoTR/XTrH284w1f8sNpKSzK6Chs2MyH3clfJpZcHsxWU8HXKWGuAdfL+aHVH41azJvHPnVWYETvIt/keK/wJAxIFYt9n2oyo7bRVc/0IEw7C/1Ix36C+3AaMs6JhQwsvG0WTDLXPmnCbaOQtH0VSVnjQvf31wLKES63kfVVzqJpoIKWt9P8Q5QS1yd7OrrIEhtbrMf6J4bJkCCq1yYEorhEY4QfjqpZnotgckuzs4WZTFa+bBw/NtZUSGuyhEh9inDf/U7hqX+ZGv0WNnGFaMK9FEnmRTl7Hu8kqAtZQ+CJeEKJzTGymf+xRHsSVZdxQ==
X-YMail-OSG: LXWC9P0VM1nWqJx7OwjvahsCdES_Rxx6WP3D.XQDpyLHkLCoVI2yfQeg6IhsSLU
 hCTZsD48CbhtZ_lI4eAjr4FGLvo3b4_xBQpwBN6ZB9liAkVE7CQSNpBaylwbBfIXX7McIrs99W78
 Q5mHf.JoRx4v.vzhStp6kMUNjhSp2alhWyJaFOdxEpWjSxbIN_gFWF_WP8WavCXjrXxnaLJX5Pxu
 cPzafRGQ69g66sAylgtqvK0FFdq6ZEl9Ur2Wc9DX54MhtTUeUG3DrKp9uvPdne.Hcado94pskFx9
 R3Oz8GePtZXu_rTJ.5oObrTZNHiIa2xKCFaxDjzrfRZU5IVkKO44SNrFbNA5ZEWZKlRSVhKZNvO6
 fcCpHWkuVVLSd7w7sBhzUnEdpnUyyj2ajaEmzd5Ik7skeAuEaMnjPk.UkrMyQGjm1k1b6KF6CkwH
 UYkF_QCTYkJc7msc7JB1MUUYKawrf4TmQfJZ.AzQ59HQvB_T19A3cvpaWB.gBP9EvdplZ4.4FHV9
 vGX4ER73zK.uwv0yaERFwYgzRSDaDK1tpOpPUPNwka7IDQ8qYlqbmA_2SFqmYJcZEha0rTwXQs4e
 upLxQ3dB.GYUwNHsF1ehuaQ544TfCezf1coUffAYjsgGTmrnrBH0JgvJdCFBMIgtuG.BsADxjFJQ
 IyOfrrVluWbJzg_yftG25rPQ4CQUB8WquGbM5HTls4u7bUy1D2.oykZCnvWOPvJFlDEmMrQcvtg2
 kcNJjgVRm7dD8eACfflGRbz05YADPKSQnCuMns7gf.Ah_uOHQRP_wFnLmI8mQKZnXgrGvTeagAKp
 wNqDcvSG76Uq9zj.qoL.9lNTVqLz.yNOfBbCupriX8NAtYafSFb2SrXs3OwrBD2EGG0JbXdo4uvv
 20yQADzTBN4ZVbMWv_UC2UPDJYpcpbDKAlfc8HhrcjIdarH6HGNwBcgPzKogAXvFX_GoWgf6pS3F
 9NC9j6F522Dy9DRkrCUzcencSP2JGF5uKfVcpzO1NdBJYqSu7.rNJ3fmzEn_b1WI_Smy4VPD1Gzu
 gggdGbJcrilgOpz0TECLZRJfl7KLD6ch9AJnZNyPXHXdysJE9yBb3MRc45zunyEuK4R8VcwPKhn7
 2_WjvF8VI1hqpzHzglSIFmEqFK5QO85S4Wz_z8Ba4ls5UduovM4lYIiZmDHsBZCQtzjvQ_.ooKHK
 SGfIGTcDbR9ig_.yQwOk3OnKhhr.hT6ozW1u763N4l9fPdc6i4d2JgfhOnUwereV.uey7Sb9TxpJ
 BQnM5yR.ognjqJ6TBOXIqnzE4wj6.EbLrmVmMnBK.dcX32o2NpuYxKkBJNoz9AjgP78aGDs.k3SB
 KqWcV4MInM8aOHNurXIUnatxUahnmyesT4Tnfb.Cew5EvkBjc8.u8Ro_xbnMaDqX7r06NonyEJa9
 lWGMDlZ0PCuHJL1bLLBOdRsAKFc1WEZekB_EzE5B9kxIYDdjN1.ZdD2tkMthmpt0MZHmMPNdycsw
 T.WIvbf.JfcujaAZOMybGXHdqoxjKtD1q1CnvpMuHDjG8SoHdwbGXNWIjNuErvqkNcx7zqsnO46R
 DuIqRGIBoEbrpTz0YMp4ZKdcFgGAzKx3d05hI2AUR51_PWy_jwEr.Ff2NE2kYN1ZzSooKdGmRicQ
 oWLa06LgMNOD0je53gdlM_D06WY3YbJfrNh4eU1o181nds3WyYBGQTnwNC39lkNfZCqi3SNFfeW9
 spImseU.rLUS8Be_Z8lLaQkqYOHvL1_dwX_VSt1StLJd5HU5b58KeYLlUUTsIsqQvWMdBnnIFeU1
 jCneWOHX9i8wkBFAwDyfAm4dlKcr3_42DWGx1Gzk9iLbSwPUbhpRaf15vVuh6HSYrzJwljyaas1x
 ycUY8y3j4VdKqdN8zQqEX7iW7n_cylkJICRw5lTClNrN7pYUG5m1n4JEQn523BBKgs5DJNon5oT5
 3U6_jz6okzdcxZu1ozH8DyNhahxBiy6_jJ5wSUp4lw6yrSUdVvZkzS1mPXn2tepNmj2EeZsAPgps
 4bZmNL_JxT2_vPvGrFK_wLu2kOFk7Q098IQB3tLqE4HKU45DbJgj306_i.aWoUP9unjVhIbr3i_Z
 jsgVdxrJF3KtHUN0I6gcs3rBxtgEAMx5aXWXDQi4TtpaPxBgZ4DAZz4M6sh1YGh3p6yUNvtPbpv.
 cqcQk8TUtMWZCyxzhM7lAIcXXc7H1vifCSGrtgP9hJ09H3DNnOFjrkIFjXl2qsqRRsNl_fdFpCAx
 a4VmAjnHvRUmCWbcKE9jEj5aA0dIqY2UmA5_ruUwmuEBx8VpFPrXDSug72shvgAE1lBtj3b99Nqn
 0Bxt981JGJpp.
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Nov 2022 19:57:50 +0000
Received: by hermes--production-gq1-579bc4bddd-hbm49 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dd0bf7e44b76ebf62a48c0cf31f93899;
          Wed, 23 Nov 2022 19:57:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 0/8] LSM: Two basic syscalls
Date:   Wed, 23 Nov 2022 11:57:35 -0800
Message-Id: <20221123195744.7738-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20221123195744.7738-1-casey.ref@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two system calls for the Linux Security Module ABI.

lsm_self_attr() provides the security module specific attributes
that have previously been visible in the /proc/self/attr directory.
For each attribute that is set on the current process the system
call will return an LSM identifier, an attribute identifier and
the value of the attribute. The LSM and attribute identifier values
are defined in include/uapi/linux/lsm.h

lsm_module_list() provides the LSM identifiers, in order, of the
security modules that are active on the system. This has been
available in the securityfs file /sys/kernel/security/lsm.

Patch 0001 changes the LSM registration from passing the name
of the module to passing a lsm_id structure that contains the
name of the module.
Patch 0002 adds an LSM identifier number to the lsm_id structure.
Patch 0003 adds an attribute identifier to the lsm_id.
Patch 0004 adds the registered lsm_ids to a table.
Patch 0005 changes security_[gs]etprocattr() to use LSM IDs instead
of LSM names.
Patch 0006 implements lsm_self_attr().
Patch 0007 implements lsm_module_list().
Patch 0008 wires up the two syscalls.

Casey Schaufler (8):
  LSM: Identify modules by more than name
  LSM: Add an LSM identifier for external use
  LSM: Identify the process attributes for each module
  LSM: Maintain a table of LSM attribute data
  proc: Use lsmids instead of lsm names for attrs
  LSM: lsm_self_attr syscall for LSM self attributes
  LSM: Create lsm_module_list system call
  lsm: wireup syscalls lsm_self_attr and lsm_module_list

 arch/alpha/kernel/syscalls/syscall.tbl        |   2 +
 arch/arm/tools/syscall.tbl                    |   2 +
 arch/arm64/include/asm/unistd32.h             |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl         |   2 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   2 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   2 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   2 +
 arch/s390/kernel/syscalls/syscall.tbl         |   2 +
 arch/sh/kernel/syscalls/syscall.tbl           |   2 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   2 +
 fs/proc/base.c                                |  29 +--
 fs/proc/internal.h                            |   2 +-
 include/linux/lsm_hooks.h                     |  13 +-
 include/linux/security.h                      |  28 ++-
 include/linux/syscalls.h                      |   3 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/lsm.h                      |  67 ++++++
 kernel/sys_ni.c                               |   4 +
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
 security/lsm_syscalls.c                       | 194 ++++++++++++++++++
 security/safesetid/lsm.c                      |   9 +-
 security/security.c                           |  37 +++-
 security/selinux/hooks.c                      |  11 +-
 security/smack/smack_lsm.c                    |   9 +-
 security/tomoyo/tomoyo.c                      |   9 +-
 security/yama/yama_lsm.c                      |   8 +-
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |   2 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |   2 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   2 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   2 +
 47 files changed, 484 insertions(+), 47 deletions(-)
 create mode 100644 include/uapi/linux/lsm.h
 create mode 100644 security/lsm_syscalls.c


base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
-- 
2.37.3

