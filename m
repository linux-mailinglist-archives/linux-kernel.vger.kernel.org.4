Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1444B6279BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbiKNJ6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbiKNJ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:57:29 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D281F9FB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:56:55 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s8so1251495lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZgFCCwj8wB11LmKlfLDfrqCHhlE8OVqSoDXgx3BC38=;
        b=SQte+uuFjh+iCDGFXt+4viMdPtvMlDBe751UjK82Hzad2N5dN/acH0h+kbwHOj6/vH
         rOg1g+aV4EmzytsJB6tkj4lu1fcQaQcbJ9LoHD7h4ercvmGf6B5gBzOQYwaH3+oOsYf4
         05yfW3/ZTQO01bfnVNvVnLEVdeEjkp1/ccP+rGO3QhhhzkcWu8L9hAPWnrSX66jVdhwh
         cKYrdEjjxNryTrRbsIrLqI4fsREr2tp64HJHXTLeyHGb8Dfiua0ctbA0O9eNkcs0Him2
         6gMDblMH/froZ/qvda6i9OU6GNAYwahhDh2btItHzOLfCKZ7aE5lni+t6FbWAGpknald
         XNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZgFCCwj8wB11LmKlfLDfrqCHhlE8OVqSoDXgx3BC38=;
        b=cJFCiS8w8Kki8dMvJiYeTV4hFedPZc9FBnE1NQnKTJfPX9SOq4d90HswX9QXPIP/a7
         YMdbF4wZPRESTg0piO2q8BbLC+Pty+OlLzWwnQT4jTNGAgFeH7vTMPPof6q67r6pe8PK
         hKe9aIvp0zibZ8nqO9I1Wqt79oKirVE6+6qDH1/1Btus3bkpCr3G3NVeRZV0GSV//BK/
         AegfOKOX3D6IgVbNsI3WpJgMCRHKEkrjjPyfy8x8ewiGJKvSCG23nlBTWz4uA7FV6v2F
         cd73RPv0ePHQGjRuWLTZyDiI8U6/lJiSVhC0o2Q5QJAFTl3tNjDTQGGwZEdbLmYeR+EK
         4zzg==
X-Gm-Message-State: ANoB5pkRLJsGBIuyPgsalhhughxGnIS9BbM2TCQ7S7nKyuwYultQXbuL
        jeNm7UE7shFCEo/RfhgG+5X+Aw==
X-Google-Smtp-Source: AA0mqf6bxOqmmy6/RlNRckHSCmsMrReMHSiLWyHiZXClP4QJOy1BdNeCHp29S90ZVMf4Bccsu+ak7w==
X-Received: by 2002:ac2:5f50:0:b0:4a2:4eba:3de0 with SMTP id 16-20020ac25f50000000b004a24eba3de0mr4463812lfz.633.1668419814975;
        Mon, 14 Nov 2022 01:56:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i20-20020a198c54000000b004aa14caf6e9sm1762331lfj.58.2022.11.14.01.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:56:54 -0800 (PST)
Message-ID: <d9034e77-c127-b81e-e6c0-2478c861cedf@linaro.org>
Date:   Mon, 14 Nov 2022 10:56:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH net-next 4/5] dt-bindings: net: qcom,ipa: support skipping
 GSI firmware load
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org,
        elder@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221112200717.1533622-1-elder@linaro.org>
 <20221112200717.1533622-5-elder@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221112200717.1533622-5-elder@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2022 21:07, Alex Elder wrote:
> Add a new enumerated value to those defined for the qcom,gsi-loader
> property.  If the qcom,gsi-loader is "skip", the GSI firmware will
> already be loaded, so neither the AP nor modem is required to load
> GSI firmware.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/qcom,ipa.yaml | 4 +++-

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

