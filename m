Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E2A663307
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbjAIVfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbjAIVee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:34:34 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3792C65CE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:34:08 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id v65so942217ioe.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=huMYy70lFxriRC2q1A/wWNqoYByrLQQfgObb+HMnC2A=;
        b=fxSsG+zgzWcoMkdaiH8/RB0JAV3m2lb8DT2JuYvUUA0lz9XcpsnS8tTtaOUeeNaoeC
         Fl+O+odQB9Pjtlfnz2womrA7AKQVWvk8ywhSJZqkKGp2EJryhIeuD8wGluV3Ma0kS/9g
         Rsn0La9yz8VhuRtIVsLxuYt6HEQo7tTTdE6XlGk9Qv6Conwq6T6TOH7qbf1FjgxyrZZW
         2IQdhLWuaaaEj90WwGuRQqaXSeGfoi/v/mVUz1us90NmK0gYs267PEU45LKYg8ZyUtfb
         GJwJnjTdwgFFmxqqG8qS6oMtNNJ0BzS7deRYWEbmM0FlPEM3DtnZOa469a0Kh4m5wPXI
         m/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huMYy70lFxriRC2q1A/wWNqoYByrLQQfgObb+HMnC2A=;
        b=zAQflwA2XCDs7tyyhVinxOE+wWZczvU7pAzNEoDuRH1GbiqzGMyBx9dyr3FlMHM1yg
         gSU78VTZZbS0qr1FePtfqdgJ1lHOWlbXb3jcOTKgWcmvO3F/HaTEwHKqGJdpVUVp8b2/
         XW3nU0FP1tYTEiMst29MWgyQ3MM6cLNcG7u5bdYXjxiFGk8IXHxnM7ikxxnz8dU1E+0M
         LXa3qh/TfGmv9uHlHl7NbGxnRf8b/Ao5kpuxjSwyNDw6mKhZfIznd4zO7k2A2vaSmixi
         P8H1YHQ4I2pO1ccTjo9MFICwtVgzKLEymey4ysFtIyS03JGeVMx336lNDdjOskeJKA7B
         LW6Q==
X-Gm-Message-State: AFqh2kqXX0GimIyPEp3VnnERi6EHHxxs/0G5ZSNhq2n4EzABmznqfGxM
        A7DMKdC3vfq2Li38JRyw3LuT0Q==
X-Google-Smtp-Source: AMrXdXupMN05WIUaqLUZx/szhBy89RcLba5z69JFx7cRJ/EYQE/r21S5RYjGEjD4nr+5Tw9H6nmeDA==
X-Received: by 2002:a5e:c107:0:b0:6e0:256d:547a with SMTP id v7-20020a5ec107000000b006e0256d547amr47694461iol.14.1673300047416;
        Mon, 09 Jan 2023 13:34:07 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id p15-20020a0566022b0f00b006e00556dc9esm3548191iov.16.2023.01.09.13.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 13:34:07 -0800 (PST)
Message-ID: <af7b5726-c244-f0c6-7632-1a4bf72b53ef@linaro.org>
Date:   Mon, 9 Jan 2023 15:34:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v8 01/28] docs: gunyah: Introduce Gunyah Hypervisor
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-2-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20221219225850.2397345-2-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/22 4:58 PM, Elliot Berman wrote:
> Gunyah is an open-source Type-1 hypervisor developed by Qualcomm. It
> does not depend on any lower-privileged OS/kernel code for its core
> functionality. This increases its security and can support a smaller
> trusted computing based when compared to Type-2 hypervisors.
> 
> Add documentation describing the Gunyah hypervisor and the main
> components of the Gunyah hypervisor which are of interest to Linux
> virtualization development.
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   Documentation/virt/gunyah/index.rst         | 114 ++++++++++++++++++++
>   Documentation/virt/gunyah/message-queue.rst |  56 ++++++++++
>   Documentation/virt/index.rst                |   1 +
>   MAINTAINERS                                 |   7 ++
>   4 files changed, 178 insertions(+)
>   create mode 100644 Documentation/virt/gunyah/index.rst
>   create mode 100644 Documentation/virt/gunyah/message-queue.rst
> 
> diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
> new file mode 100644
> index 000000000000..fbadbdd24da7
> --- /dev/null
> +++ b/Documentation/virt/gunyah/index.rst
> @@ -0,0 +1,114 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +Gunyah Hypervisor
> +=================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   message-queue
> +
> +Gunyah is a Type-1 hypervisor which is independent of any OS kernel, and runs in
> +a higher CPU privilege level. It does not depend on any lower-privileged operating system
> +for its core functionality. This increases its security and can support a much smaller
> +trusted computing base than a Type-2 hypervisor.
> +
> +Gunyah is an open source hypervisor. The source repo is available at
> +https://github.com/quic/gunyah-hypervisor.
> +
> +Gunyah provides these following features.
> +
> +- Scheduling:
> +
> +  A scheduler for virtual CPUs (vCPUs) on physical CPUs and enables time-sharing

