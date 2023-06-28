Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3188874113F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjF1Miv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:38:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131]:21442 "EHLO
        mx0a-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231583AbjF1Mg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:36:58 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S5hCU6026329;
        Wed, 28 Jun 2023 12:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=JSeJz6vmPXLz33wUlydFQ74f+iZyLf0EKLfg0q3PF5E=;
 b=H27ML2s7GPpH7Ph8f7sdf1Yd6lB1Pqx+7YrDbHpoL4SUpBBctm+zujZgaDsTbHxQgGit
 FpZJR3iPG8uYZYx0erRreuLM2vBw4wSTEnPxuVMS81OY9gaajGSmVMTKF2k5CBf6BkgD
 qKVwBUy7J1Xo9XIt9gKWO5EtfjYBXxKdabDp5T557BJpfigOeitrBGvH3fKUWf6dVoTS
 prSTeJL/VxS1JAv1bRnUMzp/sTFI+VB9/XmFGVeh49bPykWoAhtbgfMHzwaqxQknRaJ8
 Ac7sdbe1NUgASHjGKUAuP165aVL7Ql0K7jGcxTUhSXW5y7auYilnJSLxd9QG8g4A6xW2 pQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgextgwv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:35:21 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCZKKx029062
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:35:20 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:35:14 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v4 01/21] docs: qcom: Add qualcomm minidump guide
Date:   Wed, 28 Jun 2023 18:04:28 +0530
Message-ID: <1687955688-20809-2-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hAb0oc_PLuXPEomLl0jYT4OvLrOJPJmz
X-Proofpoint-GUID: hAb0oc_PLuXPEomLl0jYT4OvLrOJPJmz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the qualcomm minidump guide for the users which
tries to cover the dependency and the way to test
and collect minidump on Qualcomm supported platforms.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 Documentation/admin-guide/index.rst         |   1 +
 Documentation/admin-guide/qcom_minidump.rst | 293 ++++++++++++++++++++++++++++
 2 files changed, 294 insertions(+)
 create mode 100644 Documentation/admin-guide/qcom_minidump.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 43ea35613dfc..251d070486c2 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -120,6 +120,7 @@ configure specific aspects of kernel behavior to your liking.
    perf-security
    pm/index
    pnp
+   qcom_minidump
    rapidio
    ras
    rtc
