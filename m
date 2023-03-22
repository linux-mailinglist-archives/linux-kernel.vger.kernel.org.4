Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEE06C4BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCVNbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjCVNbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:31:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE1560A9D;
        Wed, 22 Mar 2023 06:31:17 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCZaIA015956;
        Wed, 22 Mar 2023 13:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=vDtyiD7Qi5wZwZ4H5vKlst6sLlaTZs6GWKS5M2DRMcA=;
 b=cYLqWaC9g7s67xupGBZDapK+LJUAfMJqv/shHHv2W95IIOWoRBpjsVdzS/HPMkdnd56R
 32lQv9zqq93X8kdaoajUpr+Jdp2pvG/VEaJG00/I9IYR+IK9QskeO2htdluAgtdSvNmI
 7p/Tcev56sizARgi2GlWgxyvFcCVfXbHARKCmIduMnsQy9pA+pSBPYyMsrvEm8CVz4Gi
 X3Se5iV7oiArEIGIXTpM2i/nRxJ02rH9elschx6bUpkHHOjTAPt6b2IekRATo51HIiq7
 iFi59kwhEz6Au24sfiszLic86D0tg9+dXMRKnPvZFJI/WalMFe4zqxaUmCtpZA43U+EV xw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfc2pudu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 13:30:55 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32MDUsCT001358
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 13:30:54 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Mar 2023 06:30:49 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v2 3/6] docs: qcom: Add qualcomm minidump guide
Date:   Wed, 22 Mar 2023 19:00:14 +0530
Message-ID: <1679491817-2498-4-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
References: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gEgzXNIWWcCzxdI622U76Q6lInvUJxqB
X-Proofpoint-GUID: gEgzXNIWWcCzxdI622U76Q6lInvUJxqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_11,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220098
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
 Documentation/admin-guide/qcom_minidump.rst | 240 ++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)
 create mode 100644 Documentation/admin-guide/qcom_minidump.rst

diff --git a/Documentation/admin-guide/qcom_minidump.rst b/Documentation/admin-guide/qcom_minidump.rst
new file mode 100644
index 0000000..bdff1c9
--- /dev/null
+++ b/Documentation/admin-guide/qcom_minidump.rst
@@ -0,0 +1,240 @@
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
+to be dumped as part of ram dump collection. It provides appropriate
+symbol to check its enablement and register client region.
+
+To simplify post mortem debugging, it creates and maintain an ELF
+header as first region that gets updated each time a new region gets
+registered.
+
+The solution supports extracting the ramdump/minidump produced either
+over USB or stored to an attached storage device.
+
+Dependency of minidump kernel driver
+------------------------------------
+
+It is noted that minidump kernel driver depends on Qualcomm's
+shared memory (SMEM) driver and its device tree entry (device
+presence). If above support is present and Qualcomm boot firmware
+has minidump support, so it is possible to dump linux region as
+part of minidump collection.
+
+How a kernel client driver can register region with minidump
+------------------------------------------------------------
+
+Client driver can use qcom_minidump_ready() symbol to check if the
+minidump driver is supported on the target and if it return -ENODEV
+then it means minidump is not supported on this target and the client
+should not try to register their minidump region further and
+continue with their normal execution, and if it is supported it
+can go ahead register its region with qcom_minidump_region_register().
+
+Client need to fill their region by filling qcom_minidump_region
+structure object which consist of the region name, region's
+virtual and physical address and its size.
+
+Below is one sample client driver snippet which try to allocate
+a region from kernel heap of certain size and it writes a certain
+known pattern (that can help in verification after collection
+that we got the exact pattern, what we wrote) and registers with
+minidump.
+
+ .. code-block:: c
+
+  #include <soc/qcom/minidump.h>
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
+  [... Check if minidump is ready return -EPROBE_DEFER
+   if this is a probe function otherwise return accordingly ...]
+  err = qcom_minidump_ready();
+  if (err && err != -ENODEV)
+	return -EPROBE_DEFER;
+
+  strlcpy(region.name, "REGION_A", sizeof(region.name));
+  region.virt_addr = client_mem_region;
+  region.phys_addr = virt_to_phys(client_mem_region);
+  region.size = region_size;
+
+  if (!err) {
+	ret = qcom_minidump_region_register(&region);
+	if (ret < 0) {
+		pr_err("failed to add region in minidump: err: %d\n", ret);
+		return ret;
+	}
+  }
+
+  [...]
+
+
+Test
+----
+
+Existing Qualcomm devices already supports entire ddr dump (also called
+full dump) via writing appropriate value to Qualcomm's top control and
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
+
+Similarly, "full" is passed to set the download mode to full dump
+where entire ddr dump will be collected while setting it "both"
+will set the mode to both (mini + full).
+
+sysfs can also be used to set the mode to minidump.
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
-- 
2.7.4

