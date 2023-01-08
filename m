Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ABF661639
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 16:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjAHPgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 10:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjAHPge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 10:36:34 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126EDE08C
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 07:36:33 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so4729182wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 07:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0Y9NXW1uR93OzQg0aE5HzcgNDOO8kxrR8xgvwlZmQg=;
        b=Fq2GBqZV+dO0qub33W4gajEmbdeDSPTSo5gcqjMty85eLhO3UiUDK7Oy6uJMZjXFad
         GarIRvry7ORaDD4PmTS2xk1esmBDzDruWmN++UHY5MSaF7zpez4dwf/JzBvuY7T0DWPP
         exzhHKudLSF+Uj7nGTXQtUJuJsCqZFW3fjdHB4IfEAMmivNBbsqPcxS9sHCKx8J3usHv
         60FxgdCgLn1wOULtb8e/hDD5SMLCrBV44iv0wFtsy7Vec10p8S6KVU5jY9rBuNCvYSye
         THgRWtarbzVliNpUuQcr/7vbT537cz3DZ6u7Eelg8Gd+wrn7YCUmCZVcaqY6oehwREvY
         W/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0Y9NXW1uR93OzQg0aE5HzcgNDOO8kxrR8xgvwlZmQg=;
        b=kI3wISz40ZpUuzRzJEVStnYdaIPH2RUEqANnMbeTaypemCc9SXMcy1+J9aeNi6Fsjs
         Rc13d1BywsZF3bFY6jhN10ChLvWWWlTk9n5sIT4DMObI7sXs3frIkoWRUY6mIaFkhAQg
         +LEkJQAdaFRhi5IaJkECA6ANXWncdzfICORgGxIngOZwYXBsM96m373CEYnMJmNkMyLn
         i7Yohf2+KDJ/IYWUNAjiUYOY9VTfE4uMBonwl+QkVf5Ozc8mT1KQ3w9vZ7ILZJDXqb6S
         +LYvv4Hr7K/mU+2E0uv93wpdsOXVVXKVg6b1thm4wsCTPhjei33po65AHtU0psxaDInF
         wgfw==
X-Gm-Message-State: AFqh2koLV8hHKgVvufNBEcf48sp+KwLDCIjkvb/j3lvN1npA3RJW49mu
        79RT2vaI3kEBbbJVYvzZIEpzug==
X-Google-Smtp-Source: AMrXdXs7B9K+/qUy69qOI8OZeEAnJUYC7tslNm8V5WNaRoYfPvoX2f4B1yNlMUiw7m6xWYM5pp8mPw==
X-Received: by 2002:a05:600c:4f11:b0:3d9:ee01:ae5b with SMTP id l17-20020a05600c4f1100b003d9ee01ae5bmr1147386wmq.12.1673192191645;
        Sun, 08 Jan 2023 07:36:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id az28-20020a05600c601c00b003cf57329221sm12935721wmb.14.2023.01.08.07.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 07:36:31 -0800 (PST)
Message-ID: <c6ea3f37-fe5a-9a61-3a02-99bc036fd23e@linaro.org>
Date:   Sun, 8 Jan 2023 16:36:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] dt-bindings: remoteproc: qcom: sc7280-adsp-pil: Add
 reg-names and power-domain-names
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-remoteproc@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org,
        mathieu.poirier@linaro.org, corbet@lwn.net
References: <1672991425-898-1-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1672991425-898-1-git-send-email-quic_srivasam@quicinc.com>
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

On 06/01/2023 08:50, Srinivasa Rao Mandadapu wrote:
> Add reg-names and power-domain-names for remoteproc ADSP pheripheral
> loader. This is to make compatible with remoteproc ADSP PIL driver.

I don't understand the reasoning. Before binding was "incompatible"?

> Also change power domain from LCX to CX.

Why? Hardware changed?

> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
> Changes Since v1:
>     -- Modify subject line to SoC specific.
> 
>  .../devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> index 94ca7a0..b5bee2c 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> @@ -23,6 +23,11 @@ properties:
>        - description: qdsp6ss register
>        - description: efuse q6ss register
>  
> +  reg-names:
> +    items:
> +      - const: qdsp6ss_base
> +      - const: lpass_efuse
> +
>    iommus:
>      items:
>        - description: Phandle to apps_smmu node with sid mask
> @@ -57,7 +62,11 @@ properties:
>  
>    power-domains:
>      items:
> -      - description: LCX power domain
> +      - description: CX power domain
> +
> +  power-domain-names:
> +    items:
> +      - const: cx
>  
>    resets:
>      items:

Best regards,
Krzysztof