s/and enables/enables/  (?)

> +  of the CPUs. Gunyah supports two models of scheduling:
> +
> +    1. "Behind the back" scheduling in which Gunyah hypervisor schedules vCPUS on its own.
> +    2. "Proxy" scheduling in which a delegated VM can donate part of one of its vCPU slice
> +       to another VM's vCPU via a hypercall.
> +
> +- Memory Management:
> +
> +  APIs handling memory, abstracted as objects, limiting direct use of physical
> +  addresses. Memory ownership and usage tracking of all memory under its control.
> +  Memory partitioning between VMs is a fundamental security feature.
> +
> +- Interrupt Virtualization:
> +
> +  Uses CPU hardware interrupt virtualization capabilities. Interrupts are handled
> +  in the hypervisor and routed to the assigned VM.
> +
> +- Inter-VM Communication:
> +
> +  There are several different mechanisms provided for communicating between VMs.
> +
> +- Virtual platform:
> +
> +  Architectural devices such as interrupt controllers and CPU timers are directly provided
> +  by the hypervisor as well as core virtual platform devices and system APIs such as ARM PSCI.
> +
> +- Device Virtualization:
> +
> +  Para-virtualization of devices is supported using inter-VM communication.
> +
> +Architectures supported
> +=======================
> +AArch64 with a GIC
> +
> +Resources and Capabilities
> +==========================
> +
> +Some services or resources provided by the Gunyah hypervisor are described to a virtual machine by
> +capability IDs. For instance, inter-VM communication is performed with doorbells and message queues.
> +Gunyah allows access to manipulate that doorbell via the capability ID. These devices are described

s/devices/resources/

> +in Linux as a struct gunyah_resource.
> +
> +High level management of these resources is performed by the resource manager VM. RM informs a

s/resource manager VM/resource manager VM (RM)/

> +guest VM about resources it can access through either the device tree or via guest-initiated RPC.
> +
> +For each virtual machine, Gunyah maintains a table of resources which can be accessed by that VM.
> +An entry in this table is called a "capability" and VMs can only access resources via this
> +capability table. Hence, virtual Gunyah devices are referenced by a "capability IDs" and not a

s/devices/resources/
s/and not a/and not/

> +"resource IDs". A VM can have multiple capability IDs mapping to the same resource. If 2 VMs have
> +access to the same resource, they may not be using the same capability ID to access that resource

Does "may not be using the same capability ID" mean they "shall not",
or "are permitted not to"?

> +since the tables are independent per VM.
> +
> +Resource Manager
> +================
> +
> +The resource manager (RM) is a privileged application VM supporting the Gunyah Hypervisor.
> +It provides policy enforcement aspects of the virtualization system. The resource manager can
> +be treated as an extension of the Hypervisor but is separated to its own partition to ensure
> +that the hypervisor layer itself remains small and secure and to maintain a separation of policy
> +and mechanism in the platform. On arm64, RM runs at NS-EL1 similar to other virtual machines.

This only runs on arm64, right?  Maybe "RM runs at arm64 NS-EL1..."
> +
> +Communication with the resource manager from each guest VM happens with message-queue.rst. Details

Is "message-queue.rst" supposed to be a reference to that other document?

> +about the specific messages can be found in drivers/virt/gunyah/rsc_mgr.c
> +
> +::
> +
> +  +-------+   +--------+   +--------+
> +  |  RM   |   |  VM_A  |   |  VM_B  |
> +  +-.-.-.-+   +---.----+   +---.----+
> +    | |           |            |
> +  +-.-.-----------.------------.----+
> +  | | \==========/             |    |
> +  |  \========================/     |
> +  |            Gunyah               |
> +  +---------------------------------+
> +
> +The source for the resource manager is available at https://github.com/quic/gunyah-resource-manager.
> +
> +The resource manager provides the following features:
> +
> +- VM lifecycle management: allocating a VM, starting VMs, destruction of VMs
> +- VM access control policy, including memory sharing and lending
> +- Interrupt routing configuration
> +- Forwarding of system-level events (e.g. VM shutdown) to owner VM
> +
> +When booting a virtual machine which uses a devicetree, resource manager overlays a

