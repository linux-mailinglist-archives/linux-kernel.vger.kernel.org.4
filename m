Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823946A13E7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBWXmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBWXmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:42:02 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C41A2D179
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:41:58 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id ko13so15554524plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+lqxjm0+kKvGCHCvbCD4t+kuH1zTIskid0IPJ7eZkw=;
        b=EJZTNr5h/wNKgKRS64pBO/5V4ChAnia9P42JWAAFXaw3feJfeB1Jk6JQeMudWl0ieF
         Irgq86pwcQS2rFeRSTfW4URv/fsH9yLByJi0+vCkZ2Als/22/b3EgyvQ/6t8e0J+F2AK
         /DzSjx3KCta7nT7GTlViD+VVHIf29Iu+TrpL5yl1f52e339WnFl82MGeVCCtjZgM1cA3
         BtRty8xyy9jEP8xh+zZv5VhfBDXkFznU5fCXOFw1Jw8qVCyU7ZrBbC2j7dlmSUG2Ct1b
         Cwxj6F6cybKwoxUXtz2ahkyAHiJAZz1GhQ8YgvPNA+uiTu8cR5ZZRKvFkb33qVpTbPHa
         3S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+lqxjm0+kKvGCHCvbCD4t+kuH1zTIskid0IPJ7eZkw=;
        b=AADPVWKtl6hj8sSqOu/ARfxdsdleiArDBTBOOjhIuzDvJLdxKMn4GrsRitRo3ScYOX
         Hi+DMGDoZKoNbCerV1uxVG29Wb9RWtonRiyd4mkVEaHvL8NVnVnnipwFrKn+Ht7hqoG0
         I5oGwcwjgikd+WafBLvTNfan+hOnK6fblWokZgIzSKN61St0rF55R/A4OVO1st19vhkk
         CTMWYkUEoR4NpOxwf0WYAOVlamAZfYYpf80F+YRACJuzOJGz1dY2NxA9jXo68F/siK0r
         ax2sVLxgYoPx9oW7aL3VLF/uhwJIFP7eMBOVTRj9coBHXAqV4GjLZhgmWXlgKnWQ0m8O
         9p5A==
X-Gm-Message-State: AO0yUKXRC5C2unMvkCNyq6X7Gv6qKLRao7efZZW2chR3ws+7WMaRVzHp
        whoyNqk6QdF2K2IW8noibrqj6g==
X-Google-Smtp-Source: AK7set/IG4130KCWLoU6ORwXcepFD/YDxbZLb410AmyaHu8UWBbwWVWerDn8d+UP8xsqZTQT6FycrQ==
X-Received: by 2002:a17:902:e1cc:b0:19c:9420:6236 with SMTP id t12-20020a170902e1cc00b0019c94206236mr8569592pla.22.1677195717615;
        Thu, 23 Feb 2023 15:41:57 -0800 (PST)
Received: from [10.211.55.3] (c-73-221-130-71.hsd1.wa.comcast.net. [73.221.130.71])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b00194c90ca320sm7699073pld.204.2023.02.23.15.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 15:41:57 -0800 (PST)
Message-ID: <41df9fd2-9277-b6e8-7961-509da295dcb8@linaro.org>
Date:   Thu, 23 Feb 2023 17:41:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 01/26] docs: gunyah: Introduce Gunyah Hypervisor
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214211229.3239350-2-quic_eberman@quicinc.com>
From:   Alex Elder <alex.elder@linaro.org>
In-Reply-To: <20230214211229.3239350-2-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 3:12 PM, Elliot Berman wrote:
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
>   Documentation/virt/gunyah/index.rst         | 113 ++++++++++++++++++++
>   Documentation/virt/gunyah/message-queue.rst |  61 +++++++++++
>   Documentation/virt/index.rst                |   1 +
>   3 files changed, 175 insertions(+)
>   create mode 100644 Documentation/virt/gunyah/index.rst
>   create mode 100644 Documentation/virt/gunyah/message-queue.rst
> 
> diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
> new file mode 100644
> index 000000000000..45adbbc311db
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
> +Gunyah allows access to manipulate that doorbell via the capability ID. These resources are
> +described in Linux as a struct gunyah_resource.
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
> +this VM. See Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml for a description
> +of this node.
> diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
> new file mode 100644
> index 000000000000..0667b3eb1ff9
> --- /dev/null
> +++ b/Documentation/virt/gunyah/message-queue.rst
> @@ -0,0 +1,61 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Message Queues
> +==============
> +Message queue is a simple low-capacity IPC channel between two VMs. It is
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

Can you clarify that the message being sent is in the VM's *own*
memory/  Maybe this is clear, but the message doesn't have to (for
example) be located in shared memory.  The original message is
copied into message queue buffers in order to be transferred.

> +   with the message to inform the hypervisor to add the message to
> +   message queue 1's queue.
> +
> +2. Gunyah raises the corresponding interrupt for VM_B (Rx vIRQ) when any of
> +   these happens:
> +
> +   a. gh_msgq_send has PUSH flag. Queue is immediately flushed. This is the typical case.

Below you use gh_msgq_send() (with parentheses).  I prefer that,
but whatever you do, do it consistently.

> +   b. Explicility with gh_msgq_push command from VM_A.
> +   c. Message queue has reached a threshold depth.
> +
> +3. VM_B calls gh_msgq_recv and Gunyah copies message to requested buffer.
> +
> +4. Gunyah buffers messages in the queue. If the queue became full when VM_A added a message,
> +   the return values for gh_msgq_send() include a flag that indicates the queue is full.
> +   Once VM_B receives the message and, thus, there is space in the queue, Gunyah
> +   will raise the Tx vIRQ on VM_A to indicate it can continue sending messages.
> +
> +For VM_B to send a message to VM_A, the process is identical, except that hypercalls
> +reference message queue 2's capability ID. Each message queue has its own independent
> +vIRQ: two TX message queues will have two vIRQs (and two capability IDs).

Can a sender determine when a message has been delivered?
Does the TX vIRQ indicate only that the messaging system
has processed the message (taken it and queued it), but
says nothing about it being delivered/accepted/received?

					-Alex

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
> index 7fb55ae08598..15869ee059b3 100644
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

