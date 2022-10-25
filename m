Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622C560D3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiJYStG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiJYSsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:48:53 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE890115433
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723723; bh=ol1pIH4ci4A8s6ujxzI53vrv6ZOj4gMh0L/Sc5n98Gc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=nRD6gwl48+hiEb1nP+qRaJrA25othUqyvKrmyGuX4mYXL2d2/3u9oYkFXTCE+mB+V5npYHz24j0Mr6Hy0nizbY/bBZ2g5npAAJ6Lvldd3Cwp/HpVipxHHvPBFAAd93SNR+jVOiYXYAyrwbli3MmbXoIVm0E4ZIIuKgtIY7RVWpYxIoC4hWwt3h3wPhK02hiQxtcQVEQxgD0MY95mTWzofB6+lPVtyCf9JeMuKV0THhs7U1yZrxd4evJ30N9jrE4eo/vPIDohOy2hg0/3YX4ZQh8SC7pEqyn4Nab9xuUS5JP1Thbn6wuN6zSVSYBuPvoSVr3oc8O8/CItU9HNwzHXcg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666723723; bh=cKjk+tGNjKE2ILWVDvLp45hKxcrDsIQQ3J3GJnzX0Xn=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Ty1nNGZ7h7UG9jvzi+E2mH/fBfLGM1lKoZsYtpnVmf5zZCSKZxKyA3NwiMSu+2ufWLiEaRnJm57vLZua1PGxRaRv2Nr7gwjB2VYDgx0+kcGqACb/cdLO5XGRB/8t4DHE92qf6KrDJf3xGKB9gyCrlaMQ4NvnOciHdO+L6SXvMdQK43LmdCzbPVlonBvcEmJD952KN/+0L0xJbOH6vMQf43HeNwv+uMgf0VcyNFuIFAAjK97uGWlXJGB033j655dnfsAkfJZigNKlIzzUjKXKta+Cjyx90bQ1Hpp1D18xQaEGsI5F/Xy85ielxZG4lpmow2eE2rCm4X3eXP2V3LAQRA==
X-YMail-OSG: s42lKF0VM1llYIA12O.5XUJnKCO9jImTtD3jKp6SC.MDXHYxSwerN5mA5BZWmrJ
 3uEvJNeBwMFnnlkPLNV572fxgZXsp9LNK4HYU63RN1FA.mou8o6ozmq4ThPTj_pYXfYPaxUAvPFt
 0xCdVB5F5vZdaTd4uPbotWWXSae0UI7CGckB7YXjzopby7mLHM6guAftQh7IyNTiy7wy6xB1oxl1
 2v8i4fXmn5IvUpsdkasv_vvctiP97DJbAJBRY2Fw.ShTxWciWm.anc6BcEWycMSB7u6DEDMvZhxT
 F31BOqtJtvWyl5wawrj4QszA.VDOW31mXzteB82OtxsHh3EcQZo0tTyXzIVDj1p1xUolZevtRgSs
 12ci706C9B_wka3iwd9XGXaP8gElkhkTgC1rNMY1v7YiVtUmf.6BAGoJ8O7fszXCSJeJafQlM_2Q
 iHVzH8KOfTWyhG1tQaCrjjEFKEWt03sJ2BUqvWDWKrz.FuvFEjgY6ATKw7MJ9Vxshb2I9c5sWgai
 xL1z1IvI2P5JLBf97wCHbBQwzGZKAmruyHdX.IfF2Ic0o64QlNKDWGSPknAgMZNv4go_csqQEVQH
 rQdwbyWRQU7yrpMKffNPPr.pCWg5vs4y4auKxp8Sed62efpQlTjCeyxh7rC4BJq34G4v0c4wDRjv
 gRBDPJgRD9twyWX1LlPJXQXZ1UPtbVx9qs5d0Eg2a1XS0P1JDTYo9BIbXDFMlgqu2wZrR6ziLEMs
 qp.sm.Mlt_aAqkvi4RxiDHTQMW7LCJMtzsdX9dNXDoj7YKjks.TIS08wR_4bJJdhJndU9V76dIjs
 FAKdsfOT3NuUH4U9yxGU1hTV.jxgxgqbfQqdI_R1FSStKPQ2ggX_J0JskoIxo_gXld9c744GJC0Y
 LjTH3hgFpx57gCIg5IUTwB59k5PHobSXyd5IOfjr436yvUlv2brf.DMbsd_AD5T71tApHrurt36Y
 FTTmiKfLadOWNlcCy0rkdeIGapFVxO3KK62eNTKjEs115BHYl8L53Zil6.k.1rQVfDnMFE7vPc6P
 4KjXaZPVU4.7X8cELUdSOYoNz2F.8t.Pew0xWHK1UuddW4MWuZgR7lpfUI7ELSHvdhSHY9Unzs.i
 9.DRztqJ6ALqULb_s1_dqU5dA1EYbUTxzUVD5KczrlJYil5IaF9deO_3LrozV0yvzPcIA2Wnuikm
 otk7e5ku_y7lbbsHzVe.1zS8mbduKyE1eR3CHyB_z0HrETwp7B4idjYVMFBvOe6vh6fOi_PSjWq6
 d2Y3kn6hT0KzT2sfenyLQxDXSpZiwj_uRABSwIx1dPPxdtXP.9vMjncqDv6wJ6oECb11hXqlV34Z
 ERz5NmPA8CEIcjTfQBpZCeTwozKtJk4QQrUADaH8S9VKthM83HfW0sDsghK5pioE18iu_uYrqr2O
 ghOcWlaUlH_u3LS6z.H4CgbQS246wPujk_EKJGuGGy2sx7YZ8.bpJVwfeJdOVKi05.T3tmhnZiFs
 BT95LwYhei3AiJqXy2yHw.T4SFAdZps6LdXOnMfqIEkntI8F_IF_AFSFX2bVI2aDVFNyyA0vTp8X
 YGiAAZwZiA5Xwoh2YZzwAtMTdgz1kltdN7gpNOBy65zbAG0C7hOF5OmRhp5BifuFN9BfVCxkquJ6
 wIoJL_RT2k7RuewLylAPQr0_buuzLOSgHlPz1ZNNWWoc9PJbyzdmQ8VLv7NcqGwlTc0K1eA6xF01
 aN_8.RarHv.EOvneJ_vBUBnUnhkGtDJ8lq2NYupohTG0G7Z5.XoKnbfF2t1Y1JfHJm6AJTpMcDb4
 BKu4gpzNCyF8EJ7RL0xOhD14OasvJA9e2G.ULwBBQT3cBuijEzJfh1zNwcdIFgei3y_bAC3ELYag
 80L3GroOI_f3uIbHnLLUpc0EOm.Iqfw8VCQD6m5I_V1Kn2x2MtP4dq.1P9JwjTmUn88u8WX5NUlG
 xfD7ECm3jkiO1hz5TwsP4LtfaHr1f64E9W.FiyMK7.VBTHe6vAppGViZDSlTF9AqHbVZAqyUvHZ4
 by3i4l.jryk7bKIxpbRSj4ps9Gr_G7W.jo9gaCa8mchhqhJqoni8jQHYM3k2Eq3nla.piN76vnLn
 sRT99bZ3fp_Uvaj1fq650L88.X5VSa6tCeVvSHOoMmAQg7nVLGZlDM6gCQkm4vronCNFlveRuV_b
 Ed3gIbz08WeSAWHLfM3vFQXx9onW0ZiIo4ViDiJG0FqTCdqj1fXo9qYJNr9lMcwadB3z8w7BsMuq
 dXYQChbsxHUatRVTofB27aYy03R1xXTgokmISzUnQKApCj.PGMugnkM8kriPSqDi305It4CC_MS1
 9yeBLvxKm6OCi89DTDFNffZJ0Dw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Oct 2022 18:48:43 +0000
