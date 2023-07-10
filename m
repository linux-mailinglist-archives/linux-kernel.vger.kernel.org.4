Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FDA74DEC7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjGJUGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjGJUGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:06:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2378F194
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:06:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9922d6f003cso651708166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689019591; x=1691611591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BsV3afNUPdRTqIu9mC0ppRm+HLuppkRLq5+x+yU4ss=;
        b=iGsuPKAQ4y+HsUAXtu0egNmfuNLKhZpsLpulpuyFtbJuqk+DZ1W0Hn/IMhqy8VOGrX
         qpAKbUMmEB4Gs03GN/GnUE5qZm49XEktkZYEhp1VFeLvk4Tl1wBAzx5zXfQwadTvV2Cz
         DcmYDldJlJUPng05pyrCVnYkU8gYLBYSS35NOzG0/WRTY1W6NTrl8pQTY62XnQiH7VpY
         ffZITKenjkKtuuDY67OpKol4V5t3sx0/gtPefhTz8GvK9GEIe65KqSVUXcI3pa4DQAtt
         MHlUXmSAa7oF0tVn3Q3aqhxLKZoCPkYtCm0Nb6MOqbSgUuf8FpAhBG+VixX89pnwZEiG
         wLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689019591; x=1691611591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BsV3afNUPdRTqIu9mC0ppRm+HLuppkRLq5+x+yU4ss=;
        b=RmY3GGFM68fz0WOG9uHh74oK7czZnuOGos8jWixVmCGWoTugcil251wq67txxgKoiZ
         ZTIB5i7+FwMNmfxq2D+ur8Hjuu6WLHAB6BGbTt353R31BkBknvH2nQHiEroYn8AZ7epL
         92HbvU+VKjGz9gPuFraXrapUuxHfl018Q3P37GciY+6VBw01WWi+MWyvi3sJxEdQBnnF
         66lIpSOVBbeuqrd6RtobnBd6FYHRe9g0Z1tQaaVKJXy5cIl1Xhn1kaVqH8akT0kfDtbm
         tBqw6YFKp5qel03/jB6Y1OwWWSZSYtOrnFVp+myh/OooYpOHeop9KcvV4CJ213uhJlC5
         s9dw==
X-Gm-Message-State: ABy/qLarCCHAEOCzq6dmXJzzvyVGVrwEIuJ9VqNqiiucIaE/91N8c8VB
        4x1ff5Y3HSCSozOZMT95dx6Upg==
X-Google-Smtp-Source: APBJJlEFYeatmYspjFQNCMZfZRMGTpcYPZh9depifJXq2wY7Qxc4M/1FWw5viZ1q7/HRU8uqbAP7EQ==
X-Received: by 2002:a17:906:a242:b0:982:8ec0:15a3 with SMTP id bi2-20020a170906a24200b009828ec015a3mr11921561ejb.67.1689019591609;
        Mon, 10 Jul 2023 13:06:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id dk7-20020a170906f0c700b009931a3adf64sm176882ejb.17.2023.07.10.13.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 13:06:30 -0700 (PDT)
Message-ID: <5f65d487-4692-0e94-a79a-82c663317ec7@linaro.org>
Date:   Mon, 10 Jul 2023 22:06:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] dt-bindings: thermal: tsens: Add ipq5332 compatible
Content-Language: en-US
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-4-quic_ipkumar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230710103735.1375847-4-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 12:37, Praveenkumar I wrote:
> IPQ5332 uses TSENS v2.3.3 with combined interrupt. RPM is not
> available in the SoC, hence adding new compatible to have the
> sensor enablement and calibration function.>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 8b7863c3989e..ee57713f6131 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -68,8 +68,10 @@ properties:
>            - const: qcom,tsens-v2
>  
>        - description: v2 of TSENS with combined interrupt
> -        enum:
> -          - qcom,ipq8074-tsens
> +        items:

Drop items, you do not have multiple items.

> +          - enum:
> +              - qcom,ipq8074-tsens
> +              - qcom,ipq5332-tsens

Keep the order.
>  
>        - description: v2 of TSENS with combined interrupt
>          items:
> @@ -289,6 +291,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,ipq8074-tsens
> +              - qcom,ipq5332-tsens

And here

>      then:
>        properties:
>          interrupts:
> @@ -304,6 +307,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,ipq8074-tsens
> +              - qcom,ipq5332-tsens

And here.

>                - qcom,tsens-v0_1
>                - qcom,tsens-v1
>                - qcom,tsens-v2

Best regards,
Krzysztof

