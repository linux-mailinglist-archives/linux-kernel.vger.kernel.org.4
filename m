Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228CB7465CF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 00:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGCWmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 18:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCWmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 18:42:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9DFE41;
        Mon,  3 Jul 2023 15:42:18 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363MTqiY010829;
        Mon, 3 Jul 2023 22:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=L+OpEEaeN7eopB4Jc0EQb1atU6IhFsnIOFVMcdE/9RU=;
 b=gG9afJKFZP5ZjS1St76UPh5WOvaDqtKGPcXWI6a8aVSLEMWgFdKMXcXriv+fRuQz+Ywb
 x/UswS/K6yFye51aBcSj5K97MvZLniE18M9JneF7/xsdxDiVmqHrUHC/i76IvGXvuQ+Z
 ckBjcwYleJvQ3+7FjQDQ6XSujm8fxAQkyO49R01I0CGxwykHs4Z8mqMmvZkL74jKChPC
 cMtdOe1b/ILVubN3+RmIBMkM9eibjv3eNkP6D5cdI8/ijdOOKTqn5m/tXDooo3o6Gsn5
 HT6/ARCL10wz7WsMt4xdeMcL8Hu8u/IU9dznscIP449ODH9OzbhIIuB8mojIsvhrg3wL Bg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rkyrr8wex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 22:41:59 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 363MfxAs007195
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Jul 2023 22:41:59 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 3 Jul 2023
 15:41:58 -0700
Message-ID: <5dc7438c-e161-915c-c037-19c5099a274f@quicinc.com>
Date:   Mon, 3 Jul 2023 15:41:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v14 01/25] docs: gunyah: Introduce Gunyah Hypervisor
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>,
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
        Conor Dooley <conor+dt@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-2-quic_eberman@quicinc.com>
 <cb1d4b05-26f3-22f5-ce8e-813d255cda8a@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <cb1d4b05-26f3-22f5-ce8e-813d255cda8a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dZ-ST4h7zayM3KrhngV1wZZEFNILYbFA
X-Proofpoint-ORIG-GUID: dZ-ST4h7zayM3KrhngV1wZZEFNILYbFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_15,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 adultscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030205
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/2023 9:32 AM, Alex Elder wrote:
> On 6/13/23 12:20 PM, Elliot Berman wrote:
>> Gunyah is an open-source Type-1 hypervisor developed by Qualcomm. It
>> does not depend on any lower-privileged OS/kernel code for its core
>> functionality. This increases its security and can support a smaller
>> trusted computing based when compared to Type-2 hypervisors.
> 
> s/based/base/
> 
>>
>> Add documentation describing the Gunyah hypervisor and the main
>> components of the Gunyah hypervisor which are of interest to Linux
>> virtualization development.
>>
>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> I have some questions and comments.  But I trust that you
> can answer them and update your patch in a reasonable way
> to address what I say.  So... please consider these things,
> and update as you see fit.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
>> ---
>>   Documentation/virt/gunyah/index.rst         | 113 ++++++++++++++++++++
>>   Documentation/virt/gunyah/message-queue.rst |  63 +++++++++++
>>   Documentation/virt/index.rst                |   1 +
>>   3 files changed, 177 insertions(+)
>>   create mode 100644 Documentation/virt/gunyah/index.rst
>>   create mode 100644 Documentation/virt/gunyah/message-queue.rst
>>
>> diff --git a/Documentation/virt/gunyah/index.rst 
>> b/Documentation/virt/gunyah/index.rst
>> new file mode 100644
>> index 0000000000000..74aa345e0a144
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
> 
> s/VCPUS/VCPUs/
> 
>> +    2. "Proxy" scheduling in which a delegated VM can donate part of 
>> one of its vCPU slice
>> +       to another VM's vCPU via a hypercall.
> 
> This might sound dumb, but can there be more vCPUs than there
> are physical CPUs?  Is a vCPU *tied* to a particular physical
> CPU, or does it just indicate that a VM has one abstracted CPU
> available to use--and any available physical CPU core can
> implement it (possibly changing between time slices)?
> 

There can be more vCPUs than physical CPUs. If someone wanted to 
hard-code their VM to use 16 vCPUs, they could (I picked 16 arbitrarily).

