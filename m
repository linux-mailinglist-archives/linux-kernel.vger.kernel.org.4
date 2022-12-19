Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E7B650EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiLSPap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiLSPal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:30:41 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF188FCC;
        Mon, 19 Dec 2022 07:30:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i7so9011841wrv.8;
        Mon, 19 Dec 2022 07:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTQ6G2szldacTi/s3gJTUQlmGKJMBS6VQ125oYFyBx8=;
        b=eUav2kVKU5p8sDthFIbgHzqdA3yxrgylMhYz07uqKZs90eIQYt8H+orFGPL1ygyWXJ
         WvrOOs18X2Fs3iGoXObwlrJ3/0ZEJLvZ5/NivWy+zmYiuc9vaRVs1rGkDhPOvaqJAZfH
         tB5Y4GRe/rQv8wYeq67N1lsT1zZ9owWplgT1D9SURqAnQooqvdOY8uZK8XiV1JpN5jMt
         2gI96QZyPWr34rbjj/KsTCjJg6Dj/t7YhkbJeGWKKUBik7QU78i9euO1ZYWmYt2bPQyC
         jpmVsJ8gJOXeWnLjvTY/E62zmUqoixBxGS7vwooY6OCSbk+PVBbrWM9M3v0boCz1ms5Y
         hVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTQ6G2szldacTi/s3gJTUQlmGKJMBS6VQ125oYFyBx8=;
        b=zRZ4ON4VSIGD8v4KTbIDC2vYH8EqSjjrUTnJF5FrrpAlhYgXUHbqW4kBSlKYSwkVV6
         6b7aVtHUUCttqxCw+GZ1fTiidtq8vJXL1V/LoFQfrNpQHE81Fr/qawBinLVr6Fzd9QUV
         CUgOY64FqFZmkcW877aZsUYL5Wrl2PDBb1N09x2vsBN49leC1erkX3notrX+WuCvmcwh
         KH6sSTD5UM8X0qB5eOXxoljz9f2Aia8kTaiD3ZZ4YNYQP7PmHObkQCNwfBeJeaonS6XZ
         gf24svaOqUtX37CWLgu7zhafZvEB26nD1YoFJ4x/fbdBGhe9v7KofRFduIka+Hr3OJos
         uG9A==
X-Gm-Message-State: ANoB5plc5trkY43KRwgkWiwmoihm+000QDqETnmvELU7VSI0tig6ganW
        SR0ZKVx7uZ8ckZkGjT+fvH8sEgqL6HI=
X-Google-Smtp-Source: AA0mqf6OHT62PrwhgFgVpJEqsIU0+tVRZO6rLoXmVtaw9hEQeVPbnkWFog31jANr4bCVbjtIihTb3Q==
X-Received: by 2002:a5d:690f:0:b0:242:2b3c:c7e with SMTP id t15-20020a5d690f000000b002422b3c0c7emr27389352wru.17.1671463834297;
        Mon, 19 Dec 2022 07:30:34 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d6541000000b00241f029e672sm10191022wrv.107.2022.12.19.07.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 07:30:33 -0800 (PST)
Message-ID: <5ebaf98b-a77e-3c5a-3e08-bbb0119558a2@gmail.com>
Date:   Mon, 19 Dec 2022 16:30:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 01/10] spi: mtk-snfi: Change default page format to
 setup default setting
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221219024019.31974-1-xiangsheng.hou@mediatek.com>
 <20221219024019.31974-2-xiangsheng.hou@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221219024019.31974-2-xiangsheng.hou@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your patch! There is something to improve please see below.

On 19/12/2022 03:40, Xiangsheng Hou wrote:
> Change default page format to setup default setting since the sector
> size 1024 on MT7986 will lead to probe fail.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---
>   drivers/spi/spi-mtk-snfi.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
> index fa8412ba20e2..719fc6f53ab1 100644
> --- a/drivers/spi/spi-mtk-snfi.c
> +++ b/drivers/spi/spi-mtk-snfi.c
> @@ -1430,8 +1430,7 @@ static int mtk_snand_probe(struct platform_device *pdev)
>   
>   	// setup an initial page format for ops matching page_cache_op template
>   	// before ECC is called.
> -	ret = mtk_snand_setup_pagefmt(ms, ms->caps->sector_size,
> -				      ms->caps->spare_sizes[0]);
> +	ret = mtk_snand_setup_pagefmt(ms, SZ_2K, SZ_64);

Couldn't you just set sector_size in mt7986_snand_caps?

Regards,
Matthias


>   	if (ret) {
>   		dev_err(ms->dev, "failed to set initial page format\n");
>   		goto disable_clk;
