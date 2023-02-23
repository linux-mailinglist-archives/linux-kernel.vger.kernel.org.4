Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD926A1277
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjBWWAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBWWAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:00:02 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2265193F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 14:00:00 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d7so6827822pfu.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 14:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b+mJjhLKuxQBtUISdRXM2nXLfPdKn+PRq8NK1iTbBCk=;
        b=KXVI3/xB2Bb15dZQuLce9ySUcCyncejTtBeVmOS60XOyTmUgC7ixPm8SwT53x1jGTt
         webcH6PZrA9yKWYstffABWdpxELEjGY0o0KhqXXUGZ9ILHj7UBUhLFe2wDUC2ehuzH4G
         pAqs7AMlMd6GN/EkiJ9zmi29Vy/Cde5dK9C3rVaRcKeM1AX+oiqlZBv6CXQmMibTDRWA
         zMKGxR0pi5ZOr+5sehCl3OPV/i70i8Hw+9VArt9Yikq/mbfxeMH34TvQ6fHEYs/Yg5xE
         Nq7hKw3cwwlLkwKjeMAFiue3fwE5lDVLdLcuz8S7q+9rJUSTPmpoT2SpASNnr5KhKZIR
         RekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+mJjhLKuxQBtUISdRXM2nXLfPdKn+PRq8NK1iTbBCk=;
        b=TY1L1SZNIfgOS0AA10JRTYBHoIVzIcXSz7iiAwf38MiW5UEoMqSVmFFIvrA6+HAI9n
         B8Yzk50Gp7b33jW6iTANuTlwckzmNJYA3OUTGRLQ85iN7xPnGTX/Zq6iOZsxpoyauhRM
         IpSAq+rtxFpbutStA4E9CuOxzYRYPk+bda9vnAKCBqOlnQQptAHkEPgOyCQW05fCGqby
         Cy+DimnKP+tUwNMnsAVZVUJqMKXR2Q46xwIbQUkaP3qqUmTM+GD9rG1hvLZV/zPZP2U9
         OeeVtb83DOq0aEtFXjX9W+Rf9oVYHt/+CgQ4RQHycVebwgH9wp3Nc1CX1sN2hPzVBKgY
         eV7g==
X-Gm-Message-State: AO0yUKWsMJLuCm33BvRxCjtQosD0KoIjnpTApdL+wIJJVkOPD5OiFU5q
        SQeJX1WRjBDT//JvJKsKFs2qOA==
X-Google-Smtp-Source: AK7set+NVjZ5pG5LQw7zStCtGRkhlaN9G1/TlBiFYNzbN6C+vPQhOWv6Xu4ASt4ZFV0SdHSqRbdpoQ==
X-Received: by 2002:a05:6a00:809:b0:5a8:ac15:534d with SMTP id m9-20020a056a00080900b005a8ac15534dmr12804120pfk.13.1677189599844;
        Thu, 23 Feb 2023 13:59:59 -0800 (PST)
Received: from [10.211.55.3] (c-73-221-130-71.hsd1.wa.comcast.net. [73.221.130.71])
        by smtp.gmail.com with ESMTPSA id a21-20020aa78655000000b005a54a978c1bsm4416016pfo.7.2023.02.23.13.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 13:59:59 -0800 (PST)
Message-ID: <df3b485f-924e-a7bc-7c07-7fb9cfed5110@linaro.org>
Date:   Thu, 23 Feb 2023 15:59:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 00/26] Drivers for Gunyah hypervisor
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
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
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
From:   Alex Elder <alex.elder@linaro.org>
In-Reply-To: <20230214211229.3239350-1-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 3:12 PM, Elliot Berman wrote:
> Gunyah is a Type-1 hypervisor independent of any
> high-level OS kernel, and runs in a higher CPU privilege level. It does
> not depend on any lower-privileged OS kernel/code for its core
> functionality. This increases its security and can support a much smaller
> trusted computing base than a Type-2 hypervisor.

Very general comment, across your whole series...

Although it is not strictly required any more, most kernel
code still stays within about 80 columns width, where longer
lines are the exception.  Your patches go beyond 80 columns
a lot, and it's just not what I'm accustomed to looking at.

