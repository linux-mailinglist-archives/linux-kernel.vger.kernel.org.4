Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2816AD920
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCGIUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjCGITR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:19:17 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9208B31E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:18:45 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so48857734edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 00:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678177123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Do4YkA6Qh5/zbnf9UnghiBAzarZSaRBWdWuzQ+PewAM=;
        b=UCQ6Vdc3Cyg3JKL2dIP0YC6lSPuFrrPP764OtDk9paRS7PS0ax9b1sQLG5xxop80eq
         cR2HVU+gpSf9Hh1lRB16E6EhWsbjbdruc6GE0CAnT98QFmZVzVcWgnsCvS0iLmEleGhP
         kJ9dmHlqr9k+0gwntSC7FzC21C8ihOMExHuThZPTDueWLNvhIl1vKEIFRraozhNs9j3V
         MdlQi+hX7tXLGveJVmauqrDaPG4exxTnJyR3jvqlq9ZDiXsllhsdV4CDBi9XSHWVaihf
         M1j1IHUexU/BGnlmB39m4q9utglssXP+A5knJJxSw18peqJafJdcmxs1gNWXTv0X1DY3
         ya2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678177123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Do4YkA6Qh5/zbnf9UnghiBAzarZSaRBWdWuzQ+PewAM=;
        b=n5gqmODXRT7A0grJemEeu2c3LG7in8eBib/rsCkxGpHZE9TCfHvtdLPlJIckdoRQp4
         4JgRGS0WpHu8HnaDZDQ4RIVQZXpvD5jfOzWCfrhZe2HKQqUjsM+ldoF3ixT/UD6ptjna
         L+iOIjSvJxk0bfMz4JwyyqeJY5jpnx+GW3FQq1+bGkwyOisnAnPHHJNAV+Zzy1CFh+Ff
         DM+N9BsYgj+bD3vua4T1Ly6yYA6Eh+5fbwQhtYhD5ZXKkPEsOjBlcmSaceIw7jJzZDXe
         wlS21kgU2som9K0Dt/pRBUW+8bcgKA2jOfPBzjsILr9s6jCNhSdsoGTUBuEdoKtxnRzZ
         pdlg==
X-Gm-Message-State: AO0yUKVGHxXWu5aSpXsnqXPsG9QrGByOHGFWBbXOOyTwNtTfWfWOk1Q9
        iYyqRDF+Fq2UV1bEvBiEB3qSGw==
X-Google-Smtp-Source: AK7set+c0QqDpM8AYt9wk7zDvHh9gsZXV5SvHa6/CKLviZvwpxj1sDnk+NdHrMZg7Vktk6/A6LJmdQ==
X-Received: by 2002:a17:906:fe07:b0:879:ab3:93d1 with SMTP id wy7-20020a170906fe0700b008790ab393d1mr19784755ejb.4.1678177122960;
        Tue, 07 Mar 2023 00:18:42 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id i24-20020a170906851800b008b95c1fe636sm5674440ejx.207.2023.03.07.00.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 00:18:42 -0800 (PST)
Message-ID: <ef6ce2bf-3fb9-50ac-ce4b-f8a0d5a8f099@linaro.org>
Date:   Tue, 7 Mar 2023 09:18:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 13/19] dt-bindings: PCI: qcom-ep: Rename "mmio" region to
 "mhi"
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
 <20230306153222.157667-14-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306153222.157667-14-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 16:32, Manivannan Sadhasivam wrote:
> As per Qualcomm's internal documentation, the name of the region is "mhi"
> and not "mmio". So let's rename it to follow the convention.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 89cfdee4b89f..c2d50f42cb4c 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -22,7 +22,7 @@ properties:
>        - description: External local bus interface registers
>        - description: Address Translation Unit (ATU) registers
>        - description: Memory region used to map remote RC address space
> -      - description: BAR memory region
> +      - description: MHI register region used as BAR
>  
>    reg-names:
>      items:
> @@ -31,7 +31,7 @@ properties:
>        - const: elbi
>        - const: atu
>        - const: addr_space
> -      - const: mmio
> +      - const: mhi

That literally breaks ABI just for convention. I don't think it's right
approach.

Best regards,
Krzysztof

