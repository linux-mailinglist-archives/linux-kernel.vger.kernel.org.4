Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B1665B497
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbjABQDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjABQD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:03:27 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B0EE52
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:03:26 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id bn6so19481836ljb.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=am6ZA2IygZpjsFVfOboIQOY/eHsWOf06mjYmev75JTQ=;
        b=FqLAxO7dWspIsHLdjdPJMguYSjgNz1BL0qUSVFO3paGpfOYPkgY/A7Ej1R8zeIfU7/
         hcQyWr55DTXBpcVkgDrG/V8Ih4UknDB/0De4Y9er63fp2SLZBdjW3qmzY1dIeiTFXJMy
         fGHXgPD7ZSgn3S/272g4KDh0no4iA8NTbsx8Kmw2VLRH0T2/CGUfTAOV8LOC+ll7jJqe
         enjlcXTA6pMGP04kGCN/9h2DBalNlT6DgeSCEzd4DF2RZ3FI/0a+HdVHK9f2YYx0oArJ
         1aonOoRRKoV7EaEXPwtdnplhCieeqKoQZJOra5adR0EF6OC2kRQ0MzSmOwR1xJQFA84F
         YMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=am6ZA2IygZpjsFVfOboIQOY/eHsWOf06mjYmev75JTQ=;
        b=7Mfik2FuzmLm6Oi+DeY3DzOFoKMAlzxqt1JPM40Tk9C8+UAwd8Hymp/KgsqOVvAoCD
         z4OUmH1cpDpe9ekrBTNzpEKYCObVEp9QbEZcZhhl2wmHaupQMi8Fq4f+TLZ7a7Vyy/dQ
         /g59qdZoP+ub/BHAB8JyIgRLd10R2C/4740cRGZSEAkuO95BLDRM1iY1Hi++X9SzJdzM
         X0h1cKaklp4XKw7Sy7nKFhlcuGjmXRC90gUFwu9+Px3WhEumzH/8yqjcV8Lq+YFn79ft
         N36Bw+tD2e78nVJD42ybn3sW+xVJGQFcZJAkWcFHDZEtJXCUBYSY+okGcAdUM811CIjp
         Oj+Q==
X-Gm-Message-State: AFqh2kp9qjvx9cJ9X7zWWoN/EdjA3JMKqdLt/X2G0o+8x9+64UwH4F7E
        y8wTWsIR0jqUW0/fXJEmkS/5Sg==
X-Google-Smtp-Source: AMrXdXukcDTEmLeG0Pm6NyYJLX4Me3oHOABqZu17HpqfJkbQeJ35Lo2shsFJ6YLbjC5sU5q7zm/BhA==
X-Received: by 2002:a2e:9b15:0:b0:27f:c5b3:792c with SMTP id u21-20020a2e9b15000000b0027fc5b3792cmr6539138lji.41.1672675405001;
        Mon, 02 Jan 2023 08:03:25 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p7-20020a2ea4c7000000b0027fc5d5dbb5sm2047016ljm.77.2023.01.02.08.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 08:03:24 -0800 (PST)
Message-ID: <0d225fb0-7bc7-4de0-0f07-039502926e6b@linaro.org>
Date:   Mon, 2 Jan 2023 17:03:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: qcom,sc7280-lpasscc: Remove
 qdsp6ss reg property
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        swboyd@chromium.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, quic_plai@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
References: <1672407799-13768-1-git-send-email-quic_srivasam@quicinc.com>
 <1672407799-13768-2-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1672407799-13768-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2022 14:43, Srinivasa Rao Mandadapu wrote:
> The qdsp6ss memory region is being shared by ADSP remoteproc device and
> lpasscc clock device, hence causing memory conflict.
> As the qdsp6ss clocks are being enabled in remoteproc driver, remove
> clock controlling in the clock driver.
> 

That's an ABI break change. You cannot just drop it because the driver
will fail now to probe with old DTS.

This ABI break (and Fixes tag below) requires extensive justification
where is the bug and how it affects users. Otherwise, I see no reason
for ABI changes.

> Fixes: d15eb8012476 ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280")
> 

Drop blank line.

> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
> index 6151fde..9c72b8e 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
> @@ -33,12 +33,10 @@ properties:
>  
>    reg:
>      items:
> -      - description: LPASS qdsp6ss register
>        - description: LPASS top-cc register
>  
Best regards,
Krzysztof

