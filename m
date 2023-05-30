Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EA8716DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjE3TpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjE3TpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:45:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5ECB2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:45:14 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f4b256a0c9so5462278e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685475912; x=1688067912;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPBl7CVyGi7z3EnEqP8i0l1/Rp7cAONGFh5tesIqeUQ=;
        b=wtwhG4hRQYmLsKNHr6yPT4PxwE86DRjpaU6CInTtWe3dQ2ORJ8RSSIXgYsctPq6pHo
         bsA42IlNLmBkPQ/aQjb3MZy6gU3CFsIMPdeyzO5j4eGvo6PIt1UYhJ6JtG0JRkrjaWE/
         YEPRJBYadY2QY5eqwR5qbTGk/gIuL7tzHKSoHirm3c9fjHaqMXhIqFETJLAJiR0SsQZt
         UteV3tsJK9l88yPqJbBHlLCTQ/TTfIPTf9CupsZwVq80qHHlujm3eCXZ5+6O7iHp23Qa
         xsyrUjkluvR9qYqvCyl6wKxZcjBrwKPcJRWYpUkob8CYw6mvzJUXwLLExLRFHhshXXLi
         ENfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685475912; x=1688067912;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPBl7CVyGi7z3EnEqP8i0l1/Rp7cAONGFh5tesIqeUQ=;
        b=J5IVyoUkzGNxzv19xBEGGrBodW7MdASARM530UPdUGTdErQejTiGdkZfIUezd+CiTY
         1+Xk8wmOo5eUeoW71Lp/xyPqnMBQ9GHaSR57q/4J0ealC+1FaeJgMQqnC7C7DOfgQ9yo
         Tc55aDryxpwaMwXWYI9SAqiA6aumaQ0Yt7GGTmjqSRJHWahmyW/KRwkxZgt5/fvl7N9G
         0gSVXbNX9MjYWCCWkf6/beXHJsnywjivK2CZGJ7+2ZxD9Xbq+TZLiOSIvn7vLTMlqXaw
         ZkTRhL21hTzGdENPkQoX071OjnOPB2pvdaSnXVB1UiPdFBCu+MuVdmzNJmCVHQm5Ov7y
         Lskg==
X-Gm-Message-State: AC+VfDxk6tCkCo5EH17VaZPVDV5zKhUEo7rrTO38/77XtVpI3SpM8FaH
        mRYey2QBZPc+YndWrQxC+Qlkag==
X-Google-Smtp-Source: ACHHUZ48qmvzgPiAm4eIF9ZN57Y01/3tKsrZOTUz5daAvG3cHRT2GRkwsPORqWGpzNxu5zinnU4l0w==
X-Received: by 2002:a2e:3101:0:b0:2a8:e642:8cdb with SMTP id x1-20020a2e3101000000b002a8e6428cdbmr1345004ljx.49.1685475912524;
        Tue, 30 May 2023 12:45:12 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id a24-20020a2e8618000000b002a76c16ad65sm3017684lji.87.2023.05.30.12.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 12:45:12 -0700 (PDT)
Message-ID: <0e9903c0-4669-9298-e0ee-72fc775998c3@linaro.org>
Date:   Tue, 30 May 2023 21:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230530193436.3833889-1-quic_bjorande@quicinc.com>
 <20230530193436.3833889-3-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 2/2] soc: qcom: rmtfs: Support dynamic placement of region
In-Reply-To: <20230530193436.3833889-3-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.05.2023 21:34, Bjorn Andersson wrote:
> In some configurations, the exact placement of the rmtfs shared memory
> region isn't so strict. In the current implementation the author of the
> DeviceTree source is forced to make up a memory region.
IIUC the test here would be... "works" / "doesn't", just as if one
misplaced the fixed region?

Does the downstream sharedmem-uio driver do any additional cryptic
magic or does it simply rely on the vendor's cma/dma pool settings?
Can we replicate its behavior to stop hardcoding rmtfs, period?

