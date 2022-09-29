Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F9A5EECA4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 06:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiI2ECX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 00:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiI2ECU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 00:02:20 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582ACF1934;
        Wed, 28 Sep 2022 21:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664424139; x=1695960139;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PQTvPdtfbIJpzPf1F/SRY//WCyK26Mw3kEBkRj9QTyQ=;
  b=RFunYgSTDYOkxozPb9phlK8pXZXMbqKkOcf29MPWGL+uSQotmXu0YH7z
   SKZvRIGxljQ0j8DORnvWyrgXC/LjC6kxQBYmtV98Yw9iKJHpbqz8P4iZ9
   5h3Uu2e8CWPqqt5vqd4yf3GzsQg22csL7aTMaHAqRYX1w2p2s0Zo8oV4o
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Sep 2022 21:02:19 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 21:02:18 -0700
Received: from [10.110.116.67] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 21:02:17 -0700
Message-ID: <e6502af5-73c1-6b06-5da7-28185477aefe@quicinc.com>
Date:   Wed, 28 Sep 2022 21:02:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 01/14] docs: gunyah: Introduce Gunyah Hypervisor
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-2-quic_eberman@quicinc.com>
 <YzUUaIx+azyzFDNX@debian.me>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <YzUUaIx+azyzFDNX@debian.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/2022 8:43 PM, Bagas Sanjaya wrote:
