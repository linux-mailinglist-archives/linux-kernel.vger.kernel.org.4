Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD365F28D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbjAERWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjAERVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:21:13 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431D6564F9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:15:03 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r2so1968946wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n67EXi2DxaUGQNZldfWmP0oWklEr+2h12NuoITaK4oU=;
        b=cb1noHtTwXSIqdkVBnBjmTZevi5eDykk8T/dYtaP34aWWZL8bTKkTFuyeu/NNILXUL
         Gbw+yQks87nGpVDsvAdwOkXCWIg7XBFQCXPNnmxrplfmDkXQ355dUic3QRI/myCZwsfG
         aVwSS7zWfLGRE0NZPWUJ9loDsT06jbOIOvylwAyey1TtPHyZl9Po/8FSjcp54N5Gbzie
         5UCz+KYr6/xpypjJAvlsPysK5E3cOt9+KSBNx/YM3B8lfwl8CmQaxgj7E/gP241O1CdT
         85S5PjeAMkDCMu2Mo434zJL+SMxZEuEY3oNZ+mtCc85H+7BJncKNAVynEmAdP+pTdpnU
         xqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n67EXi2DxaUGQNZldfWmP0oWklEr+2h12NuoITaK4oU=;
        b=fRdY2YShrKVlTbkuNVvo6ghf21GiYbDFF1pCl3Dlqn6rSbPsgY6+i44fSNCRh1YfXT
         +tUOAP8t/m4L42PcxiHXcCRiz2KW5PuIhBKCKs5RXmWfsytKuImEl+FOZg9DI1N6iAWr
         nkK+Gv97uktTfQHvOjQnX1hYBT/q60spgaXvs7RCzPEg2YfmSgj86rWXabSOxS6yJzFB
         Pnm1uiUUNo1Lof3sg6Rq01Jfze/h0W8s0xJ3k1hj6Qeb5pRPSNTESiHtyyK7ZVsA+2lc
         Jawqom/nXf65wW3zhSG4P5z05LkhADLMT0iF9OI2QisbxkqNqhJ1dTZX3wbnFeh7ztRn
         S/Gg==
X-Gm-Message-State: AFqh2krbrElcXUtvi9MURZZvLk4cwh4O5tbheA2/JfLSsRLo0IJ5bSl7
        ekbs8vjLSTxviYRYZCr4MV/Eb7n2fLEJbiIq9Ac=
X-Google-Smtp-Source: AMrXdXuouVOmirnUjwp/feXQB4gD8Wc+b4LA3daJwE59+sjXkRBitK3Z9i5WC/PcnRWTG+dQyEK1gA==
X-Received: by 2002:a5d:5312:0:b0:297:bdaa:c8b8 with SMTP id e18-20020a5d5312000000b00297bdaac8b8mr10222823wrv.23.1672938901848;
        Thu, 05 Jan 2023 09:15:01 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id q15-20020adff78f000000b00291f1a5ced6sm16243607wrp.53.2023.01.05.09.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 09:15:01 -0800 (PST)
Message-ID: <81d01cab-02ce-00fd-f9fb-225f1547d3fb@linaro.org>
Date:   Thu, 5 Jan 2023 17:14:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2][next] nvmem: layouts: Fix spelling mistake "platforn"
 -> "platform"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230105095828.2951-1-colin.i.king@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230105095828.2951-1-colin.i.king@gmail.com>
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



On 05/01/2023 09:58, Colin Ian King wrote:
> There is a spelling mistake in the literal string. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Applied thanks,

--srini
>   drivers/nvmem/layouts/onie-tlv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
> index 074c7c700845..767f39fff717 100644
> --- a/drivers/nvmem/layouts/onie-tlv.c
> +++ b/drivers/nvmem/layouts/onie-tlv.c
> @@ -48,7 +48,7 @@ static const char *onie_tlv_cell_name(u8 type)
>   	case 0x27:
>   		return "label-revision";
>   	case 0x28:
> -		return "platforn-name";
> +		return "platform-name";
>   	case 0x29:
>   		return "onie-version";
>   	case 0x2A:
