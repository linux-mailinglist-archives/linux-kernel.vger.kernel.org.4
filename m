Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB0D74AD2E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGGIfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjGGIff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:35:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674E4113
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:35:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99342a599e9so201100966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 01:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688718932; x=1691310932;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gfp5YnplyNI7ZZxVR1nzYlh1znSHp2pyPlsqgetXBH0=;
        b=a5YGKsob76RZKcNb3APPFN49ojM4izecoEniz8wRkWSvlHkYnoI9FH8/5bfNrJa8La
         UUf77hiBedWBZQVl9PhNLmwYTYv+v8FVsf6/kVQhWx/HPpv1kuji9w509zUctM+BsX9u
         NmnBF2AtaDMGfwPMBJiRsQ2aMstNsNT+4Bt5Svlcy+SMXTCp8Gd06F31D6mMtW3e5m00
         kHNUssJoXqNtKY0J4xdrW9rFHVUseww9g8FSeZcRCZBXiflYa5aIm/8vBPTg0ZpTxq4g
         HbHVh3fCjfjHzAZ3ZH5YN4cmzrG1rvqzi2nQMSmXrZcQ6FKw1UVzJr//r1nGcEOz6FlS
         tIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688718932; x=1691310932;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gfp5YnplyNI7ZZxVR1nzYlh1znSHp2pyPlsqgetXBH0=;
        b=SfQ6Seo0KbKI6opYq7CdWRgkSlmOck2h8AgPOig+4CEgasosJEkG3ByaomXKe5Ubvr
         YIIY86ll2Mi3sL7BFH+KEw4Fj7z03ucfDi4tLnBdFdF3UPboiuIP1gC4siuy3706FBzy
         fKZ7cc6EekazDe+zlYdT+lI6RekQcKGH3/6/yakvY16973nWHd2QKYY8D4/pLeWZSVYS
         qRNvVVMqUbxZ6z4N0KYFsfM0p/Bd1814S0ueI1hMI9MiBcCFFyhMc+4DoIhtsHKhk92K
         Wmh1tZQhZv4x1zn9DLJkG5mjCmqvcrWFc9Hl11OUJK2gvBCBJPdWirGg0nMH2gWrTOVH
         d+8Q==
X-Gm-Message-State: ABy/qLZH95FV6iFQo1FnjXUAy88wMSTCyjkmI4CWcLlJ7p3x9NAVEbXS
        XRZ1jTe6kwWnzLlK+Z4CiZo/GQ==
X-Google-Smtp-Source: APBJJlHVIcrQOa49qCeTblKamg9Js3+YQHLGpbElKy5lgi88UbQJqiq2QghEYQEOIEcpcwgasbL4Yw==
X-Received: by 2002:a17:906:338e:b0:992:3ac7:a2d8 with SMTP id v14-20020a170906338e00b009923ac7a2d8mr2931894eja.37.1688718931759;
        Fri, 07 Jul 2023 01:35:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906c29000b00991d54db2acsm1869577ejz.44.2023.07.07.01.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 01:35:31 -0700 (PDT)
Message-ID: <a0387aa9-80b1-bd80-4316-82a0f95cd747@linaro.org>
Date:   Fri, 7 Jul 2023 10:35:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 2/3] usb: gadget: udc: gxp-udc: add HPE GXP USB support
Content-Language: en-US
To:     richard.yu@hpe.com, verdun@hpe.com, nick.hawkins@hpe.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230706215910.78772-1-richard.yu@hpe.com>
 <20230706215910.78772-3-richard.yu@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230706215910.78772-3-richard.yu@hpe.com>
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

On 06/07/2023 23:59, richard.yu@hpe.com wrote:
> From: Richard Yu <richard.yu@hpe.com>
> 
> The HPE GXP vEHCI controller presents a four port EHCI compatible PCI
> function to host software. Each vEHCI port is logically connected to a
> corresponding set of virtual device registers.
> 
> Signed-off-by: Richard Yu <richard.yu@hpe.com>
> ---
>  drivers/usb/gadget/udc/Kconfig   |    6 +
>  drivers/usb/gadget/udc/Makefile  |    1 +
>  drivers/usb/gadget/udc/gxp-udc.c | 1401 ++++++++++++++++++++++++++++++
>  3 files changed, 1408 insertions(+)
>  create mode 100644 drivers/usb/gadget/udc/gxp-udc.c
> 
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
> index 83cae6bb12eb..c01eb2a2c7db 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -461,6 +461,12 @@ config USB_ASPEED_UDC
>  	  dynamically linked module called "aspeed_udc" and force all
>  	  gadget drivers to also be dynamically linked.

