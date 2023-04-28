Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E52D6F196C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346273AbjD1N1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346279AbjD1N1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:27:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC99E4ECA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:27:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-2f917585b26so9017238f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682688426; x=1685280426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkJoG1LPHO8i6Q8wWiW6Rl5rdW7E3T2NGYe6a0Rghqs=;
        b=ZdfR/e7VVW6XiNkmL3LmeM9+R4kj8X362H1qodHBMdg+uyiTshG0jpKr6rOibBTLeu
         DA6AQrMAhDORd2ChFpbJX2cLTnbyPu/BHIGoBE75Na1jUzq6e5AC0V+UIGD++SG/sNXJ
         mGDaZ8yLslXk5mssqHuBP36BhSqhv+mPHsLS0BPVVZ4BED7q8ohax35mMWz6I9VPGZ3t
         OPOLiuu8l7Yaw62vcREt7DtwhNkiHcKre57Q5mvg4Esp9IK6s6lMW30S6s6PLj05uT4H
         e+sgnqYRSRKx4U2/nHvg3skEwxeqVxsEjqS6KT74CuzPHkxQDm2TxYR1vuAwCaLefcer
         MIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688426; x=1685280426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkJoG1LPHO8i6Q8wWiW6Rl5rdW7E3T2NGYe6a0Rghqs=;
        b=REnbbTXj3IYwYL7JxUYkARrV7y+THuTrReKtZcaya9C/OcS65eK22qcV1YBrjV6bp0
         cEqJTf6QjVYnX1+OhOTV7fETQhlDBxIm0UdWxaYXYdNm/qbfv1SYnS0tDeaz2T+WCvCA
         c8+fBQBMeaPcByiORijwM4JgO0emNfAWvCaliPsV4ogMn1OftYD3JmTFUduQ2AtGP1CN
         lfp2R39H0QisrN5l+/3eoPIXck92zeT/ICI/d98QyHE8dp5mIU2D9AskGWeTqqrZLNNI
         X4bLin1tNqEpAebav3GidN1KEIZUdHfEMrLdLh+p2mTPweYVHQbZSpG4qB5Hj3vj6O3V
         tF5w==
X-Gm-Message-State: AC+VfDzbNOvVpe1k0PnhDDYk22nuO+JmDlE2GWWeWlsAHve3yXP0pwRe
        5aOrI438kBxRx5vyJUmKWTkllw==
X-Google-Smtp-Source: ACHHUZ4s83IplXBwoNtSQYlpNZ2jgP0cGcl1S9RUA3BThTitRPqEC3TEtyd9ZfVctIWKGMQH4+ujZQ==
X-Received: by 2002:adf:e54c:0:b0:2fa:a4b5:6b8 with SMTP id z12-20020adfe54c000000b002faa4b506b8mr3865844wrm.27.1682688426294;
        Fri, 28 Apr 2023 06:27:06 -0700 (PDT)
Received: from [172.23.2.142] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d6646000000b002f6dafef040sm21107235wrw.12.2023.04.28.06.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 06:27:05 -0700 (PDT)
Message-ID: <4b690859-be5a-c331-8243-b875136d4807@linaro.org>
Date:   Fri, 28 Apr 2023 15:27:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/6] dt-bindings: usb: qcom,dwc3: Add bindings for
 SA8775P
To:     Shazad Hussain <quic_shazhuss@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     dmitry.baryshkov@linaro.org, athierry@redhat.com, robh@kernel.org,
        konrad.dybcio@linaro.org, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230428130824.23803-1-quic_shazhuss@quicinc.com>
 <20230428130824.23803-2-quic_shazhuss@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230428130824.23803-2-quic_shazhuss@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2023 15:08, Shazad Hussain wrote:
> Add the compatible string for SA8775P SoC from Qualcomm.
> 
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> ---

(...)

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sa8775p-dwc3
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 3
> +          maxItems: 4
> +        interrupt-names:
> +          minItems: 3
> +          items:
> +            - const: pwr_event
> +            - const: dp_hs_phy_irq
> +            - const: dm_hs_phy_irq
> +            - const: ss_phy_irq

Why the last interrupt line is optional? Is it really optional?

Best regards,
Krzysztof

