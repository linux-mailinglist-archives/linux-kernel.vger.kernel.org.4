Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A456A6873
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCAHy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAHy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:54:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB022DE75;
        Tue, 28 Feb 2023 23:54:54 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3216dDS4026185;
        Wed, 1 Mar 2023 07:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=5vBpNWqoIG9Sd56AWdWffRkP9kbDWEXkwlpB9BhHEBM=;
 b=i7R4ff6w9rH0a2e50JCojHoGxsTMhNNycNhpF3z6uXcFRmAB+lZJcCZkB1jScGBQvF6W
 W9qfL4Vid/xCSC+zEJ7qzFaZOm/DaVzJyead4H+MFmbhI9AYC4dHB1So2U4QOAHXoTWz
 tUteb3Au5vV1uNdHqkkE9vP9vjy/ncqC+Y6bA4g1laiNf1Nc1FcDfneD5cZlXKShLGeo
 +E+L2ZRjbCrH9OtS5qvHvT8l3LKGJvtXrJNp075YUqdLxhzjzQdGi0PmFpDScNZG1Nos
 WluuOlp8EKyu6+bKmZM4e6NxAXi9fQzcjZ2v8lQZcuueoDnf97wTWcdywO/ELf4KgmJO kw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1mwxa28a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 07:54:32 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3217sVbx032691
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 07:54:32 GMT
Received: from hu-johmoo-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 28 Feb 2023 23:54:31 -0800
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
        Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH v2 2/2] docs: dev-tools: Add UAPI checker documentation
Date:   Tue, 28 Feb 2023 23:54:02 -0800
Message-ID: <20230301075402.4578-3-quic_johmoo@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230301075402.4578-1-quic_johmoo@quicinc.com>
References: <20230301075402.4578-1-quic_johmoo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 40KKAWs3331-R91PucECTRAARLT9wbO7
X-Proofpoint-GUID: 40KKAWs3331-R91PucECTRAARLT9wbO7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_04,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010063
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add detailed documentation for scripts/check-uapi.sh.
---
 Documentation/dev-tools/checkuapi.rst | 258 ++++++++++++++++++++++++++
 Documentation/dev-tools/index.rst     |   1 +
 2 files changed, 259 insertions(+)
 create mode 100644 Documentation/dev-tools/checkuapi.rst