diff --git a/Documentation/admin-guide/qcom_minidump.rst b/Documentation/admin-guide/qcom_minidump.rst
new file mode 100644
index 000000000000..a3a8cfee4555
--- /dev/null
+++ b/Documentation/admin-guide/qcom_minidump.rst
@@ -0,0 +1,293 @@
+Qualcomm Minidump Feature
+=========================
+
+Introduction
+------------
+
+Minidump is a best effort mechanism to collect useful and predefined
+data for first level of debugging on end user devices running on
+Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
+or subsystem part of SoC crashes, due to a range of hardware and
+software bugs. Hence, the ability to collect accurate data is only
+a best-effort. The data collected could be invalid or corrupted, data
+collection itself could fail, and so on.
+
+Qualcomm devices in engineering mode provides a mechanism for generating
+full system RAM dumps for post-mortem debugging. But in some cases it's
+however not feasible to capture the entire content of RAM. The minidump
+mechanism provides the means for selecting region should be included in
+the ramdump.
+
+::
+
+   +-----------------------------------------------+
+   |   DDR                       +-------------+   |
+   |                             |      SS0-ToC|   |
+   | +----------------+     +----------------+ |   |
+   | |Shared memory   |     |         SS1-ToC| |   |
+   | |(SMEM)          |     |                | |   |
+   | |                | +-->|--------+       | |   |
+   | |G-ToC           | |   | SS-ToC  \      | |   |
+   | |+-------------+ | |   | +-----------+  | |   |
+   | ||-------------| | |   | |-----------|  | |   |
+   | || SS0-ToC     | | | +-|<|SS1 region1|  | |   |
+   | ||-------------| | | | | |-----------|  | |   |
+   | || SS1-ToC     |-|>+ | | |SS1 region2|  | |   |
+   | ||-------------| |   | | |-----------|  | |   |
+   | || SS2-ToC     | |   | | |  ...      |  | |   |
+   | ||-------------| |   | | |-----------|  | |   |
+   | ||  ...        | |   |-|<|SS1 regionN|  | |   |
+   | ||-------------| |   | | |-----------|  | |   |
+   | || SSn-ToC     | |   | | +-----------+  | |   |
+   | |+-------------+ |   | |                | |   |
+   | |                |   | |----------------| |   |
+   | |                |   +>|  regionN       | |   |
+   | |                |   | |----------------| |   |
+   | +----------------+   | |                | |   |
+   |                      | |----------------| |   |
+   |                      +>|  region1       | |   |
+   |                        |----------------| |   |
+   |                        |                | |   |
+   |                        |----------------|-+   |
+   |                        |  region5       |     |
+   |                        |----------------|     |
+   |                        |                |     |
+   |  Region information    +----------------+     |
+   | +---------------+                             |
+   | |region name    |                             |
+   | |---------------|                             |
+   | |region address |                             |
+   | |---------------|                             |
+   | |region size    |                             |
+   | +---------------+                             |
+   +-----------------------------------------------+
+       G-ToC: Global table of contents
+       SS-ToC: Subsystem table of contents
+       SS0-SSn: Subsystem numbered from 0 to n
+
+It depends on targets how the underlying hardware taking care of the
+implementation part for minidump like above diagram is for shared
+memory and it is possible that this could be implemented via memory
+mapped regions but the general idea remain same.
+
+In this document, SMEM will be used as the backend implementation of
+minidump.
+
+SMEM as backend
+----------------
+
+The core of minidump feature is part of Qualcomm's boot firmware code.
+It initializes shared memory (SMEM), which is a part of DDR and
+allocates a small section of it to minidump table, i.e. also called
+global table of contents (G-ToC). Each subsystem (APSS, ADSP, ...) has
+its own table of segments to be included in the minidump, all
+references from a descriptor in SMEM (G-ToC). Each segment/region has
+some details like name, physical address and its size etc. and it
+could be anywhere scattered in the DDR.
+
+Minidump kernel driver concept
+------------------------------
+::
+
+  Minidump Client-1     Client-2      Client-5    Client-n
+         |               |              |             |
+         |               |    ...       |   ...       |
+         |               |              |             |
+         |               |              |             |
+         |               |              |             |
+         |               |              |             |
+         |               |              |             |
+         |               |              |             |
+         |           +---+--------------+----+        |
+         +-----------+  qcom_minidump(core)  +--------+
+                     |                       |
+                     +------+-----+------+---+
+                            |     |      |
+                            |     |      |
+            +---------------+     |      +--------------------+
+            |                     |                           |
+            |                     |                           |
+            |                     |                           |
+            v                     v                           v
+ +-------------------+      +-------------------+     +------------------+
+ |qcom_minidump_smem |      |qcom_minidump_mmio |     | qcom_minidump_rm |
+ |                   |      |                   |     |                  |
+ +-------------------+      +-------------------+     +------------------+
+   Shared memory              Memory mapped IO           Resource manager
+    (backend)                   (backend)                   (backend)
+
+
+Kernel implementation of minidump driver is divided into two parts one is,
+the core implementation called frontend driver ``qcom_minidump.c`` and this
+is the driver will be exposing the API for clients and the other part is,
+backend driver and its depends whether it is based on SMEM, MMIO or some
+other way corressponding driver will be hooking itself up with the core
+driver to get itself working. As of now, at a time one and only one backend
+can be attached to the front-end either it is HOST or a guest VM.
+
+Qualcomm minidump kernel driver adds the capability to add Linux region
+to be dumped as part of RAM dump collection. At the moment, shared memory
+driver creates platform device for minidump driver and give a means to
+APSS minidump to initialize itself on probe.
+
+This driver provides ``qcom_minidump_region_register`` and
+``qcom_minidump_region_unregister`` API's to register and unregister
+APSS minidump region. It also gives a mechanism to update physical/virtual
+address for the client whose addresses keeps on changing, e.g., current stack
+address of task keeps on changing on context switch for each core. So these
+clients can update their addresses with ``qcom_minidump_update_region``
+API.
+
+The driver also supports registration for the clients who came before
+minidump driver was initialized. It maintains pending list of clients
+who came before minidump and once minidump is initialized it registers
+them in one go.
+
+To simplify post-mortem debugging, driver creates and maintain an ELF
+header as first region that gets updated each time a new region gets
+registered.
+
+The solution supports extracting the RAM dump/minidump produced either
+over USB or stored to an attached storage device.
+
+Dependency of minidump kernel driver
+------------------------------------
+
+It is to note that whole of minidump depends on Qualcomm boot
+firmware whether it supports minidump or not. So, if the minidump
+SMEM ID is present in shared memory, it indicates that minidump
+is supported from boot firmware and it is possible to dump Linux
+(APSS) region as part of minidump collection.
+
+How a kernel client driver can register region with minidump
+------------------------------------------------------------
+
+Client driver can use ``qcom_minidump_region_register`` API's to
+register and ``qcom_minidump_region_unregister`` to unregister
+their region from minidump driver.
+
+Client needs to fill their region by filling ``qcom_minidump_region``
+structure object which consists of the region name, region's
+virtual and physical address and its size.
+
+Below is one sample client driver snippet which tries to allocate
+a region from kernel heap of certain size and it writes a certain
+known pattern (that can help in verification after collection
+that we got the exact pattern, what we wrote) and registers it with
+minidump.
+
+ .. code-block:: c
+
+  #include <soc/qcom/qcom_minidump.h>
+  [...]
+
+
+  [... inside a function ...]
+  struct qcom_minidump_region region;
+
+  [...]
+
+  client_mem_region = kzalloc(region_size, GFP_KERNEL);
+  if (!client_mem_region)
+	return -ENOMEM;
+
+  [... Just write a pattern ...]
+  memset(client_mem_region, 0xAB, region_size);
+
+  [... Fill up the region object ...]
+  strlcpy(region.name, "REGION_A", sizeof(region.name));
+  region.virt_addr = client_mem_region;
+  region.phys_addr = virt_to_phys(client_mem_region);
+  region.size = region_size;
+
+  ret = qcom_minidump_region_register(&region);
+  if (ret < 0) {
+	pr_err("failed to add region in minidump: err: %d\n", ret);
+	return ret;
+  }
+
+  [...]
+
+
+Test
+----
+
+Existing Qualcomm devices already supports entire RAM dump (also called
+full dump) by writing appropriate value to Qualcomm's top control and
+status register (tcsr) in ``driver/firmware/qcom_scm.c`` .
+
+SCM device Tree bindings required to support download mode
+For example (sm8450) ::
+
+	/ {
+
+	[...]
+
+		firmware {
+			scm: scm {
+				compatible = "qcom,scm-sm8450", "qcom,scm";
+				[... tcsr register ... ]
+				qcom,dload-mode = <&tcsr 0x13000>;
+
+				[...]
+			};
+		};
+
+	[...]
+
+		soc: soc@0 {
+
+			[...]
+
+			tcsr: syscon@1fc0000 {
+				compatible = "qcom,sm8450-tcsr", "syscon";
+				reg = <0x0 0x1fc0000 0x0 0x30000>;
+			};
+
+			[...]
+		};
+	[...]
+
+	};
+
+User of minidump can pass ``qcom_scm.download_mode="mini"`` to kernel
+commandline to set the current download mode to minidump.
+Similarly, ``"full"`` is passed to set the download mode to full dump
+where entire RAM dump will be collected while setting it ``"full,mini"``
+will collect minidump along with fulldump.
+
+Writing to sysfs node can also be used to set the mode to minidump::
+
+	echo "mini" > /sys/module/qcom_scm/parameter/download_mode
+
+Once the download mode is set, any kind of crash will make the device collect
+respective dump as per set download mode.
+
+Dump collection
+---------------
+
+The solution supports extracting the minidump produced either over USB or
+stored to an attached storage device.
+
+By default, dumps are downloaded via USB to the attached x86_64 machine
+running PCAT (Qualcomm tool) software. Upon download, we will see
+a set of binary blobs starting with name ``md_*`` in PCAT configured directory
+in x86_64 machine, so for above example from the client it will be
+``md_REGION_A.BIN``. This binary blob depends on region content to determine
+whether it needs external parser support to get the content of the region,
+so for simple plain ASCII text we don't need any parsing and the content
+can be seen just opening the binary file.
+
+To collect the dump to attached storage type, one needs to write appropriate
+value to IMEM register, in that case dumps are collected in rawdump
+partition on the target device itself.
+
+One needs to read the entire rawdump partition and pull out content to
+save it onto the attached x86_64 machine over USB. Later, this rawdump
+can be passed to another tool (``dexter.exe`` [Qualcomm tool]) which converts
+this into the similar binary blobs which we have got it when download type
+was set to USB, i.e. a set of registered regions as blobs and their name
+starts with ``md_*``.
+
+Replacing the ``dexter.exe`` with some open source tool can be added as future
+scope of this document.
-- 
2.7.4

