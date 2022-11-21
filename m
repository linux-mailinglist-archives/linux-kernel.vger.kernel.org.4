Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ADE632507
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKUOGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiKUOFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:05:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6A81570A;
        Mon, 21 Nov 2022 06:02:51 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALDS0EE002790;
        Mon, 21 Nov 2022 14:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Iu8gzi/8SDZ9jKDVjZrgx67m0CCgK3Dg5o8FVtuo6Vg=;
 b=MWF45FLXCl0RbX8iCOLvmV2AusDeY0xzn/cmp1EcD38gKsE4mLshQtjMAwcZwh23naHI
 JOgue/SYS8mUhnvcl0zVs5OrhBXruSRKhANqfvCcdj1qHYtcQ7A/PrxMPjAKUuHwLl86
 /FsyIqcIV+6T+VwCDo2MmHz5J5+s83cjpHTojrDM5X8gReLQ2kcuEVpO8qfa5Ri1GxhR
 3C6XGirCLXftdni5/SVvaS8wuH2rMRUeD6vvTs2gRSJegM0uDvb5V2RZQnQPmHZ5kV0A
 QXfksUOlgjxmR5hTkIkMY//y+Jy4VJmxs6iNyyWJ6aZmjCVe6jfREyZ4JbiZy67/NUV0 Dg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrtqcfk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 14:02:24 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ALE2NCF025232
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 14:02:23 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 06:02:21 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v7 20/20] docs: gunyah: Document Gunyah VM Manager
Date:   Mon, 21 Nov 2022 06:00:09 -0800
Message-ID: <20221121140009.2353512-21-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121140009.2353512-1-quic_eberman@quicinc.com>
References: <20221121140009.2353512-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Byp0FmToY85YvAkIubm7FfoecHUI5HaK
X-Proofpoint-GUID: Byp0FmToY85YvAkIubm7FfoecHUI5HaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the ioctls and usage of Gunyah VM Manager driver.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/index.rst      |  1 +
 Documentation/virt/gunyah/vm-manager.rst | 91 ++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 Documentation/virt/gunyah/vm-manager.rst

diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
index fbadbdd24da7..9019a03b6f3e 100644
--- a/Documentation/virt/gunyah/index.rst
+++ b/Documentation/virt/gunyah/index.rst
@@ -7,6 +7,7 @@ Gunyah Hypervisor
 .. toctree::
    :maxdepth: 1
 
+   vm-manager
    message-queue
 
 Gunyah is a Type-1 hypervisor which is independent of any OS kernel, and runs in
diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
new file mode 100644
index 000000000000..16fb2b98c371
--- /dev/null
+++ b/Documentation/virt/gunyah/vm-manager.rst
@@ -0,0 +1,91 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Virtual Machine Manager
+=======================
+
+The Gunyah Virtual Machine Manager is a Linux driver to support launching
+virtual machines using Gunyah. It presently supports launching non-proxy
+scheduled Linux-like virtual machines.
+
+Sample Userspace VMM
+====================
+
+A sample userspace VMM is included in samples/gunyah/ along with a minimal
+devicetree that can be used to launch a VM. To build this sample, enable
+CONFIG_SAMPLE_GUNYAH.
+
+IOCTLs and userspace VMM flows
+==============================
+
+The kernel exposes a char device interface at /dev/gunyah.
+
+To create a VM, use the GH_CREATE_VM ioctl. A successful call will return a
+"Gunyah VM" file descriptor.
+
+/dev/gunyah API Descriptions
+----------------------------
+
+GH_CREATE_VM
+~~~~~~~~~~~~
+
+Creates a Gunyah VM. The argument is reserved for future use and must be 0.
+
+Gunyah VM API Descriptions
+--------------------------
+
+GH_VM_SET_USER_MEM_REGION
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+  struct gh_userspace_memory_region {
+	__u32 label;
+	__u32 flags;
+	__u64 guest_phys_addr;
+	__u64 memory_size;
+	__u64 userspace_addr;
+  };
+
+This ioctl allows the user to create or delete a memory parcel for a guest
+virtual machine. Each memory region is uniquely identified by a label;
+attempting to create two regions with the same label is not allowed.
+
+While VMM is guest-agnostic and allows runtime addition of memory regions,
+Linux guest virtual machines do not support accepting memory regions at runtime.
+Thus, memory regions should be provided before starting the VM and the VM must
+be configured to accept these at boot-up.
+
+The guest physical address is used by Linux kernel to check that the requested
+user regions do not overlap and to help find the corresponding memory region
+for calls like GH_VM_SET_DTB_CONFIG.
+
+To delete a memory region, call GH_VM_SET_USER_MEM_REGION with label set to the
+desired region and memory_size set to 0.
+
+The flags field of gh_userspace_memory_region accepts the following bits. All
+other bits must be 0 and are reserved for future use. The ioctl will return
+-EINVAL if an unsupported bit is detected.
+
+  - GH_MEM_ALLOW_READ/GH_MEM_ALLOW_WRITE/GH_MEM_ALLOW_EXEC sets read/write/exec
+    permissions for the guest, respectively.
+  - GH_MEM_LENT means that the memory will be unmapped from the host and be
+    unaccessible by the host while the guest has the region.
+
+GH_VM_SET_DTB_CONFIG
+~~~~~~~~~~~~~~~~~~~~
+
+::
+
+  struct gh_vm_dtb_config {
+	__u64 gpa;
+	__u64 size;
+  };
+
+This ioctl sets the location of the VM's devicetree blob and is used by Gunyah
+Resource Manager to allocate resources.
+
+GH_VM_START
+~~~~~~~~~~~
+
+This ioctl starts the VM.
-- 
2.25.1

