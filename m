Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648526AB88B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCFIkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjCFIkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:40:49 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ACA20D1B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:40:43 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ay14so31487555edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQ0kCNRvnlBPGo3zFijI80Fs5ytanhlw1wiiBbqnEfM=;
        b=Ea6pV7O954GCjZZnA876T0Bb4Qg5OupjdBek5ck1JbEIMJ4b7kEXiDEzcbL8rSTvnA
         oaIzWTe5Lw2yxeK+XboKU72Tqs/YlVcmW37a80e0z2+xz5GhiWsXwYcgIDhgn5KkZO4E
         +HlkicDKmizcb7yP8KJqos2OJ7Kzsappz6vcJeuzl3qWYb7SLiqAvrwIvtvB2yGVD14M
         MFldyS5c1rzHRBSD/oc2Ox9lLuvEvi4IrTthJjWCDFjY+VGhaumc9H7AD5TTdHzh4ZjM
         T3O3k5OVPn9FsEn4C6dqFQ6149aKjGOS1IxWx9XbqKjrNUdAoBYGDqludp806OVGOSqQ
         uFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ0kCNRvnlBPGo3zFijI80Fs5ytanhlw1wiiBbqnEfM=;
        b=iTCxRehfz797P9CPkd8TNlSDFfPqSUA07WcoMQ0uZk80YjJbWqLNvIUFRXYCpJm0vZ
         JBvN5H186TZ2OGUxNFSXn0ojkEcZhQCPNVbsgP0h4awPU7On3GaE+JpHZN/cGmDzhjXQ
         CXqy+qJYZ8crrJB+WgBtZA2kxLnDET2mPh1WJqzo7Q9B+v1Jy78vakmhAliBkk5M8Sgk
         CUZ5ZRq3ty7BV0lo5dWnPw7OU+HByKea9oFPTciB1dpXkPY8xfU4j9ne/+VvSnL1j/Bc
         xOxY6WRSmCuXpOIbm+Rzd5MlxHvzV7vKs6qkfMU+29sVOqMDYlEsrQgMhosAVejKMKFP
         icBQ==
X-Gm-Message-State: AO0yUKVfRy5MtVPE7SX1uabV7f6O801ZgGv+oK0ZHqPrZnqBH0GHVNzh
        FV7UJDmLbcU1CZIPYSG6UbcmUQ==
X-Google-Smtp-Source: AK7set//ASnOu0ofB+sAvHW9PfcCZXmE6A9lrbCDAjj9FiQCBEuJ8PvkwlD3i0mN6IIJvOdE0LHw3Q==
X-Received: by 2002:a17:906:3141:b0:8b1:7b10:61d5 with SMTP id e1-20020a170906314100b008b17b1061d5mr9872711eje.33.1678092041758;
        Mon, 06 Mar 2023 00:40:41 -0800 (PST)
Received: from [10.203.3.194] ([185.202.34.81])
        by smtp.gmail.com with ESMTPSA id s23-20020a50d497000000b004c8948162e8sm4370855edi.67.2023.03.06.00.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 00:40:40 -0800 (PST)
Message-ID: <18e507e2-4159-d2aa-1945-4c06651d91a1@linaro.org>
Date:   Mon, 6 Mar 2023 10:40:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom,qmp: Add SDX65 QMP PHY binding
Content-Language: en-GB
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1678079913-27945-1-git-send-email-quic_rohiagar@quicinc.com>
 <1678079913-27945-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1678079913-27945-2-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 07:18, Rohit Agarwal wrote:
> Add devicetree YAML binding for Qualcomm QMP Super Speed (SS) PHY found
> in SDX65.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>   Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
> index 62045dc..d877589 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml

Please use new PCIe bindings from qcom,sc8280xp-qmp-pcie-phy.yaml


-- 
With best wishes
Dmitry

