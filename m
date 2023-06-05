Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C080D723043
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbjFETte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbjFETtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:49:06 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071410E2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:48:46 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33b6c47898dso26925185ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994525; x=1688586525;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wl7EFgUA9cMgMK8O5jKjE2iLt6anAcaO3TwMrZK2D3s=;
        b=RRQhWuf/hwrL/iNreMkEwvmD9kY8GdruyfEUh3ZBdEb2pxaRXc/mk/yFoDtx1XUvZG
         ez+iNh4zlfj4LsGZ3XN4fl41HQ0mQE6Zos6dcgvLFL6sp0M+Z7aLokRUIIGCxtKHl++B
         OnGYa2IrkOCi1hPdwpvNxFAXYz0/tY4gXFg/AlBoTDwJM5BcEc1sZ4w5bYOWZ2Fz3yQ+
         +kpJrcV/qxgPyLfLU1Jz49Kq7euPEIfRXZmcyHuwEJjjwemiOnTvOoDEtqgLCB8M17H8
         w1a1CmwyF23EeOuw4oPTKVKLq1eQticeI5Mod+OqrssjWtjGCJQB4bmHgbfV30AxgNxd
         ibbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994525; x=1688586525;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wl7EFgUA9cMgMK8O5jKjE2iLt6anAcaO3TwMrZK2D3s=;
        b=F8Tu4LKIpZg0PWmaC0KinLCkd/uYhqb5RWCHQpLK3KmkCl7Nb24eU/tcoJC4LQaS1r
         0xaaNB+lByz0O7JcrU7lFWYPzj5EBJeMFtOWgXBYb/noPzufQhPpBYe4j5sMTbLwe/aF
         +eRHkkZ2p1oVHoqRTTo6YaAQufLfIhKQi6T080gMuFs/vyOgQupDrcjD6Nkj2DED2LWw
         6BvAYSVqfqNdkcGJ3XM8KhUMmJ7mC2giFN/qtt74OBQB4Bkhc8uOUvq6YflwBjTUE/KJ
         QXDGR7K939IsPmWRMv48qwnU8P0ajcHNwxvERXGizsA0N+tuLSsiUsQcg3h584Yi9G2D
         j7GQ==
X-Gm-Message-State: AC+VfDxv2MOYIEk3U3b24AF8j/nHoJ2XqyjEd9lKyK5M4VSz6qTcj8Vy
        QmFgV8bPQhWz96X42Ip4tPtDsw==
X-Google-Smtp-Source: ACHHUZ4oK5asULJo4ciPjnrVpsFgr5YF/uOT+xhOu+bkswaC95rOsaHPXFs9rNqi+DS0oTXURm6w5w==
X-Received: by 2002:a92:c08f:0:b0:331:4f70:a2b with SMTP id h15-20020a92c08f000000b003314f700a2bmr115113ile.5.1685994525224;
        Mon, 05 Jun 2023 12:48:45 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id i14-20020a02ca4e000000b0041f4f31ec7esm1247291jal.71.2023.06.05.12.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:48:44 -0700 (PDT)
