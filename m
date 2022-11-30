Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC16263D434
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiK3LSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiK3LRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:17:43 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56E313D69
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:17:41 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id r8so20498382ljn.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DghhzdLC70p88Ph3mhaw98h7VRYL9qUr3MH4/vlNzpU=;
        b=pk2KRXvukRhqgVJJ2HWK9+/xZSC8gf1lZmcPUA7LHq5GXsNg6AGRRUS4lRYB6yRxPX
         SxFOIYM3+sncwsmGoDUpXXdWiA+zE5JtPKkqOpFGaOThZ3lfUNm6lHaPxIP9sheMaFgi
         G/iAZWe/ZM/w8hEvpd5in4w6pZU4clr0BxvT4e1XZ5bTcZ+Sz6Qj+xTz9Od2n1SetIvS
         xTK1MBgKxc2kyS+heZJDRA2FklCoYpNnIWYPwFi4Ep4DZd9uJCEkObi0HGpXQV4oGYqu
         qFz4MXJlIk2dq12cfnEiidPD4InWa/WW1fng7QEU7ZcgpZ+EHVlkevvXXVk4CmGNjCdo
         /0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DghhzdLC70p88Ph3mhaw98h7VRYL9qUr3MH4/vlNzpU=;
        b=k6EQHyOHvBEIYJHNyf6ywEppCJW91t6g+J7GxYeeeMd1NeopNIko+wkCPp/+SOeben
         1D6FR3DPmt/YPU1i2vE5PMu6xmB5nE/2yho6G6h2k7MHv+HtLX6Q8YdRIpIGR6RLxBj5
         6r3UiqJVutfsQR6KtmEszXcQHAa3dPtpiApJaGTGKjylqlrQzu4bv7EvREw1x1NQBOmI
         W+98HuQIE5DSktPZgP+IZ+fwZkdaWS/tDxX7mX5ZfbEWHU/wnCEdG/sTkfoW4XhP6Ltf
         vZgX6Au+9y72uNyGnBmH9BG9uUsGuKk7o2iCCd1adlugZX+xVx76PA8ZmZp/rPKhuE6t
         q58w==
X-Gm-Message-State: ANoB5pkJBOCbihNWOzar1DUDaT2oN+EZ8yWaBr/axnLA3MIRZusAfKyV
        g+900pgNOFmvkQtvW68x8qXFgA==
X-Google-Smtp-Source: AA0mqf7FAZUmUwdxZIfnK1o0qwCU14VpcIfdB0vtB8H9/H3zj6Ulagqt8uLHVWQ63VwAvOGTlNU2hQ==
X-Received: by 2002:a2e:9c4e:0:b0:26e:2bda:1821 with SMTP id t14-20020a2e9c4e000000b0026e2bda1821mr14090758ljj.241.1669807060137;
        Wed, 30 Nov 2022 03:17:40 -0800 (PST)
Received: from [192.168.1.101] (95.49.125.236.neoplus.adsl.tpnet.pl. [95.49.125.236])
        by smtp.gmail.com with ESMTPSA id s22-20020a056512315600b0049ade93ad24sm218501lfi.156.2022.11.30.03.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 03:17:37 -0800 (PST)
Message-ID: <f508a01d-55e3-259b-d648-7125a2606c96@linaro.org>
Date:   Wed, 30 Nov 2022 12:17:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 06/12] arm64: dts: qcom: sm6115: Add rpm-stats node
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221129204616.47006-1-a39.skl@gmail.com>
 <20221129204616.47006-7-a39.skl@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221129204616.47006-7-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.11.2022 21:46, Adam Skladowski wrote:
> Add rpm stats node.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 04620c272227..6d14bbcda9d3 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -538,6 +538,11 @@ rpm_msg_ram: sram@45f0000 {
>  			reg = <0x045f0000 0x7000>;
>  		};
>  
> +		sram@4690000 {
> +			compatible = "qcom,rpm-stats";
> +			reg = <0x04690000 0x10000>;
> +		};
> +
>  		sdhc_1: mmc@4744000 {
>  			compatible = "qcom,sm6115-sdhci", "qcom,sdhci-msm-v5";
>  			reg = <0x04744000 0x1000>, <0x04745000 0x1000>, <0x04748000 0x8000>;
