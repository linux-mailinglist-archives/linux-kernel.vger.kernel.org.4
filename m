Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1398C733604
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344106AbjFPQck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343945AbjFPQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:32:37 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FBF30F9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:32:33 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-77797beb42dso29908939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686933152; x=1689525152;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T70S4p3oZUEDBszWfA2XZy9LbyQkQYYiduD+KBCp0eQ=;
        b=ksL3q0UiAJkGbNcSjze6BmE2a3czvkFhMqE/fFHyfTjqvllwF9P6no19Nk03X1p3qd
         vTOO8HF9Z4844db4Gdk6fH/omBRglhtekSLdwb2CpoO9gbssSxnb7GvrNne0aSbxPfJu
         SoeKNLEcolWXQaru2gbpU4AfmbZ/b+7ia88ow9BP25ON7xdc8uQB+IcVITKB8GhcdggX
         waSbXkkj8+zBlAdsHKGZqJne58EMOE+jt8hnH8bBn2ia7Wl2zW6yrm5V99XjLAbCaNNu
         8jS2cr/kQqz9EpdR48M27olB2TtaY7sbIW0y8CrML6TCtQE2ldbag6RdvyRIyxcVKop4
         tXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686933152; x=1689525152;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T70S4p3oZUEDBszWfA2XZy9LbyQkQYYiduD+KBCp0eQ=;
        b=DS8TT8wGL/ozE1n1bKQ7W8XmwlEbLm4RmyERpSQ/3pMJptGXg+0fmL4qKbEMYqWHDW
         L+Pma8Dc2xTKmU7nvdf9QBHKSc+hfckuzV8CnuGMtFj4aGToHNmrDc8+xG6ovLhsRl1T
         nTTj8548UfDXled0MjUEJe7muWkBbanCXwpoDekJPhnfGQl3nHLU8y0mmbZB3ctZ/8U2
         7eFLz9geldRDgvoCwG2RnBjXwYHoyovp1TT3ayNQQHMCFF8rm0WgJTpK7tgVux0Q9hWJ
         HOF1Nqi3Zlz2KIsGOi+LOhcI+sjn3VRH3jVmEk6qDTyS33Wgndh/mO8892xfMo211muO
         Ajnw==
X-Gm-Message-State: AC+VfDywHLarmLgQnbF14J5WBaDgfAheo8hkSvIH8TDP1QzR9g6WuS2P
        +ani5McypgaBhMVyGi441O0sbw==
X-Google-Smtp-Source: ACHHUZ41TujZiCzNnupLwhguPo3iiEyvDvocqHlURoyUC7i3AebOU9GuRvKlFvXisn6KDCcs6UagAw==
X-Received: by 2002:a5e:8d0e:0:b0:774:e2b4:5d6e with SMTP id m14-20020a5e8d0e000000b00774e2b45d6emr2826192ioj.14.1686933152229;
        Fri, 16 Jun 2023 09:32:32 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id z3-20020a6b6503000000b007749b2d1a6fsm6754393iob.32.2023.06.16.09.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:32:31 -0700 (PDT)
Message-ID: <cb1d4b05-26f3-22f5-ce8e-813d255cda8a@linaro.org>
Date:   Fri, 16 Jun 2023 11:32:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v14 01/25] docs: gunyah: Introduce Gunyah Hypervisor
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-2-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230613172054.3959700-2-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 12:20 PM, Elliot Berman wrote:
> Gunyah is an open-source Type-1 hypervisor developed by Qualcomm. It
> does not depend on any lower-privileged OS/kernel code for its core
> functionality. This increases its security and can support a smaller
> trusted computing based when compared to Type-2 hypervisors.

s/based/base/

> 
> Add documentation describing the Gunyah hypervisor and the main
> components of the Gunyah hypervisor which are of interest to Linux
> virtualization development.
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

I have some questions and comments.  But I trust that you
can answer them and update your patch in a reasonable way
to address what I say.  So... please consider these things,
and update as you see fit.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   Documentation/virt/gunyah/index.rst         | 113 ++++++++++++++++++++
>   Documentation/virt/gunyah/message-queue.rst |  63 +++++++++++
>   Documentation/virt/index.rst                |   1 +
>   3 files changed, 177 insertions(+)
>   create mode 100644 Documentation/virt/gunyah/index.rst
>   create mode 100644 Documentation/virt/gunyah/message-queue.rst
> 
> diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
> new file mode 100644
> index 0000000000000..74aa345e0a144
> --- /dev/null
> +++ b/Documentation/virt/gunyah/index.rst
> @@ -0,0 +1,113 @@
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
> +  A scheduler for virtual CPUs (vCPUs) on physical CPUs enables time-sharing
> +  of the CPUs. Gunyah supports two models of scheduling:
> +
> +    1. "Behind the back" scheduling in which Gunyah hypervisor schedules vCPUS on its own.

