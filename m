Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755186647CE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbjAJRz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjAJRyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:54:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E210A6E42B;
        Tue, 10 Jan 2023 09:54:51 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AFR1kT013466;
        Tue, 10 Jan 2023 17:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Y+4fTeCtJnbTxOgBgp2Rlhr+UcYW6BisFSe/cr+Tij4=;
 b=DONGnFW8mAmbJFu2viZui/Wax7PISe1/QQGyuhBUakNOJ1WUrPt9BB2JM9Qn0FMxDO+y
 /bes0bjHc41Sm0ZNQFkBf+2PM0DieGM1+aB2a72hdGtRdHfbymqL1v4UsIA4JFGkAInO
 ody2OQmXc9s8sCtv/dc0/5fA+padolTrFc6yTQ8DOJRnilx/AwXUZBxOqFeFGVBjJJzZ
 lEfmSxdqPS/AoA5KYb/brP0SVtcLGIJt7SMKjs92sGAPfmS1dZTOQki3PvJMsm8C/mJQ
 Kmpt83hypor5lfVR/bOEl7rd7aXnYhsr4dEsUx9eR9SXjjjaKnoQolJKr26VO3Dw2qNP aw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n13cnhbpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 17:54:37 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30AHsaJH006309
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 17:54:36 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 09:54:33 -0800
Message-ID: <49b3f442-b122-f4ab-4372-7b9041d54a6d@quicinc.com>
Date:   Tue, 10 Jan 2023 09:54:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v8 01/28] docs: gunyah: Introduce Gunyah Hypervisor
To:     Alex Elder <elder@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
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
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-2-quic_eberman@quicinc.com>
 <af7b5726-c244-f0c6-7632-1a4bf72b53ef@linaro.org>
Content-Language: en-US
In-Reply-To: <af7b5726-c244-f0c6-7632-1a4bf72b53ef@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9aVTc9g1tcNy-wyuNtebHNCIkOq7TBta
X-Proofpoint-GUID: 9aVTc9g1tcNy-wyuNtebHNCIkOq7TBta
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_07,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100115
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 1:34 PM, Alex Elder wrote:
> On 12/19/22 4:58 PM, Elliot Berman wrote:
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
>>   Documentation/virt/gunyah/index.rst         | 114 ++++++++++++++++++++
>>   Documentation/virt/gunyah/message-queue.rst |  56 ++++++++++
>>   Documentation/virt/index.rst                |   1 +
>>   MAINTAINERS                                 |   7 ++
>>   4 files changed, 178 insertions(+)
>>   create mode 100644 Documentation/virt/gunyah/index.rst
>>   create mode 100644 Documentation/virt/gunyah/message-queue.rst
>>
>> diff --git a/Documentation/virt/gunyah/index.rst 
>> b/Documentation/virt/gunyah/index.rst
>> new file mode 100644
>> index 000000000000..fbadbdd24da7
>> --- /dev/null
>> +++ b/Documentation/virt/gunyah/index.rst
>> @@ -0,0 +1,114 @@
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
>> +  A scheduler for virtual CPUs (vCPUs) on physical CPUs and enables 
>> time-sharing
> 
> s/and enables/enables/  (?)
> 
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
>> +  APIs handling memory, abstracted as objects, limiting direct useof 
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
>> ID. These devices are described
> 
> s/devices/resources/
> 
>> +in Linux as a struct gunyah_resource.
>> +
>> +High level management of these resources is performed by the resource 
>> manager VM. RM informs a
> 
> s/resource manager VM/resource manager VM (RM)/
> 
>> +guest VM about resources it can access through either the device tree 
>> or via guest-initiated RPC.
>> +
>> +For each virtual machine, Gunyah maintains a table of resources which 
>> can be accessed by that VM.
>> +An entry in this table is called a "capability" and VMs can only 
>> access resources via this
>> +capability table. Hence, virtual Gunyah devices are referenced by a 
>> "capability IDs" and not a
> 
> s/devices/resources/
> s/and not a/and not/
> 
>> +"resource IDs". A VM can have multiple capability IDs mapping to the 
>> same resource. If 2 VMs have
>> +access to the same resource, they may not be using the same 
>> capability ID to access that resource
> 
> Does "may not be using the same capability ID" mean they "shall not",
> or "are permitted not to"?
> 

"are permitted not to". I'll say "might not" instead of "may not".

>> +since the tables are independent per VM.
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
>> +and mechanism in the platform. On arm64, RM runs at NS-EL1 similar to 
>> other virtual machines.
> 
> This only runs on arm64, right?  Maybe "RM runs at arm64 NS-EL1..."
>> +
>> +Communication with the resource manager from each guest VM happens 
>> with message-queue.rst. Details
> 
> Is "message-queue.rst" supposed to be a reference to that other document?
> 

Yes. Sphinx will generate hyperlink to that document. It's in the same 
directory as this document.

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
>> +When booting a virtual machine which uses a devicetree, resource 
>> manager overlays a
> 
> "When booting Linux in a virtual machine..." ?
> 
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
>> index 000000000000..be4ab289236a
>> --- /dev/null
>> +++ b/Documentation/virt/gunyah/message-queue.rst
>> @@ -0,0 +1,56 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +Message Queues
>> +==============
>> +Message queue is a simple low-capacity IPC channel between two VMs. 
>> It is
>> +intended for sending small control and configuration messages. Each 
>> message
>> +queue object is unidirectional, so a full-duplex IPC channel requires 
>> a pair of
>> +objects.
> 
> The wording here makes it seem like "message queue" might be
> distinct from a "message queue object" but I think they're the
> same thing (right?).
> 

Yes, they are the same. Removed the "object" to make it more concise.

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
>> +   with the message to inform the hypervisor to add the message to
>> +   message queue 1's queue.
>> +
>> +2. Gunyah raises the corresponding interrupt for VM_B when any of 
>> these happens:

(edited above line to explicitly call out this is the Rx vIRQ)

>> +
>> +   a. gh_msgq_send has PUSH flag. Queue is immediately flushed. This 
>> is the typical case.
>> +   b. Explicility with gh_msgq_push command from VM_A.
>> +   c. Message queue has reached a threshold depth.
>> +
>> +3. VM_B calls gh_msgq_recv and Gunyah copies message to requested 
>> buffer.
> 
> So VM_B *responds* to the Rx vIRQ by calling gh_msgq_recv() and
> supplying a buffer in which Gunyah copies the message content?
> 
> I guess my point is, can VM_B post a receive buffer in advance of
> a message Rx vIRQ being delivered?

Yes, that is possible.

> 
> You don't describe what a Tx vIRQ does.  When does it fire?

Good catch! I've added a 4th point:

4. Gunyah buffers messages in the queue. If the queue became full when 
VM_A added a message,
    the return values for gh_msgq_send() include a flag that indicates 
the queue is full.
    Once VM_B receives the message and, thus, there is space in the 
queue, Gunyah
    will raise the Tx vIRQ on VM_A to indicate it can continue sending 
messages.

Thanks,
Elliot
