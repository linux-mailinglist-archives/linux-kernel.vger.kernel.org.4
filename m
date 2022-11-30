Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4924363D66C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiK3NPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiK3NPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:15:45 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8668156D4B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:15:44 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id d3so20846599ljl.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9RJJvSXTQMT1an5CIXkme+jgVFu+5jDbx7yYrLYEMo=;
        b=T8siylcYJhFzeVW2Pa2yjr65ggsHkA6sR8MOoOuFYqW9+NslqOxhLbGzAb8jniSst5
         +e53xZ0k782syQimCkdvl8jqZ4fvOotIQzEzX0s2gvIPTOz2nu4lRgXglg9Zs8vxN6FM
         99IRE3Jt/q5hHWDKEAsmqEaF12sM3httNNYWZnYyfuzX2dUSofZp4X5OJq1Fco67JoBQ
         2R6dMQskN/Azcq/YMkP1UiLVsQGQEY9+v+PrwsQ8zlIPB3VzzErx7Nc/lHNmuSBtx6lj
         zVaCtCBGsJjNc1nIivkH3CFnC11baTo7kDHXZvMcSRg3jcr42lx8eIIOl/+NgMvAjTuh
         PZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9RJJvSXTQMT1an5CIXkme+jgVFu+5jDbx7yYrLYEMo=;
        b=o+vSZ7u4x/NsZG+RPoGZjSefqogMLl07lM6ATkT1RDDHUhoLmmy80JD0OxQhrpbHK2
         ubAnhRYZ9fQJ6eNXzThHVjzWD05EXasY8p3IIdzyPaW99agkBuLqtri0ERMj9bpqStNp
         6NzmcY98FDiVWEqm09Qsaxz3bkzWdSEdBqZZwOT8RW6+0IGhx+hDD5KeWEm5kEazfCL5
         E1YGsZ1diUHcH9RPOsMCPH+p9W86YTTc1Gdi8h4rSdAz/sCKtaCgfuQNNcBc/1mQH8lx
         JgZ5fSKCm9GaLUOnZrUBfgXQSHkv3UYNtklOTnvvsm3pTtTQ08rFG/IpVddTI3K9E6XW
         tYOg==
X-Gm-Message-State: ANoB5pmGqTMUL1KlX81bxcF8GGIGlcQHc3GgFU5n4jZstQQyT2SIoA45
        KJRt2AT06eK5UNEqX+skok0mHg==
X-Google-Smtp-Source: AA0mqf6GUKd3RLZFRiiBYCHpapXpYrRHHSq+GvhYwBckvIrdhVico0tU25zsxMjNNeg1EiVFnRRXBw==
X-Received: by 2002:a2e:9d10:0:b0:26d:ecd9:aec2 with SMTP id t16-20020a2e9d10000000b0026decd9aec2mr20221064lji.80.1669814142762;
        Wed, 30 Nov 2022 05:15:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i16-20020a2ea370000000b002793dd2b36dsm128423ljn.126.2022.11.30.05.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 05:15:42 -0800 (PST)
Message-ID: <aafb1c32-bc00-2db2-edbd-aa4771f33ac7@linaro.org>
Date:   Wed, 30 Nov 2022 14:15:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/6] crypto: starfive - Add StarFive crypto engine support
Content-Language: en-US
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
 <20221130055214.2416888-2-jiajie.ho@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221130055214.2416888-2-jiajie.ho@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 06:52, Jia Jie Ho wrote:
> Adding device probe and DMA init for StarFive
> hardware crypto engine.
> 
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
> ---


> +
> +static const struct of_device_id starfive_dt_ids[] = {
> +	{ .compatible = "starfive,jh7110-crypto", .data = NULL},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, starfive_dt_ids);

Keep your table close to its usage, just like in many other drivers.

