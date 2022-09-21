Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2E45BF75D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiIUHPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiIUHO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:14:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DD82CDE3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:14:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bq9so8329417wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=y+SX0O0sFK0RfCFKUk5e5HkLwS7qj6fJY7MYEdssToA=;
        b=apm7jshLoEYBXPI75Tf8y4MR/NXL0fL9VSSam/7puniDvlDo7d73uthZ5UpxQ9L7ou
         O+G79+RsG3rF/faM8KWlc48l3lovuOdl6U/AGb2YdD/M42u0zoDWP/e9rPiE07gdtVtc
         LlSjY+bFoE9KC2mwC518e/fXU2iPFotbk56YbOD6F9D88eshMnrPuhiGTvp2se7ovMS8
         h6puuTqM5jfA4ptEDbSqGlEc/aYGJ2CQqWvCUPa8IzoEcmNK0pxmZomjvwix7iokEntz
         LrH+/2cWazCpbEWabBTg/lTsNEKpBseVS8OfQs8TWTcqaJkzS2/+6kMNeKF2664pwjX/
         /+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=y+SX0O0sFK0RfCFKUk5e5HkLwS7qj6fJY7MYEdssToA=;
        b=CfRNlwIyaDyS/6mrvvvvgXrFcMiACN1WYhflnfG3OD8K8OwO21uBIxIYOVrV27lOOZ
         pQiDqLnaQYhfSQIQkmN3tjiLbwruHBRDm3lMdtIDwitwvf6d6CMx5SHjQTAJ4Xk1Yj2n
         1KS072TTjO5ukpj982/Ppo2xEKqleU98o/COT6HB+g2E+leQTxrqs0iskbs9iRqrsw9V
         Gnkp7FdzYAaBsR5RPMDzKwGGXUXNBXYYnkhZW1T6IMAfowElGsDW81b7QNb5xd9PtDzS
         W31XdccgTyGxaQRAFde2yE1zHqZ7sMIZ3eABiUajS8i2KMrFFnNtkJuHn+eHbDQyH45V
         vu0Q==
X-Gm-Message-State: ACrzQf2G7XnlXEDWvkZUHurm8XHQhvuw01+IiALH4JdmBULhBSKfO36j
        xptm6nF7AqoITiJ+84K4ZhiW/A==
X-Google-Smtp-Source: AMsMyM6GU8QuI762MoyB+GX6M58iW8kKG3Dx7B0Wfj29BxWQh0BlsUPNqAanDdgJLa5YtJbhk4Jyiw==
X-Received: by 2002:a5d:550c:0:b0:22b:1942:4bf6 with SMTP id b12-20020a5d550c000000b0022b19424bf6mr3558303wrv.520.1663744493986;
        Wed, 21 Sep 2022 00:14:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8ce3:ff4e:ae9b:55f3? ([2a01:e0a:982:cbb0:8ce3:ff4e:ae9b:55f3])
        by smtp.gmail.com with ESMTPSA id o28-20020a05600c511c00b003a845fa1edfsm1473724wms.3.2022.09.21.00.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:14:53 -0700 (PDT)
