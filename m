Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13216733636
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjFPQfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345658AbjFPQfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:35:40 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2733AAB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:35:19 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-570002c9b38so10762057b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686933318; x=1689525318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95K85Wvdh9q9MCQWGezcUebBGPAYCwompOtePat6Pqc=;
        b=CnArW6dWlMMd1C+foAPeWAYn5BHkaXmFyOnsHEmHjNxrL9H5Aql413nkP+ciNs1Cov
         Xo9OkZjaOnGhrrihsuHKxbcwtqsTGTl2LI2Z3XjXj5nrlLg0QyAWt/jQl47G1Ms9xOgW
         NEg32rvJSSVTKc16nsbBauLbXguCPEdDQS5ltrp6kudt3iF9IUkok+HAkC8wXJ9qbmo+
         C8HRpNNdl49ZC/7MQaMdoGAdtYfoNvrvDUWKzkwyho/26eRkE/C10FR6SBO/xt4zGiNN
         7Zfq19o0pVFXHqFUQyVG958q1uLfB7PYCNuxFyNymnJRULeGVUR2O0bMGIn367n/U8fC
         2PLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686933318; x=1689525318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95K85Wvdh9q9MCQWGezcUebBGPAYCwompOtePat6Pqc=;
        b=UOUcZnaxUNuWCJFuoOisLlfioaRjOL7JXt0XdmXyuIhzCwWEAD+UPJwR4VerjLAT4M
         oZl6sPXq//cFs8tbhtl1K4zf63n/LTW2vNA7IvSiGQBvOchfUKff2OKKzRe5axM7D495
         Z6FI0UNtdeAayVwtJJEAK+4i6D+ysibL8YfyDXBHl05r9jtn1wneA2GwLOndL/cfgieR
         bcPyrRj19hddLLMgdex/LQ4KjyYO/7ldXg0GkPA/Tfz1OjQlFp/phYQiEuqIhLgCAtJ3
         ZUdtI5tUfBdGw6P6zqoE2cYPEB4NTtYhD3oNMEpcg3F4b1/2SO32aHEj7FqpSW+ee7Aw
         2TqQ==
X-Gm-Message-State: AC+VfDw8yjug1e8jO740XdX1RGUhwirt803HdSK+yvoNhp144l6wEWEc
        ZYr+S2qGuxJJlt2fxPUP1XPcmg==
X-Google-Smtp-Source: ACHHUZ5DH5BHNW8jEYHCr+oiEMGCdzAYaBvnBhc/V9soij5JdmJIy22OP/T8+doDz9SxXJR16i7Vpw==
X-Received: by 2002:a0d:c001:0:b0:570:6d74:21d5 with SMTP id b1-20020a0dc001000000b005706d7421d5mr1503676ywd.13.1686933318207;
        Fri, 16 Jun 2023 09:35:18 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id u126-20020a814784000000b005708076b851sm38135ywa.43.2023.06.16.09.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:35:17 -0700 (PDT)
Message-ID: <92b81475-66c0-0d81-a9df-71b53fff2ac7@linaro.org>
Date:   Fri, 16 Jun 2023 11:35:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 00/25] Drivers for Gunyah hypervisor
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20230613172054.3959700-1-quic_eberman@quicinc.com>
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
> Gunyah is a Type-1 hypervisor independent of any
> high-level OS kernel, and runs in a higher CPU privilege level. It does
> not depend on any lower-privileged OS kernel/code for its core
> functionality. This increases its security and can support a much smaller
> trusted computing base than a Type-2 hypervisor.

I believe I have marked "Reviewed-by" on this entire series
now.  If I'm mistaken about that, or if you make a change
that you think warrants me taking another look, please call
that to my attention.

Thanks for being very responsive to my review comments.  My
greatest hope is that we've prevented some bugs from getting
accepted, but I also hope you have found my feedback helpful.

					-Alex

