Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AD6734583
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 10:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjFRIhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 04:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjFRIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 04:37:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D67C10D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 01:37:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9741caaf9d4so308857966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 01:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687077421; x=1689669421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqBu5wPBLSKpT6xKjTZPHEicExKCCi3BZO99th5vmu0=;
        b=IfI28QAoO6Y19vMkOqSdshh/D7g51BT9PMVm9xXlg7mMo17+2bESmsKYK1I+u5OLB0
         D0R4gNuEpTL6u1yDfAH7fKIOsBVZbhyf8oJtrmqSg4rkoyPwCRabJKDVMrgyCV5AK3xg
         9wcXRyiPBHwjy4Tp616coNpDGxCe1xLvStRT46g6qtL6hGueMu0yjj1bUSVsperBa09t
         NmJDXQvc3CPB5EVTx1/xraCuBi0P2wsxjD8XDJi9U40Pugpb00JwT5SkPy+p48VEYL6g
         j2skJpK4AtNQiaYIGdul19ponWJc7BSXnvCWM8d0a42hOHuRk5U0WYd9duM+srSRSHyv
         FnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687077421; x=1689669421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CqBu5wPBLSKpT6xKjTZPHEicExKCCi3BZO99th5vmu0=;
        b=SavJ7kvx+F1XutNSJPPVVO798Z+YucNKFCdCJX7NKPtZ0jt1XyzEwRp/j+fF6LTafq
         IaDtfOx8tM1KsAvJd/goQrZBRyfLDTIXE2EySgBSfE4Jeh6bc16IsVMcEaZF9Y/jL5hb
         4CPhd3oGufe+DbiFGIqUNTmFNVL6iQWZoxg2Vz2XoxYRSl5DXszMKr2gHyfrQt9xZj7V
         pZGUayLxezd3etw0rIhOMidrdEpusLfiHLXZc+m/uk9UJU+sj2KG4UnDI+HlSpQwBHjB
         vN2w9IJgVZc8BOOSMyH0GkTZTDNivfLfSrw+GvihNs/YDrfF1gjYsX7qGSTuhmQIGiNJ
         LTGQ==
X-Gm-Message-State: AC+VfDyEcPlqeKJadPreodw0Vxt6bGR8iZxL1+AG1M+1juzzYUZMZfik
        zgykEEKbEEfge/Z4Rl/BMYlTcuX3QT7bJBtoHBc=
X-Google-Smtp-Source: ACHHUZ6D8tZRpKg4w9Sff05q/wAII4JkK1iFtnAjdeEIIbbZN0hkWuSpiteTsfq+osyb55Q4+XZMJw==
X-Received: by 2002:a17:907:1b09:b0:974:771e:6bf0 with SMTP id mp9-20020a1709071b0900b00974771e6bf0mr5372268ejc.56.1687077420866;
        Sun, 18 Jun 2023 01:37:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id cd10-20020a170906b34a00b0098696189722sm2578047ejb.192.2023.06.18.01.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 01:37:00 -0700 (PDT)
Message-ID: <bfa97efc-cd3d-dee7-157f-02f2cd01ff46@linaro.org>
Date:   Sun, 18 Jun 2023 10:36:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 02/11] dt-bindings: dma: Increase iommu maxItems for
 BAM DMA
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org,
        stephan@gerhold.net, Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
 <20230526192210.3146896-3-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230526192210.3146896-3-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2023 21:22, Bhupesh Sharma wrote:
> Since SM8450 BAM DMA engine supports five iommu entries,
> increase the maxItems in the iommu property section, without
> which 'dtbs_check' reports the following error:
> 
>   arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dtb:
>     dma-controller@1dc4000: iommus: is too long
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> index c663b6102f50..5636d38f712a 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> @@ -44,7 +44,7 @@ properties:
>  
>    iommus:
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 5

This needs at least 6 (sm8250).

Best regards,
Krzysztof