...

> +
> +static void gxp_udc_dev_release(struct device *dev)
> +{
> +	kfree(dev);
> +}
> +
> +int gxp_udc_init_dev(struct gxp_udcg_drvdata *udcg, unsigned int idx)
> +{
> +	struct gxp_udc_drvdata *drvdata;
> +	struct device *parent = &udcg->pdev->dev;
> +	int rc;
> +
> +	drvdata = devm_kzalloc(parent, sizeof(struct gxp_udc_drvdata),
> +			       GFP_KERNEL);

sizeof(*...)

> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	udcg->udc_drvdata[idx] = drvdata;
> +	drvdata->pdev = udcg->pdev;

Why do you store platform_device? It's usually useless because dev is used.

> +	drvdata->vdevnum = idx;
> +	drvdata->base = udcg->base + 0x1000 * idx;
> +	drvdata->udcg_map = udcg->udcg_map;
> +	drvdata->irq = udcg->irq;
> +
> +	/*
> +	 * we setup USB device can have up to 4 endpoints besides control
> +	 * endpoint 0.
> +	 */
> +	drvdata->fepnum = min_t(u32, udcg->max_fepnum, 4);
> +
> +	drvdata->vdevnum = idx;
> +
> +	/*
> +	 * The UDC core really needs us to have separate and uniquely
> +	 * named "parent" devices for each port so we create a sub device
> +	 * here for that purpose
> +	 */
> +	drvdata->port_dev = kzalloc(sizeof(*drvdata->port_dev), GFP_KERNEL);
> +	if (!drvdata->port_dev) {
> +		rc = -ENOMEM;
> +		goto fail_alloc;
> +	}
> +	device_initialize(drvdata->port_dev);
> +	drvdata->port_dev->release = gxp_udc_dev_release;
> +	drvdata->port_dev->parent = parent;
> +	dev_set_name(drvdata->port_dev, "%s:p%d", dev_name(parent), idx + 1);
> +
> +	/* DMA setting */
> +	drvdata->port_dev->dma_mask = parent->dma_mask;
> +	drvdata->port_dev->coherent_dma_mask = parent->coherent_dma_mask;
> +	drvdata->port_dev->bus_dma_limit = parent->bus_dma_limit;
> +	drvdata->port_dev->dma_range_map = parent->dma_range_map;
> +	drvdata->port_dev->dma_parms = parent->dma_parms;
> +	drvdata->port_dev->dma_pools = parent->dma_pools;
> +
> +	rc = device_add(drvdata->port_dev);
> +	if (rc)
> +		goto fail_add;
> +
> +	/* Populate gadget */
> +	gxp_udc_init(drvdata);
> +
> +	rc = usb_add_gadget_udc(drvdata->port_dev, &drvdata->gadget);
> +	if (rc != 0) {
> +		dev_err(drvdata->port_dev, "add gadget failed\n");

return dev_err_probe

> +		goto fail_udc;
> +	}
> +	rc = devm_request_irq(drvdata->port_dev,
> +			      drvdata->irq,
> +			      gxp_udc_irq,
> +			      IRQF_SHARED,
> +			      gxp_udc_name[drvdata->vdevnum],
> +			      drvdata);

Shared interrupt usually does not work with devm() and causes later
issues. You need to triple check your unbind and error paths, because
usually this just does not work. Usually we just don't allow devm for
this case. If you are sure this is 100% correct, it could stay...

> +
> +	if (rc < 0) {
> +		dev_err(drvdata->port_dev, "irq request failed\n");

return dev_err_probe

> +		goto fail_udc;
> +	}
> +
> +	return 0;
> +
> +fail_udc:
> +	device_del(drvdata->port_dev);
> +fail_add:
> +	put_device(drvdata->port_dev);
> +fail_alloc:
> +	kfree(drvdata);

Are you sure you tested it? I see here double free.

> +
> +	return rc;
> +}
> +
> +static int gxp_udcg_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct gxp_udcg_drvdata *drvdata;
> +	int ret, rc, err;
> +	u32 vdevnum;
> +	u32 fepnum, i;
> +
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gxp_udcg_drvdata),

