Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18370681177
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbjA3ONk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbjA3ONb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:13:31 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2B02BF09;
        Mon, 30 Jan 2023 06:13:27 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id v23so11756481plo.1;
        Mon, 30 Jan 2023 06:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jieTmRXghFVlnW/7VnBYeMI5OnEKAt15Mh9jqhvl2PI=;
        b=Z2NgzyILUmyfoFVUQTKsKWLKA/cyed3CN/nrDp1rzDrJEJnE6luglrvvezgX8IEPVV
         43gkWTuU8Rhxwx9ihjDQiEou89weVuT8hLGuPfzUel9k6O7z6omDMJDPgcZZFJylCV0X
         bNOFrtnZJdczbLrFm3j0SzfJrC7OiYgENTA9VTUfwnzHQocmsHwenT//GSYGYiW99qnu
         R1yuc4tLD2qgg1WHGHNIs+bOnYOlxX5tK9sBeKnd6j7kfF/FgtFE3y3Hyw9ATqEkxOwe
         bVNK2TCsbd66l/CffX4JCjvszRnFRV9ZQtyI0BVwhBj8JmtiRi5RIe725pDvu0QMo+C1
         OLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jieTmRXghFVlnW/7VnBYeMI5OnEKAt15Mh9jqhvl2PI=;
        b=1uG6xZ6nSh7CS4XUJTxRX3j4lyUGMSrbFwVvC+1HVP+KN01S1WRTEneSWU7wEVuKkR
         Eil43ea6OIsiTWUXL6ziazPZErY59lf0wNCYFxxIvTXH9SThCIFmciA1DRvIv852m1Qo
         41ZX22r+4T4QrngTMUMokhriSPMoUU615O5QKvQ+TqfpJqBCHfwzJLltoEOayzwJY0u7
         xkZlhnl3FZwE4qcorHSrolqOxsZVwWZR7ShGGhwpbAbDtHrlttXA8mEtuOl7LOmkkuYg
         3y4JAYltOhL548BB+aoozpAajTlffvn0xg8BPEsWzQr9mimJP9iyI3sdr1p0el9/C2Ro
         l6Hg==
X-Gm-Message-State: AFqh2kq2HYnOQ3BVCLO9pp3FwGT6TaizgaZC1op41Hz3qcEmdgvtZpf+
        P+PtH5Fb1zes9pBT/KYZJJ4=
X-Google-Smtp-Source: AMrXdXvmFdYt4x8r6PVv9J0rP4jIWdlKNwGpeCO1lB2DTi2o7Odd9OVNxxrTVMAFvC31YFuijfbT5w==
X-Received: by 2002:a17:90a:1a0a:b0:22b:b346:4d86 with SMTP id 10-20020a17090a1a0a00b0022bb3464d86mr38064833pjk.43.1675088007063;
        Mon, 30 Jan 2023 06:13:27 -0800 (PST)
Received: from [172.30.1.94] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id dw18-20020a17090b095200b00218daa55e5fsm7199844pjb.12.2023.01.30.06.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 06:13:26 -0800 (PST)
Message-ID: <cfe73771-33dd-e285-ed84-d620ee1edef0@gmail.com>
Date:   Mon, 30 Jan 2023 23:13:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: interconnect: samsung,exynos-bus: allow
 opp-table
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230125090849.122189-1-krzysztof.kozlowski@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230125090849.122189-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 1. 25. 18:08, Krzysztof Kozlowski wrote:
> The opp-table can be located in the exynos-bus node which uses it, so
> allow such child node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../interconnect/samsung,exynos-bus.yaml      | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml b/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
> index ad9ed596dfef..5e26e48c7217 100644
> --- a/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
> @@ -196,6 +196,8 @@ properties:
>      maxItems: 2
>  
>    operating-points-v2: true
> +  opp-table:
> +    type: object
>  
>    samsung,data-clock-ratio:
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -227,6 +229,31 @@ examples:
>          operating-points-v2 = <&bus_dmc_opp_table>;
>          devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>          vdd-supply = <&buck1_reg>;
> +
> +        bus_dmc_opp_table: opp-table {
> +            compatible = "operating-points-v2";
> +
> +            opp-50000000 {
> +                opp-hz = /bits/ 64 <50000000>;
> +                opp-microvolt = <800000>;
> +            };
> +            opp-100000000 {
> +                opp-hz = /bits/ 64 <100000000>;
> +                opp-microvolt = <800000>;
> +            };
> +            opp-134000000 {
> +                opp-hz = /bits/ 64 <134000000>;
> +                opp-microvolt = <800000>;
> +            };
> +            opp-200000000 {
> +                opp-hz = /bits/ 64 <200000000>;
> +                opp-microvolt = <825000>;
> +            };
> +            opp-400000000 {
> +                opp-hz = /bits/ 64 <400000000>;
> +                opp-microvolt = <875000>;
> +            };
> +        };
>      };
>  
>      ppmu_dmc0: ppmu@106a0000 {

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

