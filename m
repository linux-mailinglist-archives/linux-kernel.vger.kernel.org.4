Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA3F6DB561
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjDGUg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjDGUgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:36:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38B8D304;
        Fri,  7 Apr 2023 13:35:45 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337KVZ45022174;
        Fri, 7 Apr 2023 20:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=HpOCz21FOTwSngkqo/J//LMZU6lWOmmvao+W3Nv01wM=;
 b=A4YVwxcx3H0ahpx3MgYKqonZSxaBtDB6h5n2XvhzQkOSD1CN3broC2MxbqDnqu+2UT1g
 V0wsFsgADlxo5De+L9aR9sfg5JeJwwDTWIXTiDaFYE9kUJ9xxpPI7wpMCYh135OurCKP
 w3bdX+EUCZbT2cjOW2eyz0NiwJAofk/c2g5lAfhZKDZwY/hdODh8R0Me0H5z+Uh6a4iE
 U78ylnn/kBGjSqTGDrsbsb54eMaOvhUgh0q19FyczawG7W5nZu2xijRilBrBl2zQp7VM
 PFPKu3qygjmveCMG++Os4N5Dos0KU3fukgb4ZtIqnIJGpp94LgunN9Vb9uAyiJriZMik BQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptcrn1sq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 20:35:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337KZJPL023844
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 20:35:19 GMT
Received: from hu-johmoo-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 7 Apr 2023 13:35:18 -0700
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
Subject: [PATCH v5 2/2] docs: dev-tools: Add UAPI checker documentation
Date:   Fri, 7 Apr 2023 13:34:56 -0700
Message-ID: <20230407203456.27141-3-quic_johmoo@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230407203456.27141-1-quic_johmoo@quicinc.com>
References: <20230407203456.27141-1-quic_johmoo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: --dEwVu6sHKDQERjpgvTAx7KqDCFlr4_
X-Proofpoint-GUID: --dEwVu6sHKDQERjpgvTAx7KqDCFlr4_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_13,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070185
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add detailed documentation for scripts/check-uapi.sh.

Signed-off-by: John Moon <quic_johmoo@quicinc.com>
---
    - Reworded final false positive example.

 Documentation/dev-tools/checkuapi.rst | 480 ++++++++++++++++++++++++++
 Documentation/dev-tools/index.rst     |   1 +
 2 files changed, 481 insertions(+)
 create mode 100644 Documentation/dev-tools/checkuapi.rst

