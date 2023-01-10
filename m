Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752DC664E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjAJVsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjAJVsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:48:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2515C43A26;
        Tue, 10 Jan 2023 13:48:02 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ALMXL6012902;
        Tue, 10 Jan 2023 21:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bry9d/VTYAo4lFYiK8CLDsWACG4VizepJ9hHsaRR6qQ=;
 b=R5sWGo2B5os9NISNhjsmvDNJKYxZaTgBAodRcRYlhtJFXECT9ZA2sv2H0U+eZH/Mmwyy
 6UKrIEunMSpE8PvVlSYMvwINXNqy/G2BIabXaaOU9sXm0keC8LHsvkEG8wxf3JK+yGtE
 t8jzjb4UBEthcHsAsytdSCUultlomOMePngVQIet7+bzCuR6HkSdSn65IzCrIFQLv4N4
 OyqwxPsyGs210kO5w2SJ0hAzuIQDqdtK6zJ9eGfVrdMcImmaVsJlbh8/SWFxObr343JE
 n3GA9+/PdtcFDqFWnRp1Qo7hOO6pZi+JuYvz3CCKlWX3/C/N1QOoFb6ZKCVUA/kttAOy CA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n0sshauh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 21:47:44 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ALlhJC005089
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 21:47:43 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 13:47:42 -0800
Message-ID: <d945e654-9679-72d7-bb79-d09c45f6d5aa@quicinc.com>
Date:   Tue, 10 Jan 2023 13:47:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 00/28] Drivers for gunyah hypervisor
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <83b6dbc2-01da-04b6-64ec-9a69fd5c4c89@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <83b6dbc2-01da-04b6-64ec-9a69fd5c4c89@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LubaLysqtUaJhmdHNrmNUT27vdDx86wv
X-Proofpoint-ORIG-GUID: LubaLysqtUaJhmdHNrmNUT27vdDx86wv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 1:34 PM, Alex Elder wrote:
> On 12/19/22 4:58 PM, Elliot Berman wrote:
>> Gunyah is a Type-1 hypervisor independent of any
>> high-level OS kernel, and runs in a higher CPU privilege level. It does
>> not depend on any lower-privileged OS kernel/code for its core
>> functionality. This increases its security and can support a much smaller
>> trusted computing base than a Type-2 hypervisor.
>>
>> Gunyah is an open source hypervisor. The source repo is available at
>> https://github.com/quic/gunyah-hypervisor.
> 
> Can you provide any history about the hypervisor code itself?
> Was it publicly reviewed?  Has it been reviewed by anyone in
> the Linux kernel community, who might have some useful input
> on it?
> 
>> The diagram below shows the architecture.
>>
>> ::
>>
>>           VM A                    VM B
>>       +-----+ +-----+  | +-----+ +-----+ +-----+
>>       |     | |     |  | |     | |     | |     |
>>   EL0 | APP | | APP |  | | APP | | APP | | APP |
>>       |     | |     |  | |     | |     | |     |
>>       +-----+ +-----+  | +-----+ +-----+ +-----+
>>   ---------------------|-------------------------
>>       +--------------+ | +----------------------+
>>       |              | | |                      |
>>   EL1 | Linux Kernel | | |Linux kernel/Other OS |   ...
>>       |              | | |                      |
>>       +--------------+ | +----------------------+
>>   --------hvc/smc------|------hvc/smc------------
>>       +----------------------------------------+
>>       |                                        |
>>   EL2 |            Gunyah Hypervisor           |
>>       |                                        |
>>       +----------------------------------------+
>>
>> Gunyah provides these following features.
>>
>> - Threads and Scheduling: The scheduler schedules virtual CPUs (VCPUs) on
>> physical CPUs and enables time-sharing of the CPUs.
>> - Memory Management: Gunyah tracks memory ownership and use of all memory
>> under its control. Memory partitioning between VMs is a fundamental
>> security feature.
>> - Interrupt Virtualization: All interrupts are handled in the hypervisor
>> and routed to the assigned VM.
>> - Inter-VM Communication: There are several different mechanisms provided
>> for communicating between VMs.
>> - Device Virtualization: Para-virtualization of devices is supported 
>> using
>> inter-VM communication. Low level system features and devices such as
>> interrupt controllers are supported with emulation where required.
>>
>> This series adds the basic framework for detecting that Linux is running
>> under Gunyah as a virtual machine, communication with the Gunyah Resource
>> Manager, and a virtual machine manager capable of launching virtual 
>> machines.
>>
>> Patches 21-28 are presently intended to be submitted separately and 
>> are included
>> for initial RFC. These patches introudce "VM function" framework to 
>> expose further
>> interfaces to interact with Gunyah Virtual Machines. With all 28 
>> patches, it is
>> possible to create a Gunyah VM supporting virtio.
> 
> I'm not a virtualization expert, and it's likely some of my
> comments demonstrate that...
> 
> You're going to need to update your copyright dates to include
> 2023 now.
> 
> I haven't looked at the earlier reviews; perhaps the RFC stuff
> was requested.  I'm sure it's useful to see that but it doesn't
> seem directly helpful if your goal is to get this code upstream.
> 

