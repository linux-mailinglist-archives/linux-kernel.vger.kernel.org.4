Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD2F6324A0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiKUOBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiKUOBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:01:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A7AA8179;
        Mon, 21 Nov 2022 06:01:11 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALDSXED013940;
        Mon, 21 Nov 2022 14:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=ycEdT0mZ8ugwzguok8hseDtH7rFSzTZwEG8xpe1B7bk=;
 b=hHRORwQIm6ZRsVN+bdhYl8JXd7G/Q+kvqMg753WYtY4x2Nhy3UQsj1tDdkgSRf6Bb+pV
 bFNrD4TvmcQ+y/57wRjvH127t9CXxT+SbKOISyP1zitUqarvGIDS+Ek9HEKDKp6nagSo
 PJDRf2IJJnb5y17OPiX4+nM9Lr4D68IchMi8dd0J9fwuTim2c/8kHYVsFTwmqb34SUVN
 y7V+VP7wbjaeGFESiUDT7cTImNIaO0yhsGPuA23clSTJkY2iG8kBeD5JbgV1YolYUbk8
 2nW/em4RsUj8Fk7BONQfaXsg2lnVUOfOxYgxSKvLD/yNHSkdPRKe1YvTCwfinic/KCVM OQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrut4haf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 14:00:26 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ALE0Pxs010677
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 14:00:25 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 06:00:24 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v7 00/20] Drivers for gunyah hypervisor
Date:   Mon, 21 Nov 2022 05:59:49 -0800
Message-ID: <20221121140009.2353512-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EK8MR9eQ4DqkBd43xLrMIJXCQlX6t8vx
X-Proofpoint-ORIG-GUID: EK8MR9eQ4DqkBd43xLrMIJXCQlX6t8vx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 impostorscore=0 mlxlogscore=884 phishscore=0
 adultscore=0 clxscore=1011 bulkscore=0 priorityscore=1501 suspectscore=0
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

Gunyah is a Type-1 hypervisor independent of any
high-level OS kernel, and runs in a higher CPU privilege level. It does
not depend on any lower-privileged OS kernel/code for its core
functionality. This increases its security and can support a much smaller
trusted computing base than a Type-2 hypervisor.

Gunyah is an open source hypervisor. The source repo is available at
https://github.com/quic/gunyah-hypervisor.

The diagram below shows the architecture.

::

         VM A                    VM B
     +-----+ +-----+  | +-----+ +-----+ +-----+
     |     | |     |  | |     | |     | |     |
 EL0 | APP | | APP |  | | APP | | APP | | APP |
     |     | |     |  | |     | |     | |     |
     +-----+ +-----+  | +-----+ +-----+ +-----+
 ---------------------|-------------------------
     +--------------+ | +----------------------+
     |              | | |                      |
 EL1 | Linux Kernel | | |Linux kernel/Other OS |   ...
     |              | | |                      |
     +--------------+ | +----------------------+
 --------hvc/smc------|------hvc/smc------------
     +----------------------------------------+
     |                                        |
 EL2 |            Gunyah Hypervisor           |
     |                                        |
     +----------------------------------------+

Gunyah provides these following features.

- Threads and Scheduling: The scheduler schedules virtual CPUs (VCPUs) on
physical CPUs and enables time-sharing of the CPUs.
- Memory Management: Gunyah tracks memory ownership and use of all memory
under its control. Memory partitioning between VMs is a fundamental
security feature.
- Interrupt Virtualization: All interrupts are handled in the hypervisor
and routed to the assigned VM.
- Inter-VM Communication: There are several different mechanisms provided
for communicating between VMs.
- Device Virtualization: Para-virtualization of devices is supported using
inter-VM communication. Low level system features and devices such as
interrupt controllers are supported with emulation where required.

This series adds the basic framework for detecting that Linux is running
under Gunyah as a virtual machine, communication with the Gunyah Resource
Manager, and a basic virtual machine manager capable of launching virtual
machines. In a future series, I'll add more functionality to the VM Manager,
but functionality is kept limited here to reduce the number of patches to
review.

