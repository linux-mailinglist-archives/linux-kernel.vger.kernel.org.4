Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC8663304
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbjAIVeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbjAIVeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:34:15 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0BB5F79
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:34:04 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e129so5241140iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Ka/Jn0Y/XPOMWheZjCG9ShMUcu/j3iWF+OIwQZvVg8=;
        b=UbESKbcalsTPiNqge5UrtFZucQfMThjcx8kl6oVC/6KxPLLOea2euRHAw/7vL+x9PL
         iJc8dbgOxUtsgBKunb2s6rPWFh1YmkOBQ8qUkcpLQPr5O/ULtWODG/JtVM3z1frJ43jv
         BSwd6r+aVGyYtfKd1iLMGUIYaCiXJWWRdur8ryRKNOVQNA3ceYHn6IU10XWPSANf80mo
         KJrBdHXdAA15hFezJaPOskkvHhJugyBJu0tYP5efE4/UzbtMYqCo+gWDB8laJB8AgLU/
         n54RAmapzU03Ce9lLZrepWe+Kknnj0M5OrfW89XSKE5eMJPL2SU+RB+fuaivUexA87e9
         16kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ka/Jn0Y/XPOMWheZjCG9ShMUcu/j3iWF+OIwQZvVg8=;
        b=2v9zYSzfmertdg7kTuvZ2f4HBr/N+i+IkaWqyEuafPMJGATxOkcpoXf58gcztncIrB
         Xt3Ekyhym8KA8LvWV/OAULxDbwZMZ6jjZmV9tAZ5QS79w5Q5GORR85vez5JT/E2eq/YH
         POUmuZBQOnOhiPankJcEf294uwRaG2ojc8IifsJ53lFWYyNiHP6rSD6FlE1WIgk30Af5
         C+GAFvQ7hzdsKFSJMWjSSMqq0cTuZl4kGSiOW8osveXsdyX5vQDSJ6djEwoI6XlvIFzm
         rD5v0DcQpt+pJcJSxzKum3ixpVsS6yFnVHJTD4uM5XM064r/eX1xwFMUuKcrY3jjWgn2
         8YGw==
X-Gm-Message-State: AFqh2kqewLpl4JbYKMr8eiOFhkXqsOnZIbIH2ucFBe6cycE1xVPtojFH
        yoRIbx5stUXBESEJczbZFAeLtQ==
X-Google-Smtp-Source: AMrXdXtvj1RMTG0kTi1Yo/9pvzVobUp3K575gmGtVKG5IP2MCVMM6ds5EzQjfXItUwxOoqGujqPCbQ==
X-Received: by 2002:a6b:5a06:0:b0:6ed:13bb:4f0e with SMTP id o6-20020a6b5a06000000b006ed13bb4f0emr40869141iob.17.1673300043853;
        Mon, 09 Jan 2023 13:34:03 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id n2-20020a6bf602000000b006e02c489089sm3524697ioh.32.2023.01.09.13.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 13:34:03 -0800 (PST)
Message-ID: <83b6dbc2-01da-04b6-64ec-9a69fd5c4c89@linaro.org>
Date:   Mon, 9 Jan 2023 15:34:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v8 00/28] Drivers for gunyah hypervisor
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
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
Content-Language: en-US
In-Reply-To: <20221219225850.2397345-1-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/22 4:58 PM, Elliot Berman wrote:
> Gunyah is a Type-1 hypervisor independent of any
> high-level OS kernel, and runs in a higher CPU privilege level. It does
> not depend on any lower-privileged OS kernel/code for its core
> functionality. This increases its security and can support a much smaller
> trusted computing base than a Type-2 hypervisor.
> 
> Gunyah is an open source hypervisor. The source repo is available at
> https://github.com/quic/gunyah-hypervisor.

Can you provide any history about the hypervisor code itself?
Was it publicly reviewed?  Has it been reviewed by anyone in
the Linux kernel community, who might have some useful input
on it?

