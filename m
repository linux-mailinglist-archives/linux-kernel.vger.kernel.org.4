Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212FA65F28C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjAERWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbjAERVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:21:14 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AD950E5D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:15:09 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m7so2345966wrn.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 09:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iM5mCfiwC8a+OTfmp19obe9Kj6qhwTXYrKrkcTdIF9E=;
        b=zwrLXQmUfzQMEbqilpWKK+xVLj1aTA05Pohpdo7YEuol4uTsm+RHDV461UKCsZFPNK
         vPrwLHjEoTGULCGcdDTyOBGoioyE+Cr4vapS55b2VCFXqjQX/9AD0DYdPNf3oVDFOKKw
         gtsC2sVHIPFEXgdLCCrEfjlHYcLKRWHgbJu3zUhSrR/kOTJJlS13yJld8OP8+nlfaVeV
         f9iHAizCU/y+wUKXWF++Y5KEbpOl9I1VZrt2G0WApA2xgMux3xJZEj+VlMitHK2xEqp5
         4TXTZWgKKZfBfZiYubUcv/tQ6wUe6J74noeehD8rZf/7t+jnHpVzPzUfIgn1bAG9lPdT
         ZiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iM5mCfiwC8a+OTfmp19obe9Kj6qhwTXYrKrkcTdIF9E=;
        b=AtVEr1eyWaT/35XpdrtsJlqqSgl3ZpOyzin8JDZKWm3AonnVIhLN2ybafwYlaXNFoU
         xNXa2wWvsB6NDoAECr8uMrjLb04eCtkj/Us9xh8zk7CWSsBNR4z01VzmsFJIfxFSLM+n
         3nD1b93dOHKSksvTO8Kg+Oh5NvZYOa0X8I1DAmyRTnCKRp5bfjYqedtYxWCWDOaGKH6X
         CsuTDwrN8RE/y24HTwERAbR0tg8ZESzUrlEHiNmWm3Vwb5GmHwRmFixOqTLG4KsAMI2P
         6Wsudnu5AeojCZE1UxHDwsglJkgkNPhaVi3yqbkEe5MxTRHv3HqOyrFair521Z5+ub3x
         gBRQ==
X-Gm-Message-State: AFqh2kqjjAEqDY7qYeYIEBm21cp43XwSVpsl5sXk27QlPZBCVyJUW5Ow
        LhNy8O7B1zg+nOOJrP0iP0njg/YEClnwZ8tSSsM=
X-Google-Smtp-Source: AMrXdXvJk2l1IjLcaY0OYATiOZbdTA0NyUchj6Iv8P4vp6xVV7wXxFj9wCcDwkggJBI+eh0Am6WDPA==
X-Received: by 2002:adf:f746:0:b0:2b8:bcd8:1818 with SMTP id z6-20020adff746000000b002b8bcd81818mr228440wrp.1.1672938908646;
        Thu, 05 Jan 2023 09:15:08 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id p11-20020adfe60b000000b002366e3f1497sm37889868wrm.6.2023.01.05.09.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 09:15:07 -0800 (PST)
Message-ID: <9440fe5e-6c93-0254-3846-334fac1f8c74@linaro.org>
Date:   Thu, 5 Jan 2023 17:15:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvmem: core: return -ENOENT if nvmem cell is not found
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20230105135931.2743351-1-michael@walle.cc>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230105135931.2743351-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/01/2023 13:59, Michael Walle wrote:
> Prior to commit 3cb05fdbaed6 ("nvmem: core: add an index parameter to
> the cell") of_nvmem_cell_get() would return -ENOENT if the cell wasn't
> found. Particularly, if of_property_match_string() returned -EINVAL,
> that return code was passed as the index to of_parse_phandle(), which
> then detected it as invalid and returned NULL. That led to an return
> code of -ENOENT.
> 
> With the new code, the negative index will lead to an -EINVAL of
> of_parse_phandle_with_optional_args() which pass straight to the
> caller and break those who expect an -ENOENT.
> 
> Fix it by always returning -ENOENT.
> 
> Fixes: 3cb05fdbaed6 ("nvmem: core: add an index parameter to the cell")
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> 

Applied thanks,

--srini
> Alexander, could you give this another try? I've changed it slightly,
> so it's a better match with how the handling was before.
> 
> 
>   drivers/nvmem/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 1b61c8bf0de4..cc885b602690 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1343,7 +1343,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
>   						  "#nvmem-cell-cells",
>   						  index, &cell_spec);
>   	if (ret)
> -		return ERR_PTR(ret);
> +		return ERR_PTR(-ENOENT);
>   
>   	if (cell_spec.args_count > 1)
>   		return ERR_PTR(-EINVAL);