diff --git a/Documentation/dev-tools/checkuapi.rst b/Documentation/dev-tools/checkuapi.rst
new file mode 100644
index 000000000000..2255066658e3
--- /dev/null
+++ b/Documentation/dev-tools/checkuapi.rst
@@ -0,0 +1,258 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+============
+UAPI Checker
+============
+
+The UAPI checker (scripts/check-uapi.sh) is a shell script which checks UAPI
+header files for userspace backwards-compatibility across the git tree.
+
+The script can produce false positives in some cases, so developers are
+encouraged to use their best judgement when interpreting the results. Please
+refer to kernel documentation on the topic of IOCTL stability for more
+information (Documentation/process/botching-up-ioctls.rst).
+
+Options
+=======
+
+This section will describe the options check-uapi.sh can be run with.
+
+Usage::
+
+    ./scripts/check-uapi.sh [-b BASE_REF] [-r COMP_REF] [-a] [-j N] [-l ERROR_LOG]
+
+Available options::
+
+    -b BASE_REF    Base git reference to use for comparison. If unspecified or empty,
+                   will use any dirty changes in tree to UAPI files. If there are no
+                   dirty changes, HEAD will be used.
+    -r COMP_REF    Compare BASE_REF to COMP_REF (e.g. -r v6.1). If unspecified or empty,
+                   will use BASE_REF^1.
+    -a             Check all UAPI headers for backwards compatibility.
+    -j JOBS        Number of checks to run in parallel (default: number of CPU cores)
+    -l ERROR_LOG   Write error log to file (default: "$KERNEL_SOURCE/abi_error_log.txt")
+
+Environmental args::
+
+    ABIDIFF  Custom path to abidiff binary
+    CC       C compiler (default is "gcc")
+
+Examples
+========
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
+    Checking changes to UAPI headers starting from dirty tree
+    No ABI differences detected in include/uapi/linux/acct.h from HEAD -> dirty tree
+    All 1 UAPI headers modified between HEAD and dirty tree are backwards compatible!
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
+    Checking changes to UAPI headers starting from dirty tree
+    No ABI differences detected in include/uapi/linux/acct.h from HEAD -> dirty tree
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
+    --- HEAD/include/uapi/linux/bpf.h       2023-02-28 22:24:44.068898545 -0800
+    +++ dirty/include/uapi/linux/bpf.h      2023-02-28 22:24:42.132909241 -0800
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
+    error - 1/2 UAPI headers modified between HEAD and dirty tree are not backwards compatible
+    error - UAPI header ABI check failed
+
+Note: the script is operating on UAPI header files which have changed in the
+dirty git tree. If there were no changes in the tree, it would look for UAPI
+changes introduced by the latest HEAD commit.
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
+Now, what happens if we run the script again with no arguments?::
+
+    % ./scripts/check-uapi.sh
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from HEAD... OK
+    Installing sanitized UAPI headers from HEAD^1... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers starting from HEAD
+    No ABI differences detected in include/uapi/linux/acct.h from HEAD^1 -> HEAD
+    All 1 UAPI headers modified between HEAD^1 and HEAD are backwards compatible!
+
+It doesn't catch any breaking change because by default, it only compares HEAD
+to HEAD^1. If we wanted the search scope to go back further, we'd have to use
+the "-r" option to pass other references to compare to. In this case, let's
+pass "-r HEAD~2" to the script so it checks UAPI changes between HEAD~2 and
+HEAD::
+
+    % ./scripts/check-uapi.sh -r "HEAD~2"
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from HEAD... OK
+    Installing sanitized UAPI headers from HEAD~2... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers starting from HEAD
+    No ABI differences detected in include/uapi/linux/acct.h from HEAD~2 -> HEAD
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
+    --- HEAD~2/include/uapi/linux/bpf.h     2023-02-28 22:27:40.311925004 -0800
+    +++ HEAD/include/uapi/linux/bpf.h       2023-02-28 22:27:39.743928142 -0800
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
+    error - 1/2 UAPI headers modified between HEAD~2 and HEAD are not backwards compatible
+    error - UAPI header ABI check failed
+
+If you want to check different chunks of the tree, you can also change your
+base commit with the "-b" option. For example, to check all changed UAPI header
+files between v6.0 and v6.1, you'd run::
+
+    % ./scripts/check-uapi.sh -b v6.1 -r v6.0
+    Saving current tree state... OK
+    Installing sanitized UAPI headers from v6.1... OK
+    Installing sanitized UAPI headers from v6.0... OK
+    Restoring current tree state... OK
+    Checking changes to UAPI headers starting from v6.1
+    -- snip --
+    error - 42/106 UAPI headers modified between v6.0 and v6.1 are not backwards compatible
+    error - UAPI header ABI check failed
+
+Aren't kernel UAPIs stable forever? Why is the script reporting errors?
+
+False Positives
+===============
+
+The UAPI checker is very aggressive in detecting ABI changes, so some false
+positives may appear. For example, if you check all UAPI headers between v6.0
+and v6.1, many breakages will be flagged. Run the following::
+
+    ./scripts/check-uapi.sh -b v6.1 -r v6.0
+
+The errors will be logged to "abi_error_log.txt". Here, we'll find examples of
+several types of false positives.
+
+Enum Expansion::
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
+Expanding into reserved/padding fields::
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
+In the future, as tooling improves, we may be able to filter out more of these
+false positives. There may also be additional examples of false positives not
+listed here. Use your best judgement, and ideally a unit test in userspace, to
+test your UAPI changes!
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