Changes in v7:
 - Refactor to remove gunyah RM bus
 - Refactor allow multiple RM device instances
 - Bump UAPI to start at 0x0
 - Refactor QCOM SCM's platform hooks to allow CONFIG_QCOM_SCM=Y/CONFIG_GUNYAH=M combinations

Changes in v6: https://lore.kernel.org/all/20221026185846.3983888-1-quic_eberman@quicinc.com/
 - *Replace gunyah-console with gunyah VM Manager*
 - Move include/asm-generic/gunyah.h into include/linux/gunyah.h
 - s/gunyah_msgq/gh_msgq/
 - Minor tweaks and documentation tidying based on comments from Jiri, Greg, Arnd, Dmitry, and Bagas.

Changes in v5: https://lore.kernel.org/all/20221011000840.289033-1-quic_eberman@quicinc.com/
 - Dropped sysfs nodes
 - Switch from aux bus to Gunyah RM bus for the subdevices
 - Cleaning up RM console

Changes in v4: https://lore.kernel.org/all/20220928195633.2348848-1-quic_eberman@quicinc.com/
 - Tidied up documentation throughout based on questions/feedback received
 - Switched message queue implementation to use mailboxes
 - Renamed "gunyah_device" as "gunyah_resource"

Changes in v3: https://lore.kernel.org/all/20220811214107.1074343-1-quic_eberman@quicinc.com/
 - /Maintained/Supported/ in MAINTAINERS
 - Tidied up documentation throughout based on questions/feedback received
 - Moved hypercalls into arch/arm64/gunyah/; following hyper-v's implementation
 - Drop opaque typedefs
 - Move sysfs nodes under /sys/hypervisor/gunyah/
 - Moved Gunyah console driver to drivers/tty/
 - Reworked gunyah_device design to drop the Gunyah bus.

Changes in v2: https://lore.kernel.org/all/20220801211240.597859-1-quic_eberman@quicinc.com/
 - DT bindings clean up
 - Switch hypercalls to follow SMCCC 

v1: https://lore.kernel.org/all/20220223233729.1571114-1-quic_eberman@quicinc.com/