Message-ID: <0f1cce61-b2f4-79f0-5432-9a5559e8bf5c@linaro.org>
Date:   Wed, 21 Sep 2022 09:14:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: qcom: msm8998-yoshino: Fix up SMD regulators
 formatting
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220921004741.152765-1-konrad.dybcio@somainline.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220921004741.152765-1-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 02:47, Konrad Dybcio wrote:
> Add a new line between each subnode and make the { } consistent.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>   .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 33 ++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> index d08639082247..862d859af885 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
> @@ -410,131 +410,162 @@ vreg_s3a_1p35: s3 {
>   			regulator-min-microvolt = <1352000>;
>   			regulator-max-microvolt = <1352000>;
>   		};
> +
>   		vreg_s4a_1p8: s4 {
>   			regulator-min-microvolt = <1800000>;
>   			regulator-max-microvolt = <1800000>;
>   			regulator-system-load = <100000>;
>   			regulator-allow-set-load;
>   		};
> +
>   		vreg_s5a_2p04: s5 {
>   			regulator-min-microvolt = <1904000>;
>   			regulator-max-microvolt = <2032000>;
>   		};
> +
>   		vreg_s7a_1p025: s7 {
>   			regulator-min-microvolt = <900000>;
>   			regulator-max-microvolt = <1028000>;
>   		};
> +
>   		vreg_l1a_0p875: l1 {
>   			regulator-min-microvolt = <880000>;
>   			regulator-max-microvolt = <880000>;
>   			regulator-system-load = <73400>;
>   			regulator-allow-set-load;
>   		};
> +
>   		vreg_l2a_1p2: l2 {
>   			regulator-min-microvolt = <1200000>;
>   			regulator-max-microvolt = <1200000>;
>   			regulator-system-load = <12560>;
>   			regulator-allow-set-load;
>   		};
> +
>   		vreg_l3a_1p0: l3 {
>   			regulator-min-microvolt = <1000000>;
>   			regulator-max-microvolt = <1000000>;
>   		};
> +
>   		vreg_l5a_0p8: l5 {
>   			regulator-min-microvolt = <800000>;
>   			regulator-max-microvolt = <800000>;
>   		};
> +
>   		vreg_l6a_1p8: l6 {
>   			regulator-min-microvolt = <1800000>;
>   			regulator-max-microvolt = <1800000>;
>   		};
> +
>   		vreg_l7a_1p8: l7 {
>   			regulator-min-microvolt = <1800000>;
>   			regulator-max-microvolt = <1800000>;
>   		};
> +
>   		vreg_l8a_1p2: l8 {
>   			regulator-min-microvolt = <1200000>;
>   			regulator-max-microvolt = <1200000>;
>   		};
> +
>   		vreg_l9a_1p8: l9 {
>   			regulator-min-microvolt = <1808000>;
>   			regulator-max-microvolt = <2960000>;
>   		};
> +
>   		vreg_l10a_1p8: l10 {
>   			regulator-min-microvolt = <1808000>;
>   			regulator-max-microvolt = <2960000>;
>   		};
> +
>   		vreg_l11a_1p0: l11 {
>   			regulator-min-microvolt = <1000000>;
>   			regulator-max-microvolt = <1000000>;
>   		};
> +
>   		vreg_l12a_1p8: l12 {
>   			regulator-min-microvolt = <1800000>;
>   			regulator-max-microvolt = <1800000>;
>   		};
> +
>   		vreg_l13a_2p95: l13 {
>   			regulator-min-microvolt = <1808000>;
>   			regulator-max-microvolt = <2960000>;
>   			regulator-allow-set-load;
>   		};
> +
>   		vreg_l14a_1p85: l14 {
>   			regulator-min-microvolt = <1848000>;
>   			regulator-max-microvolt = <1856000>;
>   			regulator-system-load = <32000>;
>   			regulator-allow-set-load;
>   		};
> +
>   		vreg_l15a_1p8: l15 {
>   			regulator-min-microvolt = <1800000>;
>   			regulator-max-microvolt = <1800000>;
>   		};
> +
>   		vreg_l16a_2p7: l16 {
>   			regulator-min-microvolt = <2704000>;
>   			regulator-max-microvolt = <2704000>;
>   		};
> +
>   		vreg_l17a_1p3: l17 {
>   			regulator-min-microvolt = <1304000>;
>   			regulator-max-microvolt = <1304000>;
>   		};
> -		vreg_l18a_2p85: l18 {};
> +
> +		vreg_l18a_2p85: l18 { };
> +
>   		vreg_l19a_2p7: l19 {
>   			regulator-min-microvolt = <2696000>;
>   			regulator-max-microvolt = <2704000>;
>   		};
> +
>   		vreg_l20a_2p95: l20 {
>   			regulator-min-microvolt = <2960000>;
>   			regulator-max-microvolt = <2960000>;
>   			regulator-system-load = <10000>;
>   			regulator-allow-set-load;
>   		};
> +
>   		vreg_l21a_2p95: l21 {
>   			regulator-min-microvolt = <2960000>;
>   			regulator-max-microvolt = <2960000>;
>   			regulator-system-load = <800000>;
>   			regulator-allow-set-load;
>   		};
> +
>   		vreg_l22a_2p85: l22 { };
> +
>   		vreg_l23a_3p3: l23 {
>   			regulator-min-microvolt = <3312000>;
>   			regulator-max-microvolt = <3312000>;
>   		};
> +
>   		vreg_l24a_3p075: l24 {
>   			regulator-min-microvolt = <3088000>;
>   			regulator-max-microvolt = <3088000>;
>   		};
> +
>   		vreg_l25a_3p3: l25 {
>   			regulator-min-microvolt = <3104000>;
>   			regulator-max-microvolt = <3312000>;
>   		};
> +
>   		vreg_l26a_1p2: l26 {
>   			regulator-min-microvolt = <1200000>;
>   			regulator-max-microvolt = <1200000>;
>   			regulator-allow-set-load;
>   		};
> +
>   		vreg_l28_3p0: l28 {
>   			regulator-min-microvolt = <3000000>;
>   			regulator-max-microvolt = <3000000>;
>   		};
> +
>   		vreg_lvs1a_1p8: lvs1 { };
> +
>   		vreg_lvs2a_1p8: lvs2 { };
>   	};
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