Message-ID: <026fb04d-6d58-8d9c-8208-4f34a287a78f@linaro.org>
Date:   Mon, 5 Jun 2023 14:48:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v13 14/24] virt: gunyah: Add Qualcomm Gunyah platform ops
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
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
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-15-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230509204801.2824351-15-quic_eberman@quicinc.com>
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
> Qualcomm platforms have a firmware entity which performs access control
> to physical pages. Dynamically started Gunyah virtual machines use the
> QCOM_SCM_RM_MANAGED_VMID for access. Linux thus needs to assign access
> to the memory used by guest VMs. Gunyah doesn't do this operation for us
> since it is the current VM (typically VMID_HLOS) delegating the access
> and not Gunyah itself. Use the Gunyah platform ops to achieve this so
> that only Qualcomm platforms attempt to make the needed SCM calls.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Minor suggestions below.  Please consider them, but either way:

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/virt/gunyah/Kconfig       |  13 +++
>   drivers/virt/gunyah/Makefile      |   1 +
>   drivers/virt/gunyah/gunyah_qcom.c | 147 ++++++++++++++++++++++++++++++
>   3 files changed, 161 insertions(+)
>   create mode 100644 drivers/virt/gunyah/gunyah_qcom.c
> 
> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
> index de815189dab6..0421b751aad4 100644
> --- a/drivers/virt/gunyah/Kconfig
> +++ b/drivers/virt/gunyah/Kconfig
> @@ -5,6 +5,7 @@ config GUNYAH
>   	depends on ARM64
>   	depends on MAILBOX
>   	select GUNYAH_PLATFORM_HOOKS
> +	imply GUNYAH_QCOM_PLATFORM if ARCH_QCOM
>   	help
>   	  The Gunyah drivers are the helper interfaces that run in a guest VM
>   	  such as basic inter-VM IPC and signaling mechanisms, and higher level
> @@ -15,3 +16,15 @@ config GUNYAH
>   
>   config GUNYAH_PLATFORM_HOOKS
>   	tristate
> +
> +config GUNYAH_QCOM_PLATFORM
> +	tristate "Support for Gunyah on Qualcomm platforms"
> +	depends on GUNYAH
> +	select GUNYAH_PLATFORM_HOOKS
> +	select QCOM_SCM
> +	help
> +	  Enable support for interacting with Gunyah on Qualcomm
> +	  platforms. Interaction with Qualcomm firmware requires
> +	  extra platform-specific support.
> +
> +	  Say Y/M here to use Gunyah on Qualcomm platforms.
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index 4fbeee521d60..2aa9ff038ed0 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
>   obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
> +obj-$(CONFIG_GUNYAH_QCOM_PLATFORM) += gunyah_qcom.o
>   
>   gunyah-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
>   obj-$(CONFIG_GUNYAH) += gunyah.o
> diff --git a/drivers/virt/gunyah/gunyah_qcom.c b/drivers/virt/gunyah/gunyah_qcom.c
> new file mode 100644
> index 000000000000..18acbda8fcbd
> --- /dev/null
> +++ b/drivers/virt/gunyah/gunyah_qcom.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/gunyah_rsc_mgr.h>
> +#include <linux/module.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/types.h>
> +#include <linux/uuid.h>
> +
> +#define QCOM_SCM_RM_MANAGED_VMID	0x3A
> +#define QCOM_SCM_MAX_MANAGED_VMID	0x3F

Is this limited to 63 because there are at most 64 VMIDs
that can be represented in a 64-bit unsigned?

> +
> +static int qcom_scm_gh_rm_pre_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel)
> +{
> +	struct qcom_scm_vmperm *new_perms;
> +	u64 src, src_cpy;
> +	int ret = 0, i, n;
> +	u16 vmid;
> +
> +	new_perms = kcalloc(mem_parcel->n_acl_entries, sizeof(*new_perms), GFP_KERNEL);
> +	if (!new_perms)
> +		return -ENOMEM;
> +
> +	for (n = 0; n < mem_parcel->n_acl_entries; n++) {
> +		vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
> +		if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
> +			new_perms[n].vmid = vmid;
> +		else
> +			new_perms[n].vmid = QCOM_SCM_RM_MANAGED_VMID;

So any out-of-range VM ID will cause the hunk of memory to
be assigned to the resource manager.  Is it expected that
this can occur (and not be an error)?

> +		if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_X)
> +			new_perms[n].perm |= QCOM_SCM_PERM_EXEC;
> +		if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_W)
> +			new_perms[n].perm |= QCOM_SCM_PERM_WRITE;
> +		if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_R)
> +			new_perms[n].perm |= QCOM_SCM_PERM_READ;
> +	}
> +
> +	src = (1ull << QCOM_SCM_VMID_HLOS);

	src = BIT_ULL(QCOM_SCM_VMID_HLOS);

> +
> +	for (i = 0; i < mem_parcel->n_mem_entries; i++) {
> +		src_cpy = src;
> +		ret = qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
> +						le64_to_cpu(mem_parcel->mem_entries[i].size),
> +						&src_cpy, new_perms, mem_parcel->n_acl_entries);

Loops like this can look simpler if you jump to error handling
at the end that does this unwind activity, rather than incorporating
it inside the loop itself.  Or even just breaking if ret != 0, e.g.:

		if (ret)
			break;
	}

	if (!ret)
		return 0;

	/* And do the following block here, "outdented" twice */

