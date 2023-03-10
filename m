Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DDC6B3C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCJKa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjCJKaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:30:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752C210C13A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 02:30:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so4569095wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 02:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678444216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Br/tDw2GlFjkNZdTES8uGn3IRc1zfPXazZDzXirshY=;
        b=S/253spPED/sv/JwraglQ+ux7jT198YShDNQb+u4lq6Y51vXcuZ5/uaJTD3zQQQwBH
         4sGCz4+kZCTiwyUqIu1ilE7qhM1gyV5XNnjqTG1/G57BJeF8AF8EIopuNagH8u0IhRHV
         NwjMYwLtJWK8HB/T6Q1mNt4/v8vOXOzQ6HkJozRytH+teAXuxPZgBNXDbM6zXm8lAwHb
         R5FyZh1lKjVA2flTa6ZdnQBs9hPyHbr4oYJcMLwmJMEWN4DIyUH2LKst2iSg+CNLhMvl
         Zhj0P9dhr60HZkuq691ZYWtOkD6MTAJTStmKP8oxx8LNsuMleFy7k9BcG/7HGWLkUHHx
         E2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678444216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Br/tDw2GlFjkNZdTES8uGn3IRc1zfPXazZDzXirshY=;
        b=J153fhkFn7Ds1ruPyc0eerAUkHOPuLytKacy4MOU73EmPeBmKYlH6oDhEcRHGGGduz
         977CgFec6WC639khXLtb6KwXGXWRY04trAjjJ1X3FwrtqzFcxTPl1NAPFLFxBWoxL2aP
         mv4uEHzxrcsjnlB04eGfE6O3FQxdHxz5wR37Sl+Zq1behHaatW2dHLvOZRnaTVi+ztgr
         vSSAk4lOgvKkvRjsTTrcnlSWeuuMDc61tBNuKGXS8oi/ueroqAfEcskK1NGooiBWJwYa
         3im9zdNoqQ7WB1Y55dN3bFZ1hBaX+jDv1gujPMujtxZhAIYEb3H+s2Jj0Ydde32rB7+H
         SqBQ==
X-Gm-Message-State: AO0yUKXtcwVGwgII3+G2qxWKoDoEzCUcH7oqoGE1cFjbo4jDpBsnxYgO
        ZDFOEdrsy72I2Zb949w9ISfo8g==
X-Google-Smtp-Source: AK7set8vnKP6T8A6zSfP/x6TAQj8Tms/Jlj4cEN/U+hzkD8dNGbFoBmLeq13PsGPe4T0edqArJnOgQ==
X-Received: by 2002:a05:600c:4587:b0:3df:e468:17dc with SMTP id r7-20020a05600c458700b003dfe46817dcmr1957531wmo.40.1678444215986;
        Fri, 10 Mar 2023 02:30:15 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 14-20020a05600c24ce00b003eb5a531232sm1641909wmu.38.2023.03.10.02.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 02:30:15 -0800 (PST)
Message-ID: <c37d2d5d-4a25-27de-3f80-033984232ed9@linaro.org>
Date:   Fri, 10 Mar 2023 10:30:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 11/21] nvmem: core: handle the absence of expected
 layouts
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
 <20230307165359.225361-12-miquel.raynal@bootlin.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230307165359.225361-12-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2023 16:53, Miquel Raynal wrote:
> Make nvmem_layout_get() return -EPROBE_DEFER while the expected layout
> is not available. This condition cannot be triggered today as nvmem
> layout drivers are initialed as part of an early init call, but soon
> these drivers will be converted into modules and be initialized with a
> standard priority, so the unavailability of the drivers might become a
> reality that must be taken care of.
> 
> Let's anticipate this by telling the caller the layout might not yet be
> available. A probe deferral is requested in this case.
> 
> Please note this does not affect any nvmem device not using layouts,
> because an early check against the "nvmem-layout" container presence
> will return NULL in this case.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Tested-by: Michael Walle <michael@walle.cc>
> ---
>   drivers/nvmem/core.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index b9be1faeb7be..51fd792b8d70 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -755,7 +755,7 @@ EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
>   static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
>   {

Any reason why this is not part of 10/21?

kernel doc for nvmem_layout_get needs updating with this behavior.


--srini

>   	struct device_node *layout_np, *np = nvmem->dev.of_node;
> -	struct nvmem_layout *l, *layout = NULL;
> +	struct nvmem_layout *l, *layout = ERR_PTR(-EPROBE_DEFER);
>   
>   	layout_np = of_get_child_by_name(np, "nvmem-layout");
>   	if (!layout_np)
> @@ -938,6 +938,13 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	 * pointer will be NULL and nvmem_layout_put() will be a noop.
>   	 */
>   	nvmem->layout = config->layout ?: nvmem_layout_get(nvmem);
> +	if (IS_ERR(nvmem->layout)) {
> +		rval = PTR_ERR(nvmem->layout);
> +		nvmem->layout = NULL;
> +
> +		if (rval == -EPROBE_DEFER)
> +			goto err_teardown_compat;
> +	}
>   
>   	if (config->cells) {
>   		rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
> @@ -970,6 +977,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   err_remove_cells:
>   	nvmem_device_remove_all_cells(nvmem);
>   	nvmem_layout_put(nvmem->layout);
> +err_teardown_compat:
>   	if (config->compat)
>   		nvmem_sysfs_remove_compat(nvmem, config);
>   err_put_device:
