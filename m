Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652B06C3422
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCUOZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjCUOY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:24:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3490047400
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:24:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so60399095edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679408661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzwY28iBGjWIhbVh1Kcj4nSjeYbY2fFbRNe8TV7tK/c=;
        b=YG1lI7KOvYc4bVgqGkHKHisTMdv6NDIyvXgIZsIPEI49HUXXSuyW/D0rBmtVuTyUEH
         8Lio+7U7MwXbHFg+DVKd2EMK6oR6gjE5fjHKVqoAfkEpI/6xWH5ZJZMqN4DwkX3AnSfl
         MkyLqmpUFHkJHij1JpGFyZkKvOtI4G2g4g9WF1LCT2O3jTsfTr5BxM9mToHjUxKC5J42
         LvtJCLMU814jmrl52M4o/Dpuy95LJBP7497twBBB7fBcjtignwez0MX5dVaU4PwYt+gQ
         wO2SfjhyOgN1cebBj0CzSlWPLEPBIwkmlmJEyHyD1EyMo4H58y/nzCpuY3S0EWLx5b//
         gRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679408661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzwY28iBGjWIhbVh1Kcj4nSjeYbY2fFbRNe8TV7tK/c=;
        b=Oh5rrzgmITXsvNDIbIjtBiuEggFfbxyHK+/cc9SFW8NbB9gfEBTiznSg1QBybvt8w5
         3q2e1zqdnjVuS6T3tCYzRXrWWKi8INaoiG6VwqJWAe+Ut3w6Gieeq0jUvonZ5Fw8x8Bu
         2FUIFfgtKdXS7FD9rBiolF+SA0Qnbgo+1jsfBt2ULjlhDVkwaLZCKjfRdManYILrbtbD
         Z/qPBsODUVHcAZmXkwaOKQcCVdU4MPIJql0FoKLrqh57cJBR5veR29UL1MmgX1bFCSVi
         ympXU1rezh2Z3CLuUPb430/HDqYUN1f5SRc0NRPSWQ6p9qk0n3papLUUZfUQOTA5Rb+q
         JCBA==
X-Gm-Message-State: AO0yUKUJSHh/hgnOse5+TTydlD7bzEHtyqANEDDDFGo9qMj1y4ynGa7p
        /BH/x460W/K4/1iicB+Xo+Catg==
X-Google-Smtp-Source: AK7set8UkzzYZ3OfKTXuWe+5StrysxPwmobiX7lPhtLrk1tr6NErYtzM0tofuPA83nYg3z6T0Nvaqw==
X-Received: by 2002:a17:906:1810:b0:939:5720:a2db with SMTP id v16-20020a170906181000b009395720a2dbmr3359547eje.8.1679408661456;
        Tue, 21 Mar 2023 07:24:21 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id s15-20020a170906c30f00b00922a79e79c2sm5849164ejz.217.2023.03.21.07.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 07:24:20 -0700 (PDT)
Message-ID: <6c2e3fac-1bd8-be10-6e10-e200ee9b55f2@linaro.org>
Date:   Tue, 21 Mar 2023 14:24:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v11 16/26] firmware: qcom_scm: Register Gunyah platform
 ops
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-17-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230304010632.2127470-17-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot,

On 04/03/2023 01:06, Elliot Berman wrote:
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
> ---
>   drivers/firmware/Kconfig       |   2 +
>   drivers/firmware/qcom_scm.c    | 100 +++++++++++++++++++++++++++++++++
>   include/linux/gunyah_rsc_mgr.h |   2 +-
>   3 files changed, 103 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b59e3041fd62..b888068ff6f2 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -214,6 +214,8 @@ config MTK_ADSP_IPC
>   
>   config QCOM_SCM
>   	tristate
> +	select VIRT_DRIVERS
> +	select GUNYAH_PLATFORM_HOOKS
>

I still have concerns with this selects in Kconfig on older Qualcomm 
platforms that use SCM and do not have GUNYAH.

In our last discussing you mentioned the requirement for
"CONFIG_GUNYAH=y and CONFIG_QCOM_SCM=m"

I think that should be doable and remove selecting if you can make a 
separate GUNYAH_QCOM_PLATFORM_HOOKS driver

Does this work?
 >----------------------->cut<-------------------------------
 From 1fb7995aecf17caefd09ffb516579bc4ac9ac301 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 21 Mar 2023 13:34:02 +0000
