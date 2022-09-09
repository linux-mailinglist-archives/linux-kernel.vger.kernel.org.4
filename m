Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8CF5B3251
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiIIIwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiIIIwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DCD12FB93
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:52:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so3947513wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=xUYfPwKfjWj8UMEg1ZOqkwBhAmHe0cmPeP+wDEVrkOQ=;
        b=TubYt+GybM3R6FXjLZ/HMzhZe/TPRKvDFmW4wnSeSjkjwv7l4KlvYzC5QXADNJrGvd
         JOaD0zwqo1+n1dO/0X9WCrJ7DwiGCZ7yCZGN06+ztXv9HvKgMtS19rT43Y5/dXIu5bXS
         eYqIliMmVz+St0Navdlh2leuJlnzrJG4A5smh9Mf/cH8z2wJxaSKk+s9q/9dMTSgz3eM
         ch5re4PO6rxPqhP8acOlfiWaCVtgnEGZqqLvRPb+VjfyOC5uKlYUq9zOq9fx+tE6VNE9
         sc58LAPXfMnjboti2FKUJnFRul2unn2US5QO1sBHb80J369YvubNxnXsut6Tq0lcidTu
         S7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xUYfPwKfjWj8UMEg1ZOqkwBhAmHe0cmPeP+wDEVrkOQ=;
        b=0FEzqL2SmZFG1P8eWVM6I3zsAGQPq9gZ1ncYRJBu/fQ+93OHl2zAtfxWyGpecNlLUa
         FBxsolldxR++5WH7jmCjHK0bSLc/KjeUlxgNHqNZslg6R3tlqyNAk01utI2DiimQl87k
         SBDEqg2IxbnCSPpUESeCQ7lZiwm9+r/zrC70hyZAAkEjQtsjsyHeJLAXv98kjRln5vbI
         FEy0VvZE3KHYNLvRVBqOCQ9uQJ7V8ADfDf3f6Wg561YTHUd7eRJyB4FYU+jOYA16+7RG
         fFIO/S3m7uFcvJi5Ye7S5O7XL2iAoBg/IokNU+GBmCORwPc6CLw65KrYUIjF3YI7Z+oC
         eQOQ==
X-Gm-Message-State: ACgBeo1HgV6QD/OQP5P4vbTtJpyEBmQAc2UUOw8N6j8vzfG/i3FuiOSm
        L7xE4DCUU2fOaIQ+4oSxAX2WBQ==
X-Google-Smtp-Source: AA6agR6YJCB2REeMJ4VtYkJNS0dCNv+3+WdATOvoAFtL5QD6iWSIVlpuGC2hE4dJ8XV2FmJqUy44nw==
X-Received: by 2002:a05:600c:2059:b0:3a5:92cc:19c5 with SMTP id p25-20020a05600c205900b003a592cc19c5mr4469580wmg.101.1662713534861;
        Fri, 09 Sep 2022 01:52:14 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id bg35-20020a05600c3ca300b003a5c1e916c8sm1012461wmb.1.2022.09.09.01.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 01:52:13 -0700 (PDT)
Message-ID: <bee9db9d-fc1b-41d8-5714-1c7f48bb0722@linaro.org>
Date:   Fri, 9 Sep 2022 09:52:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 06/20] nvmem: core: add nvmem_add_one_cell()
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20220901221857.2600340-1-michael@walle.cc>
 <20220901221857.2600340-7-michael@walle.cc>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220901221857.2600340-7-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/2022 23:18, Michael Walle wrote:
> Add a new function to add exactly one cell. This will be used by the
> nvmem layout drivers to add custom cells. In contrast to the
> nvmem_add_cells(), this has the advantage that we don't have to assemble
> a list of cells on runtime.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v1:
>   - none
> 
>   drivers/nvmem/core.c           | 58 ++++++++++++++++++++--------------
>   include/linux/nvmem-provider.h |  8 +++++
>   2 files changed, 42 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index be38e62fd190..3dfd149374a8 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -501,6 +501,35 @@ static int nvmem_cell_info_to_nvmem_cell_entry(struct nvmem_device *nvmem,
>   	return 0;
>   }
>   
> +/**
> + * nvmem_add_one_cell() - Add one cell information to an nvmem device
> + *
> + * @nvmem: nvmem device to add cells to.
> + * @info: nvmem cell info to add to the device
> + *
> + * Return: 0 or negative error code on failure.
> + */
> +int nvmem_add_one_cell(struct nvmem_device *nvmem,
> +		       const struct nvmem_cell_info *info)
> +{
> +	struct nvmem_cell_entry *cell;
> +	int rval;
> +
> +	cell = kzalloc(sizeof(*cell), GFP_KERNEL);
> +	if (!cell)
> +		return -ENOMEM;
> +
> +	rval = nvmem_cell_info_to_nvmem_cell_entry(nvmem, info, cell);
> +	if (rval) {
> +		kfree(cell);
> +		return rval;
> +	}
> +
> +	nvmem_cell_entry_add(cell);
> +
> +	return 0;
> +}
> +

EXPORT_SYMBOL_GPL ???

>   /**
>    * nvmem_add_cells() - Add cell information to an nvmem device
>    *
> @@ -514,34 +543,15 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
>   		    const struct nvmem_cell_info *info,
>   		    int ncells)
>   {
> -	struct nvmem_cell_entry **cells;
> -	int i, rval = 0;
> -
> -	cells = kcalloc(ncells, sizeof(*cells), GFP_KERNEL);
> -	if (!cells)
> -		return -ENOMEM;
> +	int i, rval;
>   
>   	for (i = 0; i < ncells; i++) {
> -		cells[i] = kzalloc(sizeof(**cells), GFP_KERNEL);
> -		if (!cells[i]) {
> -			rval = -ENOMEM;
> -			goto out;
> -		}
> -
> -		rval = nvmem_cell_info_to_nvmem_cell_entry(nvmem, &info[i], cells[i]);
> -		if (rval) {
> -			kfree(cells[i]);
> -			goto out;
> -		}
> -
> -		nvmem_cell_entry_add(cells[i]);
> +		rval = nvmem_add_one_cell(nvmem, &info[i]);
> +		if (rval)
> +			return rval;
>   	}
>   
> -out:
> -	/* remove tmp array */
> -	kfree(cells);
> -
> -	return rval;
> +	return 0;
>   }
>   
>   /**
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index 14a32a1bc249..385d29168008 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -155,6 +155,9 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
>   void nvmem_add_cell_table(struct nvmem_cell_table *table);
>   void nvmem_del_cell_table(struct nvmem_cell_table *table);
>   
> +int nvmem_add_one_cell(struct nvmem_device *nvmem,
> +		       const struct nvmem_cell_info *info);
> +
>   #else
>   
>   static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
> @@ -172,6 +175,11 @@ devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
>   
>   static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
>   static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
> +static inline int nvmem_add_one_cell(struct nvmem_device *nvmem,
> +				     const struct nvmem_cell_info *info)
> +{
> +	return -EOPNOTSUPP;
> +}
>   
>   #endif /* CONFIG_NVMEM */
>   #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
