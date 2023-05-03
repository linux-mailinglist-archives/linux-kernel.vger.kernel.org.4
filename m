Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3146F5C55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjECRDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjECRDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:03:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8376910E5;
        Wed,  3 May 2023 10:03:36 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343GPCxi013098;
        Wed, 3 May 2023 17:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=HNQz+qxTB8IzlwVrA59Mwe9ugeXXODBw3iVV15Vkmu0=;
 b=YNvMcg1NO4xQphpnEuV4m2n7jEyaT0J4Ngs5CZe1CQWEbUyK7G/fGKlnvsrkDFMsYHmu
 UYYZVasgStXMf4zVBGRcBBMXnOqWxxie+Xm8zAi6WI7F8o1pmH9nPPyKVg9Xwvv8JM/m
 NPsjGWJ1e7P7LxocqGOa5349EwgKZ8cYQCd49yTGEJ/ytsLiWxFJ55A7z1aHjMKplFW/
 4ixrjvTDOUOo74y0inrqLNh9t6SXYBhIz0IqRiriVx5dGyVM+IMB14vg7iT4U5kzfzzT
 8icGj88uOSqHI2PAVzUtfmxPQSEy+vDLQPzfmuLA1KJeuZrVlwFcxGvcjwmiBNWOZoOx uQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbmy48xtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 17:03:11 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 343H3Aw7000854
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 17:03:10 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 May 2023 10:03:04 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v3 03/18] docs: qcom: Add qualcomm minidump guide
Date:   Wed, 3 May 2023 22:32:17 +0530
Message-ID: <1683133352-10046-4-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V6yj7ZJP8E4f1rkmRHy-wa5R9HkPvFjT
X-Proofpoint-GUID: V6yj7ZJP8E4f1rkmRHy-wa5R9HkPvFjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_12,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the qualcomm minidump guide for the users which
tries to cover the dependency and the way to test
and collect minidump on Qualcomm supported platforms.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 Documentation/admin-guide/qcom_minidump.rst | 246 ++++++++++++++++++++++++++++
 1 file changed, 246 insertions(+)
 create mode 100644 Documentation/admin-guide/qcom_minidump.rst

diff --git a/Documentation/admin-guide/qcom_minidump.rst b/Documentation/admin-guide/qcom_minidump.rst
new file mode 100644
index 0000000..062c797
--- /dev/null
+++ b/Documentation/admin-guide/qcom_minidump.rst
@@ -0,0 +1,246 @@
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
+full system ramdumps for post mortem debugging. But in some cases it's
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
+       G-ToC: Global table of content
+       SS-ToC: Subsystem table of content
+       SS0-SSn: Subsystem numbered from 0 to n
+
+The core of minidump feature is part of Qualcomm's boot firmware code.
+It initializes shared memory(SMEM), which is a part of DDR and
+allocates a small section of it to minidump table i.e also called
+global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
+their own table of segments to be included in the minidump, all
+references from a descriptor in SMEM (G-ToC). Each segment/region has
+some details like name, physical address and it's size etc. and it
+could be anywhere scattered in the DDR.
+
+Minidump kernel driver concept
+------------------------------
+
+Qualcomm minidump kernel driver adds the capability to add linux region
+to be dumped as part of ram dump collection. At the moment, shared memory
+driver creates plaform device for minidump driver and give a means to
+APSS minidump to initialize itself on probe.
+
+This driver provides ``qcom_apss_minidump_region_register`` and
+``qcom_apss_minidump_region_unregister`` API's to register and unregister
+apss minidump region. It also gives a mechanism to update physical/virtual
+address for the client whose addresses keeps on changing e.g Current stack
+address of task keep on changing on context switch for each core. So these
+clients can update their addresses with ``qcom_apss_minidump_update_region``
+API.
+
+The driver also supports registration for the clients who came before
+minidump driver was initialized. It maintains pending list of clients
+who came before minidump and once minidump is initialized it registers
+them in one go.
+
+To simplify post mortem debugging, driver creates and maintain an ELF
+header as first region that gets updated each time a new region gets
+registered.
+
+The solution supports extracting the ramdump/minidump produced either
+over USB or stored to an attached storage device.
+
+Dependency of minidump kernel driver
+------------------------------------
+
+It is to note that whole of minidump thing depends on Qualcomm boot
+firmware whether it supports minidump or not. So, if the minidump
+smem id is present in shared memory, it indicates that minidump
+is supported from boot firmware and it is possible to dump linux
+(APSS) region as part of minidump collection.
+
+How a kernel client driver can register region with minidump
+------------------------------------------------------------
+
+Client driver can use ``qcom_apss_minidump_region_register`` API's to
+register and ``qcom_apss_minidump_region_unregister`` to unregister
+their region from minidump driver.
+
+Client need to fill their region by filling qcom_apss_minidump_region
+structure object which consist of the region name, region's
+virtual and physical address and its size.
+
+Below is one sample client driver snippet which try to allocate
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
+  struct qcom_apss_minidump_region region;
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
+  ret = qcom_apss_minidump_region_register(&region);
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
+Existing Qualcomm devices already supports entire ddr dump (also called
+full dump) by writing appropriate value to Qualcomm's top control and
+status register(tcsr) in driver/firmware/qcom_scm.c .
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
+User of minidump can pass qcom_scm.download_mode="mini" to kernel
+commandline to set the current download mode to minidump.
+Similarly, "full" is passed to set the download mode to full dump
+where entire ddr dump will be collected while setting it "full,mini"
+will collect minidump along with fulldump.
+
+Writing to sysfs node can also be used to set the mode to minidump.
+
+::
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
+a set of binary blobs starts with name md_* in PCAT configured directory
+in x86_64 machine, so for above example from the client it will be
+md_REGION_A.BIN. This binary blob depends on region content to determine
+whether it needs external parser support to get the content of the region,
+so for simple plain ASCII text we don't need any parsing and the content
+can be seen just opening the binary file.
+
+To collect the dump to attached storage type, one need to write appropriate
+value to IMEM register, in that case dumps are collected in rawdump
+partition on the target device itself.
+
+One need to read the entire rawdump partition and pull out content to
+save it onto the attached x86_64 machine over USB. Later, this rawdump
+can be pass it to another tool dexter.exe(Qualcomm tool) which converts
+this into the similar binary blobs which we have got it when download type
+was set to USB i.e a set of registered region as blobs and their name
+starts with md_*.
+
+Replacing the dexter.exe with some open source tool can be added as future
+scope of this document.
-- 
2.7.4