s/VCPUS/VCPUs/

> +    2. "Proxy" scheduling in which a delegated VM can donate part of one of its vCPU slice
> +       to another VM's vCPU via a hypercall.

This might sound dumb, but can there be more vCPUs than there
are physical CPUs?  Is a vCPU *tied* to a particular physical
CPU, or does it just indicate that a VM has one abstracted CPU
available to use--and any available physical CPU core can
implement it (possibly changing between time slices)?

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
> +Gunyah allows access to manipulate that doorbell via the capability ID. These resources are
> +described in Linux as a struct gh_resource.
> +
> +High level management of these resources is performed by the resource manager VM. RM informs a
> +guest VM about resources it can access through either the device tree or via guest-initiated RPC.
> +
> +For each virtual machine, Gunyah maintains a table of resources which can be accessed by that VM.
> +An entry in this table is called a "capability" and VMs can only access resources via this
> +capability table. Hence, virtual Gunyah resources are referenced by a "capability IDs" and not
> +"resource IDs". If 2 VMs have access to the same resource, they might not be using the same
> +capability ID to access that resource since the capability tables are independent per VM.
> +
> +Resource Manager
> +================
> +
> +The resource manager (RM) is a privileged application VM supporting the Gunyah Hypervisor.
> +It provides policy enforcement aspects of the virtualization system. The resource manager can
> +be treated as an extension of the Hypervisor but is separated to its own partition to ensure
> +that the hypervisor layer itself remains small and secure and to maintain a separation of policy
> +and mechanism in the platform. RM runs at arm64 NS-EL1 similar to other virtual machines.
> +
> +Communication with the resource manager from each guest VM happens with message-queue.rst. Details
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
> +When booting a virtual machine which uses a devicetree such as Linux, resource manager overlays a
> +/hypervisor node. This node can let Linux know it is running as a Gunyah guest VM,
> +how to communicate with resource manager, and basic description and capabilities of

Maybe:

This node lets Linux know it is running as a Gunyah guest VM.
It provides a basic description and capabilities of the VM,
as well as information required to communicate with the resource
manager.

> +this VM. See Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml for a description
> +of this node.
> diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
> new file mode 100644
> index 0000000000000..b352918ae54b4
> --- /dev/null
> +++ b/Documentation/virt/gunyah/message-queue.rst
> @@ -0,0 +1,63 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Message Queues
> +==============
> +Message queue is a simple low-capacity IPC channel between two VMs. It is

I don't know what the "capacity" of an IPC channel is.  But
that's OK I guess; it's sort of descriptive.

> +intended for sending small control and configuration messages. Each message
> +queue is unidirectional, so a full-duplex IPC channel requires a pair of queues.
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
> +   message queue 1's queue. The hypervisor copies memory into the internal
> +   message queue representation; the memory doesn't need to be shared between
> +   VM_A and VM_B.
> +
> +2. Gunyah raises the corresponding interrupt for VM_B (Rx vIRQ) when any of
> +   these happens:
> +
> +   a. gh_msgq_send() has PUSH flag. Queue is immediately flushed. This is the typical case.
> +   b. Explicility with gh_msgq_push command from VM_A.

s/Explicility/Explicitly/

Is gh_msgq_send() a function and gh_msgq_push a "command" or
something?  Why the difference in parentheses?  (Pick a
convention and follow it.)

Does "Queue is flushed" mean "VM_B is interrupted"?

VM_A calls gh_msgq_push, and that causes the VM_B interrupt to
be signaled?

I'm being a little picky but I think these descriptions could be
improved a bit.

> +   c. Message queue has reached a threshold depth.
> +
> +3. VM_B calls gh_msgq_recv() and Gunyah copies message to requested buffer.

It sure would be nice if all this didn't have to be copied
twice.  But I recognize the copies ensure isolation.

> +
> +4. Gunyah buffers messages in the queue. If the queue became full when VM_A added a message,
> +   the return values for gh_msgq_send() include a flag that indicates the queue is full.
> +   Once VM_B receives the message and, thus, there is space in the queue, Gunyah
> +   will raise the Tx vIRQ on VM_A to indicate it can continue sending messages.

Does the Tx vIRQ on VM_A fire after *every* message is sent,
or only when the state of the queue goes from "full" to "not"?
(Looking at patch 6 it looks like the latter.)

If it's signaled after every message is sent, does it
indicate that the message has been *received* by VM_B
(versus just received and copied by Gunyah)?

> +
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
> index 7fb55ae08598d..15869ee059b35 100644
> --- a/Documentation/virt/index.rst
> +++ b/Documentation/virt/index.rst
> @@ -16,6 +16,7 @@ Virtualization Support
>      coco/sev-guest
>      coco/tdx-guest
>      hyperv/index
> +   gunyah/index
>   
>   .. only:: html and subproject
>   

