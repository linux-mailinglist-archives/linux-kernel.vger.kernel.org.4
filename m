Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AAB6E366B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 11:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjDPJGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 05:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjDPJF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 05:05:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021BB9B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:05:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id xd13so22677022ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681635955; x=1684227955;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlGz8JKELgg3r8mMiki5eECoDbZv+x5gc1ofLrVcTyg=;
        b=cOgPSIoFkdBBtroB7HJ8Jy5YxHfHM+s7oz+bS15lmhrLaQv7kDAJryXB+eWSTdFnCq
         KJe5Y6hXhpZ9g6Dmrc5P+qOCFrE3Bx2c47+KA38UAZlSmq8M1c2+K2vWV0J5K3jw5Ww5
         QXtZ8Zg17Q/p9uGZ6jnuUdssnXYE2+oc2fCeJkvEHO3OFfMrCVVPTpYLM0LaJhdKIJhp
         UGbCaMEczEp71Q2lHkkvurXNkkHULzbwbdlRU7/NoUch2q7Os4vfOjUYwWiNam+RzGwu
         cW0thOZCWngq/3yRUpDCwkZF6udLdqTeHGz0jy29p034FLxvU+NZwoJS8SrMKNQiHLKo
         HNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681635955; x=1684227955;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlGz8JKELgg3r8mMiki5eECoDbZv+x5gc1ofLrVcTyg=;
        b=T1Kpf9PfMMQPSveDfhHLo15qN4eqm7p6Dne//7eawxkU1Tv7EixcfM+B/zdTd1UK9T
         KCuOHvYphrpYApT2ZASjB+q0OYuBR8MPp4EF+goF1dvr8GRWpSENk6oEOld3skgEhus+
         NovnnIrYm8XfgayWMlzEn0//D7DTPgrbBcM5RxwpGG1HAIgWnTV6UQFEfIS2Y4iefXb5
         7neWijPm0edl818juxJnNpCEHexQIMGC7sS1TL/aW57C1iukekAuz2hKbBLimgwJNTwl
         bhu8lJJ7N79nVg1kmU3GEO0AZ5fjTJiOxTxUC3i3VQu9q4EUwOfOg43IotxkSS/fWGsx
         GX2w==
X-Gm-Message-State: AAQBX9evXgL/BeE+G9f8hHiygkQsvZpnSivpYLkYaVlTn0RabGjipin6
        Ki27QRDAlZmEJ4l36qx+/7PPZw==
X-Google-Smtp-Source: AKy350YtxFNxax7Pbq26Km+VElE38/PHPK+bNeopmDM55nPrGadnmeGvHZepVxj8+9iGRvAW89qqwQ==
X-Received: by 2002:a17:906:1014:b0:948:eed:b4e0 with SMTP id 20-20020a170906101400b009480eedb4e0mr4192321ejm.61.1681635955504;
        Sun, 16 Apr 2023 02:05:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id n20-20020a1709065db400b0094a90d3e385sm4807165ejv.30.2023.04.16.02.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 02:05:55 -0700 (PDT)
Message-ID: <4b3ce97d-a134-290d-e762-46d6a91caee1@linaro.org>
Date:   Sun, 16 Apr 2023 11:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 5/9] dt-bindings: qcom: Add ipq5018 bindings
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
 <1681468167-11689-6-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1681468167-11689-6-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 12:29, Sricharan Ramabadhran wrote:
> Document the new ipq5018 SOC/board device tree bindings.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v3] Fixed board name
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 785b969..350f9f6 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -30,6 +30,7 @@ description: |
>          apq8084
>          apq8096
>          ipq4018
> +        ipq5018
>          ipq5332
>          ipq6018
>          ipq8074
> @@ -95,6 +96,7 @@ description: |
>          hk10-c2
>          idp
>          liquid
> +        rdp432-c1

Keep proper order, not random.

>          mtp
>          qrd
>          ride


Best regards,
Krzysztof

