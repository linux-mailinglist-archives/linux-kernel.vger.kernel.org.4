Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC9968D601
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjBGLw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjBGLwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:52:24 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8420F2E0FA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:52:18 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so12988089wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 03:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OyoJuN/6LU3Bboa6HrWF3emMpW6LTbAHeVxTuS0iulE=;
        b=Ig8uQoIrkun5jDQks/bjYIm398HK0JtL2EoEb20gkk3DdrUD9GQPNoDfZl1U/tFbwS
         EsKlwLAfmMO/9uSzPpZ+N/qtFCa1BzFOfJkXOSOV035mUdfeQISUktLTz1ysBRBvB0hL
         bElZDQBRG6IYUmQWVmi6PrqckVCpfdqe1VeMwa2K4pfMv49UAZCviGyefK8lXrf7c0oO
         putGhrNmHkCECzfsPL1yzp8737Z90bChBboZE0xurqvtxYXG71Y9y5P7rWbxEEfRNUXp
         PMmepsm+vZJVH8IuaWKjewC7ANJlOoryBvUFtZre2QQ4in1o0HWKMKcb8M9kWh/cbu/l
         2kVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyoJuN/6LU3Bboa6HrWF3emMpW6LTbAHeVxTuS0iulE=;
        b=fSUuUQuDof4v/0w1/GQxAkUls5Ir/65q7QRg2bDMoHyH2uBlKryqa49uDAc294vTnf
         TDh5hzW2V38enoN7fE0pmAWNSE3UOIxedZkK4jXtF0MThwJsmxgWrDOy73JjdmJlxWBI
         JzB3H0T2JhI/glJEivh2pY7iEwErY3lCJJTaZu1BODy8IdNEy9TtnFX0bHh18VYg1nfm
         PnFmnKkFDUAc+bFgDZVy3DHGDkoux0TGfEbKWlmmqSEyOEg7SSAP3otjebK/Ze98bimU
         rsiZT/8nFtaeGkw4SL+Rvai0mqTamzO+Qs2H1pL81VT3Eb8M6my6gJfCUr+mdPxxENWI
         atJw==
X-Gm-Message-State: AO0yUKWHJ3QGu+mgAbmLnW8XjL97mJo0VBSIpEGQhgK21Yl+vdDc7SIU
        8rPBWZEIbSYKQNlqYOT3pPEhFw==
X-Google-Smtp-Source: AK7set+/NwX/2lFSlvGu/dXJP5TvtrUro6T9ufWwsOf3l8ph0CDdLl12H4gi8ebvNgTm4vUAMEXSsQ==
X-Received: by 2002:a05:600c:3287:b0:3d9:e5f9:984c with SMTP id t7-20020a05600c328700b003d9e5f9984cmr3639286wmp.2.1675770737120;
        Tue, 07 Feb 2023 03:52:17 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id n9-20020a05600c3b8900b003d9aa76dc6asm20035922wms.0.2023.02.07.03.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 03:52:16 -0800 (PST)
Message-ID: <5564746d-2221-8c3e-0c81-b320716ad114@linaro.org>
Date:   Tue, 7 Feb 2023 11:52:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 18/27] firmware: qcom_scm: Register Gunyah platform ops
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
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
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-19-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230120224627.4053418-19-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/01/2023 22:46, Elliot Berman wrote:
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

So far SCM usage has been as library of functions to talk to Secure 
world, now why is this selecting GUNYAH, it should be other way round.


>   
>   config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>   	bool "Qualcomm download mode enabled by default"
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 92763dce6477..20a1434087eb 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -17,6 +17,7 @@
>   #include <linux/clk.h>
>   #include <linux/reset-controller.h>
>   #include <linux/arm-smccc.h>
> +#include <linux/gunyah_rsc_mgr.h>
>   
>   #include "qcom_scm.h"
>   
> @@ -27,6 +28,9 @@ module_param(download_mode, bool, 0);
>   #define SCM_HAS_IFACE_CLK	BIT(1)
>   #define SCM_HAS_BUS_CLK		BIT(2)
>   
> +#define QCOM_SCM_RM_MANAGED_VMID	0x3A
> +#define QCOM_SCM_MAX_MANAGED_VMID	0x3F
> +
>   struct qcom_scm {
>   	struct device *dev;
>   	struct clk *core_clk;
> @@ -1292,6 +1296,99 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>   }
>   EXPORT_SYMBOL(qcom_scm_lmh_dcvsh);
>   
> +static int qcom_scm_gh_rm_pre_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel)
why can't this be an exported function like other scm interfaces?

We do not need a redirection here tbh.

That will also remove the need of gunyah_platform_hooks.c altogether, 
and you could call scm functions directly.
Correct me if this is not the case.



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
> +				ret = qcom_scm_assign_mem(
> +						le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
> +						le64_to_cpu(mem_parcel->mem_entries[i].size),
> +						&src_cpy, new_perms, 1);
> +				WARN_ON_ONCE(ret);
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
> +	u64 src = 0;
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
> +		ret = qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
> +						le64_to_cpu(mem_parcel->mem_entries[i].size),
> +						&src, &new_perms, 1);
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
> @@ -1414,6 +1511,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   	if (download_mode)
>   		qcom_scm_set_download_mode(true);
>   
> +	if (gh_rm_register_platform_ops(&qcom_scm_gh_rm_platform_ops))
> +		dev_warn(__scm->dev, "Gunyah RM platform ops were already registered\n");
> +
>   	return 0;
>   }
>   
