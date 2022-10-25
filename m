Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D9F60D3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiJYSpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiJYSpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:45:33 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F604C023
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723527; bh=KGezVsV0Po7wkqsLTMkHH3Oi+nbFxChfwJVSfxR3dMA=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=RtHzdyObclKhnjsaIJ3WAnb0UjvxSjbHlzVkiGZntj54rFgNGIF4CXaomux15f3JW87ijJw3jQreoPbke1kMMqgbXV/7Ol0SmvXZWmbAlULGLpnwMAoRJ7Bb4sbpNQz62mgxkC/M/Rbn/Oy+YlP4DhjPAcGasLfGRm3CNKvDkpQqRW12F+H/aBYHo+fR4dXJOoX8+fiTUKDaXTbY6tx9i7cwX3VZ/yFzi/OfqUL0+21ZKTtCrzmTXGPrnA/lezTaIqhyj659HbQn7rHsFv2D+fUuB25jAvFQFUMLi75LV231WLwPke6yefphnKQHMoHFUfoZ0D85kv/tPINpvjOAjA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723527; bh=26r7vNZRlFAy0Nfuom5q612171Iyc4BcfBGeJQK5EpL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=K+RTrKborR8VYFMAOqndcIhkgTMM58sS4OmRZrnu+fl+l6XUSmkQ1yUR0w+zy2uqYsFk0qMSRG8iLpEAJTE8opyTgaE0kODTNBu79CbtGYznBQqk72qnnYs4IgYaLC3mBINEvH0LnL5mrfadhbwkDpL9Bbvx/1+Mz9w4r2EosoaVYZ7Cj2m2zycDsZXbi+ER4mPLev0kfDO7UqYL/Ocyw6h3Tl4436EmQT61ouQUL3ERqrVqLPWHGcPYH8A9IvnYScMaZFTVPjSRQyXZC/vM+upOUSo23HyC1d2gjmyZqbErJkmD9axx+VIoLgsaromAeviOmmBlLRWNDJOPQL7f4w==
X-YMail-OSG: JZ_ZOsMVM1mICj.po.vXEvgKtW5akTQdEDwKXTT5rzW17TRFdh7Xx15UzzwcFY5
 p0PmDRHeXE7cROtRr3p2ZHtop03WwcjD1NXi0ge1ca1RZclINMeRwGMtX_0rLrOS2E65aQPxLYNU
 O9vjjtnzGDMXTjJGMhbHfv3N3z3N1UkPUUKTrQwXxjq0n3qBkn8RcGjTFObn0QgADntAEgsM7ggz
 r.lAkFVrNZXFdWVmjMflnP1pmQOpEoL8.y8dIlkzuuc9.m5yl2u0JzcGFV50Vq4VVrXyvcoh0585
 _jiipI2Ihdl6ZlAfVoWqNwAgbGh.kklvQBsV0faJtlUDB7wrubmM4liz8d1ZGRSbj_GaP76XuoO5
 NtDQmmgBbsVrdBjwBunRyZca0NYWpptmEnuRRV6N3eRIjkBXeTJnxuGqjf3D11Ig.VyYVTLkOkcj
 5Te2kcW.ymGw3kLJIdC7XbMRFJNlpfPCa7OCpLXesBIY6F4bQPtP3U68BUqMm0_ZqY6DdmIfdu9s
 XX1joeTEJVAA8PFFAHnZIQZ68qIPIyHn2C7PRA_4ytL7IhsYCWGzBLNbDI56it_UoGBgObVUG_T7
 etPahKt2W9bUarNA.b1RcJ.wDciJmdpXVnelhkIMQO1PT0ve7okBnINFtbpy69uBqimu9lWB79NX
 k8ADG_1rgk__cU7M9LqodztVT6ept4U97MzzkS7Mbu.t__BYbl3Flr1MQcFaN_idbxSSc2RddqxT
 ph5uhAdgaw7U_kQSpv6HlvQK4r4blr3q0rYOhGuBzaRXHismmcDVCIwWVK0I6l9qs9b_dMaWdtSK
 hvpCF48cicrLwodG29m6dIsDabPXKXWi2BCu7RaTGr4fY4Trta8wIUP2vwc0v_JW7agpUVeybAC0
 wAQ7IkJ4WugpcaFlon8umxJyFK0D7k.IWiJmc28j.FBVabovGG8hc.lVVX.c4x2iwgxxhuFVcWi5
 yXxPgxzWegmhb22uMTrG7ETTI9tCSm4HdaRVPxJvjkwwmxSzErk7EXlbqUmq2cCtK4YJL0db.Bjc
 eqZLSSaQxR8JGQZmPEULQYARqp8aKuKL9MO7mxAbQbvEtf5U_emUWbSrFma0KH7iEvxEZ0fss6dp
 mRcP3CsY54n3qmwz46JN3QHA5.CgAjHpcf080ywKE_uUd5M8xCoLApWYB5mbHshcacx1e484VCNI
 0EvEJqWyYXq4oEmBN8CC.PIAFB4pd2BizkuRVQ0rApzIjI2CZnIhdtlwEG.OFvLOUHVZO68Q5_2Y
 Rl8dZ9Ydwsner8jdHlza_EbZMWZ2_Gfb1YFG0qnXmuHhft5tOghyZdh4EDXZLBvp7Jgc5Z8Tm5fv
 n7Zjboh.GFkgeAsUyPCuA7pKvfApM8ZMj1ASHFqV4OhiIgQDwpv9M77kXEpiyo6BG45DbqJs1TfZ
 cQKOC99My5y15HJbHToNI55UaZyX_8n6uSJRcT4TDzu4Z1iV_dAhfqjuIpmJFibY.CN5wE1aTIHc
 jw_0oShETwnJOL8NKOQYvcDraPAtnUz85G9HwTlQOawEYx9p9ZSJIqz1XWK8unBmfY2ZfrVzo7i2
 X6gr4kClVyvwd6v0ANR26Mif68A3zAteTnaRg9726kmVr_qPEMyxGaReAiv0_5POADplYhCIue6r
 6Z9TGtDEGpXd7hhEO61BjpadOKSV1BGb4EnPyzDI0lR777hUpIjAZdjDL4uSPseN7h6bRQgygRb9
 0ktmgfM6tkrwQVoEg3JaPF7vhmsl2LFmUvQDjc77a112Mgtw_anqmuWJqVVa3fXSvnya9SJ2QRnY
 uZXgM5Nif1r2yF90JmOcVHhjApYO1hOy2TckC4fDQyeOdgHM5.nPeK8a4GAJycfx6eqLpHcPIp10
 ZNL8wp87eZpi6AssvDnqlY_rb33XCQR.foQsYjdb3iyw53RmCVfrlqju7KXuthIOcsZjtCMP3e7d
 _xputnaRX7IMtnsBSinGjwouLHkwLIh7Re9_caUfNkXGjeYEQFnGo5Z6I4_nnFfx8cY1vm_sr6Dj
 cVZu6i2A.rGkrtTu_7CMSeXHKO1vthc2xGLmcdsGd3V7IsnJsQ.m70SC2rsO1ZjxvweR..h6ilLl
 4GY2LjQddyxF0dOB2vyV4yjXuVUUnw0fnAs3yoUbtUvR8lijYOEi45qll3S00bF91nWYjqDYVXbz
 ttmU1jWZdxj3Jrbk1.9kJ5ZdOBiu30m_TQ6N02giBx4q9x9MCMRiI6ZR1Ggt_zGy4bf08kAAR2eg
 JyBx1uLusW_hrGzD6czwiKnFzoy4S3qULgQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Oct 2022 18:45:27 +0000
Received: by hermes--production-ne1-c47ffd5f5-h6ptj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cee108ccde84a9105dc7ebe9516c7326;
          Tue, 25 Oct 2022 18:45:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 0/8] LSM: Two basic syscalls
Date:   Tue, 25 Oct 2022 11:45:11 -0700
Message-Id: <20221025184519.13231-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20221025184519.13231-1-casey.ref@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