> +
> +static int starfive_dma_init(struct starfive_sec_dev *sdev)
> +{
> +	dma_cap_mask_t mask;
> +	int err;
> +
> +	sdev->sec_xm_m = NULL;
> +	sdev->sec_xm_p = NULL;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	sdev->sec_xm_m = dma_request_chan(sdev->dev, "sec_m");
> +	if (IS_ERR(sdev->sec_xm_m)) {
> +		dev_err(sdev->dev, "sec_m dma channel request failed.\n");

return dev_err_probe

> +		return PTR_ERR(sdev->sec_xm_m);
> +	}
> +
> +	sdev->sec_xm_p = dma_request_chan(sdev->dev, "sec_p");
> +	if (IS_ERR(sdev->sec_xm_p)) {
> +		dev_err(sdev->dev, "sec_p dma channel request failed.\n");

dev_err_probe

> +		goto err_dma_out;
> +	}
> +
> +	init_completion(&sdev->sec_comp_m);
> +	init_completion(&sdev->sec_comp_p);
> +
> +	return 0;
> +
> +err_dma_out:
> +	dma_release_channel(sdev->sec_xm_m);

I don't think you tested it. Not even built with proper tools liek
smatch, sparse, W=1. Where do you set err?

> +
> +	return err;
> +}
> +
> +static void starfive_dma_cleanup(struct starfive_sec_dev *sdev)
> +{
> +	dma_release_channel(sdev->sec_xm_p);
> +	dma_release_channel(sdev->sec_xm_m);
> +}
> +
> +static int starfive_cryp_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct starfive_sec_dev *sdev;
> +	struct resource *res;
> +	int pages = 0;
> +	int ret;
> +
> +	sdev = devm_kzalloc(dev, sizeof(*sdev), GFP_KERNEL);
> +	if (!sdev)
> +		return -ENOMEM;
> +
> +	sdev->dev = dev;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "secreg");
> +	sdev->io_base = devm_ioremap_resource(dev, res);

I think there is a wrapper for both calls...

> +
> +	if (IS_ERR(sdev->io_base))
> +		return PTR_ERR(sdev->io_base);
> +
> +	sdev->use_side_channel_mitigation =
> +		device_property_read_bool(dev, "enable-side-channel-mitigation");
> +	sdev->use_dma = device_property_read_bool(dev, "enable-dma");
> +	sdev->dma_maxburst = 32;
> +
> +	sdev->sec_hclk = devm_clk_get(dev, "sec_hclk");
> +	if (IS_ERR(sdev->sec_hclk)) {
> +		dev_err(dev, "Failed to get sec_hclk.\n");
> +		return PTR_ERR(sdev->sec_hclk);

return dev_err_probe

> +	}
> +
> +	sdev->sec_ahb = devm_clk_get(dev, "sec_ahb");
> +	if (IS_ERR(sdev->sec_ahb)) {
> +		dev_err(dev, "Failed to get sec_ahb.\n");
> +		return PTR_ERR(sdev->sec_ahb);

return dev_err_probe

> +	}
> +
> +	sdev->rst_hresetn = devm_reset_control_get_shared(sdev->dev, "sec_hre");
> +	if (IS_ERR(sdev->rst_hresetn)) {
> +		dev_err(sdev->dev, "Failed to get sec_hre.\n");
> +		return PTR_ERR(sdev->rst_hresetn);

return dev_err_probe

> +	}
> +
> +	clk_prepare_enable(sdev->sec_hclk);
> +	clk_prepare_enable(sdev->sec_ahb);
> +	reset_control_deassert(sdev->rst_hresetn);
> +
> +	platform_set_drvdata(pdev, sdev);
> +
> +	spin_lock(&dev_list.lock);
> +	list_add(&sdev->list, &dev_list.dev_list);
> +	spin_unlock(&dev_list.lock);
> +
> +	if (sdev->use_dma) {
> +		ret = starfive_dma_init(sdev);
> +		if (ret) {
> +			dev_err(dev, "Failed to initialize DMA channel.\n");
> +			goto err_dma_init;
> +		}
> +	}
> +
> +	pages = get_order(STARFIVE_MSG_BUFFER_SIZE);
> +
> +	sdev->pages_count = pages >> 1;
> +	sdev->data_buf_len = STARFIVE_MSG_BUFFER_SIZE >> 1;
> +
> +	/* Initialize crypto engine */
> +	sdev->engine = crypto_engine_alloc_init(dev, 1);
> +	if (!sdev->engine) {
> +		ret = -ENOMEM;
> +		goto err_engine;
> +	}
> +
> +	ret = crypto_engine_start(sdev->engine);
> +	if (ret)
> +		goto err_engine_start;
> +
> +	dev_info(dev, "Crypto engine started\n");

Drop silly probe success messages.