"When booting Linux in a virtual machine..." ?

> +/hypervisor node. This node can let Linux know it is running as a Gunyah guest VM,
> +how to communicate with resource manager, and basic description and capabilities of
> +this VM. See Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml for a description
> +of this node.
> diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
> new file mode 100644
> index 000000000000..be4ab289236a
> --- /dev/null
> +++ b/Documentation/virt/gunyah/message-queue.rst
> @@ -0,0 +1,56 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Message Queues
> +==============
> +Message queue is a simple low-capacity IPC channel between two VMs. It is
> +intended for sending small control and configuration messages. Each message
> +queue object is unidirectional, so a full-duplex IPC channel requires a pair of
> +objects.

The wording here makes it seem like "message queue" might be
distinct from a "message queue object" but I think they're the
same thing (right?).

> +
> +Messages can be up to 240 bytes in length. Longer messages require a further
> +protocol on top of the message queue messages themselves. For instance, communication
> +with the resource manager adds a header field for sending longer messages via multiple
> +message fragments.
> +
> +The diagram below shows how message queue works. A typical configuration involves
> +2 message queues. Message queue 1 allows VM_A to send messages to VM_B. Message
> +queue 2 allows VM_B to send messages to VM_A.
> +
> +1. VM_A sends a message of up to 240 bytes in length. It raises a hypercall
> +   with the message to inform the hypervisor to add the message to
> +   message queue 1's queue.
> +
> +2. Gunyah raises the corresponding interrupt for VM_B when any of these happens:
> +
> +   a. gh_msgq_send has PUSH flag. Queue is immediately flushed. This is the typical case.
> +   b. Explicility with gh_msgq_push command from VM_A.
> +   c. Message queue has reached a threshold depth.
> +
> +3. VM_B calls gh_msgq_recv and Gunyah copies message to requested buffer.

So VM_B *responds* to the Rx vIRQ by calling gh_msgq_recv() and
supplying a buffer in which Gunyah copies the message content?

I guess my point is, can VM_B post a receive buffer in advance of
a message Rx vIRQ being delivered?

You don't describe what a Tx vIRQ does.  When does it fire?

					-Alex

> +For VM_B to send a message to VM_A, the process is identical, except that hypercalls
> +reference message queue 2's capability ID. Each message queue has its own independent
> +vIRQ: two TX message queues will have two vIRQs (and two capability IDs).
> +
> +::
> +
> +      +---------------+         +-----------------+         +---------------+
> +      |      VM_A     |         |Gunyah hypervisor|         |      VM_B     |
> +      |               |         |                 |         |               |
> +      |               |         |                 |         |               |
> +      |               |   Tx    |                 |         |               |
> +      |               |-------->|                 | Rx vIRQ |               |
> +      |gh_msgq_send() | Tx vIRQ |Message queue 1  |-------->|gh_msgq_recv() |
> +      |               |<------- |                 |         |               |
> +      |               |         |                 |         |               |
> +      | Message Queue |         |                 |         | Message Queue |
> +      | driver        |         |                 |         | driver        |
> +      |               |         |                 |         |               |
> +      |               |         |                 |         |               |
> +      |               |         |                 |   Tx    |               |
> +      |               | Rx vIRQ |                 |<--------|               |
> +      |gh_msgq_recv() |<--------|Message queue 2  | Tx vIRQ |gh_msgq_send() |
> +      |               |         |                 |-------->|               |
> +      |               |         |                 |         |               |
> +      |               |         |                 |         |               |
> +      +---------------+         +-----------------+         +---------------+
> diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
> index 2f1cffa87b1b..418d540f5484 100644
> --- a/Documentation/virt/index.rst
> +++ b/Documentation/virt/index.rst
> @@ -15,6 +15,7 @@ Linux Virtualization Support
>      acrn/index
>      coco/sev-guest
>      hyperv/index
> +   gunyah/index
>   
>   .. only:: html and subproject
>   
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 886d3f69ee64..1dd8f58d6e01 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8934,6 +8934,13 @@ L:	linux-efi@vger.kernel.org
>   S:	Maintained
>   F:	block/partitions/efi.*
>   
> +GUNYAH HYPERVISOR DRIVER
> +M:	Elliot Berman <quic_eberman@quicinc.com>
> +M:	Murali Nalajala <quic_mnalajal@quicinc.com>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Supported
> +F:	Documentation/virt/gunyah/
> +
>   HABANALABS PCI DRIVER
>   M:	Oded Gabbay <ogabbay@kernel.org>
>   S:	Supported