Others might disagree with this, but it would be my preference
that you try to reformat your lines so they normally fit within
80 columns.  Format strings for printk-like functions are an
exception--people prefer those to be kept intact.  But even
there, look at long messages and consider whether they can
be made more concise.

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
> Manager, and a virtual machine manager capable of launching virtual machines.
> 
> The series relies on two other patches posted separately:
>   - https://lore.kernel.org/all/20230213181832.3489174-1-quic_eberman@quicinc.com/
>   - https://lore.kernel.org/all/20230213232537.2040976-2-quic_eberman@quicinc.com/
> 
> Changes in v10:
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
>   - Reworked gunyah_device design to drop the Gunyah bus.
> 
> Changes in v2: https://lore.kernel.org/all/20220801211240.597859-1-quic_eberman@quicinc.com/
>   - DT bindings clean up
>   - Switch hypercalls to follow SMCCC
> 
> v1: https://lore.kernel.org/all/20220223233729.1571114-1-quic_eberman@quicinc.com/
> 
> Elliot Berman (26):
>    docs: gunyah: Introduce Gunyah Hypervisor
>    dt-bindings: Add binding for gunyah hypervisor
>    gunyah: Common types and error codes for Gunyah hypercalls
>    virt: gunyah: Add hypercalls to identify Gunyah
>    virt: gunyah: Identify hypervisor version
>    virt: gunyah: msgq: Add hypercalls to send and receive messages
>    mailbox: Add Gunyah message queue mailbox
>    gunyah: rsc_mgr: Add resource manager RPC core
>    gunyah: rsc_mgr: Add VM lifecycle RPC
>    gunyah: vm_mgr: Introduce basic VM Manager
>    gunyah: rsc_mgr: Add RPC for sharing memory
>    unyah: vm_mgr: Add/remove user memory regions
>    gunyah: vm_mgr: Add ioctls to support basic non-proxy VM boot
>    samples: Add sample userspace Gunyah VM Manager
>    gunyah: rsc_mgr: Add platform ops on mem_lend/mem_reclaim
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
>    MAINTAINERS: Add Gunyah hypervisor drivers section
> 
>   .../bindings/firmware/gunyah-hypervisor.yaml  |  82 ++
>   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>   Documentation/virt/gunyah/index.rst           | 114 +++
>   Documentation/virt/gunyah/message-queue.rst   |  69 ++
>   Documentation/virt/gunyah/vm-manager.rst      | 193 +++++
>   Documentation/virt/index.rst                  |   1 +
>   MAINTAINERS                                   |  13 +
>   arch/arm64/Kbuild                             |   1 +
>   arch/arm64/gunyah/Makefile                    |   3 +
>   arch/arm64/gunyah/gunyah_hypercall.c          | 146 ++++
>   arch/arm64/include/asm/gunyah.h               |  23 +
>   drivers/firmware/Kconfig                      |   2 +
>   drivers/firmware/qcom_scm.c                   | 100 +++
>   drivers/mailbox/Makefile                      |   2 +
>   drivers/mailbox/gunyah-msgq.c                 | 214 +++++
>   drivers/virt/Kconfig                          |   2 +
>   drivers/virt/Makefile                         |   1 +
>   drivers/virt/gunyah/Kconfig                   |  46 +
>   drivers/virt/gunyah/Makefile                  |  11 +
>   drivers/virt/gunyah/gunyah.c                  |  54 ++
>   drivers/virt/gunyah/gunyah_ioeventfd.c        | 113 +++
>   drivers/virt/gunyah/gunyah_irqfd.c            | 160 ++++
>   drivers/virt/gunyah/gunyah_platform_hooks.c   |  80 ++
>   drivers/virt/gunyah/gunyah_vcpu.c             | 463 ++++++++++
>   drivers/virt/gunyah/rsc_mgr.c                 | 798 +++++++++++++++++
>   drivers/virt/gunyah/rsc_mgr.h                 | 169 ++++
>   drivers/virt/gunyah/rsc_mgr_rpc.c             | 419 +++++++++
>   drivers/virt/gunyah/vm_mgr.c                  | 801 ++++++++++++++++++
>   drivers/virt/gunyah/vm_mgr.h                  |  70 ++
>   drivers/virt/gunyah/vm_mgr_mm.c               | 258 ++++++
>   include/linux/gunyah.h                        | 198 +++++
>   include/linux/gunyah_rsc_mgr.h                | 171 ++++
>   include/linux/gunyah_vm_mgr.h                 | 119 +++
>   include/uapi/linux/gunyah.h                   | 191 +++++
>   samples/Kconfig                               |  10 +
>   samples/Makefile                              |   1 +
>   samples/gunyah/.gitignore                     |   2 +
>   samples/gunyah/Makefile                       |   6 +
>   samples/gunyah/gunyah_vmm.c                   | 270 ++++++
>   samples/gunyah/sample_vm.dts                  |  68 ++
>   40 files changed, 5445 insertions(+)
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
> base-commit: 3ebb0ac55efaf1d0fb1b106f852c114e5021f7eb