> The diagram below shows the architecture.
> 
> ::
> 
>           VM A                    VM B
>       +-----+ +-----+  | +-----+ +-----+ +-----+
>       |     | |     |  | |     | |     | |     |
>   EL0 | APP | | APP |  | | APP | | APP | | APP |
>       |     | |     |  | |     | |     | |     |
>       +-----+ +-----+  | +-----+ +-----+ +-----+
>   ---------------------|-------------------------
>       +--------------+ | +----------------------+
>       |              | | |                      |
>   EL1 | Linux Kernel | | |Linux kernel/Other OS |   ...
>       |              | | |                      |
>       +--------------+ | +----------------------+
>   --------hvc/smc------|------hvc/smc------------
>       +----------------------------------------+
>       |                                        |
>   EL2 |            Gunyah Hypervisor           |
>       |                                        |
>       +----------------------------------------+
> 
> Gunyah provides these following features.
> 
> - Threads and Scheduling: The scheduler schedules virtual CPUs (VCPUs) on
> physical CPUs and enables time-sharing of the CPUs.
> - Memory Management: Gunyah tracks memory ownership and use of all memory
> under its control. Memory partitioning between VMs is a fundamental
> security feature.
> - Interrupt Virtualization: All interrupts are handled in the hypervisor
> and routed to the assigned VM.
> - Inter-VM Communication: There are several different mechanisms provided
> for communicating between VMs.
> - Device Virtualization: Para-virtualization of devices is supported using
> inter-VM communication. Low level system features and devices such as
> interrupt controllers are supported with emulation where required.
> 
> This series adds the basic framework for detecting that Linux is running
> under Gunyah as a virtual machine, communication with the Gunyah Resource
> Manager, and a virtual machine manager capable of launching virtual machines.
> 
> Patches 21-28 are presently intended to be submitted separately and are included
> for initial RFC. These patches introudce "VM function" framework to expose further
> interfaces to interact with Gunyah Virtual Machines. With all 28 patches, it is
> possible to create a Gunyah VM supporting virtio.

I'm not a virtualization expert, and it's likely some of my
comments demonstrate that...

You're going to need to update your copyright dates to include
2023 now.

I haven't looked at the earlier reviews; perhaps the RFC stuff
was requested.  I'm sure it's useful to see that but it doesn't
seem directly helpful if your goal is to get this code upstream.

At this point I've reviewed only through patch 9.  I currently
have smallish blocks of time and I don't want to hold back my
feedback for too long.

					-Alex