> 
> Extend the rmtfs memory driver to relieve the author of this
> responsibility by introducing support for using dynamic allocation in
> the driver.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 10 ++++
>  drivers/soc/qcom/rmtfs_mem.c            | 66 +++++++++++++++++++------
>  2 files changed, 61 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index d1440b790fa6..e6191b8ba4c6 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -12,6 +12,8 @@
>  #include "pm8998.dtsi"
>  #include "pmi8998.dtsi"
>  
> +/delete-node/ &rmtfs_mem;
> +
>  / {
>  	model = "Qualcomm Technologies, Inc. SDM845 MTP";
>  	compatible = "qcom,sdm845-mtp", "qcom,sdm845";
> @@ -48,6 +50,14 @@ vreg_s4a_1p8: pm8998-smps4 {
>  		vin-supply = <&vph_pwr>;
>  	};
>  
> +	rmtfs {
> +		compatible = "qcom,rmtfs-mem";
> +
> +		qcom,alloc-size = <(2*1024*1024)>;
> +		qcom,client-id = <1>;
> +		qcom,vmid = <15>;
> +	};
This should have been a separate patch.

> +
>  	thermal-zones {
>  		xo_thermal: xo-thermal {
>  			polling-delay-passive = <0>;
> diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> index f83811f51175..5f56ded9f905 100644
> --- a/drivers/soc/qcom/rmtfs_mem.c
> +++ b/drivers/soc/qcom/rmtfs_mem.c
> @@ -3,6 +3,8 @@
>   * Copyright (c) 2017 Linaro Ltd.
>   */
>  
> +#include "linux/gfp_types.h"
> +#include "linux/sizes.h"
<>?

>  #include <linux/kernel.h>
>  #include <linux/cdev.h>
>  #include <linux/err.h>
> @@ -168,23 +170,63 @@ static void qcom_rmtfs_mem_release_device(struct device *dev)
>  	kfree(rmtfs_mem);
>  }
>  
> +static int qcom_rmtfs_acquire_mem(struct device *dev, struct qcom_rmtfs_mem *rmtfs_mem)
> +{
> +	struct device_node *node = dev->of_node;
> +	struct reserved_mem *rmem;
> +	dma_addr_t dma_addr;
> +	void *mem;
> +	u32 size;
> +	int ret;
> +
> +	rmem = of_reserved_mem_lookup(node);
> +	if (rmem) {
> +		rmtfs_mem->addr = rmem->base;
> +		rmtfs_mem->size = rmem->size;
> +
> +		rmtfs_mem->base = devm_memremap(&rmtfs_mem->dev, rmtfs_mem->addr,
> +						rmtfs_mem->size, MEMREMAP_WC);
> +		if (IS_ERR(rmtfs_mem->base)) {
> +			dev_err(dev, "failed to remap rmtfs_mem region\n");
> +			return PTR_ERR(rmtfs_mem->base);
> +		}
> +
> +		return 0;
> +	}
> +
> +	ret = of_property_read_u32(node, "qcom,alloc-size", &size);
> +	if (ret < 0) {
> +		dev_err(dev, "rmtfs of unknown size\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Ensure that the protected region isn't adjacent to other protected
> +	 * regions by allocating an empty page on either side.
> +	 */
> +	mem = dma_alloc_coherent(dev, size + 2 * SZ_4K, &dma_addr, GFP_KERNEL);
Should this be made pagesize-independent? Can we even run non-4K kernels on msm?

Konrad
> +	if (mem) {
> +		rmtfs_mem->base = mem + SZ_4K;
> +		rmtfs_mem->addr = dma_addr + SZ_4K;
> +		rmtfs_mem->size = size;
> +
> +		return 0;
> +	}
> +
> +	dev_err(dev, "unable to allocate memory for rmtfs mem\n");
> +	return -ENOMEM;
> +}
> +
>  static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  {
>  	struct device_node *node = pdev->dev.of_node;
>  	struct qcom_scm_vmperm perms[NUM_MAX_VMIDS + 1];
> -	struct reserved_mem *rmem;
>  	struct qcom_rmtfs_mem *rmtfs_mem;
>  	u32 client_id;
>  	u32 vmid[NUM_MAX_VMIDS];
>  	int num_vmids;
>  	int ret, i;
>  
> -	rmem = of_reserved_mem_lookup(node);
> -	if (!rmem) {
> -		dev_err(&pdev->dev, "failed to acquire memory region\n");
> -		return -EINVAL;
> -	}
> -
>  	ret = of_property_read_u32(node, "qcom,client-id", &client_id);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to parse \"qcom,client-id\"\n");
> @@ -196,22 +238,16 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  	if (!rmtfs_mem)
>  		return -ENOMEM;
>  
> -	rmtfs_mem->addr = rmem->base;
>  	rmtfs_mem->client_id = client_id;
> -	rmtfs_mem->size = rmem->size;
>  
>  	device_initialize(&rmtfs_mem->dev);
>  	rmtfs_mem->dev.parent = &pdev->dev;
>  	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;
>  	rmtfs_mem->dev.release = qcom_rmtfs_mem_release_device;
>  
> -	rmtfs_mem->base = devm_memremap(&rmtfs_mem->dev, rmtfs_mem->addr,
> -					rmtfs_mem->size, MEMREMAP_WC);
> -	if (IS_ERR(rmtfs_mem->base)) {
> -		dev_err(&pdev->dev, "failed to remap rmtfs_mem region\n");
> -		ret = PTR_ERR(rmtfs_mem->base);
> +	ret = qcom_rmtfs_acquire_mem(&pdev->dev, rmtfs_mem);
> +	if (ret < 0)
>  		goto put_device;
> -	}
>  
>  	cdev_init(&rmtfs_mem->cdev, &qcom_rmtfs_mem_fops);
>  	rmtfs_mem->cdev.owner = THIS_MODULE;
