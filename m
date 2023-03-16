Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E295A6BD808
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCPSRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjCPSRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:17:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC94E1C87;
        Thu, 16 Mar 2023 11:17:09 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G25WYA000452;
        Thu, 16 Mar 2023 18:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=RLht7V2kHs64kFtZ/QakmBEeS7NkeR50EiAkeTB32wM=;
 b=XhrFAF4rgtXIKrvFZtLd0j/GAXKbp6kDz+9pVGJGaNe/1CconuT8dRmMuW6aDUNxq8BS
 q4imHFk3MLsdDjkxvC5QaD9A93UrdzAhKa4sl8Zv0dMVDtmtJbIS96HGMVnu60H34uzj
 ZqMpqOYr0180sABlEOz+u3SPbOGDmSd/ZC60aLAiafMMoR5x5haDBMgqht0clJEdlUUH
 YRGBRSJY0XPldKGw56dgeWkuTsMj7wcK1lUhTiYNBDzG8rL3dzkQSBvCiU/fOfcsuDVS
 FpSUO1KV/7Z/cWLY0JPjEy/BVEvQPo+haYz5vFLgf/0ESTLYoGartafnUb69ptw1NMvN uA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpxjttnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 18:16:29 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32GIGRTj007111
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 18:16:28 GMT
Received: from hu-johmoo-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 16 Mar 2023 11:16:27 -0700
From:   John Moon <quic_johmoo@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>
CC:     John Moon <quic_johmoo@quicinc.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, <libabigail@sourceware.org>,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>
Subject: [PATCH v3 2/2] docs: dev-tools: Add UAPI checker documentation
Date:   Thu, 16 Mar 2023 11:15:55 -0700
Message-ID: <20230316181555.9327-3-quic_johmoo@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230316181555.9327-1-quic_johmoo@quicinc.com>
References: <20230316181555.9327-1-quic_johmoo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5I8CZOaFV21zfQ90meyyJseH5duDutbJ
X-Proofpoint-ORIG-GUID: 5I8CZOaFV21zfQ90meyyJseH5duDutbJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_10,2023-03-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add detailed documentation for scripts/check-uapi.sh.

Signed-off-by: John Moon <quic_johmoo@quicinc.com>
---
    - Updated with new flags/usage
    - Added example of possible false negatives
    - Improved formatting

 Documentation/dev-tools/checkuapi.rst | 492 ++++++++++++++++++++++++++
 Documentation/dev-tools/index.rst     |   1 +
 2 files changed, 493 insertions(+)
 create mode 100644 Documentation/dev-tools/checkuapi.rst

