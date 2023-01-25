Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A96467B0EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbjAYLQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbjAYLQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:16:04 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D9A26870
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:15:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so1023171wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23T5umlyYrF2FXJKgoziFOlNP0+IthzQVNGQv+io51A=;
        b=rQsxU9jPLGjmWEn2AD84v4VOtWkiI46td/tPRm0LTjWOQs0erdrmzV2ywQYApRBbDT
         NrRDuebeWV/CwiHGND+GHyTb/omHYCLbnYha7oKWBNzWVhVIYsvHR6IMsv7HCTGZ0ll7
         fq6spB+7KjlCaOMPDjDqpmcEStwTEn93zRPirEnX10KBK7wDeDz9BUgpiZki6z2jqfjk
         5DWdcgWtUug9bRwX73wADFrcrPB+KGkm2JKAkgH9E3H17UeGOwy7W6XGMS41bdWSicHR
         w9+OvNX9TYLnrM55JZRzV4G3qQ1eWMnyOH27Z3m/vJcs88yKBAcHQI7aABu7Vl7t1FbX
         ZT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23T5umlyYrF2FXJKgoziFOlNP0+IthzQVNGQv+io51A=;
        b=UQLWcdoLsWFEm4wTaDMUBT7/5oZodDixxSmwVbA3BLTW1mUeU+nKvuENWdFCh7oxXL
         XJfou/GzXUNi07DKqo9wQbTJLfyiVmq78j+MEN0+FnTErn4HQZFQmp54NNiYKhPyegwA
         1LRoKKj5uqcBfiDlx8jZ9fCAy+MWPQm24y9sV+aUlaWjvz/UUfEuI+0Cr3FH1axeguB3
         hXvOF0ZvVzAuKEo40KqTqksfCCsl7A7cQfDvulLz6rkW1WbgElEjK7CUAuTXMqkPcekG
         g8RJy4Jt3pIw1s5KLNLBhUPrdihbsLJ3bn+lT66FK/3ZMXxbxcqEPaAFgfFDrnEVrgXq
         +VyA==
X-Gm-Message-State: AFqh2kqFedCwHZMwS+BJUvNb0AW0bQxcBkRKXquowUFmeUhwzdieQa6g
        /qtJHLV8TSqzKvdRVNXiO9IA4A==
X-Google-Smtp-Source: AMrXdXvSRVletsh6wJOHdlxoGQpjDgPFrXMbiEwm16X2303lJd+K56UCWAdxcb1t9MZ+WfhAqpA9xA==
X-Received: by 2002:a1c:4b09:0:b0:3db:f0a:8726 with SMTP id y9-20020a1c4b09000000b003db0f0a8726mr28419900wma.28.1674645333828;
        Wed, 25 Jan 2023 03:15:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b003db09692364sm1714854wmn.11.2023.01.25.03.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:15:33 -0800 (PST)
Message-ID: <2c04c2f8-801e-37d3-f705-7a5953265a9d@linaro.org>
Date:   Wed, 25 Jan 2023 12:15:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 06/10] dt-bindings: qcom: add ipq5332 boards
Content-Language: en-US
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, robimarko@gmail.com, quic_gurus@quicinc.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230125104520.89684-1-quic_kathirav@quicinc.com>
 <20230125104520.89684-7-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230125104520.89684-7-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 11:45, Kathiravan Thirumoorthy wrote:
> From: Kathiravan T <quic_kathirav@quicinc.com>
> 
> Document the new ipq5332 SoC/board device tree bindings
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 27063a045bd0..a3568c7d3cc9 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -30,6 +30,7 @@ description: |
>          apq8084
>          apq8096
>          ipq4018
> +        ipq5332
>          ipq6018
>          ipq8074
>          mdm9615
> @@ -82,6 +83,7 @@ description: |
>          hk10-c2
>          idp
>          liquid
> +        mi01.2

Is "01.2" board version or name of board?


Best regards,
Krzysztof

