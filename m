Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69266723007
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbjFETrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjFETrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:47:14 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EECF3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:47:11 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33b4b70693eso26813275ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994430; x=1688586430;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cfEnuJ6Ft0AsxyXZb4P7yMLKfL6fTB5HTNmSSGIRH2Y=;
        b=H5JYehQlvqCzHz7uaLc+55itUgE3vah19h3z+gra4aBN+WDHs0rPjeT6u29dL9Pl9w
         Bxal12ZNDWX3kRr0LBMfLa/KmnCaUeoiqLs2Dx+nEG6UekMOUNe8tt1dUGQZJcsQIkkS
         oFVgvmPucvdsNdai4UAb3RJrT/L/lgdX+9E+EHOkEu/luBOe3sjyhrH0evPUv1VLlPlU
         i2m/2ee/+V21ZEvVbawS7WVSSPo3DKpMJZyhN5tD53y0al9qkO3BTU5yp1Ch4ETEITEw
         xNftLNMtEiFQoRdYyt37hQwSPm24Nhhj8OGTiw4CBfkVxN0vwSbmgVuG2ufmnyYZBJWC
         AVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994430; x=1688586430;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfEnuJ6Ft0AsxyXZb4P7yMLKfL6fTB5HTNmSSGIRH2Y=;
        b=W2rCyqPDPy5L/H2VKM7S99xqK7I9Y829kyJRMhfcTakQdebEZK053t3PnPJxGIO1G7
         u7p6rRr7FQUquSXwwMO1/vfkNiB0uEh5q5qbQ+5NX/qAfiapL9mp/JrXgKs+IXSZZiVI
         SMluazBbNPNZ5ImsBFNWXx3I8mhzONy1H58tdw3Pxracx9c3/Qir5B0hc/QJJB/YSBAu
         /rWPU/DMwiiySKosAIFO+6prhMlQbovFlN7/E04JNb1bVv8oPvPRmqhpvdrfN/qDv4IN
         cMjWT9PeuhIOFBTkwTLVHKSAeOITcXLjUW+QgmsVnub4h+H3BXGpOTHa7e2e+OlUPQ7l
         lxpA==
X-Gm-Message-State: AC+VfDw+GvLoKs0jlHSYHKsY/nFb0n1rlywml5LxBSSKvcQyu0eR+6TS
        jQ2cm3qR5v+iohcx5puFq0dMhQ==
X-Google-Smtp-Source: ACHHUZ5njdZArzavZ9es/Z3yKJIHS5p05e3JUjelCMyJt9g4kL+ke7kpsKsPT5IY9GYyEhQRFtZg2Q==
X-Received: by 2002:a92:6e12:0:b0:335:9303:4345 with SMTP id j18-20020a926e12000000b0033593034345mr37281ilc.25.1685994430445;
        Mon, 05 Jun 2023 12:47:10 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id b23-20020a02c997000000b0040bbfad3e28sm2318103jap.96.2023.06.05.12.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:47:09 -0700 (PDT)
Message-ID: <358bd1d1-1a3c-f2b0-425c-d05f1692a62f@linaro.org>
Date:   Mon, 5 Jun 2023 14:47:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v13 00/24] Drivers for Gunyah hypervisor
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
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230509204801.2824351-1-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 3:47 PM, Elliot Berman wrote:
> Gunyah is a Type-1 hypervisor independent of any
> high-level OS kernel, and runs in a higher CPU privilege level. It does
> not depend on any lower-privileged OS kernel/code for its core
> functionality. This increases its security and can support a much smaller
> trusted computing base than a Type-2 hypervisor.
> 
> Gunyah is an open source hypervisor. The source repo is available at
> https://github.com/quic/gunyah-hypervisor.

Does the kernel code in this patch series function with the
hypervisor code at the link above?  It looks like it has not
been updated in 2 years.  If not, where can one find the open
source hypervisor code that this kernel driver *does* function
with?  If it is not available now, *when* will it be published?

It's OK for the hypervisor to be closed source, but if that's
the case, the statement about it being open source should not
be made.

In addition, the Gunyah resource manager is a fundamental
component of Gunyah.  It's code appears to be here:
     https://github.com/quic/gunyah-resource-manager/
I haven't looked further on in the kernel documentation
yet but if there is a permanent place where the open source
hypervisor and resource manager code will reside, you should
link to both repositories (and anything else that might be
required) there.

Previously I reviewed the net result of all applied patches,
and did a pretty detailed review of the code.  I'm comfortable
I've previously pointed out things I thought were significant,
so this time around I'm doing less detailed review, looking at
each individual patch.  For the most part, it looks fine to me
(and in most cases I've provided a Reviewed-by tag).

I'll state once more that my review is oriented toward correct
code and good practices.  For "virtualization issues" you should
rely on others (like Will) to provide informed feedback.

					-Alex

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

The above patch has been applied in the Qualcomm tree.

>   - https://lore.kernel.org/all/20230213232537.2040976-2-quic_eberman@quicinc.com/

And this link doesn't lead to a patch.  Has it too been
applied?  (Otherwise, it should be corrected.)

					-Alex

> Changes in v13:
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
> Elliot Berman (24):
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
>   Documentation/virt/gunyah/index.rst           |   1 +
>   Documentation/virt/gunyah/message-queue.rst   |   8 +
>   Documentation/virt/gunyah/vm-manager.rst      | 142 +++
>   MAINTAINERS                                   |  13 +
>   arch/arm64/Kbuild                             |   1 +
>   arch/arm64/gunyah/Makefile                    |   3 +
>   arch/arm64/gunyah/gunyah_hypercall.c          | 140 +++
>   arch/arm64/include/asm/gunyah.h               |  24 +
>   drivers/mailbox/Makefile                      |   2 +
>   drivers/mailbox/gunyah-msgq.c                 | 212 ++++
>   drivers/virt/Kconfig                          |   2 +
>   drivers/virt/Makefile                         |   1 +
>   drivers/virt/gunyah/Kconfig                   |  59 ++
>   drivers/virt/gunyah/Makefile                  |  11 +
>   drivers/virt/gunyah/gunyah_ioeventfd.c        | 130 +++
>   drivers/virt/gunyah/gunyah_irqfd.c            | 180 ++++
>   drivers/virt/gunyah/gunyah_platform_hooks.c   |  80 ++
>   drivers/virt/gunyah/gunyah_qcom.c             | 147 +++
>   drivers/virt/gunyah/gunyah_vcpu.c             | 468 +++++++++
>   drivers/virt/gunyah/rsc_mgr.c                 | 910 ++++++++++++++++++
>   drivers/virt/gunyah/rsc_mgr.h                 |  19 +
>   drivers/virt/gunyah/rsc_mgr_rpc.c             | 500 ++++++++++
>   drivers/virt/gunyah/vm_mgr.c                  | 794 +++++++++++++++
>   drivers/virt/gunyah/vm_mgr.h                  |  70 ++
>   drivers/virt/gunyah/vm_mgr_mm.c               | 256 +++++
>   include/linux/gunyah.h                        | 207 ++++
>   include/linux/gunyah_rsc_mgr.h                | 162 ++++
>   include/linux/gunyah_vm_mgr.h                 | 126 +++
>   include/uapi/linux/gunyah.h                   | 293 ++++++
>   samples/Kconfig                               |  10 +
>   samples/Makefile                              |   1 +
>   samples/gunyah/.gitignore                     |   2 +
>   samples/gunyah/Makefile                       |   6 +
>   samples/gunyah/gunyah_vmm.c                   | 270 ++++++
>   samples/gunyah/sample_vm.dts                  |  68 ++
>   37 files changed, 5401 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
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
> base-commit: c8c655c34e33544aec9d64b660872ab33c29b5f1
> prerequisite-patch-id: b48c45acdec06adf37e09fe35e6a9412c5784800
> prerequisite-patch-id: bc27499c7652385c584424529edbc5781c074d68