> Gunyah is an open source hypervisor. The source repo is available at
> https://github.com/quic/gunyah-hypervisor.
> 
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
> Manager, and a sample virtual machine manager capable of launching virtual machines.
> 
> The series relies on two other patches posted separately:
>   - https://lore.kernel.org/all/20230213181832.3489174-1-quic_eberman@quicinc.com/
>   - https://lore.kernel.org/all/20230213232537.2040976-2-quic_eberman@quicinc.com/
> 
> 
> Changes in v14:
>   - Coding/cosmetic tweaks suggested by Alex
>   - Mark IRQs as wake-up capable
> 
> Changes in v13: https://lore.kernel.org/all/20230509204801.2824351-1-quic_eberman@quicinc.com/
>   - Tweaks to message queue driver to address race condition between IRQ and mailbox registration
>   - Allow removal of VM functions by function-specific comparison -- specifically to allow
>     removing irqfd by label only and not requiring original FD to be provided.
> 
> Changes in v12: https://lore.kernel.org/all/20230424231558.70911-1-quic_eberman@quicinc.com/
>   - Stylistic/cosmetic tweaks suggested by Alex
>   - Remove patch "virt: gunyah: Identify hypervisor version" and squash the
>     check that we're running under a reasonable Gunyah hypervisor into RM driver
>   - Refactor platform hooks into a separate module per suggestion from Srini
>   - GFP_KERNEL_ACCOUNT and account_locked_vm() for page pinning
>   - enum-ify related constants
> 
> Changes in v11: https://lore.kernel.org/all/20230304010632.2127470-1-quic_eberman@quicinc.com/
>   - Rename struct gh_vm_dtb_config:gpa -> guest_phys_addr & overflow checks for this
>   - More docstrings throughout
>   - Make resp_buf and resp_buf_size optional
>   - Replace deprecated idr with xarray
>   - Refconting on misc device instead of RM's platform device
>   - Renaming variables, structs, etc. from gunyah_ -> gh_
>   - Drop removal of user mem regions
>   - Drop mem_lend functionality; to converge with restricted_memfd later
> 
> Changes in v10: https://lore.kernel.org/all/20230214211229.3239350-1-quic_eberman@quicinc.com/
>   - Fix bisectability (end result of series is same, --fixups applied to wrong commits)
>   - Convert GH_ERROR_* and GH_RM_ERROR_* to enums
>   - Correct race condition between allocating/freeing user memory
>   - Replace offsetof with struct_size
>   - Series-wide renaming of functions to be more consistent
>   - VM shutdown & restart support added in vCPU and VM Manager patches
>   - Convert VM function name (string) to type (number)
>   - Convert VM function argument to value (which could be a pointer) to remove memory wastage for arguments
>   - Remove defensive checks of hypervisor correctness
>   - Clean ups to ioeventfd as suggested by Srivatsa
> 
> Changes in v9: https://lore.kernel.org/all/20230120224627.4053418-1-quic_eberman@quicinc.com/
>   - Refactor Gunyah API flags to be exposed as feature flags at kernel level
>   - Move mbox client cleanup into gunyah_msgq_remove()
>   - Simplify gh_rm_call return value and response payload
>   - Missing clean-up/error handling/little endian fixes as suggested by Srivatsa and Alex in v8 series
> 
> Changes in v8: https://lore.kernel.org/all/20221219225850.2397345-1-quic_eberman@quicinc.com/
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
>   - Reworked gh_device design to drop the Gunyah bus.
> 
> Changes in v2: https://lore.kernel.org/all/20220801211240.597859-1-quic_eberman@quicinc.com/
>   - DT bindings clean up
>   - Switch hypercalls to follow SMCCC
> 
> v1: https://lore.kernel.org/all/20220223233729.1571114-1-quic_eberman@quicinc.com/
> 
> Elliot Berman (25):
>    docs: gunyah: Introduce Gunyah Hypervisor
>    dt-bindings: Add binding for gunyah hypervisor
>    gunyah: Common types and error codes for Gunyah hypercalls
>    virt: gunyah: Add hypercalls to identify Gunyah
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
>    virt: gunyah: Add Qualcomm Gunyah platform ops
>    docs: gunyah: Document Gunyah VM Manager
>    virt: gunyah: Translate gh_rm_hyp_resource into gunyah_resource
>    gunyah: vm_mgr: Add framework for VM Functions
>    virt: gunyah: Add resource tickets
>    virt: gunyah: Add IO handlers
>    virt: gunyah: Add proxy-scheduled vCPUs
>    virt: gunyah: Add hypercalls for sending doorbell
>    virt: gunyah: Add irqfd interface
>    virt: gunyah: Add ioeventfd
>    MAINTAINERS: Add Gunyah hypervisor drivers section
> 
>   .../bindings/firmware/gunyah-hypervisor.yaml  |  82 ++
>   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>   Documentation/virt/gunyah/index.rst           | 114 +++
>   Documentation/virt/gunyah/message-queue.rst   |  71 ++
>   Documentation/virt/gunyah/vm-manager.rst      | 143 +++
>   Documentation/virt/index.rst                  |   1 +
>   MAINTAINERS                                   |  13 +
>   arch/arm64/Kbuild                             |   1 +
>   arch/arm64/gunyah/Makefile                    |   3 +
>   arch/arm64/gunyah/gunyah_hypercall.c          | 142 +++
>   arch/arm64/include/asm/gunyah.h               |  24 +
>   drivers/mailbox/Makefile                      |   2 +
>   drivers/mailbox/gunyah-msgq.c                 | 219 +++++
>   drivers/virt/Kconfig                          |   2 +
>   drivers/virt/Makefile                         |   1 +
>   drivers/virt/gunyah/Kconfig                   |  59 ++
>   drivers/virt/gunyah/Makefile                  |  11 +
>   drivers/virt/gunyah/gunyah_ioeventfd.c        | 130 +++
>   drivers/virt/gunyah/gunyah_irqfd.c            | 180 ++++
>   drivers/virt/gunyah/gunyah_platform_hooks.c   |  80 ++
>   drivers/virt/gunyah/gunyah_qcom.c             | 153 +++
>   drivers/virt/gunyah/gunyah_vcpu.c             | 470 +++++++++
>   drivers/virt/gunyah/rsc_mgr.c                 | 909 ++++++++++++++++++
>   drivers/virt/gunyah/rsc_mgr.h                 |  19 +
>   drivers/virt/gunyah/rsc_mgr_rpc.c             | 500 ++++++++++
>   drivers/virt/gunyah/vm_mgr.c                  | 791 +++++++++++++++
>   drivers/virt/gunyah/vm_mgr.h                  |  70 ++
>   drivers/virt/gunyah/vm_mgr_mm.c               | 252 +++++
>   include/linux/gunyah.h                        | 207 ++++
>   include/linux/gunyah_rsc_mgr.h                | 162 ++++
>   include/linux/gunyah_vm_mgr.h                 | 153 +++
>   include/uapi/linux/gunyah.h                   | 293 ++++++
>   samples/Kconfig                               |  10 +
>   samples/Makefile                              |   1 +
>   samples/gunyah/.gitignore                     |   2 +
>   samples/gunyah/Makefile                       |   6 +
>   samples/gunyah/gunyah_vmm.c                   | 266 +++++
>   samples/gunyah/sample_vm.dts                  |  68 ++
>   38 files changed, 5611 insertions(+)
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
>   create mode 100644 drivers/virt/gunyah/gunyah_ioeventfd.c
>   create mode 100644 drivers/virt/gunyah/gunyah_irqfd.c
>   create mode 100644 drivers/virt/gunyah/gunyah_platform_hooks.c
>   create mode 100644 drivers/virt/gunyah/gunyah_qcom.c
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
> base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375

