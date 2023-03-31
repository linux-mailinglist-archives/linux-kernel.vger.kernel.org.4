Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FBC6D22A1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjCaO2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjCaO2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:28:21 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B561E73C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:27:51 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id cu4so16466009qvb.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272852; x=1682864852;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qqnqnEHVA2tW5+/68LwnpJrkDgIkxWfkcCNnP6Qn8uQ=;
        b=pAHRGhvHQbbzwnkMfo0dgwvIyDcBIQaXD7AbxD3lN/EfhD35ut5RCt+d6c1l7MShOj
         oUDh02kiXIxg10mdR9iPjEXyylARHiteF0pX7DexNpRyvf/oWRZHzgNIbn3cCbxI4HuO
         pfT5qxrkuDMkVyfVEwiA1/t4qkYEmyn2fVqdVgwIPGS/mbwx+sKwdl28O2dZCkSpGZWS
         dAHjY9VBnRvgYLxXPOUNjourdjr5MtkE/8KovnqLUslFcXculqXJJF2fTkdZwIYuypaD
         Mxxw+JopHCk5Notyo7AoB7pBmcr6obq7fKKjV9FIyoESedBEplru0dR0x40E3NyiY6lN
         s98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272852; x=1682864852;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqnqnEHVA2tW5+/68LwnpJrkDgIkxWfkcCNnP6Qn8uQ=;
        b=fCVX6DNkg8fXM3F7Pzv+8bues4pnarocFij6r6sX1HIirMhjHhmzFldo/LNiTGPd/f
         GOhk9EGNmqE0KgO9kNIlpnc9tyMb96llZkEX0t4Y4I4c290sbQdafO2j//0MnFHyCbYi
         M2JsmBKX2yXnGudAlUB59SEDd/IHE7L3dfJFeaK9NipYIkcgZQsTMY8mEcUUxpS+YKAx
         oQwSRafkT5UppbPqy1rAJY2Easj0JX+PyVmFUInHXDZVw42IQT2uaEYCBJpeW806BnVf
         Mdyao1Acygy20h2fvFCvSFxX0xxorDBhd3sI0co2qZ0UusxBA8nOX673Hz/BjDUaB01t
         tdAg==
X-Gm-Message-State: AAQBX9dfqhJOpHZrufPQ7Onsz5aLPed9CDuhw/o2o0ek5lDcSVRGMI4r
        UHgOjiNoV4/56RY9w0vsjBu5/A==
X-Google-Smtp-Source: AKy350YGeKx+V95+YEGDyTkPTFx72WXUe8t4jj++ChMtX+tQCtkW7GUHZ0/Eiw5fn/O5YofNcXE32w==
X-Received: by 2002:a05:6214:2461:b0:5a2:7a52:f53a with SMTP id im1-20020a056214246100b005a27a52f53amr43403311qvb.48.1680272852120;
        Fri, 31 Mar 2023 07:27:32 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id mn7-20020a0562145ec700b005dd8b93459fsm631764qvb.55.2023.03.31.07.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:27:31 -0700 (PDT)
Message-ID: <98ad146d-492d-aa0c-4f6a-ba37e6bf74eb@linaro.org>
Date:   Fri, 31 Mar 2023 09:27:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 22/26] virt: gunyah: Add proxy-scheduled vCPUs
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
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
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-23-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-23-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/23 7:06 PM, Elliot Berman wrote:
> Gunyah allows host virtual machines to schedule guest virtual machines
> and handle their MMIO accesses. vCPUs are presented to the host as a
> Gunyah resource and represented to userspace as a Gunyah VM function.
> 
> Creating the vcpu VM function will create a file descriptor that:
>   - can run an ioctl: GH_VCPU_RUN to schedule the guest vCPU until the
>     next interrupt occurs on the host or when the guest vCPU can no
>     longer be run.
>   - can be mmap'd to share a gh_vcpu_run structure which can look up the
>     reason why GH_VCPU_RUN returned and provide return values for MMIO
>     access.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

I suggest reorganizing and renaming a few things here, but I don't
think there's anything major.

					-Alex