Right, the RFC patches were requested. Do you have a recommendation for 
sharing those later patches? I understand it's best practice not to post 
too many patches. The logical split was to have 1-20 go in first, and 
the remaining patches submitted later.

> At this point I've reviewed only through patch 9.  I currently
> have smallish blocks of time and I don't want to hold back my
> feedback for too long.
> 
>                      -Alex
> 
>> Changes in v8:
>>   - Treat VM manager as a library of RM
>>   - Add patches 21-28 as RFC to support proxy-scheduled vCPUs and 
>> necessary bits to support virtio
>>     from Gunyah userspace
>>
>> Changes in v7: 
>> https://lore.kernel.org/all/20221121140009.2353512-1-quic_eberman@quicinc.com/
>>   - Refactor to remove gunyah RM bus
>>   - Refactor allow multiple RM device instances
>>   - Bump UAPI to start at 0x0
>>   - Refactor QCOM SCM's platform hooks to allow 
>> CONFIG_QCOM_SCM=Y/CONFIG_GUNYAH=M combinations
>>
>> Changes in v6: 
>> https://lore.kernel.org/all/20221026185846.3983888-1-quic_eberman@quicinc.com/
>>   - *Replace gunyah-console with gunyah VM Manager*
>>   - Move include/asm-generic/gunyah.h into include/linux/gunyah.h
>>   - s/gunyah_msgq/gh_msgq/
>>   - Minor tweaks and documentation tidying based on comments from 
>> Jiri, Greg, Arnd, Dmitry, and Bagas.
>>
>> Changes in v5: 
>> https://lore.kernel.org/all/20221011000840.289033-1-quic_eberman@quicinc.com/
>>   - Dropped sysfs nodes
>>   - Switch from aux bus to Gunyah RM bus for the subdevices
>>   - Cleaning up RM console
>>
>> Changes in v4: 
>> https://lore.kernel.org/all/20220928195633.2348848-1-quic_eberman@quicinc.com/
>>   - Tidied up documentation throughout based on questions/feedback 
>> received
>>   - Switched message queue implementation to use mailboxes
>>   - Renamed "gunyah_device" as "gunyah_resource"
>>
>> Changes in v3: 
>> https://lore.kernel.org/all/20220811214107.1074343-1-quic_eberman@quicinc.com/
>>   - /Maintained/Supported/ in MAINTAINERS
>>   - Tidied up documentation throughout based on questions/feedback 
>> received
>>   - Moved hypercalls into arch/arm64/gunyah/; following hyper-v's 
>> implementation
>>   - Drop opaque typedefs
>>   - Move sysfs nodes under /sys/hypervisor/gunyah/
>>   - Moved Gunyah console driver to drivers/tty/
>>   - Reworked gunyah_device design to drop the Gunyah bus.
>>
>> Changes in v2: 
>> https://lore.kernel.org/all/20220801211240.597859-1-quic_eberman@quicinc.com/
>>   - DT bindings clean up
>>   - Switch hypercalls to follow SMCCC
>>
>> v1: 
>> https://lore.kernel.org/all/20220223233729.1571114-1-quic_eberman@quicinc.com/
>>
>> Elliot Berman (28):
>>    docs: gunyah: Introduce Gunyah Hypervisor
>>    dt-bindings: Add binding for gunyah hypervisor
>>    gunyah: Common types and error codes for Gunyah hypercalls
>>    arm64: smccc: Include alternative-macros.h
>>    virt: gunyah: Add hypercalls to identify Gunyah
>>    virt: gunyah: Identify hypervisor version
>>    mailbox: Allow direct registration to a channel
>>    virt: gunyah: msgq: Add hypercalls to send and receive messages
>>    mailbox: Add Gunyah message queue mailbox
>>    gunyah: rsc_mgr: Add resource manager RPC core
>>    gunyah: rsc_mgr: Add VM lifecycle RPC
>>    gunyah: vm_mgr: Introduce basic VM Manager
>>    gunyah: rsc_mgr: Add RPC for sharing memory
>>    gunyah: vm_mgr: Add/remove user memory regions
>>    gunyah: vm_mgr: Add ioctls to support basic non-proxy VM boot
>>    samples: Add sample userspace Gunyah VM Manager
>>    gunyah: rsc_mgr: Add platform ops on mem_lend/mem_reclaim
>>    firmware: qcom_scm: Use fixed width src vm bitmap
>>    firmware: qcom_scm: Register Gunyah platform ops
>>    docs: gunyah: Document Gunyah VM Manager
>>    virt: gunyah: Translate gh_rm_hyp_resource into gunyah_resource
>>    gunyah: vm_mgr: Add framework to add VM Functions
>>    virt: gunyah: Add resource tickets
>>    virt: gunyah: Add IO handlers
>>    virt: gunyah: Add proxy-scheduled vCPUs
>>    virt: gunyah: Add hypercalls for sending doorbell
>>    virt: gunyah: Add irqfd interface
>>    virt: gunyah: Add ioeventfd
>>
>>   .../bindings/firmware/gunyah-hypervisor.yaml  |  82 ++
>>   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>>   Documentation/virt/gunyah/index.rst           | 115 +++
>>   Documentation/virt/gunyah/message-queue.rst   |  64 ++
>>   Documentation/virt/gunyah/vm-manager.rst      | 187 ++++
>>   Documentation/virt/index.rst                  |   1 +
>>   MAINTAINERS                                   |  13 +
>>   arch/arm64/Kbuild                             |   1 +
>>   arch/arm64/gunyah/Makefile                    |   1 +
>>   arch/arm64/gunyah/gunyah_hypercall.c          | 157 ++++
>>   arch/arm64/include/asm/gunyah.h               |  23 +
>>   drivers/firmware/Kconfig                      |   2 +
>>   drivers/firmware/qcom_scm.c                   | 107 ++-
>>   drivers/mailbox/Kconfig                       |  10 +
>>   drivers/mailbox/Makefile                      |   2 +
>>   drivers/mailbox/gunyah-msgq.c                 | 229 +++++
>>   drivers/mailbox/mailbox.c                     |  96 ++-
>>   drivers/mailbox/omap-mailbox.c                |  18 +-
>>   drivers/mailbox/pcc.c                         |  18 +-
>>   drivers/misc/fastrpc.c                        |   6 +-
>>   drivers/net/wireless/ath/ath10k/qmi.c         |   4 +-
>>   drivers/remoteproc/qcom_q6v5_mss.c            |   8 +-
>>   drivers/soc/qcom/rmtfs_mem.c                  |   2 +-
>>   drivers/virt/Kconfig                          |   1 +
>>   drivers/virt/Makefile                         |   1 +
>>   drivers/virt/gunyah/Kconfig                   |  73 ++
>>   drivers/virt/gunyah/Makefile                  |  10 +
>>   drivers/virt/gunyah/gunyah.c                  |  46 +
>>   drivers/virt/gunyah/gunyah_ioeventfd.c        | 109 +++
>>   drivers/virt/gunyah/gunyah_irqfd.c            | 180 ++++
>>   drivers/virt/gunyah/gunyah_platform_hooks.c   |  63 ++
>>   drivers/virt/gunyah/gunyah_vcpu.c             | 350 ++++++++
>>   drivers/virt/gunyah/rsc_mgr.c                 | 795 ++++++++++++++++++
>>   drivers/virt/gunyah/rsc_mgr.h                 | 124 +++
>>   drivers/virt/gunyah/rsc_mgr_rpc.c             | 428 ++++++++++
>>   drivers/virt/gunyah/vm_mgr.c                  | 594 +++++++++++++
>>   drivers/virt/gunyah/vm_mgr.h                  |  76 ++
>>   drivers/virt/gunyah/vm_mgr_mm.c               | 245 ++++++
>>   include/linux/arm-smccc.h                     |   1 +
>>   include/linux/gunyah.h                        | 186 ++++
>>   include/linux/gunyah_rsc_mgr.h                | 136 +++
>>   include/linux/gunyah_vm_mgr.h                 | 107 +++
>>   include/linux/mailbox_client.h                |   1 +
>>   include/linux/qcom_scm.h                      |   2 +-
>>   include/uapi/linux/gunyah.h                   | 114 +++
>>   samples/Kconfig                               |  10 +
>>   samples/Makefile                              |   1 +
>>   samples/gunyah/.gitignore                     |   2 +
>>   samples/gunyah/Makefile                       |   6 +
>>   samples/gunyah/gunyah_vmm.c                   | 270 ++++++
>>   samples/gunyah/sample_vm.dts                  |  69 ++
>>   51 files changed, 5075 insertions(+), 72 deletions(-)
>>   create mode 100644 
>> Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>>   create mode 100644 Documentation/virt/gunyah/index.rst
>>   create mode 100644 Documentation/virt/gunyah/message-queue.rst
>>   create mode 100644 Documentation/virt/gunyah/vm-manager.rst
>>   create mode 100644 arch/arm64/gunyah/Makefile
>>   create mode 100644 arch/arm64/gunyah/gunyah_hypercall.c
>>   create mode 100644 arch/arm64/include/asm/gunyah.h
>>   create mode 100644 drivers/mailbox/gunyah-msgq.c
>>   create mode 100644 drivers/virt/gunyah/Kconfig
>>   create mode 100644 drivers/virt/gunyah/Makefile
>>   create mode 100644 drivers/virt/gunyah/gunyah.c
>>   create mode 100644 drivers/virt/gunyah/gunyah_ioeventfd.c
>>   create mode 100644 drivers/virt/gunyah/gunyah_irqfd.c
>>   create mode 100644 drivers/virt/gunyah/gunyah_platform_hooks.c
>>   create mode 100644 drivers/virt/gunyah/gunyah_vcpu.c
>>   create mode 100644 drivers/virt/gunyah/rsc_mgr.c
>>   create mode 100644 drivers/virt/gunyah/rsc_mgr.h
>>   create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c
>>   create mode 100644 drivers/virt/gunyah/vm_mgr.c
>>   create mode 100644 drivers/virt/gunyah/vm_mgr.h
>>   create mode 100644 drivers/virt/gunyah/vm_mgr_mm.c
>>   create mode 100644 include/linux/gunyah.h
>>   create mode 100644 include/linux/gunyah_rsc_mgr.h
>>   create mode 100644 include/linux/gunyah_vm_mgr.h
>>   create mode 100644 include/uapi/linux/gunyah.h
>>   create mode 100644 samples/gunyah/.gitignore
>>   create mode 100644 samples/gunyah/Makefile
>>   create mode 100644 samples/gunyah/gunyah_vmm.c
>>   create mode 100644 samples/gunyah/sample_vm.dts
>>
>>
>> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
> 