> +
> +	return 0;
> +
> +err_engine_start:
> +	crypto_engine_exit(sdev->engine);
> +err_engine:
> +	starfive_dma_cleanup(sdev);
> +err_dma_init:
> +	spin_lock(&dev_list.lock);
> +	list_del(&sdev->list);
> +	spin_unlock(&dev_list.lock);
> +
> +	return ret;
> +}
> +
> +static int starfive_cryp_remove(struct platform_device *pdev)
> +{
> +	struct starfive_sec_dev *sdev = platform_get_drvdata(pdev);
> +
> +	if (!sdev)
> +		return -ENODEV;
> +
> +	crypto_engine_stop(sdev->engine);
> +	crypto_engine_exit(sdev->engine);
> +
> +	starfive_dma_cleanup(sdev);
> +
> +	spin_lock(&dev_list.lock);
> +	list_del(&sdev->list);
> +	spin_unlock(&dev_list.lock);
> +
> +	clk_disable_unprepare(sdev->sec_hclk);
> +	clk_disable_unprepare(sdev->sec_ahb);
> +	reset_control_assert(sdev->rst_hresetn);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int starfive_cryp_runtime_suspend(struct device *dev)
> +{
> +	struct starfive_sec_dev *sdev = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(sdev->sec_ahb);
> +	clk_disable_unprepare(sdev->sec_hclk);
> +
> +	return 0;
> +}
> +
> +static int starfive_cryp_runtime_resume(struct device *dev)
> +{
> +	struct starfive_sec_dev *sdev = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(sdev->sec_ahb);
> +	if (ret) {
> +		dev_err(sdev->dev, "Failed to prepare_enable sec_ahb clock\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(sdev->sec_hclk);
> +	if (ret) {
> +		dev_err(sdev->dev, "Failed to prepare_enable sec_hclk clock\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops starfive_cryp_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(starfive_cryp_runtime_suspend,
> +			   starfive_cryp_runtime_resume, NULL)
> +};
> +
> +static struct platform_driver starfive_cryp_driver = {
> +	.probe  = starfive_cryp_probe,
> +	.remove = starfive_cryp_remove,
> +	.driver = {
> +		.name           = DRIVER_NAME,
> +		.pm		= &starfive_cryp_pm_ops,
> +		.of_match_table = starfive_dt_ids,
> +	},
> +};
> +
> +module_platform_driver(starfive_cryp_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("StarFive hardware crypto acceleration");
> diff --git a/drivers/crypto/starfive/starfive-regs.h b/drivers/crypto/starfive/starfive-regs.h
> new file mode 100644
> index 000000000000..0d680cb1f502
> --- /dev/null
> +++ b/drivers/crypto/starfive/starfive-regs.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __STARFIVE_REGS_H__
> +#define __STARFIVE_REGS_H__
> +
> +#define STARFIVE_ALG_CR_OFFSET			0x0
> +#define STARFIVE_ALG_FIFO_OFFSET		0x4
> +#define STARFIVE_IE_MASK_OFFSET			0x8
> +#define STARFIVE_IE_FLAG_OFFSET			0xc
> +#define STARFIVE_DMA_IN_LEN_OFFSET		0x10
> +#define STARFIVE_DMA_OUT_LEN_OFFSET		0x14
> +
> +union starfive_alg_cr {
> +	u32 v;
> +	struct {
> +		u32 start			:1;
> +		u32 aes_dma_en			:1;
> +		u32 rsvd_0			:1;
> +		u32 hash_dma_en			:1;
> +		u32 alg_done			:1;
> +		u32 rsvd_1			:3;
> +		u32 clear			:1;
> +		u32 rsvd_2			:23;
> +	};
> +};
> +
> +#endif
> diff --git a/drivers/crypto/starfive/starfive-str.h b/drivers/crypto/starfive/starfive-str.h
> new file mode 100644
> index 000000000000..4ba3c56f0573
> --- /dev/null
> +++ b/drivers/crypto/starfive/starfive-str.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __STARFIVE_STR_H__
> +#define __STARFIVE_STR_H__
> +
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +
> +#include <crypto/engine.h>
> +
> +#include "starfive-regs.h"
> +
> +#define STARFIVE_MSG_BUFFER_SIZE		SZ_16K
> +
> +struct starfive_sec_ctx {
> +	struct crypto_engine_ctx		enginectx;
> +	struct starfive_sec_dev			*sdev;
> +
> +	u8					*buffer;
> +};
> +
> +struct starfive_sec_dev {
> +	struct list_head			list;
> +	struct device				*dev;
> +
> +	struct clk				*sec_hclk;
> +	struct clk				*sec_ahb;
> +	struct reset_control			*rst_hresetn;
> +
> +	void __iomem				*io_base;
> +	phys_addr_t				io_phys_base;
> +
> +	size_t					data_buf_len;
> +	int					pages_count;
> +	u32					use_side_channel_mitigation;
> +	u32					use_dma;
> +	u32					dma_maxburst;
> +	struct dma_chan				*sec_xm_m;
> +	struct dma_chan				*sec_xm_p;
> +	struct dma_slave_config			cfg_in;
> +	struct dma_slave_config			cfg_out;
> +	struct completion			sec_comp_m;
> +	struct completion			sec_comp_p;
> +
> +	struct crypto_engine			*engine;
> +
> +	union starfive_alg_cr			alg_cr;
> +};
> +
> +static inline u32 starfive_sec_read(struct starfive_sec_dev *sdev, u32 offset)
> +{
> +	return __raw_readl(sdev->io_base + offset);

I don't think these read/write wrappers help anyhow...


Best regards,
Krzysztof

