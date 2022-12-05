Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225BF642740
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiLELL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiLELLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:11:12 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC9919C39
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:11:11 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vp12so26896324ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 03:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smtBi/D7Bb1bx3MPJhAviruHQBepHI3ynR3xtWdGlAs=;
        b=nLkBuy45LkMiUEOiNQnJUDv0PW+d392FDkbqPPo+HsncZ6U2IHLDGwOBD9nirLltZn
         twwg5KiputuXVhxQPjasA52tLSPby24leYs2bq8GxeFYl0LnnsVbSDTWmmw4Oy59znNe
         9+f5I+zPkkNCtp+a+5k3OdwO7Mw89PCtXEumMGIp/H7zmVkdPKg5OYXa2eAghy/0pIeY
         IhduCXfdbAnhT6ICyBhukKghFr9GoSxtiz6Zk8waEtyuzwJPvdnCg9gHqTNbEp9EdMF5
         OsITDNQaobIjzPvVJVvlYp0QL9x3G7mJn5D+d2eoHbD+pR+UD4hxo149LVaIKKjSXzv3
         pokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=smtBi/D7Bb1bx3MPJhAviruHQBepHI3ynR3xtWdGlAs=;
        b=EW1SQqCmDH/w0uCGuourcFez7iJJkh/8AZNI7N5sexqbfpjys5pQ4m19+QmBdyPjtj
         k/P0yk9VoX3ShaH4PG19lKfYTS0ycju5jp1r9qDfhkUVnnG54RKJ8g3nXsk2bFyw2YdF
         tVu0P5oqLgBb4Q52rABFzAAEdaTqEmBv8fgWooAJktpoAoxP8oEZBqfK5SaGcDnnyneh
         5w+ZHWZp3PquwBdcU+7ZwG+2G+Lk1FA0lboVNyNZfCNhy/ZtELyrsxWVSEnUwjEGe/54
         l5jllRtK638Tltxhqn2qTwF6XRPHPJPgt+6zj7tEPagSjf7WRrcghkymWX4lzNla3n89
         7y9Q==
X-Gm-Message-State: ANoB5pmDgd0bcAqDSXrcdAW/dQKrdgGvMJJmXmW10BJRUJs/wAOdHVkC
        X1mozsI7R5vIXnTP7jzupE/12g==
X-Google-Smtp-Source: AA0mqf67S9PgG8N5xafgp8BktWPtM9uv6Q5IJ8A0kmQU/ngSo5GctcZKDYojkWpornJfxAuKr7L7vA==
X-Received: by 2002:a17:906:b14b:b0:78d:cede:91f4 with SMTP id bt11-20020a170906b14b00b0078dcede91f4mr68739444ejb.764.1670238669867;
        Mon, 05 Dec 2022 03:11:09 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id ca24-20020a170906a3d800b007abafe43c3bsm6118349ejb.86.2022.12.05.03.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 03:11:09 -0800 (PST)
Message-ID: <3ab4970e-5ea5-4d85-7066-e15940ea7f57@linaro.org>
Date:   Mon, 5 Dec 2022 12:11:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sdm845-sony-xperia-tama: fix no-mmc
 property for SDHCI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221204094438.73288-1-krzysztof.kozlowski@linaro.org>
 <20221204094438.73288-5-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221204094438.73288-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 04/12/2022 10:44, Krzysztof Kozlowski wrote:
> There is no "no-emmc" property, so intention for SD/SDIO only nodes was
> to use "no-mmc":
> 
>    qcom/sdm845-sony-xperia-tama-akatsuki.dtb: mmc@8804000: Unevaluated properties are not allowed ('no-emmc' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> index 51ee42e3c995..87dd0fc36747 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> @@ -376,7 +376,7 @@ &sdhc_2 {
>   	pinctrl-names = "default";
>   	bus-width = <4>;
>   	no-sdio;
> -	no-emmc;
> +	no-mmc;
>   };
>   
>   &tlmm {