Elliot Berman (20):
  docs: gunyah: Introduce Gunyah Hypervisor
  dt-bindings: Add binding for gunyah hypervisor
  gunyah: Common types and error codes for Gunyah hypercalls
  arm64: smccc: Include alternative-macros.h
  virt: gunyah: Add hypercalls to identify Gunyah
  virt: gunyah: Identify hypervisor version
  mailbox: Allow direct registration to a channel
  virt: gunyah: msgq: Add hypercalls to send and receive messages
  mailbox: Add Gunyah message queue mailbox
  gunyah: rsc_mgr: Add resource manager RPC core
  gunyah: rsc_mgr: Add VM lifecycle RPC
  gunyah: vm_mgr: Introduce basic VM Manager
  gunyah: rsc_mgr: Add RPC for sharing memory
  gunyah: vm_mgr: Add/remove user memory regions
  gunyah: vm_mgr: Add ioctls to support basic non-proxy VM boot
  samples: Add sample userspace Gunyah VM Manager
  gunyah: rsc_mgr: Add platform ops on mem_lend/mem_reclaim
  firmware: qcom_scm: Use fixed width src vm bitmap
  firmware: qcom_scm: Register Gunyah platform ops
  docs: gunyah: Document Gunyah VM Manager

 .../bindings/firmware/gunyah-hypervisor.yaml  |  82 ++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 Documentation/virt/gunyah/index.rst           | 115 ++
 Documentation/virt/gunyah/message-queue.rst   |  64 ++
 Documentation/virt/gunyah/vm-manager.rst      |  91 ++
 Documentation/virt/index.rst                  |   1 +
 MAINTAINERS                                   |  13 +
 arch/arm64/Kbuild                             |   1 +
 arch/arm64/gunyah/Makefile                    |   1 +
 arch/arm64/gunyah/gunyah_hypercall.c          | 102 ++
 drivers/firmware/Kconfig                      |   2 +
 drivers/firmware/qcom_scm.c                   | 107 +-
 drivers/mailbox/Kconfig                       |  10 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/gunyah-msgq.c                 | 229 ++++
 drivers/mailbox/mailbox.c                     |  96 +-
 drivers/mailbox/omap-mailbox.c                |  18 +-
 drivers/mailbox/pcc.c                         |  17 +-
 drivers/misc/fastrpc.c                        |   6 +-
 drivers/net/wireless/ath/ath10k/qmi.c         |   4 +-
 drivers/remoteproc/qcom_q6v5_mss.c            |   8 +-
 drivers/soc/qcom/rmtfs_mem.c                  |   2 +-
 drivers/virt/Kconfig                          |   1 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/gunyah/Kconfig                   |  33 +
 drivers/virt/gunyah/Makefile                  |   7 +
 drivers/virt/gunyah/gunyah.c                  |  46 +
 drivers/virt/gunyah/gunyah_platform_hooks.c   |  63 ++
 drivers/virt/gunyah/gunyah_rm_rpc.c           | 987 ++++++++++++++++++
 drivers/virt/gunyah/gunyah_rsc_mgr.c          |  70 ++
 drivers/virt/gunyah/rsc_mgr.h                 | 130 +++
 drivers/virt/gunyah/vm_mgr.c                  | 291 ++++++
 drivers/virt/gunyah/vm_mgr.h                  |  68 ++
 drivers/virt/gunyah/vm_mgr_mm.c               | 246 +++++
 include/linux/arm-smccc.h                     |   1 +
 include/linux/gunyah.h                        | 167 +++
 include/linux/gunyah_rsc_mgr.h                | 137 +++
 include/linux/mailbox_client.h                |   1 +
 include/linux/qcom_scm.h                      |   2 +-
 include/uapi/linux/gunyah.h                   |  53 +
 samples/Kconfig                               |  10 +
 samples/Makefile                              |   1 +
 samples/gunyah/.gitignore                     |   2 +
 samples/gunyah/Makefile                       |   6 +
 samples/gunyah/gunyah_vmm.c                   | 270 +++++
 samples/gunyah/sample_vm.dts                  |  69 ++
 46 files changed, 3563 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
 create mode 100644 Documentation/virt/gunyah/index.rst
 create mode 100644 Documentation/virt/gunyah/message-queue.rst
 create mode 100644 Documentation/virt/gunyah/vm-manager.rst
 create mode 100644 arch/arm64/gunyah/Makefile
 create mode 100644 arch/arm64/gunyah/gunyah_hypercall.c
 create mode 100644 drivers/mailbox/gunyah-msgq.c
 create mode 100644 drivers/virt/gunyah/Kconfig
 create mode 100644 drivers/virt/gunyah/Makefile
 create mode 100644 drivers/virt/gunyah/gunyah.c
 create mode 100644 drivers/virt/gunyah/gunyah_platform_hooks.c
 create mode 100644 drivers/virt/gunyah/gunyah_rm_rpc.c
 create mode 100644 drivers/virt/gunyah/gunyah_rsc_mgr.c
 create mode 100644 drivers/virt/gunyah/rsc_mgr.h
 create mode 100644 drivers/virt/gunyah/vm_mgr.c
 create mode 100644 drivers/virt/gunyah/vm_mgr.h
 create mode 100644 drivers/virt/gunyah/vm_mgr_mm.c
 create mode 100644 include/linux/gunyah.h
 create mode 100644 include/linux/gunyah_rsc_mgr.h
 create mode 100644 include/uapi/linux/gunyah.h
 create mode 100644 samples/gunyah/.gitignore
 create mode 100644 samples/gunyah/Makefile
 create mode 100644 samples/gunyah/gunyah_vmm.c
 create mode 100644 samples/gunyah/sample_vm.dts


base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
-- 
2.25.1