Received: by hermes--production-gq1-754cb59848-jkt9q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d383105834ed78a52d504d4d360854e7;
          Tue, 25 Oct 2022 18:48:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v1 8/8] lsm: wireup syscalls lsm_self_attr and lsm_module_list
Date:   Tue, 25 Oct 2022 11:45:19 -0700
Message-Id: <20221025184519.13231-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221025184519.13231-1-casey@schaufler-ca.com>
References: <20221025184519.13231-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wireup two syscalls for Linux Security Modules.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl              | 2 ++
 arch/arm/tools/syscall.tbl                          | 2 ++
 arch/arm64/include/asm/unistd32.h                   | 2 ++
 arch/ia64/kernel/syscalls/syscall.tbl               | 2 ++
 arch/m68k/kernel/syscalls/syscall.tbl               | 2 ++
 arch/microblaze/kernel/syscalls/syscall.tbl         | 2 ++
 arch/mips/kernel/syscalls/syscall_n32.tbl           | 2 ++
 arch/mips/kernel/syscalls/syscall_n64.tbl           | 2 ++
 arch/mips/kernel/syscalls/syscall_o32.tbl           | 2 ++
 arch/parisc/kernel/syscalls/syscall.tbl             | 2 ++
 arch/powerpc/kernel/syscalls/syscall.tbl            | 2 ++
 arch/s390/kernel/syscalls/syscall.tbl               | 2 ++
 arch/sh/kernel/syscalls/syscall.tbl                 | 2 ++
 arch/sparc/kernel/syscalls/syscall.tbl              | 2 ++
 arch/x86/entry/syscalls/syscall_32.tbl              | 2 ++
 arch/x86/entry/syscalls/syscall_64.tbl              | 2 ++
 arch/xtensa/kernel/syscalls/syscall.tbl             | 2 ++
 include/uapi/asm-generic/unistd.h                   | 5 ++++-
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 2 ++
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 2 ++
 tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 2 ++
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 2 ++
 22 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 8ebacf37a8cf..41e4f3704ccf 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -490,3 +490,5 @@
 558	common	process_mrelease		sys_process_mrelease
 559	common  futex_waitv                     sys_futex_waitv
 560	common	set_mempolicy_home_node		sys_ni_syscall
