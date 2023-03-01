Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365736A63F6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCAABN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCAABM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:01:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2B932E73;
        Tue, 28 Feb 2023 16:01:09 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SNt3I6026847;
        Wed, 1 Mar 2023 00:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NhGwVS6CIONnk+XWakqOalE8W1WIZqOPtcHjC/goOnI=;
 b=UGdMQ4JB3JrmVoecQ0Z97/oh/LRP8t7ZHExJDBjkNXQooe3/BuAguCV8hvkEBe+Zt7zE
 ZyutA1WSDEsAC1eyTOvHHFTSUUYqvZl7+nBmZU+SH3YKgYCvhVBDavesJQLD8MovNXST
 SohA0IPT2ZfZAB3OJLSdSl4TXPBHSIFfvDIF2ZITyLQa8xxy0RZnlM9KAtdGNoi+Ew0K
 2KAbkZZA18ZpHB+su5u14NSM9GNAsdfp9YZ8pkgYws4edNIc+J+Ijl6d6nhFW2d1oKPo
 VQK7nFFGxpIQIu60Lw8Elfj9jLBI0R2xnQWtyASsTK4W/6LDOeyA6WCA159EorRU0nqs nA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1n0th1ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 00:00:50 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32100ng1015946
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 00:00:49 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Feb
 2023 16:00:48 -0800
Message-ID: <ef5d41e7-7755-4a8e-5e6d-fc8d48c6a981@quicinc.com>
Date:   Tue, 28 Feb 2023 16:00:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 01/26] docs: gunyah: Introduce Gunyah Hypervisor
Content-Language: en-US
To:     Alex Elder <alex.elder@linaro.org>, Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214211229.3239350-2-quic_eberman@quicinc.com>
 <41df9fd2-9277-b6e8-7961-509da295dcb8@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <41df9fd2-9277-b6e8-7961-509da295dcb8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pbTrruF5wveUIN7XyTqut40dX1hTBkrr