> Changes in v8:
>   - Treat VM manager as a library of RM
>   - Add patches 21-28 as RFC to support proxy-scheduled vCPUs and necessary bits to support virtio
>     from Gunyah userspace
> 
> Changes in v7: https://lore.kernel.org/all/20221121140009.2353512-1-quic_eberman@quicinc.com/
>   - Refactor to remove gunyah RM bus
>   - Refactor allow multiple RM device instances
>   - Bump UAPI to start at 0x0
>   - Refactor QCOM SCM's platform hooks to allow CONFIG_QCOM_SCM=Y/CONFIG_GUNYAH=M combinations
> 
> Changes in v6: https://lore.kernel.org/all/20221026185846.3983888-1-quic_eberman@quicinc.com/
>   - *Replace gunyah-console with gunyah VM Manager*
>   - Move include/asm-generic/gunyah.h into include/linux/gunyah.h
>   - s/gunyah_msgq/gh_msgq/
>   - Minor tweaks and documentation tidying based on comments from Jiri, Greg, Arnd, Dmitry, and Bagas.
> 
> Changes in v5: https://lore.kernel.org/all/20221011000840.289033-1-quic_eberman@quicinc.com/
>   - Dropped sysfs nodes
>   - Switch from aux bus to Gunyah RM bus for the subdevices
>   - Cleaning up RM console
> 
> Changes in v4: https://lore.kernel.org/all/20220928195633.2348848-1-quic_eberman@quicinc.com/
>   - Tidied up documentation throughout based on questions/feedback received
>   - Switched message queue implementation to use mailboxes
>   - Renamed "gunyah_device" as "gunyah_resource"
> 
> Changes in v3: https://lore.kernel.org/all/20220811214107.1074343-1-quic_eberman@quicinc.com/
>   - /Maintained/Supported/ in MAINTAINERS
>   - Tidied up documentation throughout based on questions/feedback received
>   - Moved hypercalls into arch/arm64/gunyah/; following hyper-v's implementation
>   - Drop opaque typedefs
>   - Move sysfs nodes under /sys/hypervisor/gunyah/
>   - Moved Gunyah console driver to drivers/tty/
>   - Reworked gunyah_device design to drop the Gunyah bus.
> 
> Changes in v2: https://lore.kernel.org/all/20220801211240.597859-1-quic_eberman@quicinc.com/
>   - DT bindings clean up
>   - Switch hypercalls to follow SMCCC
> 
> v1: https://lore.kernel.org/all/20220223233729.1571114-1-quic_eberman@quicinc.com/
> 
> Elliot Berman (28):
>    docs: gunyah: Introduce Gunyah Hypervisor
>    dt-bindings: Add binding for gunyah hypervisor
>    gunyah: Common types and error codes for Gunyah hypercalls
>    arm64: smccc: Include alternative-macros.h
>    virt: gunyah: Add hypercalls to identify Gunyah
>    virt: gunyah: Identify hypervisor version
>    mailbox: Allow direct registration to a channel
>    virt: gunyah: msgq: Add hypercalls to send and receive messages
>    mailbox: Add Gunyah message queue mailbox
>    gunyah: rsc_mgr: Add resource manager RPC core
>    gunyah: rsc_mgr: Add VM lifecycle RPC
>    gunyah: vm_mgr: Introduce basic VM Manager
>    gunyah: rsc_mgr: Add RPC for sharing memory
>    gunyah: vm_mgr: Add/remove user memory regions
>    gunyah: vm_mgr: Add ioctls to support basic non-proxy VM boot
>    samples: Add sample userspace Gunyah VM Manager
>    gunyah: rsc_mgr: Add platform ops on mem_lend/mem_reclaim
>    firmware: qcom_scm: Use fixed width src vm bitmap
>    firmware: qcom_scm: Register Gunyah platform ops
>    docs: gunyah: Document Gunyah VM Manager
>    virt: gunyah: Translate gh_rm_hyp_resource into gunyah_resource
>    gunyah: vm_mgr: Add framework to add VM Functions
>    virt: gunyah: Add resource tickets
>    virt: gunyah: Add IO handlers
>    virt: gunyah: Add proxy-scheduled vCPUs
>    virt: gunyah: Add hypercalls for sending doorbell
>    virt: gunyah: Add irqfd interface
>    virt: gunyah: Add ioeventfd
> 
>   .../bindings/firmware/gunyah-hypervisor.yaml  |  82 ++
>   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>   Documentation/virt/gunyah/index.rst           | 115 +++
>   Documentation/virt/gunyah/message-queue.rst   |  64 ++
>   Documentation/virt/gunyah/vm-manager.rst      | 187 ++++
>   Documentation/virt/index.rst                  |   1 +
>   MAINTAINERS                                   |  13 +
>   arch/arm64/Kbuild                             |   1 +
>   arch/arm64/gunyah/Makefile                    |   1 +
>   arch/arm64/gunyah/gunyah_hypercall.c          | 157 ++++
>   arch/arm64/include/asm/gunyah.h               |  23 +
>   drivers/firmware/Kconfig                      |   2 +
>   drivers/firmware/qcom_scm.c                   | 107 ++-
>   drivers/mailbox/Kconfig                       |  10 +
>   drivers/mailbox/Makefile                      |   2 +
>   drivers/mailbox/gunyah-msgq.c                 | 229 +++++
>   drivers/mailbox/mailbox.c                     |  96 ++-
>   drivers/mailbox/omap-mailbox.c                |  18 +-
>   drivers/mailbox/pcc.c                         |  18 +-
>   drivers/misc/fastrpc.c                        |   6 +-
>   drivers/net/wireless/ath/ath10k/qmi.c         |   4 +-
>   drivers/remoteproc/qcom_q6v5_mss.c            |   8 +-
>   drivers/soc/qcom/rmtfs_mem.c                  |   2 +-
>   drivers/virt/Kconfig                          |   1 +
>   drivers/virt/Makefile                         |   1 +
>   drivers/virt/gunyah/Kconfig                   |  73 ++
>   drivers/virt/gunyah/Makefile                  |  10 +
>   drivers/virt/gunyah/gunyah.c                  |  46 +
>   drivers/virt/gunyah/gunyah_ioeventfd.c        | 109 +++
>   drivers/virt/gunyah/gunyah_irqfd.c            | 180 ++++
>   drivers/virt/gunyah/gunyah_platform_hooks.c   |  63 ++
>   drivers/virt/gunyah/gunyah_vcpu.c             | 350 ++++++++
>   drivers/virt/gunyah/rsc_mgr.c                 | 795 ++++++++++++++++++
>   drivers/virt/gunyah/rsc_mgr.h                 | 124 +++
>   drivers/virt/gunyah/rsc_mgr_rpc.c             | 428 ++++++++++
>   drivers/virt/gunyah/vm_mgr.c                  | 594 +++++++++++++
>   drivers/virt/gunyah/vm_mgr.h                  |  76 ++
>   drivers/virt/gunyah/vm_mgr_mm.c               | 245 ++++++
>   include/linux/arm-smccc.h                     |   1 +
>   include/linux/gunyah.h                        | 186 ++++
>   include/linux/gunyah_rsc_mgr.h                | 136 +++
>   include/linux/gunyah_vm_mgr.h                 | 107 +++
>   include/linux/mailbox_client.h                |   1 +
>   include/linux/qcom_scm.h                      |   2 +-
>   include/uapi/linux/gunyah.h                   | 114 +++
>   samples/Kconfig                               |  10 +
>   samples/Makefile                              |   1 +
>   samples/gunyah/.gitignore                     |   2 +
>   samples/gunyah/Makefile                       |   6 +
>   samples/gunyah/gunyah_vmm.c                   | 270 ++++++
>   samples/gunyah/sample_vm.dts                  |  69 ++
>   51 files changed, 5075 insertions(+), 72 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>   create mode 100644 Documentation/virt/gunyah/index.rst
>   create mode 100644 Documentation/virt/gunyah/message-queue.rst
>   create mode 100644 Documentation/virt/gunyah/vm-manager.rst
>   create mode 100644 arch/arm64/gunyah/Makefile
>   create mode 100644 arch/arm64/gunyah/gunyah_hypercall.c
>   create mode 100644 arch/arm64/include/asm/gunyah.h
>   create mode 100644 drivers/mailbox/gunyah-msgq.c
>   create mode 100644 drivers/virt/gunyah/Kconfig
>   create mode 100644 drivers/virt/gunyah/Makefile
>   create mode 100644 drivers/virt/gunyah/gunyah.c
>   create mode 100644 drivers/virt/gunyah/gunyah_ioeventfd.c
>   create mode 100644 drivers/virt/gunyah/gunyah_irqfd.c
>   create mode 100644 drivers/virt/gunyah/gunyah_platform_hooks.c
>   create mode 100644 drivers/virt/gunyah/gunyah_vcpu.c
>   create mode 100644 drivers/virt/gunyah/rsc_mgr.c
>   create mode 100644 drivers/virt/gunyah/rsc_mgr.h
>   create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c
>   create mode 100644 drivers/virt/gunyah/vm_mgr.c
>   create mode 100644 drivers/virt/gunyah/vm_mgr.h
>   create mode 100644 drivers/virt/gunyah/vm_mgr_mm.c
>   create mode 100644 include/linux/gunyah.h
>   create mode 100644 include/linux/gunyah_rsc_mgr.h
>   create mode 100644 include/linux/gunyah_vm_mgr.h
>   create mode 100644 include/uapi/linux/gunyah.h
>   create mode 100644 samples/gunyah/.gitignore
>   create mode 100644 samples/gunyah/Makefile
>   create mode 100644 samples/gunyah/gunyah_vmm.c
>   create mode 100644 samples/gunyah/sample_vm.dts
> 
> 
> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476