> ---
>   Documentation/virt/gunyah/vm-manager.rst |  46 ++-
>   arch/arm64/gunyah/gunyah_hypercall.c     |  28 ++
>   drivers/virt/gunyah/Kconfig              |  11 +
>   drivers/virt/gunyah/Makefile             |   2 +
>   drivers/virt/gunyah/gunyah_vcpu.c        | 465 +++++++++++++++++++++++
>   drivers/virt/gunyah/vm_mgr.c             |   4 +
>   drivers/virt/gunyah/vm_mgr.h             |   1 +
>   include/linux/gunyah.h                   |   8 +
>   include/uapi/linux/gunyah.h              | 108 ++++++
>   9 files changed, 671 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/virt/gunyah/gunyah_vcpu.c
> 
> diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
> index af8ad88a88ab..83d326b0d11f 100644
> --- a/Documentation/virt/gunyah/vm-manager.rst
> +++ b/Documentation/virt/gunyah/vm-manager.rst
> @@ -5,8 +5,7 @@ Virtual Machine Manager
>   =======================
>   
>   The Gunyah Virtual Machine Manager is a Linux driver to support launching
> -virtual machines using Gunyah. It presently supports launching non-proxy
> -scheduled Linux-like virtual machines.
> +virtual machines using Gunyah.
>   
>   Except for some basic information about the location of initial binaries,
>   most of the configuration about a Gunyah virtual machine is described in the
> @@ -107,3 +106,46 @@ GH_VM_START
>   ~~~~~~~~~~~
>   
>   This ioctl starts the VM.
> +
> +GH_VM_ADD_FUNCTION
> +~~~~~~~~~~~~~~~~~~
> +
> +This ioctl registers a Gunyah VM function with the VM manager. The VM function
> +is described with a `type` string and some arguments for that type. Typically,
> +the function is added before the VM starts, but the function doesn't "operate"
> +until the VM starts with GH_VM_START: e.g. vCPU ioclts will all return an error
> +until the VM starts because the vCPUs don't exist until the VM is started. This
> +allows the VMM to set up all the kernel functionality needed for the VM *before*
> +the VM starts.
> +
> +.. kernel-doc:: include/uapi/linux/gunyah.h
> +   :identifiers: gh_fn_desc
> +
> +The possible types are documented below:
> +
> +.. kernel-doc:: include/uapi/linux/gunyah.h
> +   :identifiers: GH_FN_VCPU gh_fn_vcpu_arg
> +
> +Gunyah VCPU API Descriptions
> +----------------------------
> +
> +A vCPU file descriptor is created after calling `GH_VM_ADD_FUNCTION` with the type `GH_FN_VCPU`.
> +
> +GH_VCPU_RUN
> +~~~~~~~~~~~
> +
> +This ioctl is used to run a guest virtual cpu.  While there are no
> +explicit parameters, there is an implicit parameter block that can be
> +obtained by mmap()ing the vcpu fd at offset 0, with the size given by
> +GH_VCPU_MMAP_SIZE. The parameter block is formatted as a 'struct
> +gh_vcpu_run' (see below).
> +
> +GH_VCPU_MMAP_SIZE
> +~~~~~~~~~~~~~~~~~
> +
> +The GH_VCPU_RUN ioctl communicates with userspace via a shared
> +memory region. This ioctl returns the size of that region. See the
> +GH_VCPU_RUN documentation for details.
> +
> +.. kernel-doc:: include/uapi/linux/gunyah.h
> +   :identifiers: gh_vcpu_run gh_vm_exit_info
> diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
> index 3420d8f286a9..f01f5cec4d23 100644
> --- a/arch/arm64/gunyah/gunyah_hypercall.c
> +++ b/arch/arm64/gunyah/gunyah_hypercall.c
> @@ -43,6 +43,7 @@ EXPORT_SYMBOL_GPL(arch_is_gh_guest);
>   #define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x8000)
>   #define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x801B)
>   #define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x801C)
> +#define GH_HYPERCALL_VCPU_RUN			GH_HYPERCALL(0x8065)
>   
>   /**
>    * gh_hypercall_hyp_identify() - Returns build information and feature flags
> @@ -91,5 +92,32 @@ enum gh_error gh_hypercall_msgq_recv(u64 capid, void *buff, size_t size, size_t
>   }
>   EXPORT_SYMBOL_GPL(gh_hypercall_msgq_recv);
>   
> +enum gh_error gh_hypercall_vcpu_run(u64 capid, u64 *resume_data,
> +					struct gh_hypercall_vcpu_run_resp *resp)
> +{
> +	struct arm_smccc_1_2_regs args = {
> +		.a0 = GH_HYPERCALL_VCPU_RUN,
> +		.a1 = capid,
> +		.a2 = resume_data[0],
> +		.a3 = resume_data[1],
> +		.a4 = resume_data[2],
> +		/* C language says this will be implictly zero. Gunyah requires 0, so be explicit */
> +		.a5 = 0,
> +	};
> +	struct arm_smccc_1_2_regs res;
> +
> +	arm_smccc_1_2_hvc(&args, &res);
> +
> +	if (res.a0 == GH_ERROR_OK) {
> +		resp->state = res.a1;
> +		resp->state_data[0] = res.a2;
> +		resp->state_data[1] = res.a3;
> +		resp->state_data[2] = res.a4;
> +	}
> +
> +	return res.a0;
> +}
> +EXPORT_SYMBOL_GPL(gh_hypercall_vcpu_run);
> +
>   MODULE_LICENSE("GPL");
>   MODULE_DESCRIPTION("Gunyah Hypervisor Hypercalls");
> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
> index de815189dab6..4c1c6110b50e 100644
> --- a/drivers/virt/gunyah/Kconfig
> +++ b/drivers/virt/gunyah/Kconfig
> @@ -15,3 +15,14 @@ config GUNYAH
>   
>   config GUNYAH_PLATFORM_HOOKS
>   	tristate
> +
> +config GUNYAH_VCPU
> +	tristate "Runnable Gunyah vCPUs"
> +	depends on GUNYAH
> +	help
> +	  Enable kernel support for host-scheduled vCPUs running under Gunyah.
> +	  When selecting this option, userspace virtual machine managers (VMM)
> +	  can schedule the guest VM's vCPUs instead of using Gunyah's scheduler.
> +	  VMMs can also handle stage 2 faults of the vCPUs.
> +
> +	  Say Y/M here if unsure and you want to support Gunyah VMMs.
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index 6b8f84dbfe0d..2d1b604a7b03 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -5,3 +5,5 @@ obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
>   
>   gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
>   obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
> +
> +obj-$(CONFIG_GUNYAH_VCPU) += gunyah_vcpu.o
> diff --git a/drivers/virt/gunyah/gunyah_vcpu.c b/drivers/virt/gunyah/gunyah_vcpu.c
> new file mode 100644
> index 000000000000..870e471a11df
> --- /dev/null
> +++ b/drivers/virt/gunyah/gunyah_vcpu.c
> @@ -0,0 +1,465 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/anon_inodes.h>
> +#include <linux/file.h>
> +#include <linux/gunyah.h>
> +#include <linux/gunyah_vm_mgr.h>
> +#include <linux/interrupt.h>
> +#include <linux/kref.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +
> +#include "vm_mgr.h"
> +
> +#include <uapi/linux/gunyah.h>
> +
> +#define MAX_VCPU_NAME		20 /* gh-vcpu:u32_max+NUL */
> +
> +struct gh_vcpu {
> +	struct gh_vm_function_instance *f;
> +	struct gh_resource *rsc;
> +	struct mutex run_lock;
> +	/* Track why vcpu_run left last time around. */
> +	enum {
> +		GH_VCPU_UNKNOWN = 0,
> +		GH_VCPU_READY,
> +		GH_VCPU_MMIO_READ,
> +		GH_VCPU_SYSTEM_DOWN,
> +	} state;
> +	u8 mmio_read_len;
> +	struct gh_vcpu_run *vcpu_run;
> +	struct completion ready;
> +	struct gh_vm *ghvm;
> +
> +	struct notifier_block nb;
> +	struct gh_vm_resource_ticket ticket;
> +	struct kref kref;
> +};
> +