X-Proofpoint-GUID: pbTrruF5wveUIN7XyTqut40dX1hTBkrr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280188
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2023 3:41 PM, Alex Elder wrote:
> On 2/14/23 3:12 PM, Elliot Berman wrote:
>> Gunyah is an open-source Type-1 hypervisor developed by Qualcomm. It
>> does not depend on any lower-privileged OS/kernel code for its core
>> functionality. This increases its security and can support a smaller
>> trusted computing based when compared to Type-2 hypervisors.
>>
>> Add documentation describing the Gunyah hypervisor and the main
>> components of the Gunyah hypervisor which are of interest to Linux
>> virtualization development.
>>
>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   Documentation/virt/gunyah/index.rst         | 113 ++++++++++++++++++++
>>   Documentation/virt/gunyah/message-queue.rst |  61 +++++++++++
>>   Documentation/virt/index.rst                |   1 +
>>   3 files changed, 175 insertions(+)
>>   create mode 100644 Documentation/virt/gunyah/index.rst
>>   create mode 100644 Documentation/virt/gunyah/message-queue.rst
>>
>> diff --git a/Documentation/virt/gunyah/index.rst 
>> b/Documentation/virt/gunyah/index.rst
>> new file mode 100644
>> index 000000000000..45adbbc311db
>> --- /dev/null
>> +++ b/Documentation/virt/gunyah/index.rst
>> @@ -0,0 +1,113 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=================
>> +Gunyah Hypervisor
>> +=================
>> +
>> +.. toctree::
>> +   :maxdepth: 1
>> +
>> +   message-queue
>> +
>> +Gunyah is a Type-1 hypervisor which is independent of any OS kernel, 
>> and runs in
>> +a higher CPU privilege level. It does not depend on any 
>> lower-privileged operating system
>> +for its core functionality. This increases its security and can 
>> support a much smaller
>> +trusted computing base than a Type-2 hypervisor.
>> +
>> +Gunyah is an open source hypervisor. The source repo is available at
>> +https://github.com/quic/gunyah-hypervisor.
>> +
>> +Gunyah provides these following features.
>> +
>> +- Scheduling:
>> +
>> +  A scheduler for virtual CPUs (vCPUs) on physical CPUs enables 
>> time-sharing
>> +  of the CPUs. Gunyah supports two models of scheduling:
>> +
>> +    1. "Behind the back" scheduling in which Gunyah hypervisor 
>> schedules vCPUS on its own.
>> +    2. "Proxy" scheduling in which a delegated VM can donate part of 
>> one of its vCPU slice
>> +       to another VM's vCPU via a hypercall.
>> +
>> +- Memory Management:
>> +
>> +  APIs handling memory, abstracted as objects, limiting direct use of 
>> physical
>> +  addresses. Memory ownership and usage tracking of all memory under 
>> its control.
>> +  Memory partitioning between VMs is a fundamental security feature.
>> +
>> +- Interrupt Virtualization:
>> +
>> +  Uses CPU hardware interrupt virtualization capabilities. Interrupts 
>> are handled
>> +  in the hypervisor and routed to the assigned VM.
>> +
>> +- Inter-VM Communication:
>> +
>> +  There are several different mechanisms provided for communicating 
>> between VMs.
>> +
>> +- Virtual platform:
>> +
>> +  Architectural devices such as interrupt controllers and CPU timers 
>> are directly provided
>> +  by the hypervisor as well as core virtual platform devices and 
>> system APIs such as ARM PSCI.
>> +
>> +- Device Virtualization:
>> +
>> +  Para-virtualization of devices is supported using inter-VM 
>> communication.
>> +
>> +Architectures supported
>> +=======================
>> +AArch64 with a GIC
>> +
>> +Resources and Capabilities
>> +==========================
>> +
>> +Some services or resources provided by the Gunyah hypervisor are 
>> described to a virtual machine by
>> +capability IDs. For instance, inter-VM communication is performed 
>> with doorbells and message queues.
>> +Gunyah allows access to manipulate that doorbell via the capability 
>> ID. These resources are
>> +described in Linux as a struct gunyah_resource.
>> +
>> +High level management of these resources is performed by the resource 
>> manager VM. RM informs a
>> +guest VM about resources it can access through either the device tree 
>> or via guest-initiated RPC.
>> +
>> +For each virtual machine, Gunyah maintains a table of resources which 
>> can be accessed by that VM.
>> +An entry in this table is called a "capability" and VMs can only 
>> access resources via this
>> +capability table. Hence, virtual Gunyah resources are referenced by a 
>> "capability IDs" and not
>> +"resource IDs". If 2 VMs have access to the same resource, they might 
>> not be using the same
>> +capability ID to access that resource since the capability tables are 
>> independent per VM.
>> +
>> +Resource Manager
>> +================
>> +
>> +The resource manager (RM) is a privileged application VM supporting 
>> the Gunyah Hypervisor.
>> +It provides policy enforcement aspects of the virtualization system. 
>> The resource manager can
>> +be treated as an extension of the Hypervisor but is separated to its 
>> own partition to ensure
>> +that the hypervisor layer itself remains small and secure and to 
>> maintain a separation of policy
>> +and mechanism in the platform. RM runs at arm64 NS-EL1 similar to 
>> other virtual machines.
>> +
>> +Communication with the resource manager from each guest VM happens 
>> with message-queue.rst. Details
>> +about the specific messages can be found in 
>> drivers/virt/gunyah/rsc_mgr.c
>> +
>> +::
>> +
>> +  +-------+   +--------+   +--------+
>> +  |  RM   |   |  VM_A  |   |  VM_B  |
>> +  +-.-.-.-+   +---.----+   +---.----+
>> +    | |           |            |
>> +  +-.-.-----------.------------.----+
>> +  | | \==========/             |    |
>> +  |  \========================/     |
>> +  |            Gunyah               |
>> +  +---------------------------------+
>> +
>> +The source for the resource manager is available at 
>> https://github.com/quic/gunyah-resource-manager.
>> +
>> +The resource manager provides the following features:
>> +
>> +- VM lifecycle management: allocating a VM, starting VMs, destruction 
>> of VMs
>> +- VM access control policy, including memory sharing and lending
>> +- Interrupt routing configuration
>> +- Forwarding of system-level events (e.g. VM shutdown) to owner VM
>> +
>> +When booting a virtual machine which uses a devicetree such as Linux, 
>> resource manager overlays a
>> +/hypervisor node. This node can let Linux know it is running as a 
>> Gunyah guest VM,
>> +how to communicate with resource manager, and basic description and 
>> capabilities of
>> +this VM. See 
>> Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml for 
>> a description
>> +of this node.
>> diff --git a/Documentation/virt/gunyah/message-queue.rst 
>> b/Documentation/virt/gunyah/message-queue.rst
>> new file mode 100644
>> index 000000000000..0667b3eb1ff9
>> --- /dev/null
>> +++ b/Documentation/virt/gunyah/message-queue.rst
>> @@ -0,0 +1,61 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +Message Queues
>> +==============
>> +Message queue is a simple low-capacity IPC channel between two VMs. 
>> It is
>> +intended for sending small control and configuration messages. Each 
>> message
>> +queue is unidirectional, so a full-duplex IPC channel requires a pair 
>> of queues.
>> +
>> +Messages can be up to 240 bytes in length. Longer messages require a 
>> further
>> +protocol on top of the message queue messages themselves. For 
>> instance, communication
>> +with the resource manager adds a header field for sending longer 
>> messages via multiple
>> +message fragments.
>> +
>> +The diagram below shows how message queue works. A typical 
>> configuration involves
>> +2 message queues. Message queue 1 allows VM_A to send messages to 
>> VM_B. Message
>> +queue 2 allows VM_B to send messages to VM_A.
>> +
>> +1. VM_A sends a message of up to 240 bytes in length. It raises a 
>> hypercall
> 
> Can you clarify that the message being sent is in the VM's *own*
> memory/  Maybe this is clear, but the message doesn't have to (for
> example) be located in shared memory.  The original message is
> copied into message queue buffers in order to be transferred.
> 
>> +   with the message to inform the hypervisor to add the message to
>> +   message queue 1's queue.
>> +
>> +2. Gunyah raises the corresponding interrupt for VM_B (Rx vIRQ) when 
>> any of
>> +   these happens:
>> +
>> +   a. gh_msgq_send has PUSH flag. Queue is immediately flushed. This 
>> is the typical case.
> 
> Below you use gh_msgq_send() (with parentheses).  I prefer that,
> but whatever you do, do it consistently.
> 
>> +   b. Explicility with gh_msgq_push command from VM_A.
>> +   c. Message queue has reached a threshold depth.
>> +
>> +3. VM_B calls gh_msgq_recv and Gunyah copies message to requested 
>> buffer.
>> +
>> +4. Gunyah buffers messages in the queue. If the queue became full 
>> when VM_A added a message,
>> +   the return values for gh_msgq_send() include a flag that indicates 
>> the queue is full.
>> +   Once VM_B receives the message and, thus, there is space in the 
>> queue, Gunyah
>> +   will raise the Tx vIRQ on VM_A to indicate it can continue sending 
>> messages.
>> +
>> +For VM_B to send a message to VM_A, the process is identical, except 
>> that hypercalls
>> +reference message queue 2's capability ID. Each message queue has its 
>> own independent
>> +vIRQ: two TX message queues will have two vIRQs (and two capability 
>> IDs).
> 
> Can a sender determine when a message has been delivered?

Sender cannot determine when the receiving VM has processed the message.

> Does the TX vIRQ indicate only that the messaging system
> has processed the message (taken it and queued it), but
> says nothing about it being delivered/accepted/received?

That's the correct interpretation.

Thanks,
Elliot
