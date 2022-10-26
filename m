Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8133760E81A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbiJZTB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiJZTAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:00:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E754D14004;
        Wed, 26 Oct 2022 11:59:53 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QIocVb008070;
        Wed, 26 Oct 2022 18:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=fdvhN2ek0j9u/3bpipbta6GyJtQWHZ1w8rwMD/oO+J8=;
 b=P45yVbjUDhNLxwQHzklTqVydOwC5cMh4nisYxauTf9WU/uM7L5iovWnRB/IBBjFVpaTc
 TnqX28p+N9g83DHBhGNLld5sh1QCmA9F9oFybOxrC0Y5M3wmyfKYNyt+L7TsvpcT0BuD
 BEv3qdMNYVkn5J51GTpj4XykpIb3LDGGeJNFd2Bi+K7WasRr7mEqeh3EKD5k6IucFCLl
 mAJoP08eKBylzTXwkIq+ePp75/sNQMG9qgnzxe4n5D9Ptez5W6aBS1qrRWstzfq7hDQP
 0dnuOPiYOqnOWmNtBsBLVC4av9vNbXN71LB7lGrM5Fyihflyi9oqlO6/rZBZo1VMdrlp Pw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahc80u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:41 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29QIxeot008399
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 18:59:40 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 26 Oct 2022 11:59:40 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 21/21] docs: gunyah: Document Gunyah VM Manager
Date:   Wed, 26 Oct 2022 11:58:46 -0700
Message-ID: <20221026185846.3983888-22-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026185846.3983888-1-quic_eberman@quicinc.com>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DrMhYVKqKKXgFm8XOsHV0tSoSA0nOt_j
X-Proofpoint-GUID: DrMhYVKqKKXgFm8XOsHV0tSoSA0nOt_j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210260107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the ioctls and usage of Gunyah VM Manager driver.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/virt/gunyah/index.rst      |  1 +
 Documentation/virt/gunyah/vm-manager.rst | 94 ++++++++++++++++++++++++
 2 files changed, 95 insertions(+)
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
index 000000000000..c232ba05de7e
--- /dev/null
+++ b/Documentation/virt/gunyah/vm-manager.rst
@@ -0,0 +1,94 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Virtual Machine Manager
+=======================
+
+The Gunyah Virtual Machine Manager is a Linux driver to support launching virtual machines.
+
+Summary
+=======
+
+Gunyah VMM presently supports launching non-proxy scheduled Linux-like virtual machines.
+
+Sample Userspace VMM
+====================
+
+A sample userspace VMM is included in samples/gunyah/ along with a sample minimal devicetree
+that can be used to launch a Linux-like virtual machine under Gunyah. To build this sample, enable
+CONFIG_SAMPLE_GUNYAH.
+
+IOCTLs and userspace VMM flows
+==============================
+
+The kernel exposes a char device interface at /dev/gunyah.
+
+To create a VM, use the GH_CREATE_VM ioctl. A successful call will return a "Gunyah VM" file descriptor.
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
+attempting to create two memory regions with the same label is not allowed.
+
+While VMM is guest-agnostic and allows runtime addition of memory regions,
+Linux guest virtual machines do not support accepting memory regions at runtime.
+Thus, memory regions should be provided before starting the VM and the VM
+configured to accept those memory regions at boot-up.
+
+The guest physical address is used by Linux to check the requested user regions
+do not overlap and to help find a corresponding memory region for calls like
+GH_VM_SET_DTB_CONFIG.
+
+To delete a memory region, call GH_VM_SET_USER_MEM_REGION with label set to the
+memory region of interest and memory_size set to 0.
+
+The flags field of gh_userspace_memory_region can set the following bits. All
+other bits must be 0 and are reserved for future use. The ioctl will return
+-EINVAL if an unsupported bit is detected.
+
+  - GH_MEM_ALLOW_READ/GH_MEM_ALLOW_WRITE/GH_MEM_ALLOW_EXEC sets read/write/exec permissions
+    for the guest, respectively.
+
+  - GH_MEM_LENT means that the memory will be unmapped from the host and be unaccessible by
+    the host while the guest has the region.
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
+This ioctl starts the virtual machine.
-- 
2.25.1