diff --git a/Documentation/dev-tools/checkuapi.rst b/Documentation/dev-tools/checkuapi.rst
new file mode 100644
index 000000000000..18da0ac6426e
--- /dev/null
+++ b/Documentation/dev-tools/checkuapi.rst
@@ -0,0 +1,480 @@
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
+    check-uapi.sh [-b BASE_REF] [-p PAST_REF] [-j N] [-l ERROR_LOG] [-q] [-v]
+
+Available options::
+
+    -b BASE_REF    Base git reference to use for comparison. If unspecified or empty,
+                   will use any dirty changes in tree to UAPI files. If there are no
+                   dirty changes, HEAD will be used.
+    -p PAST_REF    Compare BASE_REF to PAST_REF (e.g. -p v6.1). If unspecified or empty,
+                   will use BASE_REF^1. Must be an ancestor of BASE_REF. Only headers
+                   that exist on PAST_REF will be checked for compatibility.
+    -j JOBS        Number of checks to run in parallel (default: number of CPU cores).
+    -l ERROR_LOG   Write error log to file (default: no error log is generated).
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
+    All 906 UAPI headers compatible with x86 appear to be backwards compatible
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
+    !!! ABI differences detected in include/linux/bpf.h from HEAD -> dirty tree !!!
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
+    --- HEAD/include/linux/bpf.h    2023-03-24 16:34:58.901204604 -0700
+    +++ dirty/include/linux/bpf.h   2023-03-24 16:34:56.973213331 -0700
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
+    error - 1/906 UAPI headers compatible with x86 appear _not_ to be backwards compatible
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
+    !!! ABI differences detected in include/linux/bpf.h from HEAD~2 -> HEAD !!!
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
+    --- HEAD~2/include/linux/bpf.h  2023-03-24 16:42:53.999065836 -0700
+    +++ HEAD/include/linux/bpf.h    2023-03-24 16:42:53.307068936 -0700
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
+    error - 1/906 UAPI headers compatible with x86 appear _not_ to be backwards compatible
+    error - UAPI header ABI check failed
+
+Alternatively, we could have also ran with ``-b HEAD~``. This would set the
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
+    No changes to UAPI headers were applied between HEAD and dirty tree
+
+With an x86 compiler, we can't check header files in ``arch/arm64``, so the
+script doesn't even try.
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
+    !!! ABI differences detected in include/asm/sigcontext.h from HEAD -> dirty tree !!!
+
+        [C] 'struct _aarch64_ctx' changed:
+          type size changed from 64 to 96 (in bits)
+          1 data member insertion:
+            '__u32 new_var', at offset 64 (in bits) at sigcontext.h:73:1
+        --- snip ---
+
+    Header file diff (after headers_install):
+    --- HEAD/include/asm/sigcontext.h       2023-03-24 16:45:48.850281831 -0700
+    +++ dirty/include/asm/sigcontext.h      2023-03-24 16:45:46.922290483 -0700
+    @@ -70,6 +70,7 @@
+     struct _aarch64_ctx {
+            __u32 magic;
+            __u32 size;
+    +       __u32 new_var;
+     };
+
+     #define FPSIMD_MAGIC   0x46508001
+
+    error - 1/878 UAPI headers compatible with arm64 appear _not_ to be backwards compatible
+    error - UAPI header ABI check failed
+
+We can see with ``ARCH`` and ``CC`` set properly for the file, the ABI change
+is reported properly. Also notice that the total number of UAPI header files
+checked by the script changes. This is because the number of headers installed
+for arm64 platforms is different than x86.
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
+Here, we're changing a ``typedef`` in ``types.h``. This doesn't break a UAPI in
+``types.h``, but other UAPIs in the tree may break due to this change::
+
+    % ./scripts/check-uapi.sh
+    Installing sanitized UAPI headers from dirty tree... OK
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from HEAD... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers between HEAD and dirty tree
+    !!! ABI differences detected in include/linux/eventpoll.h from HEAD -> dirty tree !!!
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
+    include/linux/eventpoll.h did not change between HEAD and dirty tree...
+    It's possible a change to one of the headers it includes caused this error:
+    #include <linux/fcntl.h>
+    #include <linux/types.h>
+
+    error - 1/906 UAPI headers compatible with x86 appear _not_ to be backwards compatible
+    error - UAPI header ABI check failed
+
+Note that the script noticed the failing header file did not change, so it
+assumes one of its includes must have caused the breakage. Indeed, we can see
+``linux/types.h`` is used from ``eventpoll.h``.
+
+UAPI Header Removals
+--------------------
+
+Consider this change::
+
+    cat << 'EOF' | patch -l -p1
+    diff --git a/include/uapi/asm-generic/Kbuild b/include/uapi/asm-generic/Kbuild
+    index ebb180aac74e..a9c88b0a8b3b 100644
+    --- a/include/uapi/asm-generic/Kbuild
+    +++ b/include/uapi/asm-generic/Kbuild
+    @@ -31,6 +31,6 @@ mandatory-y += stat.h
+     mandatory-y += statfs.h
+     mandatory-y += swab.h
+     mandatory-y += termbits.h
+    -mandatory-y += termios.h
+    +#mandatory-y += termios.h
+     mandatory-y += types.h
+     mandatory-y += unistd.h
+    EOF
+
+This script removes a UAPI header file from the install list. Let's run the
+script::
+
+    % ./scripts/check-uapi.sh
+    Installing sanitized UAPI headers from dirty tree... OK
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from HEAD... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers between HEAD and dirty tree
+    error - UAPI header include/asm/termios.h was incorrectly removed
+    error - 1/906 UAPI headers compatible with x86 appear _not_ to be backwards compatible
+    error - UAPI header ABI check failed
+
+Removing a UAPI header is considered a breaking change and the script will flag
+it as such.
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
+    error - 90/907 UAPI headers compatible with x86 appear _not_ to be backwards compatible
+    error - UAPI header ABI check failed
+
+Note: before v5.3, a header file needed by the script is not present, so the
+script is unable to check changes before then.
+
+You'll notice that the script detected many UAPI changes that are not
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
+    ./scripts/check-uapi.sh -b v6.1 -p v6.0 -l abi_error_log.txt
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
+Removals For Refactoring or Deprecation
+---------------------------------------
+
+Sometimes drivers for very old hardware are removed, such as in this example::
+
+    % ./scripts/check-uapi.sh -b ba47652ba655
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from ba47652ba655... OK
+    Installing sanitized UAPI headers from ba47652ba655^1... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers between ba47652ba655^1 and ba47652ba655
+    error - UAPI header include/linux/meye.h was incorrectly removed
+    error - 1/910 UAPI headers compatible with x86 appear _not_ to be backwards compatible
+    error - UAPI header ABI check failed
+
+Another example::
+
+    % ./scripts/check-uapi.sh -b f40eb99897af
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from f40eb99897af... OK
+    Installing sanitized UAPI headers from f40eb99897af^1... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers between f40eb99897af^1 and f40eb99897af
+    error - UAPI header include/linux/pktcdvd.h was incorrectly removed
+    error - 1/906 UAPI headers compatible with x86 appear _not_ to be backwards compatible
+    error - UAPI header ABI check failed
+
+While technically not false positives, the script will always flag removals.
+
+Other times, refactoring may drive a removal, but have no impact on userspace.
+For example, d759be8953fe. This change is before v5.3, so cannot be checked by
+the script. If it could be checked, the script would flag the change, but this
+would be a true false positive. Similar refactors in the future may be flagged
+by this script.
+
+Summary
+-------
+
+There may be other examples of false positives that are not listed here.
+
+In the future, as tooling improves, we may be able to filter out more of these
+false positives. In any case, use your best judgement (and ideally a unit test
+in userspace) to make sure your UAPI changes are backwards-compatible!
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