> On Wed, Sep 28, 2022 at 12:56:20PM -0700, Elliot Berman wrote:
>> diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
>> new file mode 100644
>> index 000000000000..959f451caccd
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
>> +   :maxdepth: 1
>> +
>> +   message-queue
>> +
>> +Gunyah is a Type-1 hypervisor which is independent of any OS kernel, and runs in
>> +a higher CPU privilege level. It does not depend on any lower-privileged operating system
>> +for its core functionality. This increases its security and can support a much smaller
>> +trusted computing base than a Type-2 hypervisor.
>> +
>> +Gunyah is an open source hypervisor. The source repo is available at
>> +https://github.com/quic/gunyah-hypervisor.
>> +
>> +Gunyah provides these following features.
>> +
>> +- Scheduling:
>> +
>> +  A scheduler for virtual CPUs (vCPUs) on physical CPUs and enables time-sharing
>> +  of the CPUs. Gunyah supports two models of scheduling:
>> +
>> +    1. "Behind the back" scheduling in which Gunyah hypervisor schedules vCPUS on its own
>> +    2. "Proxy" scheduling in which a delegated VM can donate part of one of its vCPU slice
>> +       to another VM's vCPU via a hypercall.
>> +
>> +- Memory Management:
>> +
>> +  APIs handling memory, abstracted as objects, limiting direct use of physical
>> +  addresses. Memory ownership and usage tracking of all memory under its control.
>> +  Memory partitioning between VMs is a fundamental security feature.
>> +
>> +- Interrupt Virtualization:
>> +
>> +  Uses CPU hardware interrupt virtualization capabilities. Interrupts are handled
>> +  in the hypervisor and routed to the assigned VM.
>> +
>> +- Inter-VM Communication:
>> +
>> +  There are several different mechanisms provided for communicating between VMs.
>> +
>> +- Virtual platform:
>> +
>> +  Architectural devices such as interrupt controllers and CPU timers are directly provided
>> +  by the hypervisor as well as core virtual platform devices and system APIs such as ARM PSCI.
>> +
>> +- Device Virtualization:
>> +
>> +  Para-virtualization of devices is supported using inter-VM communication.
>> +
>> +Architectures supported
>> +=======================
>> +AArch64 with a GIC
>> +
>> +Resources and Capabilities
>> +==========================
>> +
>> +Some services or resources provided by the Gunyah hypervisor are described to a virtual machine by
>> +capability IDs. For instance, inter-VM communication is performed with doorbells and message queues.
>> +Gunyah allows access to manipulate that doorbell via the capability ID. These devices are described
>> +in Linux as a struct gunyah_resource.
>> +
>> +High level management of these resources is performed by the resource manager VM. RM informs a
>> +guest VM about resources it can access through either the device tree or via guest-initiated RPC.
>> +
>> +For each virtual machine, Gunyah maintains a table of resources which can be accessed by that VM.
>> +An entry in this table is called a "capability" and VMs can only access resources via this
>> +capability table. Hence, virtual Gunyah devices are referenced by a "capability IDs" and not a
>> +"resource IDs". A VM can have multiple capability IDs mapping to the same resource. If 2 VMs have
>> +access to the same resource, they may not be using the same capability ID to access that resource
>> +since the tables are independent per VM.
>> +
>> +Resource Manager
>> +================
>> +
>> +The resource manager (RM) is a privileged application VM supporting the Gunyah Hypervisor.
>> +It provides policy enforcement aspects of the virtualization system. The resource manager can
>> +be treated as an extension of the Hypervisor but is separated to its own partition to ensure
>> +that the hypervisor layer itself remains small and secure and to maintain a separation of policy
>> +and mechanism in the platform. On arm64, RM runs at NS-EL1 similar to other virtual machines.
>> +
>> +Communication with the resource manager from each guest VM happens with message-queue.rst. Details
>> +about the specific messages can be found in drivers/virt/gunyah/rsc_mgr.c
>> +
>> +::
>> +
>> +  +-------+   +--------+   +--------+
>> +  |  RM   |   |  VM_A  |   |  VM_B  |
>> +  +-.-.-.-+   +---.----+   +---.----+
>> +    | |           |            |
>> +  +-.-.-----------.------------.----+
>> +  | | \==========/             |    |
>> +  |  \========================/     |
>> +  |            Gunyah               |
>> +  +---------------------------------+
>> +
>> +The source for the resource manager is available at https://github.com/quic/gunyah-resource-manager.
>> +
>> +The resource manager provides the following features:
>> +
>> +- VM lifecycle management: allocating a VM, starting VMs, destruction of VMs
>> +- VM access control policy, including memory sharing and lending
>> +- Interrupt routing configuration
>> +- Forwarding of system-level events (e.g. VM shutdown) to owner VM
>> +
>> +When booting a virtual machine which uses a devicetree, resource manager overlays a
>> +/hypervisor node. This node can let Linux know it is running as a Gunyah guest VM,
>> +how to communicate with resource manager, and basic description and capabilities of
>> +this VM. See Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml for a description
>> +of this node.
> 
> The documentation LGTM.
> 
>> diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
>> new file mode 100644
>> index 000000000000..e130f124ed52
>> --- /dev/null
>> +++ b/Documentation/virt/gunyah/message-queue.rst
>> <snipped>...
>> +The diagram below shows how message queue works. A typical configuration involves
>> +2 message queues. Message queue 1 allows VM_A to send messages to VM_B. Message
>> +queue 2 allows VM_B to send messages to VM_A.
>> +
>> +1. VM_A sends a message of up to 1024 bytes in length. It raises a hypercall
>> +   with the message to inform the hypervisor to add the message to
>> +   message queue 1's queue.
>> +2. Gunyah raises the corresponding interrupt for VM_B when any of these happens:
>> +   a. gh_msgq_send has PUSH flag. Queue is immediately flushed. This is the typical case.
>> +   b. Explicility with gh_msgq_push command from VM_A.
>> +   c. Message queue has reached a threshold depth.
>> +3. VM_B calls gh_msgq_recv and Gunyah copies message to requested buffer.
>> +
> 
> The nested list above should be separated with blank lines to be
> rendered properly:
> 
> ---- >8 ----
> 
> diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
> index e130f124ed525a..afaad99db215e6 100644
> --- a/Documentation/virt/gunyah/message-queue.rst
> +++ b/Documentation/virt/gunyah/message-queue.rst
> @@ -20,9 +20,11 @@ queue 2 allows VM_B to send messages to VM_A.
>      with the message to inform the hypervisor to add the message to
>      message queue 1's queue.
>   2. Gunyah raises the corresponding interrupt for VM_B when any of these happens:
> +
>      a. gh_msgq_send has PUSH flag. Queue is immediately flushed. This is the typical case.
>      b. Explicility with gh_msgq_push command from VM_A.
>      c. Message queue has reached a threshold depth.
> +
>   3. VM_B calls gh_msgq_recv and Gunyah copies message to requested buffer.
>   
>   For VM_B to send a message to VM_A, the process is identical, except that hypercalls
> 
> Thanks.
> 

Thanks! Applied for next version.

