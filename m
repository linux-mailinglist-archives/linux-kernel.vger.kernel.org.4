Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03E465F28E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjAERWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbjAERVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:21:12 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071F150054
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:14:57 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso1795996wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 09:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHsW1hXT84VrcOTSjq1ht1csJ1l/OOaXvFqtaZIGzAQ=;
        b=NNQfWw649POtb1ixyaEqO1E7yEFrDzZy1vAhwOlebXXxjlpNTucHO/2UsilwihczzW
         ly/b5+6IANCKPWbwOKP7ktXZMV0ugBiumORIsn0mOfPEZXH8VZx81o3uBCdD3CpFeMOr
         NrKokdXhMdH/7IcQod4pO719JnpblwHCthLHcb8AxN/2s+0NBTEP7NEEgIPwpdBXMKxD
         wUDAdsAzrY7O/xaVCjo2NFttdQHYkZSpMn8VT8j6ZUAbbO8023cbR2EXeigT971GIXVp
         7mHZFHskaLeJPf0HD4JugUpXU7b2f22RLJEM1TRNhfnK7fx+gXLE/waTZunGs5VGB2vE
         iYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHsW1hXT84VrcOTSjq1ht1csJ1l/OOaXvFqtaZIGzAQ=;
        b=kGxdSnGcKgmn7zkbPnDjqU5YSxObE3HIjWtjfaHzjr5n394c91w9Rb0j8odozJaQAQ
         BWXEug3slPCx7JfGbYKV+0PuZeBxeWNVGybT2O1mf4yt8S5bU5Gr/cdthRN6BuLnrdvn
         C7EqM8+B71SOPVVCIbFzU6ZPVjjmztuZh95IHFENB5/7Luf98mX2vSdMFFM+o35GfQo3
         23pdLYqEmXKszzJ4dTg6XWPLeUSgvFxN+FgjCeaemBxlaMLj3f7M37dxj3E7x9LiFr10
         wmnD/hrmjdYpwhLng9PGMwwLe2jzQZhUsQrZJFfqPW0IewJg8cshCP7jYOm9t4tS6AoB
         oCew==
X-Gm-Message-State: AFqh2ko5dLHsGFx2MiD/KiTi8k3y4kYcBA4PDJtZMZ8n3k0JRNr7XzoW
        DU2SClMYnbdw9m5blzODtyOCfA==
X-Google-Smtp-Source: AMrXdXvhvz/gUtoFPFfu54pFNu7YrSye4jdqTILHV1uc/Rj2V1Yjv53+E3kX2T+WzMDEGStmKZF19w==
X-Received: by 2002:a05:600c:8a9:b0:3cf:6e85:eda7 with SMTP id l41-20020a05600c08a900b003cf6e85eda7mr37582146wmp.14.1672938895576;
        Thu, 05 Jan 2023 09:14:55 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id o5-20020a05600c510500b003b4ff30e566sm7833558wms.3.2023.01.05.09.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 09:14:54 -0800 (PST)
Message-ID: <0ec43e5e-1364-7354-abc5-cff106ea5cdc@linaro.org>
Date:   Thu, 5 Jan 2023 17:14:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2][next] dt-bindings: nvmem: Fix spelling mistake
 "platforn" -> "platform"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230105095828.2951-1-colin.i.king@gmail.com>
 <20230105095828.2951-2-colin.i.king@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230105095828.2951-2-colin.i.king@gmail.com>
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
> There is a spelling mistake in platforn-name. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---


Applied thanks,

--srini


>   .../devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml      | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> index 5a0e7671aa3f..714a6538cc7c 100644
> --- a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
> @@ -61,7 +61,7 @@ properties:
>       type: object
>       additionalProperties: false
>   
> -  platforn-name:
> +  platform-name:
>       type: object
>       additionalProperties: false
>   