Here again, I suggest defining the states using an enumerated
type.  Then add kernel-doc comments to describe them, rather
than these one-line comments.  I like enums because it gives
you a way to refer to the group of values by name.

> +/* VCPU is ready to run */
> +#define GH_VCPU_STATE_READY		0
> +/* VCPU is sleeping until an interrupt arrives */
> +#define GH_VCPU_STATE_EXPECTS_WAKEUP	1
> +/* VCPU is powered off */
> +#define GH_VCPU_STATE_POWERED_OFF	2
> +/* VCPU is blocked in EL2 for unspecified reason */
> +#define GH_VCPU_STATE_BLOCKED		3
> +/* VCPU has returned for MMIO READ */
> +#define GH_VCPU_ADDRSPACE_VMMIO_READ	4
> +/* VCPU has returned for MMIO WRITE */
> +#define GH_VCPU_ADDRSPACE_VMMIO_WRITE	5

The states above are used as values held in the state field
of the gh_hypercall_vcpu_run_res structure.  I find it
confusing that you define them here right below the gh_vcpu
structure (which also has a "state" field--even though its
values are listed above).

Perhaps these values should be defined in <linux/gunyah.h>
instead, where th_hypercall_vcpu_run_resp is defined.  I
realize that even if you did that, they'd only be used
in this file.