The latter -- the physical CPU that makes the "vcpu_run" hypercall will 
be the one to run the vCPU. The userspace thread triggers the hypercall 
via GH_VCPU_RUN ioctl and is dependent on the host's task placement for 
which physical cpu that userspace thread runs on.

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
>> +described in Linux as a struct gh_resource.
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
> 
> Maybe:
> 
> This node lets Linux know it is running as a Gunyah guest VM.
> It provides a basic description and capabilities of the VM,
> as well as information required to communicate with the resource
> manager.
> 
>> +this VM. See 
>> Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml for 
>> a description
>> +of this node.
>> diff --git a/Documentation/virt/gunyah/message-queue.rst 
>> b/Documentation/virt/gunyah/message-queue.rst
>> new file mode 100644
>> index 0000000000000..b352918ae54b4
>> --- /dev/null
>> +++ b/Documentation/virt/gunyah/message-queue.rst
>> @@ -0,0 +1,63 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +Message Queues
>> +==============
>> +Message queue is a simple low-capacity IPC channel between two VMs. 
>> It is
> 
> I don't know what the "capacity" of an IPC channel is.  But
> that's OK I guess; it's sort of descriptive.
> 
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
>> +   with the message to inform the hypervisor to add the message to
>> +   message queue 1's queue. The hypervisor copies memory into the 
>> internal
>> +   message queue representation; the memory doesn't need to be shared 
>> between
>> +   VM_A and VM_B.
>> +
>> +2. Gunyah raises the corresponding interrupt for VM_B (Rx vIRQ) when 
>> any of
>> +   these happens:
>> +
>> +   a. gh_msgq_send() has PUSH flag. Queue is immediately flushed. 
>> This is the typical case.
>> +   b. Explicility with gh_msgq_push command from VM_A.
> 
> s/Explicility/Explicitly/
> 
> Is gh_msgq_send() a function and gh_msgq_push a "command" or
> something?  Why the difference in parentheses?  (Pick a
> convention and follow it.)

Will fix.

> 
> Does "Queue is flushed" mean "VM_B is interrupted"?

Yes, I'll clarify that's what it means. VM_B could get the interrupt and 
still decide not to read from the queue.

> 
> VM_A calls gh_msgq_push, and that causes the VM_B interrupt to
> be signaled?
> 

Yes.

> I'm being a little picky but I think these descriptions could be
> improved a bit.
> 
>> +   c. Message queue has reached a threshold depth.
>> +
>> +3. VM_B calls gh_msgq_recv() and Gunyah copies message to requested 
>> buffer.
> 
> It sure would be nice if all this didn't have to be copied
> twice.  But I recognize the copies ensure isolation.
> 
>> +
>> +4. Gunyah buffers messages in the queue. If the queue became full 
>> when VM_A added a message,
>> +   the return values for gh_msgq_send() include a flag that indicates 
>> the queue is full.
>> +   Once VM_B receives the message and, thus, there is space in the 
>> queue, Gunyah
>> +   will raise the Tx vIRQ on VM_A to indicate it can continue sending 
>> messages.
> 
> Does the Tx vIRQ on VM_A fire after *every* message is sent,
> or only when the state of the queue goes from "full" to "not"?
> (Looking at patch 6 it looks like the latter.)

Tx vIRQ only fires when state of queue goes from "full" to "not".

This may not be very relevant, but Gunyah allows the "not full" 
threshold to be less than the queue depth. For instance, the Tx vIRQ 
could be configured to only fire once there are no pending messages in 
the queue. Linux doesn't presently configure this threshold.

> 
> If it's signaled after every message is sent, does it
> indicate that the message has been *received* by VM_B
> (versus just received and copied by Gunyah)?
> 

To connect some dots: the Tx vIRQ is fired when the reader reads a 
message and the number of messages still in the queue decrements to the 
"not full" threshold.

https://github.com/quic/gunyah-hypervisor/blob/3d4014404993939f898018cfb1935c2d9bfc2830/hyp/ipc/msgqueue/src/msgqueue_common.c#L142-L148

>> +
>> +For VM_B to send a message to VM_A, the process is identical, except 
>> that hypercalls
>> +reference message queue 2's capability ID. Each message queue has its 
>> own independent
>> +vIRQ: two TX message queues will have two vIRQs (and two capability 
>> IDs).
>> +
>> +::
>> +
>> +      +---------------+         +-----------------+         
>> +---------------+
>> +      |      VM_A     |         |Gunyah hypervisor|         |      
>> VM_B     |
>> +      |               |         |                 |         
>> |               |
>> +      |               |         |                 |         
>> |               |
>> +      |               |   Tx    |                 |         
>> |               |
>> +      |               |-------->|                 | Rx vIRQ 
>> |               |
>> +      |gh_msgq_send() | Tx vIRQ |Message queue 1  
>> |-------->|gh_msgq_recv() |
>> +      |               |<------- |                 |         
>> |               |
>> +      |               |         |                 |         
>> |               |
>> +      | Message Queue |         |                 |         | Message 
>> Queue |
>> +      | driver        |         |                 |         | 
>> driver        |
>> +      |               |         |                 |         
>> |               |
>> +      |               |         |                 |         
>> |               |
>> +      |               |         |                 |   Tx    
>> |               |
>> +      |               | Rx vIRQ |                 
>> |<--------|               |
>> +      |gh_msgq_recv() |<--------|Message queue 2  | Tx vIRQ 
>> |gh_msgq_send() |
>> +      |               |         |                 
>> |-------->|               |
>> +      |               |         |                 |         
>> |               |
>> +      |               |         |                 |         
>> |               |
>> +      +---------------+         +-----------------+         
>> +---------------+
>> diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
>> index 7fb55ae08598d..15869ee059b35 100644
>> --- a/Documentation/virt/index.rst
>> +++ b/Documentation/virt/index.rst
>> @@ -16,6 +16,7 @@ Virtualization Support
>>      coco/sev-guest
>>      coco/tdx-guest
>>      hyperv/index
>> +   gunyah/index
>>   .. only:: html and subproject
> 
