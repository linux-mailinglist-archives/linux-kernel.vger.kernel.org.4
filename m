Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7DE6CA17E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjC0Kb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjC0KbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:31:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC34170C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:30:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so1693342wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679913053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RY27zgzeo2/+h7DIhGEkGBVdjkuFT2cSOB/27xypFIc=;
        b=fOdVH/hECAL4wFQubNSlYN4PDodltQkSGcxz4dq3C03YK+0Q/KwtULN/xziMXHv8sV
         0WrkaSAK8pMYCCmuzuNYn9wrFD7IpDMasZv9ZkJ7digaa135se1/Yn1VOe7g664CKkQp
         F9tkTOn6PzWrO6irJvcr0B6MzgyMWHcfMXp0jQ+hb3XpH4i+q8WE6Mhk7yd9gLfSpbSb
         80wGKdjIgifl9Iy0aP35pLBhnEqdknWEaRiv0UKl1aPqVCPg0/TDgS4+hd5+EmfSg9SK
         0lYUZb9v8WjCebZmstIJXTB3Tm99at/jNl6SYZLieRU7MlIf3P0/rrYmBNZgV57FAZIT
         SKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679913053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RY27zgzeo2/+h7DIhGEkGBVdjkuFT2cSOB/27xypFIc=;
        b=o1RztVEYRNUtONxo4ZhHWItU+wVXA8qkr8YVQwzPNk+7B0BrEhFmrbgYPAYC6BGSHH
         NQnoNiSUMkCzb9pRNNf1eP4Oorni/9itd0dbSsvErpfeth2mrjwMmhN/5ArjZ8eOBZFX
         55NA2jOSUALvJzBTOP6dWOu8qcztl7dG3fmArPuCVjLxDhjvii/HP1xsCvnc6dRYcT10
         QBmZXY5ichdSU6OlUdzCM85riEL+JnXeU/WifJanxhKG/gDzHDkBB/ntxxoP29lu0YUu
         OdOpRVYHBsl9PgHhtQiAOn17TQlWV6SQW1XNr0/OnxrayzngDhD0PX0U6cYxVkO6Oj9Z
         FDWQ==
X-Gm-Message-State: AAQBX9cGvmIMIRu0j1TZt3ElwDSdU0iUp4quOsEqSjrB66giTXsdcIMD
        jKMthqupqNosEljnk5k0pRlWiw==
X-Google-Smtp-Source: AKy350bijtXyfmmTUEm5apbI4I5dJpRvgt+p2sW5YhazHqdvAVc9zhnq0B9uAOBd/By/F49mT6CJZw==
X-Received: by 2002:a7b:cb47:0:b0:3ef:68d5:9573 with SMTP id v7-20020a7bcb47000000b003ef68d59573mr3886507wmj.19.1679913053051;
        Mon, 27 Mar 2023 03:30:53 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id f24-20020a7bc8d8000000b003eb596cbc54sm13362684wml.0.2023.03.27.03.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 03:30:52 -0700 (PDT)
Message-ID: <75dcd205-5432-7103-370c-d65d792631ea@linaro.org>
Date:   Mon, 27 Mar 2023 11:30:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/2] mtd: rawnand: stm32_fmc2: use timings.mode instead
 of checking tRC_min
Content-Language: en-US
To:     Christophe Kerello <christophe.kerello@foss.st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230327094742.38856-1-christophe.kerello@foss.st.com>
 <20230327094742.38856-3-christophe.kerello@foss.st.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230327094742.38856-3-christophe.kerello@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/23 10:47, Christophe Kerello wrote:
> This patch is using timings.mode value instead of checking tRC_min timing
> for EDO mode support.
> 

Fixes and Cc to stable here too, as you'd like to have this backported
as well, don't you?

> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> index 3abb63d00a0b..9e74bcd90aaa 100644
> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> @@ -1531,7 +1531,7 @@ static int stm32_fmc2_nfc_setup_interface(struct nand_chip *chip, int chipnr,
>  	if (IS_ERR(sdrt))
>  		return PTR_ERR(sdrt);
>  
> -	if (sdrt->tRC_min < 30000)
> +	if (conf->timings.mode > 3)
>  		return -EOPNOTSUPP;
>  
>  	if (chipnr == NAND_DATA_IFACE_CHECK_ONLY)