> +		if (ret) {
> +			src = 0;
> +			for (n = 0; n < mem_parcel->n_acl_entries; n++) {
> +				vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
> +				if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
> +					src |= (1ull << vmid);

	src |= BIT_ULL(vmid);

> +				else
> +					src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);

	src |= BIT_ULL(QCOM_SCM_RM_MANAGED_VMID);

> +			}
> +
> +			new_perms[0].vmid = QCOM_SCM_VMID_HLOS;
> +
> +			for (i--; i >= 0; i--) {
> +				src_cpy = src;
> +				WARN_ON_ONCE(qcom_scm_assign_mem(
> +						le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
> +						le64_to_cpu(mem_parcel->mem_entries[i].size),
> +						&src_cpy, new_perms, 1));
> +			}
> +			break;
> +		}
> +	}
> +
> +	kfree(new_perms);
> +	return ret;
> +}
> +
> +static int qcom_scm_gh_rm_post_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel)
> +{
> +	struct qcom_scm_vmperm new_perms;
> +	u64 src = 0, src_cpy;
> +	int ret = 0, i, n;
> +	u16 vmid;
> +
> +	new_perms.vmid = QCOM_SCM_VMID_HLOS;
> +	new_perms.perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ;
> +
> +	for (n = 0; n < mem_parcel->n_acl_entries; n++) {
> +		vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
> +		if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
> +			src |= (1ull << vmid);
> +		else
> +			src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
> +	}
> +
> +	for (i = 0; i < mem_parcel->n_mem_entries; i++) {
> +		src_cpy = src;
> +		ret = qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].phys_addr),
> +						le64_to_cpu(mem_parcel->mem_entries[i].size),
> +						&src_cpy, &new_perms, 1);
> +		WARN_ON_ONCE(ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static struct gh_rm_platform_ops qcom_scm_gh_rm_platform_ops = {
> +	.pre_mem_share = qcom_scm_gh_rm_pre_mem_share,
> +	.post_mem_reclaim = qcom_scm_gh_rm_post_mem_reclaim,
> +};
> +
> +/* {19bd54bd-0b37-571b-946f-609b54539de6} */
> +static const uuid_t QCOM_EXT_UUID =
> +	UUID_INIT(0x19bd54bd, 0x0b37, 0x571b, 0x94, 0x6f, 0x60, 0x9b, 0x54, 0x53, 0x9d, 0xe6);
> +
> +#define GH_QCOM_EXT_CALL_UUID_ID	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
> +							   ARM_SMCCC_OWNER_VENDOR_HYP, 0x3f01)
> +
> +static bool gh_has_qcom_extensions(void)
> +{
> +	struct arm_smccc_res res;
> +	uuid_t uuid;
> +
> +	arm_smccc_1_1_smc(GH_QCOM_EXT_CALL_UUID_ID, &res);
> +
> +	((u32 *)&uuid.b[0])[0] = lower_32_bits(res.a0);
> +	((u32 *)&uuid.b[0])[1] = lower_32_bits(res.a1);
> +	((u32 *)&uuid.b[0])[2] = lower_32_bits(res.a2);
> +	((u32 *)&uuid.b[0])[3] = lower_32_bits(res.a3);

I said this elsewhere.  I'd rather see:

	u32 *u = (u32 *)&uuid;		/* Or &uuid.b? */

	*u++ = lower_32_bits(res.a0);
		. . .

> +
> +	return uuid_equal(&uuid, &QCOM_EXT_UUID);
> +}
> +
> +static int __init qcom_gh_platform_hooks_register(void)
> +{
> +	if (!gh_has_qcom_extensions())
> +		return -ENODEV;
> +
> +	return gh_rm_register_platform_ops(&qcom_scm_gh_rm_platform_ops);
> +}
> +
> +static void __exit qcom_gh_platform_hooks_unregister(void)
> +{
> +	gh_rm_unregister_platform_ops(&qcom_scm_gh_rm_platform_ops);
> +}
> +
> +module_init(qcom_gh_platform_hooks_register);
> +module_exit(qcom_gh_platform_hooks_unregister);
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Platform Hooks for Gunyah");
> +MODULE_LICENSE("GPL");