+561	common	lsm_self_attr			sys_lsm_self_attr
+562	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index ac964612d8b0..20d551be0b67 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -464,3 +464,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 604a2053d006..366451dc8307 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -907,6 +907,8 @@ __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
+#define __NR_lsm_attr_set 451
+__SYSCALL(__NR_lsm_attr_set, sys_lsm_attr_set)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 72c929d9902b..a2ccef8e1eb1 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -371,3 +371,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index b1f3940bc298..59b977b3fa04 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -450,3 +450,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 820145e47350..82c39a22e38b 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -456,3 +456,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 253ff994ed2e..f973b69e7dbe 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -389,3 +389,5 @@
 448	n32	process_mrelease		sys_process_mrelease
 449	n32	futex_waitv			sys_futex_waitv
 450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n32	lsm_self_attr			sys_lsm_self_attr
+452	n32	lsm_module_list			sys_lsm_module_list
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 3f1886ad9d80..567035293634 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -365,3 +365,5 @@
 448	n64	process_mrelease		sys_process_mrelease
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n64	lsm_self_attr			sys_lsm_self_attr
+452	n64	lsm_module_list			sys_lsm_module_list
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 8f243e35a7b2..22019aa08696 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -438,3 +438,5 @@
 448	o32	process_mrelease		sys_process_mrelease
 449	o32	futex_waitv			sys_futex_waitv
 450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	o32	lsm_self_attr			sys_lsm_self_attr
+452	o32	lsm_module_list			sys_lsm_module_list
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 8a99c998da9b..e52c292923f6 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -448,3 +448,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index e9e0df4f9a61..099489ee5c45 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -534,3 +534,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 799147658dee..eaba1ed5654e 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -453,3 +453,5 @@
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
+451  common	lsm_self_attr		sys_lsm_self_attr	sys_lsm_self_attr
+452  common	lsm_module_list		sys_lsm_module_list	sys_lsm_module_list
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 2de85c977f54..b84c60d96f78 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -453,3 +453,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4398cc6fb68d..f0831bf811e3 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -496,3 +496,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 320480a8db4f..259509a0e23d 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -455,3 +455,5 @@
 448	i386	process_mrelease	sys_process_mrelease
 449	i386	futex_waitv		sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	i386	lsm_self_attr		sys_lsm_self_attr
+452	i386	lsm_module_list		sys_lsm_module_list
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..40b35e7069a7 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,8 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	lsm_self_attr		sys_lsm_self_attr
+452	common	lsm_module_list		sys_lsm_module_list
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 52c94ab5c205..f0c76d05b768 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -421,3 +421,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..aa66718e1b48 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#define __NR_lsm_self_attr 451
+__SYSCALL(__NR_lsm_self_attr, sys_lsm_self_attr)
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 452
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 3f1886ad9d80..567035293634 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -365,3 +365,5 @@
 448	n64	process_mrelease		sys_process_mrelease
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n64	lsm_self_attr			sys_lsm_self_attr
+452	n64	lsm_module_list			sys_lsm_module_list
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 2bca64f96164..7b779080acbe 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -530,3 +530,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	lsm_self_attr			sys_lsm_self_attr
+452	common	lsm_module_list			sys_lsm_module_list
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 799147658dee..eaba1ed5654e 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -453,3 +453,5 @@
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
+451  common	lsm_self_attr		sys_lsm_self_attr	sys_lsm_self_attr
+452  common	lsm_module_list		sys_lsm_module_list	sys_lsm_module_list
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..40b35e7069a7 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,8 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	lsm_self_attr		sys_lsm_self_attr
+452	common	lsm_module_list		sys_lsm_module_list
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.37.3