> +
> +static void vcpu_release(struct kref *kref)
> +{
> +	struct gh_vcpu *vcpu = container_of(kref, struct gh_vcpu, kref);
> +
> +	free_page((unsigned long)vcpu->vcpu_run);
> +	kfree(vcpu);
> +}
> +
> +/*
> + * When hypervisor allows us to schedule vCPU again, it gives us an interrupt
> + */
> +static irqreturn_t gh_vcpu_irq_handler(int irq, void *data)
> +{
> +	struct gh_vcpu *vcpu = data;
> +
> +	complete(&vcpu->ready);
> +	return IRQ_HANDLED;
> +}
> +
> +static bool gh_handle_mmio(struct gh_vcpu *vcpu,
> +				struct gh_hypercall_vcpu_run_resp *vcpu_run_resp)
> +{
> +	int ret = 0;
> +	u64 addr = vcpu_run_resp->state_data[0],
> +	    len  = vcpu_run_resp->state_data[1],
> +	    data = vcpu_run_resp->state_data[2];
> +
> +	if (vcpu_run_resp->state == GH_VCPU_ADDRSPACE_VMMIO_READ) {
> +		vcpu->vcpu_run->mmio.is_write = 0;
> +		/* Record that we need to give vCPU user's supplied value next gh_vcpu_run() */
> +		vcpu->state = GH_VCPU_MMIO_READ;
> +		vcpu->mmio_read_len = len;
> +	} else { /* GH_VCPU_ADDRSPACE_VMMIO_WRITE */
> +		/* Try internal handlers first */
> +		ret = gh_vm_mmio_write(vcpu->f->ghvm, addr, len, data);
> +		if (!ret)
> +			return true;
> +
> +		/* Give userspace the info */
> +		vcpu->vcpu_run->mmio.is_write = 1;
> +		memcpy(vcpu->vcpu_run->mmio.data, &data, len);
> +	}
> +
> +	vcpu->vcpu_run->mmio.phys_addr = addr;
> +	vcpu->vcpu_run->mmio.len = len;
> +	vcpu->vcpu_run->exit_reason = GH_VCPU_EXIT_MMIO;
> +
> +	return false;
> +}
> +
> +static int gh_vcpu_rm_notification(struct notifier_block *nb, unsigned long action, void *data)
> +{
> +	struct gh_vcpu *vcpu = container_of(nb, struct gh_vcpu, nb);
> +	struct gh_rm_vm_exited_payload *exit_payload = data;
> +
> +	if (action == GH_RM_NOTIFICATION_VM_EXITED &&
> +		le16_to_cpu(exit_payload->vmid) == vcpu->ghvm->vmid)
> +		complete(&vcpu->ready);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static inline enum gh_vm_status remap_vm_status(enum gh_rm_vm_status rm_status)
> +{
> +	switch (rm_status) {
> +	case GH_RM_VM_STATUS_INIT_FAILED:
> +		return GH_VM_STATUS_LOAD_FAILED;
> +	case GH_RM_VM_STATUS_EXITED:
> +		return GH_VM_STATUS_EXITED;
> +	default:
> +		return GH_VM_STATUS_CRASHED;
> +	}
> +}
> +
> +/**
> + * gh_vcpu_check_system() - Check whether VM as a whole is running
> + * @vcpu: Pointer to gh_vcpu
> + *
> + * Returns true if the VM is alive.
> + * Returns false if the vCPU is the VM is not alive (can only be that VM is shutting down).
> + */
> +static bool gh_vcpu_check_system(struct gh_vcpu *vcpu)
> +	__must_hold(&vcpu->run_lock)
> +{
> +	bool ret = true;
> +
> +	down_read(&vcpu->ghvm->status_lock);
> +	if (likely(vcpu->ghvm->vm_status == GH_RM_VM_STATUS_RUNNING))
> +		goto out;
> +
> +	vcpu->vcpu_run->status.status = remap_vm_status(vcpu->ghvm->vm_status);
> +	vcpu->vcpu_run->status.exit_info = vcpu->ghvm->exit_info;
> +	vcpu->vcpu_run->exit_reason = GH_VCPU_EXIT_STATUS;
> +	vcpu->state = GH_VCPU_SYSTEM_DOWN;
> +	ret = false;
> +out:
> +	up_read(&vcpu->ghvm->status_lock);
> +	return ret;
> +}
> +
> +/**
> + * gh_vcpu_run() - Request Gunyah to begin scheduling this vCPU.
> + * @vcpu: The client descriptor that was obtained via gh_vcpu_alloc()
> + */
> +static int gh_vcpu_run(struct gh_vcpu *vcpu)
> +{
> +	struct gh_hypercall_vcpu_run_resp vcpu_run_resp;
> +	u64 state_data[3] = { 0 };
> +	enum gh_error gh_error;
> +	int ret = 0;
> +
> +	if (!vcpu->f)
> +		return -ENODEV;
> +
> +	if (mutex_lock_interruptible(&vcpu->run_lock))
> +		return -ERESTARTSYS;
> +
> +	if (!vcpu->rsc) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	switch (vcpu->state) {
> +	case GH_VCPU_UNKNOWN:
> +		if (vcpu->ghvm->vm_status != GH_RM_VM_STATUS_RUNNING) {
> +			/* Check if VM is up. If VM is starting, will block until VM is fully up
> +			 * since that thread does down_write.
> +			 */
> +			if (!gh_vcpu_check_system(vcpu))
> +				goto out;
> +		}
> +		vcpu->state = GH_VCPU_READY;
> +		break;
> +	case GH_VCPU_MMIO_READ:

I think you should verify that vcpu->mmio_read_len is <= 8 bytes
(or sizeof(state_data[0]).  It is set in gh_handle_mmio(), and
*should* be correct, but in isolation here it would be defensive.

> +		memcpy(&state_data[0], vcpu->vcpu_run->mmio.data, vcpu->mmio_read_len);
> +		vcpu->state = GH_VCPU_READY;
> +		break;
> +	case GH_VCPU_SYSTEM_DOWN:
> +		goto out;
> +	default:
> +		break;
> +	}
> +
> +	while (!ret && !signal_pending(current)) {
> +		if (vcpu->vcpu_run->immediate_exit) {
> +			ret = -EINTR;
> +			goto out;
> +		}
> +
> +		gh_error = gh_hypercall_vcpu_run(vcpu->rsc->capid, state_data, &vcpu_run_resp);
> +		if (gh_error == GH_ERROR_OK) {
> +			ret = 0;
> +			switch (vcpu_run_resp.state) {
> +			case GH_VCPU_STATE_READY:
> +				if (need_resched())
> +					schedule();
> +				break;
> +			case GH_VCPU_STATE_POWERED_OFF:
> +				/* vcpu might be off because the VM is shut down.
> +				 * If so, it won't ever run again: exit back to user
> +				 */
> +				if (!gh_vcpu_check_system(vcpu))
> +					goto out;
> +				/* Otherwise, another vcpu will turn it on (e.g. by PSCI)
> +				 * and hyp sends an interrupt to wake Linux up.
> +				 */
> +				fallthrough;
> +			case GH_VCPU_STATE_EXPECTS_WAKEUP:
> +				ret = wait_for_completion_interruptible(&vcpu->ready);
> +				/* reinitialize completion before next hypercall. If we reinitialize
> +				 * after the hypercall, interrupt may have already come before
> +				 * re-initializing the completion and then end up waiting for
> +				 * event that already happened.
> +				 */
> +				reinit_completion(&vcpu->ready);
> +				/* Check system status again. Completion might've
> +				 * come from gh_vcpu_rm_notification
> +				 */
> +				if (!ret && !gh_vcpu_check_system(vcpu))
> +					goto out;
> +				break;
> +			case GH_VCPU_STATE_BLOCKED:
> +				schedule();
> +				break;
> +			case GH_VCPU_ADDRSPACE_VMMIO_READ:
> +			case GH_VCPU_ADDRSPACE_VMMIO_WRITE:
> +				if (!gh_handle_mmio(vcpu, &vcpu_run_resp))
> +					goto out;
> +				break;
> +			default:
> +				pr_warn_ratelimited("Unknown vCPU state: %llx\n",
> +							vcpu_run_resp.state);
> +				schedule();
> +				break;
> +			}
> +		} else if (gh_error == GH_ERROR_RETRY) {
> +			schedule();
> +			ret = 0;

I don't think assigning ret here is necessary.

Add curly braces for the block below.

> +		} else
> +			ret = gh_remap_error(gh_error);
> +	}
> +
> +out:
> +	mutex_unlock(&vcpu->run_lock);
> +
> +	if (signal_pending(current))
> +		return -ERESTARTSYS;
> +
> +	return ret;
> +}
> +
> +static long gh_vcpu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +	struct gh_vcpu *vcpu = filp->private_data;
> +	long ret = -EINVAL;
> +
> +	switch (cmd) {
> +	case GH_VCPU_RUN:
> +		ret = gh_vcpu_run(vcpu);
> +		break;
> +	case GH_VCPU_MMAP_SIZE:
> +		ret = PAGE_SIZE;
> +		break;
> +	default:
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static int gh_vcpu_release(struct inode *inode, struct file *filp)
> +{
> +	struct gh_vcpu *vcpu = filp->private_data;
> +
> +	gh_vm_put(vcpu->ghvm);
> +	kref_put(&vcpu->kref, vcpu_release);
> +	return 0;
> +}
> +
> +static vm_fault_t gh_vcpu_fault(struct vm_fault *vmf)
> +{
> +	struct gh_vcpu *vcpu = vmf->vma->vm_file->private_data;
> +	struct page *page = NULL;
> +
> +	if (vmf->pgoff == 0)
> +		page = virt_to_page(vcpu->vcpu_run);
> +
> +	get_page(page);
> +	vmf->page = page;
> +	return 0;
> +}
> +
> +static const struct vm_operations_struct gh_vcpu_ops = {
> +	.fault = gh_vcpu_fault,
> +};
> +
> +static int gh_vcpu_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	vma->vm_ops = &gh_vcpu_ops;
> +	return 0;
> +}
> +
> +static const struct file_operations gh_vcpu_fops = {
> +	.owner = THIS_MODULE,
> +	.unlocked_ioctl = gh_vcpu_ioctl,
> +	.release = gh_vcpu_release,
> +	.llseek = noop_llseek,
> +	.mmap = gh_vcpu_mmap,
> +};
> +
> +static int gh_vcpu_populate(struct gh_vm_resource_ticket *ticket, struct gh_resource *ghrsc)
> +{
> +	struct gh_vcpu *vcpu = container_of(ticket, struct gh_vcpu, ticket);
> +	int ret;
> +
> +	mutex_lock(&vcpu->run_lock);
> +	if (vcpu->rsc) {
> +		ret = -1;

I think this should be -EBUSY, or (as I mention
elsewhere) this function could return Boolean.

> +		goto out;
> +	}
> +
> +	vcpu->rsc = ghrsc;
> +	init_completion(&vcpu->ready);
> +
> +	ret = request_irq(vcpu->rsc->irq, gh_vcpu_irq_handler, IRQF_TRIGGER_RISING, "gh_vcpu",
> +			vcpu);
> +	if (ret)
> +		pr_warn("Failed to request vcpu irq %d: %d", vcpu->rsc->irq, ret);
> +
> +out:
> +	mutex_unlock(&vcpu->run_lock);
> +	return ret;
> +}
> +
> +static void gh_vcpu_unpopulate(struct gh_vm_resource_ticket *ticket,
> +				   struct gh_resource *ghrsc)
> +{
> +	struct gh_vcpu *vcpu = container_of(ticket, struct gh_vcpu, ticket);
> +
> +	vcpu->vcpu_run->immediate_exit = true;
> +	complete_all(&vcpu->ready);
> +	mutex_lock(&vcpu->run_lock);
> +	free_irq(vcpu->rsc->irq, vcpu);
> +	vcpu->rsc = NULL;
> +	mutex_unlock(&vcpu->run_lock);
> +}
> +
> +static long gh_vcpu_bind(struct gh_vm_function_instance *f)
> +{
> +	struct gh_fn_vcpu_arg *arg = f->argp;
> +	struct gh_vcpu *vcpu;
> +	char name[MAX_VCPU_NAME];
> +	struct file *file;
> +	struct page *page;
> +	int fd;
> +	long r;
> +
> +	if (!gh_api_has_feature(GH_FEATURE_VCPU))
> +		return -EOPNOTSUPP;
> +
> +	if (f->arg_size != sizeof(*arg))
> +		return -EINVAL;
> +
> +	vcpu = kzalloc(sizeof(*vcpu), GFP_KERNEL);
> +	if (!vcpu)
> +		return -ENOMEM;
> +
> +	vcpu->f = f;
> +	f->data = vcpu;
> +	mutex_init(&vcpu->run_lock);
> +	kref_init(&vcpu->kref);
> +
> +	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!page) {
> +		r = -ENOMEM;
> +		goto err_destroy_vcpu;
> +	}
> +	vcpu->vcpu_run = page_address(page);
> +
> +	vcpu->ticket.resource_type = GH_RESOURCE_TYPE_VCPU;
> +	vcpu->ticket.label = arg->id;
> +	vcpu->ticket.owner = THIS_MODULE;
> +	vcpu->ticket.populate = gh_vcpu_populate;
> +	vcpu->ticket.unpopulate = gh_vcpu_unpopulate;
> +
> +	r = gh_vm_add_resource_ticket(f->ghvm, &vcpu->ticket);
> +	if (r)
> +		goto err_destroy_page;
> +
> +	fd = get_unused_fd_flags(O_CLOEXEC);
> +	if (fd < 0) {
> +		r = fd;
> +		goto err_remove_vcpu;
> +	}
> +
> +	if (!gh_vm_get(f->ghvm)) {
> +		r = -ENODEV;
> +		goto err_put_fd;
> +	}
> +	vcpu->ghvm = f->ghvm;
> +
> +	vcpu->nb.notifier_call = gh_vcpu_rm_notification;
> +	/* Ensure we run after the vm_mgr handles the notification and does
> +	 * any necessary state changes. We wake up to check the new state.
> +	 */
> +	vcpu->nb.priority = -1;
> +	r = gh_rm_notifier_register(f->rm, &vcpu->nb);
> +	if (r)
> +		goto err_put_gh_vm;
> +
> +	kref_get(&vcpu->kref);
> +	snprintf(name, sizeof(name), "gh-vcpu:%d", vcpu->ticket.label);

s/%d/%u/

> +	file = anon_inode_getfile(name, &gh_vcpu_fops, vcpu, O_RDWR);
> +	if (IS_ERR(file)) {
> +		r = PTR_ERR(file);
> +		goto err_notifier;
> +	}

Maybe group getting the anonymous file with getting
an unused file descriptor.

> +
> +	fd_install(fd, file);
> +
> +	return fd;
> +err_notifier:
> +	gh_rm_notifier_unregister(f->rm, &vcpu->nb);
> +err_put_gh_vm:
> +	gh_vm_put(vcpu->ghvm);
> +err_put_fd:
> +	put_unused_fd(fd);
> +err_remove_vcpu:
> +	gh_vm_remove_resource_ticket(f->ghvm, &vcpu->ticket);
> +err_destroy_page:
> +	free_page((unsigned long)vcpu->vcpu_run);
> +err_destroy_vcpu:
> +	kfree(vcpu);
> +	return r;
> +}
> +
> +static void gh_vcpu_unbind(struct gh_vm_function_instance *f)
> +{
> +	struct gh_vcpu *vcpu = f->data;
> +
> +	gh_rm_notifier_unregister(f->rm, &vcpu->nb);
> +	gh_vm_remove_resource_ticket(vcpu->f->ghvm, &vcpu->ticket);
> +	vcpu->f = NULL;
> +
> +	kref_put(&vcpu->kref, vcpu_release);
> +}
> +
> +DECLARE_GH_VM_FUNCTION_INIT(vcpu, GH_FN_VCPU, gh_vcpu_bind, gh_vcpu_unbind);
> +MODULE_DESCRIPTION("Gunyah vCPU Driver");

Maybe "Gunyah vCPU VM function(s)"?

And if you use "Driver" (or "driver") here, consider using it for
the irqfd and ioeventfd module descriptions as well.

> +MODULE_LICENSE("GPL");
> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
> index b31fac15ff45..d453d902847e 100644
> --- a/drivers/virt/gunyah/vm_mgr.c
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -354,6 +354,10 @@ static int gh_vm_rm_notification_exited(struct gh_vm *ghvm, void *data)
>   
>   	down_write(&ghvm->status_lock);
>   	ghvm->vm_status = GH_RM_VM_STATUS_EXITED;
> +	ghvm->exit_info.type = le16_to_cpu(payload->exit_type);
> +	ghvm->exit_info.reason_size = le32_to_cpu(payload->exit_reason_size);
> +	memcpy(&ghvm->exit_info.reason, payload->exit_reason,
> +		min(GH_VM_MAX_EXIT_REASON_SIZE, ghvm->exit_info.reason_size));
>   	up_write(&ghvm->status_lock);
>   
>   	return NOTIFY_DONE;
> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
> index 9c1046af80ed..df78756639b6 100644
> --- a/drivers/virt/gunyah/vm_mgr.h
> +++ b/drivers/virt/gunyah/vm_mgr.h
> @@ -45,6 +45,7 @@ struct gh_vm {
>   	enum gh_rm_vm_status vm_status;
>   	wait_queue_head_t vm_status_wait;
>   	struct rw_semaphore status_lock;
> +	struct gh_vm_exit_info exit_info;
>   
>   	struct work_struct free_work;
>   	struct kref kref;
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index 3e706b59d2c0..37f1e2c822ce 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -175,4 +175,12 @@ enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, void *buff, int tx_
>   enum gh_error gh_hypercall_msgq_recv(u64 capid, void *buff, size_t size, size_t *recv_size,
>   					bool *ready);
>   
> +struct gh_hypercall_vcpu_run_resp {
> +	u64 state;
> +	u64 state_data[3];
> +};
> +
> +enum gh_error gh_hypercall_vcpu_run(u64 capid, u64 *resume_data,
> +					struct gh_hypercall_vcpu_run_resp *resp);
> +
>   #endif
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index caeb3b3a3e9a..e52265fa5715 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -62,8 +62,32 @@ struct gh_vm_dtb_config {
>   
>   #define GH_VM_START		_IO(GH_IOCTL_TYPE, 0x3)
>   
> +/**
> + * GH_FN_VCPU - create a vCPU instance to control a vCPU
> + *
> + * gh_fn_desc is filled with &struct gh_fn_vcpu_arg
> + *
> + * The vcpu type will register with the VM Manager to expect to control
> + * vCPU number `vcpu_id`. It returns a file descriptor allowing interaction with
> + * the vCPU. See the Gunyah vCPU API description sections for interacting with
> + * the Gunyah vCPU file descriptors.
> + *
> + * Return: file descriptor to manipulate the vcpu. See GH_VCPU_* ioctls
> + */
> +#define GH_FN_VCPU 		1

I think you should define GH_VN_VCPU, GN_FN_IRQFD, and GN_FN_IOEVENTFD
in an enumerated type.  Each has a type associated with it, and you can
add the explanation for the function in the kernel-doc comments above
thosse type definitions.

> +
>   #define GH_FN_MAX_ARG_SIZE		256
>   
> +/**
> + * struct gh_fn_vcpu_arg - Arguments to create a vCPU
> + * @id: vcpu id
> + */
> +struct gh_fn_vcpu_arg {
> +	__u32 id;

I realize this is the "CPU ID" but the other two function types
name this field "label" and it gets used as the label for the
ticket when it gets bound.  So I suggest naming this "label".

> +};
> +
> +#define GH_IRQFD_LEVEL			(1UL << 0)
> +
>   /**
>    * struct gh_fn_desc - Arguments to create a VM function
>    * @type: Type of the function. See GH_FN_* macro for supported types

If you do what I suggest, the above comment should instead refer
to the enumerated type name.

> @@ -79,4 +103,88 @@ struct gh_fn_desc {
>   #define GH_VM_ADD_FUNCTION	_IOW(GH_IOCTL_TYPE, 0x4, struct gh_fn_desc)
>   #define GH_VM_REMOVE_FUNCTION	_IOW(GH_IOCTL_TYPE, 0x7, struct gh_fn_desc)
>   
> +enum gh_vm_status {
> +	GH_VM_STATUS_LOAD_FAILED	= 1,
> +#define GH_VM_STATUS_LOAD_FAILED	GH_VM_STATUS_LOAD_FAILED
> +	GH_VM_STATUS_EXITED		= 2,
> +#define GH_VM_STATUS_EXITED		GH_VM_STATUS_EXITED
> +	GH_VM_STATUS_CRASHED		= 3,
> +#define GH_VM_STATUS_CRASHED		GH_VM_STATUS_CRASHED
> +};
> +
> +/*
> + * Gunyah presently sends max 4 bytes of exit_reason.
> + * If that changes, this macro can be safely increased without breaking
> + * userspace so long as struct gh_vcpu_run < PAGE_SIZE.

Is PAGE_SIZE allowed to be anything other than 4096 bytes?  Do you
expect this driver to work properly if the page size were configured
to be 16384 bytes?  In other words, is this a Gunyah constant, or
is it *really* the page size configured for Linux?

> + */
> +#define GH_VM_MAX_EXIT_REASON_SIZE	8u
> +
> +/**
> + * struct gh_vm_exit_info - Reason for VM exit as reported by Gunyah
> + * See Gunyah documentation for values.
> + * @type: Describes how VM exited
> + * @padding: padding bytes
> + * @reason_size: Number of bytes valid for `reason`
> + * @reason: See Gunyah documentation for interpretation. Note: these values are
> + *          not interpreted by Linux and need to be converted from little-endian
> + *          as applicable.
> + */
> +struct gh_vm_exit_info {
> +	__u16 type;
> +	__u16 padding;
> +	__u32 reason_size;
> +	__u8 reason[GH_VM_MAX_EXIT_REASON_SIZE];
> +};
> +

Define this group of values in an enumerated type.
Are these the possible "exit_reason" values?  If so,
maybe name them GH_VCPU_EXIT_REASON_*.

> +#define GH_VCPU_EXIT_UNKNOWN            0
> +#define GH_VCPU_EXIT_MMIO               1
> +#define GH_VCPU_EXIT_STATUS             2
> +
> +/**
> + * struct gh_vcpu_run - Application code obtains a pointer to the gh_vcpu_run
> + *                      structure by mmap()ing a vcpu fd.
> + * @immediate_exit: polled when scheduling the vcpu. If set, immediately returns -EINTR.
> + * @padding: padding bytes
> + * @exit_reason: Set when GH_VCPU_RUN returns successfully and gives reason why
> + *               GH_VCPU_RUN has stopped running the vCPU.
> + * @mmio: Used when exit_reason == GH_VCPU_EXIT_MMIO
> + *        The guest has faulted on an memory-mapped I/O instruction that
> + *        couldn't be satisfied by gunyah.
> + * @mmio.phys_addr: Address guest tried to access
> + * @mmio.data: the value that was written if `is_write == 1`. Filled by
> + *        user for reads (`is_wite == 0`).
> + * @mmio.len: Length of write. Only the first `len` bytes of `data`
> + *       are considered by Gunyah.
> + * @mmio.is_write: 1 if VM tried to perform a write, 0 for a read
> + * @status: Used when exit_reason == GH_VCPU_EXIT_STATUS.
> + *          The guest VM is no longer runnable. This struct informs why.
> + * @status.status: See `enum gh_vm_status` for possible values
> + * @status.exit_info: Used when status == GH_VM_STATUS_EXITED
> + */
> +struct gh_vcpu_run {
> +	/* in */
> +	__u8 immediate_exit;
> +	__u8 padding[7];
> +
> +	/* out */
> +	__u32 exit_reason;
> +
> +	union {
> +		struct {
> +			__u64 phys_addr;
> +			__u8  data[8];
> +			__u32 len;
> +			__u8  is_write;
> +		} mmio;
> +
> +		struct {
> +			enum gh_vm_status status;
> +			struct gh_vm_exit_info exit_info;
> +		} status;
> +	};
> +};
> +
> +#define GH_VCPU_RUN		_IO(GH_IOCTL_TYPE, 0x5)
> +#define GH_VCPU_MMAP_SIZE	_IO(GH_IOCTL_TYPE, 0x6)
> +
>   #endif

