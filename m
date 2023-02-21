Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73DD69E2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjBUOzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBUOzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:55:32 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747E329164
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:55:31 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o4-20020a05600c4fc400b003e1f5f2a29cso3833428wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+KKLNS9ycU8bUHQDhhmWrpDSiK3F39vekEqnfNDvzk=;
        b=FiZav6HZ941r0qmUfFkY/27g1t6280/yp9qgZBEb0QaJwqv2BGSMTxhvzLdnDnOaDZ
         M+ltLYpkXjrM50VIJQ+AQf18C6Kz6LjZkJoqo0aOENslh6eoiFzrdOPHH+6tsmf1YDfN
         PQqJ4x8/9/UvQLzCY2vdbAMEvFHU8YCjht9eFnWrzIvswjW5/0+0EE2YQu9W3/fNX+eR
         OXd5f0y1IoQhJp5kkMJiwzbgouUsgN0FxHoc3xRTzSYWsPYpJYA5bHEhNkPcV/DrisP3
         1gDQJhcb3B+MkI+YvefWhji2VulE4tBW3455tHZocdIC1b2ISSOVYFoSyn5o8+NOLNmv
         E5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+KKLNS9ycU8bUHQDhhmWrpDSiK3F39vekEqnfNDvzk=;
        b=KFNY6ev8e+nKUBdIOkoaWTBnScJKAyTPuflRi3796/I7Hx6Y7F0yiUKxRkCQMGc9Dy
         hkbE0PIgYyMGX6Np2BjVWxppWSRODEnVFCef+dJ1Sd4s81GjxTR1rNmVeKZF29xZnSDF
         99C2KfuAvWCUJN2WW4yYP4VPzcB3/HnVUmy0D8WxRyD2pSBKvdnfV5dNYaAZT1jkPIYE
         nCdId0sNZHadMu9nCs/skuzTfb4oaOmRURkvZFoOG88r+Nxw4zgyXtwjrrdRRs/D37ye
         zKOKMOUOX6MkBabM584u/VvXgWWX9ZCdHQRJ+UqB5SeUUpHQNJho1lJX8tqsAMZTJKTV
         AIGg==
X-Gm-Message-State: AO0yUKXwLYJiE+xZkk43pxe/xf43R+pEpUwvCHQk9FGOnix2t/Xz2uu7
        Yu0lfvmORPbgJip0DO7QMNkQ7g==
X-Google-Smtp-Source: AK7set9Ad86INkNtADXbvxyunm3B2VebhN8+bcplkMAQslqdZWghkZaya9+2AdQqEuG6i9K2C+ER0Q==
X-Received: by 2002:a05:600c:4393:b0:3e2:8f1:7684 with SMTP id e19-20020a05600c439300b003e208f17684mr3074361wmn.33.1676991329905;
        Tue, 21 Feb 2023 06:55:29 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id z20-20020a7bc7d4000000b003daf6e3bc2fsm4718883wmk.1.2023.02.21.06.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 06:55:29 -0800 (PST)
Message-ID: <e6832902-a48a-039e-0227-9a165109d660@linaro.org>
Date:   Tue, 21 Feb 2023 14:55:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 16/26] firmware: qcom_scm: Register Gunyah platform
 ops
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <20230214212457.3319814-1-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230214212457.3319814-1-quic_eberman@quicinc.com>
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



On 14/02/2023 21:24, Elliot Berman wrote:
> 
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
>   drivers/firmware/Kconfig    |   2 +
>   drivers/firmware/qcom_scm.c | 100 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 102 insertions(+)
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

This is really making all the Qualcomm platforms either with Gunyah and 
non-Gunyah hypervisors to enable VIRT_DRIVERS and GUNYAH_PLATFORM_HOOKS 
in there kernel builds, that is not right way to do this.

SCM is used as library so lets keep it that way, I have added some 
comments on platform hooks patch and potential way I see that this can 
be done without making SCM aware of GUNAYAH internals.

--srini
>   
>   config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>   	bool "Qualcomm download mode enabled by default"
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 468d4d5ab550..875040982b48 100644
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
> @@ -1297,6 +1301,99 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
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
> +static struct gunyah_rm_platform_ops qcom_scm_gh_rm_platform_ops = {
> +	.pre_mem_share = qcom_scm_gh_rm_pre_mem_share,
> +	.post_mem_reclaim = qcom_scm_gh_rm_post_mem_reclaim,
> +};
> +
>   static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
>   {
>   	struct device_node *tcsr;
> @@ -1500,6 +1597,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   	if (download_mode)
>   		qcom_scm_set_download_mode(true);
>   
> +	if (devm_gh_rm_register_platform_ops(&pdev->dev, &qcom_scm_gh_rm_platform_ops))
> +		dev_warn(__scm->dev, "Gunyah RM platform ops were already registered\n");
> +
>   	return 0;
>   }
>   