Subject: [PATCH] virt: gunyah: add qcom platform hooks

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
  drivers/firmware/Kconfig                      |  2 --
  drivers/firmware/qcom_scm.c                   | 14 +++-----
  drivers/virt/gunyah/Kconfig                   |  5 +++
  drivers/virt/gunyah/Makefile                  |  1 +
  .../virt/gunyah/gunyah_qcom_platform_hooks.c  | 35 +++++++++++++++++++
  include/linux/firmware/qcom/qcom_scm.h        |  3 ++
  6 files changed, 48 insertions(+), 12 deletions(-)
  create mode 100644 drivers/virt/gunyah/gunyah_qcom_platform_hooks.c

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b888068ff6f2..b59e3041fd62 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -214,8 +214,6 @@ config MTK_ADSP_IPC

  config QCOM_SCM
  	tristate
-	select VIRT_DRIVERS
-	select GUNYAH_PLATFORM_HOOKS

  config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
  	bool "Qualcomm download mode enabled by default"
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 5273cf64ee2a..194ea2bc9a1d 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1301,7 +1301,7 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 
payload_reg, u32 payload_val,
  }
  EXPORT_SYMBOL(qcom_scm_lmh_dcvsh);

-static int qcom_scm_gh_rm_pre_mem_share(struct gh_rm *rm, struct 
gh_rm_mem_parcel *mem_parcel)
+int qcom_scm_gh_rm_pre_mem_share(struct gh_rm_mem_parcel *mem_parcel)
  {
  	struct qcom_scm_vmperm *new_perms;
  	u64 src, src_cpy;
@@ -1359,8 +1359,9 @@ static int qcom_scm_gh_rm_pre_mem_share(struct 
gh_rm *rm, struct gh_rm_mem_parce
  	kfree(new_perms);
  	return ret;
  }
+EXPORT_SYMBOL_GPL(qcom_scm_gh_rm_pre_mem_share);

-static int qcom_scm_gh_rm_post_mem_reclaim(struct gh_rm *rm, struct 
gh_rm_mem_parcel *mem_parcel)
+int qcom_scm_gh_rm_post_mem_reclaim(struct gh_rm_mem_parcel *mem_parcel)
  {
  	struct qcom_scm_vmperm new_perms;
  	u64 src = 0, src_cpy;
@@ -1388,11 +1389,7 @@ static int qcom_scm_gh_rm_post_mem_reclaim(struct 
gh_rm *rm, struct gh_rm_mem_pa

  	return ret;
  }
-
-static struct gh_rm_platform_ops qcom_scm_gh_rm_platform_ops = {
-	.pre_mem_share = qcom_scm_gh_rm_pre_mem_share,
-	.post_mem_reclaim = qcom_scm_gh_rm_post_mem_reclaim,
-};
+EXPORT_SYMBOL_GPL(qcom_scm_gh_rm_post_mem_reclaim);

  static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
  {
@@ -1597,9 +1594,6 @@ static int qcom_scm_probe(struct platform_device 
*pdev)
  	if (download_mode)
  		qcom_scm_set_download_mode(true);

-	if (devm_gh_rm_register_platform_ops(&pdev->dev, 
&qcom_scm_gh_rm_platform_ops))
-		dev_warn(__scm->dev, "Gunyah RM platform ops were already registered\n");
-
  	return 0;
  }

diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index bd8e31184962..a9c48d6518f7 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -16,6 +16,11 @@ config GUNYAH
  config GUNYAH_PLATFORM_HOOKS
  	tristate

+config GUNYAH_QCOM_PLATFORM_HOOKS
+	tristate "Gunyah Platform hooks for Qualcomm"
+        depends on ARCH_QCOM && QCOM_SCM
+	depends on GUNYAH
+
  config GUNYAH_VCPU
  	tristate "Runnable Gunyah vCPUs"
  	depends on GUNYAH
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 7347b1470491..c33f701bb5c8 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -2,6 +2,7 @@

  obj-$(CONFIG_GUNYAH) += gunyah.o
  obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
+obj-$(CONFIG_GUNYAH_QCOM_PLATFORM_HOOKS) += gunyah_qcom_platform_hooks.o

  gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
  obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/gunyah_qcom_platform_hooks.c 
b/drivers/virt/gunyah/gunyah_qcom_platform_hooks.c
new file mode 100644
index 000000000000..3332f84134d3
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_qcom_platform_hooks.c
@@ -0,0 +1,35 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/gunyah_rsc_mgr.h>
+
+static int qcom_gh_rm_pre_mem_share(struct gh_rm *rm, struct 
gh_rm_mem_parcel *mem_parcel)
+{
+	return qcom_scm_gh_rm_pre_mem_share(mem_parcel);
+}
+
+static int qcom_gh_rm_post_mem_reclaim(struct gh_rm *rm, struct 
gh_rm_mem_parcel *mem_parcel)
+{
+	return qcom_scm_gh_rm_post_mem_reclaim(mem_parcel);
+}
+
+static struct gh_rm_platform_ops qcom_gh_platform_hooks_ops = {
+	.pre_mem_share = qcom_gh_rm_pre_mem_share,
+	.post_mem_reclaim = qcom_gh_rm_post_mem_reclaim,
+};
+
+static int __init qcom_gh_platform_hooks_register(void)
+{
+	return gh_rm_register_platform_ops(&qcom_gh_platform_hooks_ops);
+}
+
+static void __exit qcom_gh_platform_hooks_unregister(void)
+{
+	gh_rm_unregister_platform_ops(&qcom_gh_platform_hooks_ops);
+}
+
+module_init(qcom_gh_platform_hooks_register);
+module_exit(qcom_gh_platform_hooks_unregister);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Gunyah Platform Hooks 
driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/firmware/qcom/qcom_scm.h 
b/include/linux/firmware/qcom/qcom_scm.h
index 1e449a5d7f5c..9b0d33db803d 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -121,5 +121,8 @@ extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 
payload_reg, u32 payload_val,
  			      u64 limit_node, u32 node_id, u64 version);
  extern int qcom_scm_lmh_profile_change(u32 profile_id);
  extern bool qcom_scm_lmh_dcvsh_available(void);
+struct gh_rm_mem_parcel;
+extern int qcom_scm_gh_rm_post_mem_reclaim(struct gh_rm_mem_parcel 
*mem_parcel);
+extern int qcom_scm_gh_rm_pre_mem_share(struct gh_rm_mem_parcel 
*mem_parcel);

  #endif
--------------------------->cut<-----------------------

>   config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>   	bool "Qualcomm download mode enabled by default"
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index b95616b35bff..89a261a9e021 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -20,6 +20,7 @@
>   #include <linux/clk.h>
>   #include <linux/reset-controller.h>
>   #include <linux/arm-smccc.h>
> +#include <linux/gunyah_rsc_mgr.h>
>   
>   #include "qcom_scm.h"
>   
> @@ -30,6 +31,9 @@ module_param(download_mode, bool, 0);
>   #define SCM_HAS_IFACE_CLK	BIT(1)
>   #define SCM_HAS_BUS_CLK		BIT(2)
>   
> +#define QCOM_SCM_RM_MANAGED_VMID	0x3A
> +#define QCOM_SCM_MAX_MANAGED_VMID	0x3F
> +
>   struct qcom_scm {
>   	struct device *dev;
>   	struct clk *core_clk;
> @@ -1299,6 +1303,99 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>   }
>   EXPORT_SYMBOL(qcom_scm_lmh_dcvsh);
>   
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
> +		if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_X)
> +			new_perms[n].perm |= QCOM_SCM_PERM_EXEC;
> +		if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_W)
> +			new_perms[n].perm |= QCOM_SCM_PERM_WRITE;
> +		if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_R)
> +			new_perms[n].perm |= QCOM_SCM_PERM_READ;
> +	}
> +
> +	src = (1ull << QCOM_SCM_VMID_HLOS);
> +
> +	for (i = 0; i < mem_parcel->n_mem_entries; i++) {
> +		src_cpy = src;
> +		ret = qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
> +						le64_to_cpu(mem_parcel->mem_entries[i].size),
> +						&src_cpy, new_perms, mem_parcel->n_acl_entries);
> +		if (ret) {
> +			src = 0;
> +			for (n = 0; n < mem_parcel->n_acl_entries; n++) {
> +				vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
> +				if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
> +					src |= (1ull << vmid);
> +				else
> +					src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
> +			}
> +
> +			new_perms[0].vmid = QCOM_SCM_VMID_HLOS;
> +
> +			for (i--; i >= 0; i--) {
> +				src_cpy = src;
> +				WARN_ON_ONCE(qcom_scm_assign_mem(
> +						le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
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
> +		ret = qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
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
>   static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
>   {
>   	struct device_node *tcsr;
> @@ -1502,6 +1599,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   	if (download_mode)
>   		qcom_scm_set_download_mode(true);
>   
> +	if (devm_gh_rm_register_platform_ops(&pdev->dev, &qcom_scm_gh_rm_platform_ops))
> +		dev_warn(__scm->dev, "Gunyah RM platform ops were already registered\n");
> +
>   	return 0;
>   }
>   
> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> index 515087931a2b..acf8c1545a6c 100644
> --- a/include/linux/gunyah_rsc_mgr.h
> +++ b/include/linux/gunyah_rsc_mgr.h
> @@ -145,7 +145,7 @@ int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
>   				struct gh_rm_hyp_resources **resources);
>   int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
>   
> -struct gunyah_rm_platform_ops {
> +struct gh_rm_platform_ops {
>   	int (*pre_mem_share)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
>   	int (*post_mem_reclaim)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
>   };
