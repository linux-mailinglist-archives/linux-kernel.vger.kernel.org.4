Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D8C6FEF6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbjEKJyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbjEKJyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:54:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E1ED871
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:53:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so77404837a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683798805; x=1686390805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S708+pUvDFYWDhg/1ibK1FeSHqXbBxrzbsAmRoBje2E=;
        b=eBrz8ahOX9Nt+cpSY4jQYBLH5/8Y21ybmI4Eh9suIC0RJIDutSLVZajsfe2MHYqUai
         1VLRvBSY+RmlnV3e2G7l0JpbLLScjAKzVGl9JsWVUBAvzFnKyorYQW2Av0nar80WqIH0
         YpEMWTODP+6Ar/59jgsas//85yL2Qd02TbRezUAEQFdq0+gzbvco8VEvqwcfdMXkPft2
         drRB8JlBsBuFY3Af1cOWInNhg6RKM+U+EXj+vNQFjsUw5tyNnDTzptqZPyWFYeGCH0wO
         YpRWBhygUjuRcgq0nkOnAfooM75wokQbbhTgr3Jv25BayNbZn+nWjhqcMpXHLTF2hyZR
         O6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683798805; x=1686390805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S708+pUvDFYWDhg/1ibK1FeSHqXbBxrzbsAmRoBje2E=;
        b=Lw9gbv/XUPLpgyKuOPKlvABBEz5ca7skZy+j6SF5OI45+XOExXcfm5T8OI9sk+eAfc
         BH35M2oHhtXwjzAVcZUprK8/0sg4+SlHyZAgl0eM+VT2Q2LhR2XAahFHjEpC2kKX6Keo
         8Vf8itG7VcG8K9s3OyQKch2Jw+2l2O4U9c3QNafFmAR7Vzd8ocU8uzPBXDf32WYSz1B1
         TifBuIzX2oe2QOwUFWCJbjtKwp749z0kPItuohtQ0Iw+QHRqYg2ilv4cpG63jj7x4QiM
         hBifqZqxfPy1sgufbBclr9RRywSldTn5DbeHlEZEHQPr6wEjiZK7NtID19PQ+1O444FS
         /H+Q==
X-Gm-Message-State: AC+VfDyT1YNgEPX90Mk0RqjOQdVVj36w2YCot117V8Q/RKc/skp3DqXA
        CKiH15NRhja7Ou/p2R2reAvafQ==
X-Google-Smtp-Source: ACHHUZ6qMnGtgj1qfIE8u7lEPm6rTd85pDEMMZFe3OwKKQq8fm4MkTTXhsDjhGsGStHPh3U6GVo/Aw==
X-Received: by 2002:aa7:d3c3:0:b0:509:f399:278d with SMTP id o3-20020aa7d3c3000000b00509f399278dmr18753088edr.5.1683798805438;
        Thu, 11 May 2023 02:53:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7e61:f14a:c3a4:809e? ([2a02:810d:15c0:828:7e61:f14a:c3a4:809e])
        by smtp.gmail.com with ESMTPSA id q22-20020a056402041600b004ad601533a3sm2777002edv.55.2023.05.11.02.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 02:53:24 -0700 (PDT)
Message-ID: <23ae905f-cc25-a695-5985-7f9742c4b78a@linaro.org>
Date:   Thu, 11 May 2023 11:53:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 2/3] dt-bindings: vendor-prefixes: Add ESS Technology
 vendor prefix
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230510112349.939991-1-aidanmacdonald.0x0@gmail.com>
 <20230510112349.939991-2-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510112349.939991-2-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 13:23, Aidan MacDonald wrote:
> Add prefix "ess" for ESS Technology <https://www.esstech.com>.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

