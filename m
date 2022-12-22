Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9B653F10
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiLVLci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiLVLcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:32:33 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BAB11445
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:32:31 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id x11so1594293ljh.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xNrstpPkvJFRU3x179oushCBItlthfa6HHIQMn+fl0=;
        b=XNJKvX44os/xzlB2h72vCCQF5Fv0fcE+P3d0QOrW/pnWMjm6sZkhRkyMnLZ7wyhbxN
         fyHkU+zC6lT0yI9fc9S0R8mh/q3ebB9jVfuKZQ4VKYikM71syttdD/ieZsLzXJWlOD8Y
         CxPwY7ROLDe2hZPcQ2YlvgcDMiZe64OsI17fNR6Z+u4++zz18ubguM3JQsrbdSBtBYO9
         nNlhpXVdz6USmyIHN17JFU2/UJ7WG4ODQtIg3FH6El8L/DOmmWSYV1hFHxtURomRggVL
         yP/yRRIDvCyohZPEyva/tmdthFBEsxMEI42oYR8r8Ky4zBCnT8kz2nhl2FhbCEMv93gE
         yN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xNrstpPkvJFRU3x179oushCBItlthfa6HHIQMn+fl0=;
        b=MVx91N/2NcCvf7g+AgV7mX3x+lskBjfG7nEEUxNhVMU7d7167YQmhzF0ww/hFwoFoc
         0U0w0HjWm968Gqa9/103YpFKUKPvFCscObqbO+yoUaNbEjIjocz4+5DS8RZWvXqQJChg
         PXdnj2NWAA6xdNtcLjZ5m+2/2TF6q3VZuYJwsmHR38o5yNNRLv7c7D2ypra1DVY8S07o
         2hOEAfQtF4YW8mlwPulnEXTXF7X3XB+Nnvxs8YdNUpAn3jW7xCQs4XoVOjFJdt3txUbk
         Az3jnfHWt36iPdwhjsXicJw7YeDAT1T69Vr3xF7pI/KdxkQ33AYlEA9RJGt+i8Qa5L1i
         0B/w==
X-Gm-Message-State: AFqh2krrbY5LRLM3q6m9gcTW7NRpQ5Ox+MXBq9LjqRDFtENAL4kQdIIZ
        eTg+QyTt54boHKC2NHkKVi+ctA==
X-Google-Smtp-Source: AMrXdXsDXofPLyRo/MZV5uBG6NHJwqJ3eB0L8o21eXuNvNJI/yZWhBhJCRXmf8lmR1CP3XUoAnriEQ==
X-Received: by 2002:a2e:3a15:0:b0:27b:4a50:b85b with SMTP id h21-20020a2e3a15000000b0027b4a50b85bmr1242261lja.29.1671708750035;
        Thu, 22 Dec 2022 03:32:30 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h6-20020a2e9006000000b0027a197d8247sm23693ljg.16.2022.12.22.03.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:32:29 -0800 (PST)
Message-ID: <b4777025-0220-b1e4-f6f3-00d75ec8f0be@linaro.org>
Date:   Thu, 22 Dec 2022 12:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Patch v1 01/10] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220160240.27494-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
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