diff --git a/Documentation/dev-tools/checkuapi.rst b/Documentation/dev-tools/checkuapi.rst
new file mode 100644
index 000000000000..0e257eff1526
--- /dev/null
+++ b/Documentation/dev-tools/checkuapi.rst
@@ -0,0 +1,492 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+============
+UAPI Checker
+============
+
+The UAPI checker (``scripts/check-uapi.sh``) is a shell script which checks
+UAPI header files for userspace backwards-compatibility across the git tree.
+
+The script can produce false positives in some cases, so developers are
+encouraged to use their best judgement when interpreting the results. Please
+refer to kernel documentation on the topic of IOCTL stability for more
+information (Documentation/process/botching-up-ioctls.rst).
+
+Options
+=======
+
+This section will describe the options ``check-uapi.sh`` can be run with.
+
+Usage::
+
+    ./scripts/check-uapi.sh [-b BASE_REF] [-p PAST_REF] [-m] [-j N] [-l ERROR_LOG] [-q] [-v]
+
+Available options::
+
+    -b BASE_REF    Base git reference to use for comparison. If unspecified or empty,
+                   will use any dirty changes in tree to UAPI files. If there are no
+                   dirty changes, HEAD will be used.
+    -p PAST_REF    Compare BASE_REF to PAST_REF (e.g. -r v6.1). If unspecified or empty,
+                   will use BASE_REF^1. Must be an ancestor of BASE_REF.
+    -m             Check only UAPI headers modified between PAST_REF and BASE_REF for
+                   backwards compatibility.
+    -j JOBS        Number of checks to run in parallel (default: number of CPU cores).
+    -l ERROR_LOG   Write error log to file (default: "$KERNEL_SOURCE/abi_error_log.txt").
+    -q             Quiet operation (suppress all stdout, still print stderr).
+    -v             Verbose operation (print more information about each header being checked).
+
+Environmental args::
+
+    ABIDIFF  Custom path to abidiff binary
+    CC       C compiler (default is "gcc")
+    ARCH     Target architecture of C compiler (default is host arch)
+
+Exit codes::
+
+    0) Success
+    1) ABI difference detected
+    2) Prerequisite not met
+    3) Compilation error
+    4) All modified files were for an architecture other than ARCH
+    5) General error
+
+Examples
+========
+
+Basic Usage
+-----------
+
+First, let's try making a change to a UAPI header file that obviously won't
+break userspace::
+
+    cat << 'EOF' | patch -l -p1
+    --- a/include/uapi/linux/acct.h
+    +++ b/include/uapi/linux/acct.h
+    @@ -21,7 +21,9 @@
+     #include <asm/param.h>
+     #include <asm/byteorder.h>
+
+    -/*
+    +#define FOO
+    +
+    +/*
+      *  comp_t is a 16-bit "floating" point number with a 3-bit base 8
+      *  exponent and a 13-bit fraction.
+      *  comp2_t is 24-bit with 5-bit base 2 exponent and 20 bit fraction
+    diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
+    EOF
+
+Now, let's use the script to validate::
+
+    % ./scripts/check-uapi.sh
+    Installing sanitized UAPI headers from dirty tree... OK
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from HEAD... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers between HEAD and dirty tree
+    All 888 UAPI headers compatible with x86 appear to be backwards compatible
+    Note: UAPI headers for architectures other than x86 were not checked
+
+Let's add another change that *would* break userspace::
+
+    cat << 'EOF' | patch -l -p1
+    --- a/include/uapi/linux/bpf.h  2023-02-28 13:32:36.505591077 -0800
+    +++ b/include/uapi/linux/bpf.h  2023-02-28 13:32:57.033494020 -0800
+    @@ -73,7 +73,7 @@
+            __u8    dst_reg:4;      /* dest register */
+            __u8    src_reg:4;      /* source register */
+            __s16   off;            /* signed offset */
+    -       __s32   imm;            /* signed immediate constant */
+    +       __u32   imm;            /* unsigned immediate constant */
+     };
+
+     /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
+    EOF
+
+The script should catch this incompatibility::
+
+    % ./scripts/check-uapi.sh
+    Installing sanitized UAPI headers from dirty tree... OK
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from HEAD... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers between HEAD and dirty tree
+    !!! ABI differences detected in include/uapi/linux/bpf.h from HEAD -> dirty tree !!!
+
+        [C] 'struct bpf_insn' changed:
+          type size hasn't changed
+          1 data member change:
+            type of '__s32 imm' changed:
+              typedef name changed from __s32 to __u32 at int-ll64.h:27:1
+              underlying type 'int' changed:
+                type name changed from 'int' to 'unsigned int'
+                type size hasn't changed
+
+    Header file diff (after headers_install):
+    --- HEAD/include/uapi/linux/bpf.h       2023-03-15 16:05:39.601082143 -0700
+    +++ dirty/include/uapi/linux/bpf.h      2023-03-15 16:05:37.669092565 -0700
+    @@ -73,7 +73,7 @@
+            __u8    dst_reg:4;      /* dest register */
+            __u8    src_reg:4;      /* source register */
+            __s16   off;            /* signed offset */
+    -       __s32   imm;            /* signed immediate constant */
+    +       __u32   imm;            /* unsigned immediate constant */
+     };
+
+     /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
+
+    error - 1/888 UAPI headers compatible with x86 appear _not_ to be backwards compatible
+    Note: UAPI headers for architectures other than x86 were not checked
+    error - UAPI header ABI check failed
+
+The script finds the ABI breakage and reports it (along with a diff of the
+offending file).
+
+Let's commit the breaking change, then commit the good change::
+
+    % git commit -m 'Breaking UAPI change' include/uapi/linux/bpf.h
+    [detached HEAD f758e574663a] Breaking UAPI change
+     1 file changed, 1 insertion(+), 1 deletion(-)
+    % git commit -m 'Innocuous UAPI change' include/uapi/linux/acct.h
+    [detached HEAD 2e87df769081] Innocuous UAPI change
+     1 file changed, 3 insertions(+), 1 deletion(-)
+
+Now, let's run the script again with no arguments::
+
+    % ./scripts/check-uapi.sh
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from HEAD... OK
+    Installing sanitized UAPI headers from HEAD^1... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers between HEAD^1 and HEAD
+    All 888 UAPI headers compatible with x86 appear to be backwards compatible
+    Note: UAPI headers for architectures other than x86 were not checked
+
+It doesn't catch any breaking change because, by default, it only compares
+``HEAD`` to ``HEAD^1``. The breaking change was committed on ``HEAD~2``. If we
+wanted the search scope to go back further, we'd have to use the ``-p`` option
+to pass a different past reference to compare to. In this case, let's pass
+``-p HEAD~2`` to the script so it checks UAPI changes between ``HEAD~2`` and
+``HEAD``::
+
+    % ./scripts/check-uapi.sh -p HEAD~2
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from HEAD... OK
+    Installing sanitized UAPI headers from HEAD~2... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers between HEAD~2 and HEAD
+    !!! ABI differences detected in include/uapi/linux/bpf.h from HEAD~2 -> HEAD !!!
+
+        [C] 'struct bpf_insn' changed:
+          type size hasn't changed
+          1 data member change:
+            type of '__s32 imm' changed:
+              typedef name changed from __s32 to __u32 at int-ll64.h:27:1
+              underlying type 'int' changed:
+                type name changed from 'int' to 'unsigned int'
+                type size hasn't changed
+
+    Header file diff (after headers_install):
+    --- HEAD~2/include/uapi/linux/bpf.h     2023-03-15 16:10:39.495462638 -0700
+    +++ HEAD/include/uapi/linux/bpf.h       2023-03-15 16:10:38.919465752 -0700
+    @@ -73,7 +73,7 @@
+            __u8    dst_reg:4;      /* dest register */
+            __u8    src_reg:4;      /* source register */
+            __s16   off;            /* signed offset */
+    -       __s32   imm;            /* signed immediate constant */
+    +       __u32   imm;            /* unsigned immediate constant */
+     };
+
+     /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
+
+    error - 1/888 UAPI headers compatible with x86 appear _not_ to be backwards compatible
+    Note: UAPI headers for architectures other than x86 were not checked
+    error - UAPI header ABI check failed
+
+Alternatively, you could have also ran with ``-b HEAD~``. This would set the
+base reference to ``HEAD~`` so then the script would compare it to ``HEAD~^1``.
+
+
+Architecture-specific Headers
+-----------------------------
+
+Consider this change::
+
+    cat << 'EOF' | patch -l -p1
+    --- a/arch/arm64/include/uapi/asm/sigcontext.h
+    +++ b/arch/arm64/include/uapi/asm/sigcontext.h
+    @@ -70,6 +70,7 @@ struct sigcontext {
+     struct _aarch64_ctx {
+            __u32 magic;
+            __u32 size;
+    +       __u32 new_var;
+     };
+
+     #define FPSIMD_MAGIC   0x46508001
+    EOF
+
+This is a change to an arm64-specific UAPI header file. In this example, I'm
+running the script from an x86 machine with an x86 compiler, so by default,
+the script only works with x86-compatible UAPI header files::
+
+    % ./scripts/check-uapi.sh
+    Installing sanitized UAPI headers from dirty tree... OK
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from HEAD... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers between HEAD and dirty tree
+    All 888 UAPI headers compatible with x86 appear to be backwards compatible
+    Note: UAPI headers for architectures other than x86 were not checked
+
+With an x86 compiler, we can't check header files in ``arch/arm64``, so the
+script doesn't even try. You can pass the ``-m`` to force the script to look at
+modified files, but in this case, you'll run into an issue::
+
+    % ./scripts/check-uapi.sh -m
+    warning - detected changes to following files, but can't check them with x86 compiler:
+      - arch/arm64/include/uapi/asm/sigcontext.h
+
+    Filtering them out and performing partial check on remaining files...
+    error - all files were filtered out, there's nothing to check!
+
+The script will attempt filtering out files that don't work with ``ARCH``, but
+if it filters all of the files out, it bails out.
+
+If we want to check the header file, we'll have to use an arm64 compiler and
+set ``ARCH`` accordingly::
+
+    % CC=aarch64-linux-gnu-gcc ARCH=arm64 ./scripts/check-uapi.sh
+    Installing sanitized UAPI headers from dirty tree... OK
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from HEAD... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers between HEAD and dirty tree
+    !!! ABI differences detected in arch/arm64/include/uapi/asm/sigcontext.h from HEAD -> dirty tree !!!
+
+        [C] 'struct _aarch64_ctx' changed:
+          type size changed from 64 to 96 (in bits)
+          1 data member insertion:
+            '__u32 new_var', at offset 64 (in bits) at sigcontext.h:73:1
+        --- snip ---
+        [C] 'struct zt_context' changed:
+          type size changed from 128 to 160 (in bits)
+          2 data member changes (1 filtered):
+            '__u16 nregs' offset changed from 64 to 96 (in bits) (by +32 bits)
+            '__u16 __reserved[3]' offset changed from 80 to 112 (in bits) (by +32 bits)
+
+    Header file diff (after headers_install):
+    --- HEAD/arch/arm64/include/uapi/asm/sigcontext.h       2023-03-15 16:15:46.613800573 -0700
+    +++ dirty/arch/arm64/include/uapi/asm/sigcontext.h      2023-03-15 16:15:44.765810584 -0700
+    @@ -70,6 +70,7 @@
+     struct _aarch64_ctx {
+            __u32 magic;
+            __u32 size;
+    +       __u32 new_var;
+     };
+
+     #define FPSIMD_MAGIC   0x46508001
+
+    error - 1/858 UAPI headers compatible with arm64 appear _not_ to be backwards compatible
+    Note: UAPI headers for architectures other than arm64 were not checked
+    error - UAPI header ABI check failed
+
+We can see with ``ARCH`` and ``CC`` set properly for the file, the ABI change
+is reported properly.
+
+
+Cross-Dependency Breakages
+--------------------------
+
+Consider this change::
+
+    cat << 'EOF' | patch -l -p1
+    --- a/include/uapi/linux/types.h
+    +++ b/include/uapi/linux/types.h
+    @@ -52,7 +52,7 @@ typedef __u32 __bitwise __wsum;
+     #define __aligned_be64 __be64 __attribute__((aligned(8)))
+     #define __aligned_le64 __le64 __attribute__((aligned(8)))
+
+    -typedef unsigned __bitwise __poll_t;
+    +typedef unsigned short __bitwise __poll_t;
+
+     #endif /*  __ASSEMBLY__ */
+     #endif /* _UAPI_LINUX_TYPES_H */
+    EOF
+
+Here, we're changing a ``typedef`` in ``types.h``. Now, let's see what we get
+when we run the script with ``-m`` to only check for modified files::
+
+    % ./scripts/check-uapi.sh -m
+    Installing sanitized UAPI headers from dirty tree... OK
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from HEAD... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers between HEAD and dirty tree
+    All 1 UAPI headers modified between HEAD and dirty tree appear to be backwards compatible
+
+With the ``-m`` flag, the script will only check the ABI compatibility of
+modified files. It reports back that there aren't any ABI issues with
+``types.h``. However, other UAPI headers in the tree may be broken by this
+change!
+
+When you run *without* the ``-m`` flag, *all* headers are checked::
+
+    % ./scripts/check-uapi.sh
+    Installing sanitized UAPI headers from dirty tree... OK
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from HEAD... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers between HEAD and dirty tree
+    !!! ABI differences detected in include/uapi/linux/eventpoll.h from HEAD -> dirty tree !!!
+
+        [C] 'struct epoll_event' changed:
+          type size changed from 96 to 80 (in bits)
+          2 data member changes:
+            type of '__poll_t events' changed:
+              underlying type 'unsigned int' changed:
+                type name changed from 'unsigned int' to 'unsigned short int'
+                type size changed from 32 to 16 (in bits)
+            '__u64 data' offset changed from 32 to 16 (in bits) (by -16 bits)
+
+    include/uapi/linux/eventpoll.h did not change between HEAD and dirty tree...
+    It's possible a change to one of the headers it includes caused this error:
+    #include <linux/fcntl.h>
+    #include <linux/types.h>
+
+    error - 1/888 UAPI headers compatible with x86 appear _not_ to be backwards compatible
+    Note: UAPI headers for architectures other than x86 were not checked
+    error - UAPI header ABI check failed
+
+Note that the script noticed the failing header file did not change, so it
+assumes one of its includes must have caused the breakage. Indeed, we can see
+``linux/types.h`` is used from ``eventpoll.h``.
+
+To make sure issues like this are caught, it's recommended **not** to run with
+the ``-m`` flag when doing formal validation checks (such as in a continuous
+integration system).
+
+
+Checking Historic UAPI Compatibility
+------------------------------------
+
+You can use the ``-b`` and ``-p`` options to examine different chunks of your
+git tree. For example, to check all changed UAPI header files between tags
+v6.0 and v6.1, you'd run::
+
+    % ./scripts/check-uapi.sh -b v6.1 -p v6.0
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from v6.1... OK
+    Installing sanitized UAPI headers from v6.0... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers between v6.0 and v6.1
+    --- snip ---
+    error - 89/888 UAPI headers compatible with x86 appear _not_ to be backwards compatible
+    Note: UAPI headers for architectures other than x86 were not checked
+    error - UAPI header ABI check failed
+
+You'll notice that the script did detect many UAPI changes that are not
+backwards compatible. Knowing that kernel UAPIs are supposed to be stable
+forever, this is an alarming result. This brings us to the next section: false
+positives.
+
+False Positives
+===============
+
+The UAPI checker is very aggressive in detecting ABI changes, so some false
+positives may appear. For example, if you check all UAPI headers between v6.0
+and v6.1, many breakages will be flagged. Run the following::
+
+    ./scripts/check-uapi.sh -b v6.1 -p v6.0
+
+The errors will be logged to ``abi_error_log.txt``. Here, we'll find examples
+of several types of false positives.
+
+Enum Expansion
+--------------
+
+::
+
+    !!! ABI differences detected in include/uapi/linux/openvswitch.h from v6.0 -> v6.1 !!!
+
+        [C] 'enum ovs_datapath_attr' changed:
+          type size hasn't changed
+          1 enumerator insertion:
+            'ovs_datapath_attr::OVS_DP_ATTR_IFINDEX' value '9'
+          1 enumerator change:
+            'ovs_datapath_attr::__OVS_DP_ATTR_MAX' from value '9' to '10' at openvswitch.h.current:85:1
+
+In this case, an enum was expanded. Consequently, the "MAX" value was
+incremented. This is not considered a breaking change because it's assumed
+userspace programs are using the MAX value in a sane fashion.
+
+Expanding Into Reserved/Padding Fields
+--------------------------------------
+
+::
+
+    !!! ABI differences detected in include/uapi/linux/perf_event.h from v6.0 -> v6.1 !!!
+
+        [C] 'struct perf_branch_entry' changed:
+          type size hasn't changed
+          3 data member insertions:
+            '__u64 spec', at offset 152 (in bits) at perf_event.h.current:1420:1
+            '__u64 new_type', at offset 154 (in bits) at perf_event.h.current:1421:1
+            '__u64 priv', at offset 158 (in bits) at perf_event.h.current:1422:1
+          1 data member change:
+            '__u64 reserved' offset changed from 152 to 161 (in bits) (by +9 bits)
+
+In this case, a reserved field was expanded into. Previously, the reserved
+field occupied 40 bits in the struct. After the change, three new members
+were added that took up 9 bits, so the size of the reserved field was
+reduced to 31.
+
+As the size of the struct did not change and none of the fields a userspace
+program could have been using were removed/changed/relocated, this change is
+not considered breaking.
+
+Removals For Refactoring
+------------------------
+
+There is not an example of this in the v6.0 -> v6.1 span, but try::
+
+    % ./scripts/check-uapi.sh -b d759be8953febb6e5b5376c7d9bbf568864c6e2d -m
+    warning - detected changes to following files, but can't check them with x86 compiler:
+      - arch/alpha/include/uapi/asm/poll.h
+      - arch/ia64/include/uapi/asm/poll.h
+
+    Filtering them out and performing partial check on remaining files...
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from d759be8953febb6e5b5376c7d9bbf568864c6e2d... OK
+    Installing sanitized UAPI headers from d759be8953febb6e5b5376c7d9bbf568864c6e2d^1... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers between d759be8953febb6e5b5376c7d9bbf568864c6e2d^1 and d759be8953febb6e5b5376c7d9bbf568864c6e2d
+    error - UAPI header arch/x86/include/uapi/asm/poll.h was incorrectly removed
+    error - 1/1 UAPI headers modified between d759be8953febb6e5b5376c7d9bbf568864c6e2d^1 and d759be8953febb6e5b5376c7d9bbf568864c6e2d appear _not_ to be backwards compatible
+    error - UAPI header ABI check failed
+
+In this case, the commit was a cleanup/refactoring change that does not impact
+UAPIs. Unfortunately, the script is not smart enough to see this and raises the
+alarm because UAPI headers were removed.
+
+Summary
+-------
+
+There may be other examples of false positives that are not listed here.
+
+In the future, as tooling improves, we may be able to filter out more of these
+false positives. There may also be additional examples of false positives not
+listed here. Use your best judgement, and ideally a unit test in userspace, to
+test your UAPI changes!
+
+False Negatives
+===============
+
+The script can report false negatives when running with ``-m``. This occurs
+when a change is made to a header file which causes a break in a separate header
+file that includes it.
+
+For this reason, it's recommended not to run with the ``-m`` option unless you
+know the modified files are not being included elsewhere.
+
+For an example of this behavior, please see the Cross-Dependency Breakage
+example above.
diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 6b0663075dc0..0876f5a2cf55 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -34,6 +34,7 @@ Documentation/dev-tools/testing-overview.rst
    kselftest
    kunit/index
    ktap
+   checkuapi


 .. only::  subproject and html
--
2.17.1

