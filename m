Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0D9629F52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbiKOQnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbiKOQnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:43:11 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80E92F66C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:43:06 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j16so25272336lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DMVuHRBp4GftrN1V1KSQlvwpB/mUouGhCJfxN5gy/c=;
        b=jK6kVEMwqFDOzl7o4MlPKo19vnfhcEnL2VbjT8hTvUAQw4mSgZYYnmwwTTKA8HpFvn
         SM1B8KN7Oa2eJ8C0mAgFGeQ6WTR1gAlgp2h8luDz8FGbBjjuqTWCf1/EoicijscLzY1N
         iL3Nb0+LtTbFFN1FQ9dOzcSLVUl/IJVeY5eDZK565Zo0+hF+So0nM8KWj3s0c5XJUwm4
         j1HA3KndtMPmiPGZdTd4EbWiB7waHIV4SlkReHrpzjyalC79ZMgEhpb4wtBS69PmegDy
         ehAwuYEZgCz/iZ9nw65cEgXJ0D5N+R4CrPo2Fni6th3cw6BpPCDBFtOHE/EUgHcpyWIB
         c8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DMVuHRBp4GftrN1V1KSQlvwpB/mUouGhCJfxN5gy/c=;
        b=DJRKWHnZ6VBFEWzrnvtNxkGvcc4OnmIEja3hBxmWiDplsFefSbF0xVeWZia5lH9mNM
         Z6+ANEg73Y5W5CPoDxjD7snkjJoHE7DD/Sr5a0kZDd4fXujXsibTXmsk9ffenJJmHgt3
         BZOsSUcA464FAxXrcEDkH/nWHPYX3s1j1wWqefPVy9qmUpAB27p1XkbMyHLXHY+U8kEF
         qvyykh6Jqrd7ieTyRggSAyH2kKAt0mtZxEgrk5q8o41BfjMYhtcPbziM6YBdpNGf5/zU
         86+aIvFOFVh17mzHgX3nIj63lztWzH6oVZCQWYVd6qlZys+3rJy12T7zeigpvmQM53vt
         pN8A==
X-Gm-Message-State: ANoB5pmhgU1qDN0gbqG3Ni2S7nb11AV0khoW62DWBY03pfOT/sqIkze+
        YaLbWdlJaaMSIajeqBCjUAvoJA==
X-Google-Smtp-Source: AA0mqf5a13CZKGFrmN4xsbVr2cltGfCaGtn+odnP/5EobiQd89vK+ZWQb9JqN5euCAiUAqg8/6jTNg==
X-Received: by 2002:a05:6512:a86:b0:4a4:72b0:9a2b with SMTP id m6-20020a0565120a8600b004a472b09a2bmr5745325lfu.469.1668530585022;
        Tue, 15 Nov 2022 08:43:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 17-20020a2eb951000000b002770fb5722fsm2559896ljs.123.2022.11.15.08.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:43:04 -0800 (PST)
Message-ID: <0051d380-7bba-f19a-2455-4f09b94caafe@linaro.org>
Date:   Tue, 15 Nov 2022 17:43:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 06/11] dt-bindings: arm: qcom,ids: Add SoC IDs for
 MSM8956 and MSM8976
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com, luca@z3ntu.xyz
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-7-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111120156.48040-7-angelogioacchino.delregno@collabora.com>
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

On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
> Document the identifier of MSM8956/76.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  include/dt-bindings/arm/qcom,ids.h | 2 ++
>  1 file changed, 2 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

