Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0394462DC73
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbiKQNQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbiKQNQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:16:25 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873FE6DCC0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:16:24 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id b9so2658615ljr.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i33sxe8YJAvtvzx995z6301l/SnWDqnZWm9Vht72DH4=;
        b=tU7jXVbE/9IZhnkgZ2a2TR1cKrpxezzQgb08KohVcnbcFwh8xSb1SK8MR4QuXvS9Pm
         XihBbnMW8DhfFgPSZHICrxqW3120Lq1P53poDCUvvZreXVcLnys74vyrtcoGZ23iFVlF
         6XrA+BcxZB0URUC1GOjvTL0xUZsIoAMJrOTPvZwJRTN+YwbFxM7nP+xHf0uvt+yw5XI+
         6S4Esw86xL2AAWM1pZoiHc6p8maew1osrjr+BUAosRDPX/evJSt0NIsrqd7InhKAJI4F
         Dva5EE/QVjWaTs/cyxG7tne+9PKCnz9YvtXPqB+3nThZ7+tl5njGv8LdCBRzCq1Dyz28
         94gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i33sxe8YJAvtvzx995z6301l/SnWDqnZWm9Vht72DH4=;
        b=oetwAwXkm9NyYpMQE4blEQfyXqN4iuW5RfHP9KCPVcKRfVJqcxX8HHea3z7PocoIJ8
         0Np4Ic8XAQIoxiWepCo5XbKdQmVS6Ly1SoFLvgCd6fMbSiC/j/I6Mr50hwqyjVDLq1WL
         20TsZ6E+7p2ynmD9m6jl/cwKrUXUmNShn/5OQdRR2gYFBVUi2lODGkYClEynjp96oUp5
         ZQEseEmyDsavJW59XmZi8u+Q6pu+tK84pEuS2uZjeKPQTe5C6u/A/UNTNapQbPBuWxXJ
         5+4VoSCk9zYCPxHKPx92FjUzspA4Fy+i5qnbBJa1qcq1HP6vkc+WstbMiXtkWv+xGgpO
         EFag==
X-Gm-Message-State: ANoB5pld0Uemxmy+f2ptbW7KZKk8xI0o/YLdTm4BEjDs0GO/O75/qaFY
        vrP6YaFk4Gnv4U8u6xb9b0fPr0t7yAR9ygAM
X-Google-Smtp-Source: AA0mqf52Yxq0LSiDFcb9qJsPRrRyCkW3YFJEfEhpUMT9fdxNufjsn01xmLLHGsqOPY/x/LtHAYjLag==
X-Received: by 2002:a2e:a309:0:b0:277:88e:f5d7 with SMTP id l9-20020a2ea309000000b00277088ef5d7mr1067109lje.434.1668690982973;
        Thu, 17 Nov 2022 05:16:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q18-20020a194312000000b00494643db68fsm147572lfa.81.2022.11.17.05.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 05:16:22 -0800 (PST)
Message-ID: <aff1e286-b32c-f0ac-40bb-9be0d9588a1c@linaro.org>
Date:   Thu, 17 Nov 2022 14:16:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/9] dt-bindings: PCI: qcom: alphabetically sort
 compatibles
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221116214841.1116735-1-robimarko@gmail.com>
 <20221116214841.1116735-5-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116214841.1116735-5-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 16/11/2022 22:48, Robert Marko wrote:
> Sort the compatibles list alphabetically for maintenance.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 8 ++++----


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

