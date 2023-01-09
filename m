Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AED662E29
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjAISJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237626AbjAISIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:08:31 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ED143DBA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287646; bh=58PveJGvUcKgH/GlCJ6PiS0yrO49DI6DJOh3LvfvjV4=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=o+ImmHNhzyrbAsNOT2YT+hOrzlkDPWfU9ol1MkRdpJ5Op5kliXhxmBYu8ebI40k2Y7IvLJ+QSDmuxRjlH0p8Vws5oEO00N+ZT7tAODXbz834xrTz0giPqL/0clELiA8UWXKWBVfaxBE7IlvgLllIvxJ7WHAvRxqhhCB6c3ZX82xP5cDjzsy7Jcib6/7nB+eicxNjoCHBt9+J2s8uBQd5/zFcbgzIdEM0Wm70zPEKzt66/OWJkWbSh7EIKQIPPgW2lKwn1DWseBcUiseBQFPQhuHOpV7fQMITsF92Q+6kh3YzDB0RXTzUu6QuwCJKJw4KbTnLkKB3Aj64Gg/vEmOWgg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287646; bh=JOenBiMSVgvKIMjL+A40/4qiqmxmXar1lg9uzqDJKF5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GfvQEDhX2MDdBZ5+AeKhDXgUwCD1hPci4lrQ2J7OGKUS/H8IYunYFjQND0iJuE3+b39SrOdU689mTDDDZV/BpVb9umkGEfakFF577drHTWHFLGucukiFMtNBv7Esfnv5Q37BMd2RXdXF36R9hdoEaZ4LeL128uYmbP3Ih/SZ62f4E8BYwlJfTqfSCjyaCQZbUvwSvtMjE9eFPNdM0oR36zdjOdJ/7HfA2Q9K8bsef7VtBXsFKE9+ZHCKVSyjZbQtzPwn/oEah5wh9LHHfXD/QuSbTJFMTcPqVi9XTLtfEiwgfY2f/OfOAMUuf+qXk+nPdwV7rb/wJE2RPHjz2fdElg==
X-YMail-OSG: 1TCoBbQVM1kHWs6634ItatPEJelxaRb7uiZQLDpKXvGcrGPLJGiMeG42XsSX3kf
 ETC3J8etJ_sBn2C6FJNHjCA8d3Gkth7arHUGMF5dC49ALqBpcBprg2USLhG3_LFN_WDIhTY0UJqu
 zJx5Vn8Xn676ThhY_A8yWd9RlHZbcdlcEJ3GgNcuSKzd8hmlkCKIg.ft8DA.Vdn7L3asJvP1nG04
 YSxZzNEyQTlGtA6_CygrXBfGcwidtY9fq3wIQD844QxPfICm73p5IUj5XC4lPOVuuOijDPx51c5R
 Jago1NVgYEJNDcLlnGW7DI3ECJUtaDUMATOpYfkGqEGLPGOW6UdC0UcSkAn3xDTGfMA1LZnhj28I
 zSWjlKKHKBPlF7xSJ6F17Rowhc7tC7Jr7wmask.2Awb88n7U8c66ZAd.QSBOpUjsovLu3npq17Ls
 7aWFrPjog4V1WHjArxRCRKubeol7kIjmvLMRExZ4Mg2mcnsR1wwAdFvnUatZcMi0U3zsMAb79roH
 GD3OdVdvRAf6rGd6fXEV9TpMsIqBD9iAFQEdk0X6lZEbwjbKFjLoCYbSSwx1TOKgvVCOf3poPcLD
 IKiNEgHJwb69XTIjnoYnsBg0QJRvUnUkiTVledv.6hPwbKUEHUvXN4wfYx9PDqhRKvadpfYo58vO
 QNZTsnAzR0Hs1oASak_5q8d25dMKbSuE8zFrg.QLLl.xzqmInrSIC6DAXBX32L087AWGlpudfQlx
 PC0ZSzeAgC3Te_TllaEruDB8_EaG9gxpLAnMl.4__ZXUDJJSKO0yrSCUVlDZelrXcS5X0QxWCvTc
 70ZUDO6o9QWSAuKCyH4zEwm.Y8dWEvrGiF5vZW.K85.GspClnRhZ1NdGS7VNyP7o1QLr58.lqIwa
 yhqeVP8iKtJD6rhEmqHlPCELOEl3g1WybieBA8eV2PbcmMKX65hT36R1XdEOqpIP83nOYKIQwan_
 ZRMwXfSQizY6Kcra83XFoVlZ8BalduHLtOBsV_uAwYXvkEbHPhxNmlVcwZfvRpoPwP0RGH94MQ0b
 bUFeysVKAe6nKX1fjjhu6MIdqKhkM5rQODXB36VQsFP_HzXg.r4KZ9vRTW82KiwBhDU19i0B8ECQ
 eEq6PyfjPFgKDY3rQa9ErRLm9DXH0VQoGQooFynsj2cLokGXlWpvCHuzpqobmgjFi7Q9kjvJDqJa
 BnjGD1Az6hw6GkVp3OAY2f6Wf4MzReXiDK1ZTTGK9qxqcmxBZv3yAEN5F8et78thDmiZ.xQUZy9l
 abD8s.IYLs3KLZSDsZXGL8wZDTWcbkjjMfhBen68d2XhGrPXjigA4QfdhRg.3QSHvUaJcu1vbT_t
 UTtIEqxwjZuTUknuld1Sp1cEL6QiIcsOE_ybSliaK0iGwabDDbsPcKB2bZI40ZmZAzF.o9SXNqj4
 eZs3S.BLIcb7UbcJ24bDDSZUyCPvNxD0LbdoOMQEiBraeMWq2_KaSwVuzTKlnlb8wq.Id9TK1YCB
 s9B_fLWwbfWZcAXCueod0AqIJDO6uChwlz0BsbrszXyIDht0Eq7p7JquDA8B0UCbFjTkF5nuH15v
 6VLKVOsZ4Wfmf4KcWaBzt69vpCaUh0i24Gxd48QD7PM0DoRek3XbEQYU8laGAkpvPmePSuwbYZIn
 lOLHukiz0Q52MO_sEj6eopNptIvPCZzq41w1cV0ZTyngltkPGX02yAIxvBE2YHOmJPAj6UPdCWgA
 XSsy7.L4cV6C2AHBwSI516IOZTNm5gxvj258zZezRuUkMj_.io688OPvPipezp8H.chLfinJ31r2
 UcHXKcYw28xzYogGYdcfMGOvXi_F763pW.qRTvUk3Ech8IJhLMV1PZN.Rm.DLvHE_tVhy9Wso7Ji
 n9UZLnVPcQ37Cgm8N0d_GJPJ1eOfWW.1Kk8zKuJ28NCFkkOSEz41KhYdKYjv6li6WpySYW3Doi_j
 u62wkZx2OxbTt1jTLcY.6fsesFcZa8vjo6.UzjKH7Y01.ZO_qp9c21ZGCWpk8XDUvL3l9SqJ1aFY
 W79P.hEUyg5qxW.Ta94hwPtqiLzAApGn5nl8OBgjhWiQsHVbWq4ChP9TVlRcDwimyx4CsLGtdnqm
 kDrqdXOT62lfRWz.sTtmlwTFLin0vkhwCpo8TPfJkppCC4BQxfEb2AbPga7dRgJ7I7QYWwEZxdpX
 5gnFGWt92kBTM5sttfLrW1T1CQjh2usWYKkgw.tjCjvceaXqUsKbDPtiw8HygvZWsMcc0JZeMbPd
 7iVLCLequZNLdP7dSDyZWupbHwn6PosEY0iaGm0u5k5mJuUIuuKnnBYyxlcS2olleAen7Q3spxNm
 2XVzZTaCGig--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 9 Jan 2023 18:07:26 +0000
Received: by hermes--production-bf1-5458f64d4-46wzk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aae4f9f8595ff7b5b642ca19e86fc157;
          Mon, 09 Jan 2023 18:07:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v5 0/8] LSM: Three basic syscalls
Date:   Mon,  9 Jan 2023 10:07:09 -0800
Message-Id: <20230109180717.58855-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20230109180717.58855-1-casey.ref@schaufler-ca.com>
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

https://github.com/cschaufler/lsm-stacking.git#lsm-syscalls-6.2-rc2-v5

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
 include/linux/security.h                      |  13 +-
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
 security/security.c                           |  63 +++-
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
 56 files changed, 1438 insertions(+), 55 deletions(-)
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