On 20/12/2022 17:02, Sumit Gupta wrote:
> Adding Interconnect framework support to dynamically set the DRAM
> bandwidth from different clients. Both the MC and EMC drivers are
> added as ICC providers. The path for any request will be:
>  MC-Client[1-n] -> MC -> EMC -> EMEM/DRAM
> 
> MC clients will request for bandwidth to the MC driver which will
> pass the tegra icc node having current request info to the EMC driver.
> The EMC driver will send the BPMP Client ID, Client type and bandwidth
> request info to the BPMP-FW where the final DRAM freq for achieving the
> requested bandwidth is set based on the passed parameters.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/memory/tegra/mc.c           |  18 ++-
>  drivers/memory/tegra/tegra186-emc.c | 166 ++++++++++++++++++++++++++++
>  drivers/memory/tegra/tegra234.c     | 101 ++++++++++++++++-
>  include/soc/tegra/mc.h              |   7 ++
>  include/soc/tegra/tegra-icc.h       |  72 ++++++++++++
>  5 files changed, 362 insertions(+), 2 deletions(-)
>  create mode 100644 include/soc/tegra/tegra-icc.h
> 
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index 592907546ee6..ff887fb03bce 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -17,6 +17,7 @@
>  #include <linux/sort.h>
>  
>  #include <soc/tegra/fuse.h>
> +#include <soc/tegra/tegra-icc.h>
>  
>  #include "mc.h"
>  
> @@ -779,6 +780,7 @@ const char *const tegra_mc_error_names[8] = {
>   */
>  static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>  {
> +	struct tegra_icc_node *tnode;
>  	struct icc_node *node;
>  	unsigned int i;
>  	int err;
> @@ -792,7 +794,11 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>  	mc->provider.data = &mc->provider;
>  	mc->provider.set = mc->soc->icc_ops->set;
>  	mc->provider.aggregate = mc->soc->icc_ops->aggregate;
> -	mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;
> +	mc->provider.get_bw = mc->soc->icc_ops->get_bw;
> +	if (mc->soc->icc_ops->xlate)
> +		mc->provider.xlate = mc->soc->icc_ops->xlate;
> +	if (mc->soc->icc_ops->xlate_extended)
> +		mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;
>  
>  	err = icc_provider_add(&mc->provider);
>  	if (err)
> @@ -814,6 +820,10 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>  		goto remove_nodes;
>  
>  	for (i = 0; i < mc->soc->num_clients; i++) {
> +		tnode = kzalloc(sizeof(*tnode), GFP_KERNEL);
> +		if (!tnode)
> +			return -ENOMEM;
> +
>  		/* create MC client node */
>  		node = icc_node_create(mc->soc->clients[i].id);
>  		if (IS_ERR(node)) {
> @@ -828,6 +838,12 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>  		err = icc_link_create(node, TEGRA_ICC_MC);
>  		if (err)
>  			goto remove_nodes;
> +
> +		node->data = tnode;

Where is it freed?


(...)

>  
>  struct tegra_mc_ops {
> @@ -238,6 +243,8 @@ struct tegra_mc {
>  	struct {
>  		struct dentry *root;
>  	} debugfs;
> +
> +	struct tegra_icc_node *curr_tnode;
>  };
>  
>  int tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
> diff --git a/include/soc/tegra/tegra-icc.h b/include/soc/tegra/tegra-icc.h
> new file mode 100644
> index 000000000000..3855d8571281
> --- /dev/null
> +++ b/include/soc/tegra/tegra-icc.h

Why not in linux?

> @@ -0,0 +1,72 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2022-2023 NVIDIA CORPORATION.  All rights reserved.
> + */
> +
> +#ifndef MEMORY_TEGRA_ICC_H

This does not match the path/name.

> +#define MEMORY_TEGRA_ICC_H
> +
> +enum tegra_icc_client_type {
> +	TEGRA_ICC_NONE,
> +	TEGRA_ICC_NISO,
> +	TEGRA_ICC_ISO_DISPLAY,
> +	TEGRA_ICC_ISO_VI,
> +	TEGRA_ICC_ISO_AUDIO,
> +	TEGRA_ICC_ISO_VIFAL,
> +};
> +
> +struct tegra_icc_node {
> +	struct icc_node *node;
> +	struct tegra_mc *mc;
> +	u32 bpmp_id;
> +	u32 type;
> +};
> +
> +/* ICC ID's for MC client's used in BPMP */
> +#define TEGRA_ICC_BPMP_DEBUG		1
> +#define TEGRA_ICC_BPMP_CPU_CLUSTER0	2
> +#define TEGRA_ICC_BPMP_CPU_CLUSTER1	3
> +#define TEGRA_ICC_BPMP_CPU_CLUSTER2	4
> +#define TEGRA_ICC_BPMP_GPU		5
> +#define TEGRA_ICC_BPMP_CACTMON		6
> +#define TEGRA_ICC_BPMP_DISPLAY		7
> +#define TEGRA_ICC_BPMP_VI		8
> +#define TEGRA_ICC_BPMP_EQOS		9
> +#define TEGRA_ICC_BPMP_PCIE_0		10
> +#define TEGRA_ICC_BPMP_PCIE_1		11
> +#define TEGRA_ICC_BPMP_PCIE_2		12
> +#define TEGRA_ICC_BPMP_PCIE_3		13
> +#define TEGRA_ICC_BPMP_PCIE_4		14
> +#define TEGRA_ICC_BPMP_PCIE_5		15
> +#define TEGRA_ICC_BPMP_PCIE_6		16
> +#define TEGRA_ICC_BPMP_PCIE_7		17
> +#define TEGRA_ICC_BPMP_PCIE_8		18
> +#define TEGRA_ICC_BPMP_PCIE_9		19
> +#define TEGRA_ICC_BPMP_PCIE_10		20
> +#define TEGRA_ICC_BPMP_DLA_0		21
> +#define TEGRA_ICC_BPMP_DLA_1		22
> +#define TEGRA_ICC_BPMP_SDMMC_1		23
> +#define TEGRA_ICC_BPMP_SDMMC_2		24
> +#define TEGRA_ICC_BPMP_SDMMC_3		25
> +#define TEGRA_ICC_BPMP_SDMMC_4		26
> +#define TEGRA_ICC_BPMP_NVDEC		27
> +#define TEGRA_ICC_BPMP_NVENC		28
> +#define TEGRA_ICC_BPMP_NVJPG_0		29
> +#define TEGRA_ICC_BPMP_NVJPG_1		30
> +#define TEGRA_ICC_BPMP_OFAA		31
> +#define TEGRA_ICC_BPMP_XUSB_HOST	32
> +#define TEGRA_ICC_BPMP_XUSB_DEV		33
> +#define TEGRA_ICC_BPMP_TSEC		34
> +#define TEGRA_ICC_BPMP_VIC		35
> +#define TEGRA_ICC_BPMP_APE		36
> +#define TEGRA_ICC_BPMP_APEDMA		37
> +#define TEGRA_ICC_BPMP_SE		38
> +#define TEGRA_ICC_BPMP_ISP		39
> +#define TEGRA_ICC_BPMP_HDA		40
> +#define TEGRA_ICC_BPMP_VIFAL		41
> +#define TEGRA_ICC_BPMP_VI2FAL		42
> +#define TEGRA_ICC_BPMP_VI2		43
> +#define TEGRA_ICC_BPMP_RCE		44
> +#define TEGRA_ICC_BPMP_PVA		45
> +
> +#endif /* MEMORY_TEGRA_ICC_H */

Best regards,
Krzysztof

