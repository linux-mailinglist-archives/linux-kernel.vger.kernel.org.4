Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEF7749F2D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjGFOjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjGFOjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:39:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB6C1725
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:39:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so11457561fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688654349; x=1691246349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3mYxiUnHxsKFOAGPp86ha8b/Um2st/PRAuMFOTN2t4=;
        b=Tqsmke6IfhzmSzYIuXfuwttBCnq+QombWpFfNaffEOtQLfdZN6dVObb3Ycz1/tCQG6
         lflz697pzyI72tiU1NbLiUbUvGDDW4U1u66XAWhXLoyxDwo0hWGpGRV1ksjXXSIoZg/s
         s/46c02lxG5QzQrz3G5MMdfXTKQRkuUnS9jgf+x/fbzpSfCWNVuSW+JRfEAeobOSlu4o
         HmpTmHs529FK14Hq8Jrfga9eOJB3DTyRLReUmmyJ8jDWMW8AQjWT6ETyQj4Ia6QeXD58
         RjEkFS0G9xQK6Awj1A2zTh+N2NajXKdgiXbYjJJiBa3ivgZ84NmEoDAIxSSLJoeCcqkY
         5EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688654349; x=1691246349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3mYxiUnHxsKFOAGPp86ha8b/Um2st/PRAuMFOTN2t4=;
        b=Npuy+L0Uj3VFFs1nCNK02Fy5ZWhNXybe6jOZr6P8SqoePJzLiYfW68UYileqSBfUEh
         3QX/800C5Lp7gM85C67r5IblD602NN1EIVQM5o/ZBUy4dE+TdMRuv7b3PaURpTpufuBw
         VFhPgKmxxczxzYdn3CngNaPLTFKZtJxFcc9uO8oDgCmaTZlPp4uBZTJi6RuOMc0cd4pY
         g8rSAH3iNSH+9DbpZiOo+psQDsslYKxaCw1nbNqROsUHxpm6boBcB2iH2s8XuoMAPFtl
         cNEHVtGeD94WzUfbwI3to4y/43KRCUPuI440djb5aTuJo217Ny1hz5+G/hnaowGcukgt
         6F2Q==
X-Gm-Message-State: ABy/qLakvBswGTMbfO7M2KG+2NRxCDwBKRgMKGxkMjyngzWiwh7RYKgW
        1gDU2XQp5ihK8dpo0ijOEM68lA==
X-Google-Smtp-Source: APBJJlHiKNWPq7yGJmiuZph50nH2nERRXav+GQjngzH3Hnsq+WYJcHVkI1+kaqexuqidSqjxmBePwQ==
X-Received: by 2002:a2e:8085:0:b0:2b6:e283:32cb with SMTP id i5-20020a2e8085000000b002b6e28332cbmr1415443ljg.23.1688654348976;
        Thu, 06 Jul 2023 07:39:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i15-20020a170906264f00b009893650453fsm901514ejc.173.2023.07.06.07.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 07:39:08 -0700 (PDT)
Message-ID: <89fb0f45-0808-e7ea-2d5f-7c1405f49943@linaro.org>
Date:   Thu, 6 Jul 2023 16:39:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add compatible for pm7550ba
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1688650940-31388-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688650940-31388-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1688650940-31388-2-git-send-email-quic_rohiagar@quicinc.com>
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

On 06/07/2023 15:42, Rohit Agarwal wrote:
> Add compatible for pmic pm7550ba used in Snapdragon series.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

If this is v1, I doubt that you could get my tag, because I don't
provide tags for out-of-tree patches. So this is not v1, but then please
provide changelog and proper versioning.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

Best regards,
Krzysztof

