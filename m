Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBEA673F18
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjASQkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjASQko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:40:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7A43D91D;
        Thu, 19 Jan 2023 08:40:43 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l8so2001207wms.3;
        Thu, 19 Jan 2023 08:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=paNDMUZKRq80K7oiniio5ntVIbj7lgvtgljPQ5bDLmE=;
        b=GAt5+IamOdPgJu/kNV04eKpUyXkEGj1FWaO5790ux2SdMpfaNB3FTfJ7I56L49PcIS
         tk1fU/j2Mi82ajL2MbszBy55TcmvRIrxYd3eLgs3VImfDy9A1A8ZRyLHh3Nss75rxWHz
         2Quvb5aRck7azj3NhwOpljB875WSD1x3x/ANhFTwaoR8da8B2nPXigZl7PlLCe7+NXA0
         t2uWL01EqcMOliElMtWn6TeXOdE3/pdOPR6YnCPfYzAX5eoajhu0wGxPPvQLvGqwIqqX
         OMxinu0lmmz7RDZxgYB3rKWmHrvPM66vHOnybbqCkpyheA14yGUqB9Vz8feA7zdUOgrl
         K21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=paNDMUZKRq80K7oiniio5ntVIbj7lgvtgljPQ5bDLmE=;
        b=hrDE45lYxjenmnVDXcKVCLJJjY6DtnI/snwk3RJhcUpf5oWXVk0KIMxH604ZwmTYxa
         Nf2kDxfyD79ngOxp3Hj1ZSkJUoqnkRsWiye0rvBdmBqZTpRgiusESkCRuuMIaJAiypsk
         THxvPGRdVRmoEH7pU67bueqw/VlvLXUKz8T+iQGkL15Csl9/Pby1BoPngB8GXgvOn8uM
         KH+jUr5xCm/uJJpErJfzelvFtFcrnJ9jWr8ws7Iy/SyN/XStZ7EIdIX3JbJLaF17bma/
         2E7BpSym5TVyA+i+DoDcRmNRcUWpffTeqO+TOeIBMyEgPNnXhtvzLPP9pjxOqVjb/KfQ
         6BKg==
X-Gm-Message-State: AFqh2ko5XbUv5aNjb/CwBp2EeV2/2WVi/RRxb3JG2fQ/PxwlVDASyFRr
        VYOCK1xCPjJwXvEGmkMJFpQ=
X-Google-Smtp-Source: AMrXdXuiiSvq2ea3vPo0TiPIxiXK3dtY93Jqly2huPyxl01zLsqyBJ4750j3Qrn6N2AjyK5hXTkGuA==
X-Received: by 2002:a05:600c:3296:b0:3cf:82b9:2fe6 with SMTP id t22-20020a05600c329600b003cf82b92fe6mr11463701wmp.8.1674146441967;
        Thu, 19 Jan 2023 08:40:41 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c1d8d00b003daf7721bb3sm5364846wms.12.2023.01.19.08.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 08:40:41 -0800 (PST)
Message-ID: <d7f4ef2d-ba09-b75a-0b28-f8fccb809345@gmail.com>
Date:   Thu, 19 Jan 2023 17:40:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] spi: spidev: add new mediatek support
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230118-mt8365-spi-support-v1-0-842a21e50494@baylibre.com>
 <20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/01/2023 17:28, Alexandre Mergnat wrote:
> Add the "mediatek,genio" compatible string to support Mediatek
> SPI controller on the genio boards.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/spi/spidev.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index 6313e7d0cdf8..e23b825b8d30 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -702,6 +702,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
>   	{ .name = "m53cpld" },
>   	{ .name = "spi-petra" },
>   	{ .name = "spi-authenta" },
> +	{ .name = "genio" },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
> @@ -728,6 +729,7 @@ static const struct of_device_id spidev_dt_ids[] = {
>   	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
>   	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
>   	{ .compatible = "micron,spi-authenta", .data = &spidev_of_check },
> +	{ .compatible = "mediatek,genio", .data = &spidev_of_check },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, spidev_dt_ids);
> 
