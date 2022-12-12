Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9614E649C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiLLKkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiLLKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:39:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1D5BF47
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:32:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ja17so1970575wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6kPRPV4RSaQS320NWjFIwrJBMe2FQYgaSD/56hIzMA=;
        b=FjTA8Kw0a3RXQT9qPGY38Ql3DMUIOcWDLl2net91bCjqnfUZHM+ROCCjATm084Konf
         ZPQcQ8xTF81WNIYcHwoRJfn6C/T8zU8HGDIuvAnEHrjlfZFuYEaAT7NxtdqUQrCPLAe6
         biMkclXJvldxx03Rc0AC0vS5zrlTkYKuTGGrV++oFNOoHop5uvgZuh56qnmcDFdkY7Kx
         DV5a6Xs0ZdlyiEY5dkBZb8h0asRwLHZrAdpFGeWJP1qYSynl2wPU+qml2rd6LV06K7o7
         WcpbpT6mMIjdiS5k7EvzjoBJPiy4IojgrcyYjwiShROcpHmEJV8zCNhjpoVryYnSw5EO
         uKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6kPRPV4RSaQS320NWjFIwrJBMe2FQYgaSD/56hIzMA=;
        b=FVrD+bWDSKjuQgDrwVFnUgEH5909LNSWeNMQEiqasD0auteIdgjZb7T/4U8/GN+Njc
         bWCSNTBcvjG0DfYmbuy9C4EqbYEKXf94MsGs2M6lbkFV6X8v5csHhhOAOh0PnWUL+qUU
         jycMm0npo5Lu5C1CYt0jvGQb27/IstWmqFUqfUuZVFzKu34ErWwOlh05c++RXh0jci67
         bWklNnfsjd5N2RAeOjBFmebLLgOKAo9nhUCEoezRATswBdYPqFrMNXD3dPlknpW1I7wT
         t2zHADk9Qp4Xl+ifd0YV1PBGL0KqF40gNfHsqiBlj+afAkOVpLhB/hk1IhqbqPk96BoF
         GMnQ==
X-Gm-Message-State: ANoB5pmd9c/YhvHk7BpYA7kQRp26vMPZyiz253nUxu7NeVYHKK+f48LN
        cFAn7NdndmPhtsaLI9xC7OwqQUYcxrumPtD1
X-Google-Smtp-Source: AA0mqf6QjC1E8Jn6zjPyx68xLKAjqXSAZD4pkfe0eByryq7PjTt1JnzdKMRfkhg6j0e2xMTkmoVtpg==
X-Received: by 2002:a05:600c:1c21:b0:3d0:6ef9:9f2c with SMTP id j33-20020a05600c1c2100b003d06ef99f2cmr12014492wms.16.1670841175027;
        Mon, 12 Dec 2022 02:32:55 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id n8-20020a05600c4f8800b003d1e90717ccsm9666314wmq.30.2022.12.12.02.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 02:32:54 -0800 (PST)
Message-ID: <b5c1b07d-1b18-72d4-d173-3c9830387139@linaro.org>
Date:   Mon, 12 Dec 2022 10:32:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvmem: brcm_nvram: Add check for kzalloc
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-kernel@vger.kernel.org
References: <20221212033915.12674-1-jiasheng@iscas.ac.cn>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221212033915.12674-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2022 03:39, Jiasheng Jiang wrote:
> Add the check for the return value of kzalloc in order to avoid
> NULL pointer dereference.
> 
> Fixes: 6e977eaa8280 ("nvmem: brcm_nvram: parse NVRAM content into NVMEM cells")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Applied thanks,

--srini
> ---
>   drivers/nvmem/brcm_nvram.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
> index 4441daa20965..7bd65fc2942e 100644
> --- a/drivers/nvmem/brcm_nvram.c
> +++ b/drivers/nvmem/brcm_nvram.c
> @@ -97,6 +97,9 @@ static int brcm_nvram_parse(struct brcm_nvram *priv)
>   	len = le32_to_cpu(header.len);
>   
>   	data = kzalloc(len, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
>   	memcpy_fromio(data, priv->base, len);
>   	data[len - 1] = '\0';
>   