sizeof(*...)

> +			       GFP_KERNEL);
> +	platform_set_drvdata(pdev, drvdata);
> +	drvdata->pdev = pdev;

Why do you store platform_device? It's usually useless because dev is used.

> +
> +	spin_lock_init(&drvdata->lock);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "udcg");
> +	drvdata->udcg_base = devm_ioremap_resource(&pdev->dev, res);

Use helper for these two.

> +	if (IS_ERR(drvdata->udcg_base)) {
> +		err = PTR_ERR(drvdata->udcg_base);

Drop

> +		return dev_err_probe(&pdev->dev, err, "failed to get udcg resource\n");
> +	}
> +
> +	drvdata->udcg_map = devm_regmap_init_mmio(&pdev->dev, drvdata->udcg_base, &regmap_cfg);
> +
> +	if (IS_ERR(drvdata->udcg_map)) {
> +		dev_err(&pdev->dev, "failed to map udcg regs");

return dev_err_probe

> +		return -ENODEV;

Wrong error code

> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "udc");
> +	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(drvdata->base)) {
> +		err = PTR_ERR(drvdata->base);

Drop

> +		return dev_err_probe(&pdev->dev, err, "failed to get udc resource\n");
> +	}
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "unable to obtain IRQ number\n");

return dev_err_probe

> +		return ret;
> +	}
> +	drvdata->irq = ret;
> +
> +	if (of_property_read_u32(pdev->dev.of_node, "hpe,vehci-downstream-ports", &vdevnum)) {
> +		dev_err(&pdev->dev, "property ports number is undefined\n");
> +		return -EINVAL;
> +	}
> +
> +	if (vdevnum > GXP_UDC_MAX_NUM_VDEVICE) {
> +		dev_err(&pdev->dev, "property max port number(%d) is invalid\n", vdevnum);
> +		return -EINVAL;
> +	}
> +	drvdata->max_vdevnum = vdevnum;
> +
> +	if (of_property_read_u32(pdev->dev.of_node, "hpe,vehci-generic-endpoints", &fepnum)) {
> +		dev_err(&pdev->dev, "property generic endpoints is undefined\n");
> +		return -EINVAL;

Why? Bindings stated it has default, so should not be required.

> +	}
> +
> +	if (fepnum > GXP_UDC_MAX_NUM_FLEX_EP) {
> +		dev_err(&pdev->dev, "property fepnum(%d) is invalid\n", fepnum);
> +		return -EINVAL;
> +	}
> +	drvdata->max_fepnum = fepnum;
> +
> +	gxp_udcg_init(drvdata);
> +
> +	/* Init child devices */
> +	rc = 0;
> +	for (i = 0; i < drvdata->max_vdevnum && rc == 0; i++)
> +		rc = gxp_udc_init_dev(drvdata, i);
> +
> +	return rc;
> +}
> +
> +static const struct of_device_id gxp_udc_of_match[] = {
> +	{ .compatible = "hpe,gxp-udcg" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, gxp_udc_of_match);
> +
> +static struct platform_driver gxp_udc_driver = {
> +	.driver = {
> +		.name = "gxp-udc",
> +		.of_match_table = of_match_ptr(gxp_udc_of_match),

Drop of_match_ptr(), you will have warnings here.

> +	},
> +	.probe = gxp_udcg_probe,
> +};
> +module_platform_driver(gxp_udc_driver);
> +
> +MODULE_AUTHOR("Richard Yu <richard.yu@hpe.com>");
> +MODULE_DESCRIPTION("HPE GXP vEHCI UDC Driver");
> +MODULE_LICENSE("GPL");

Best regards,
Krzysztof

