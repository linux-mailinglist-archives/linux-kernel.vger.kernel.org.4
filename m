Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9B964B26A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiLMJe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbiLMJeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:34:21 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E82C743
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:34:18 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a19so2760598ljk.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+nrOD5xKvpcWbF/6CtQ+UieL4B0mg2+teiLt7T6rsk=;
        b=h+egXjBxP4hMd9aJAoLuJ2N7wx2CEhIrDmt3QQyXn/PDN1FHH53+vdh/CEuVJ2J43k
         wr/RaiFiu9MlvLw/IwHf8bwHdj/akmMcF+TzehEB97JPyRPFc2LYKJvg7PDASk3EIfsU
         zG74RMZoSoGKb6/hXT09jAfWeDIKGLjwtCGsOdKSCbR9gHq1KzPuEbSbBZ6L2qoBwHsC
         wBgq1xfXczXSZouGtdytiK9m/6k401oh1+A5ZIdC9Fyfy2lRcb+pG/FG3M2ABsfFzm4o
         NulWfa5M0r7HmcOe2iNlId/s1KE1qimHZAR3AcoX9JWfXVtUK9omW8yFKUt6CFrJohU1
         dvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+nrOD5xKvpcWbF/6CtQ+UieL4B0mg2+teiLt7T6rsk=;
        b=E0SwRlcIVh9owehe0s9InzKZ3UUZu86csOXjXeeZDRdRb0k4ndUdhZ0ieypYIYPpfW
         fYYjPf8vQDe4i65OyAC3uMCVpdtmw/G/TAiAILmifshdklGsM8JQn5+zJSnY2V+h0ZAi
         Uhh7e4siMnPDA5NDOLx+YCUaVnO4ElswpUH40TTf8jKX03quk8mehe/LFGporBzBPb+1
         ZJMqA+qnQ/UVwrU1WYu1upvG4DYJmhxkM1yjS2/2krn967xYN4S07tEQWYGc4efr7e6m
         1xPDLYNmnnzma24OSvkmTAipIJMygKGSOlxaA1cFhy0tVFkNAWG1ShmJEHzg+Xf1fiLK
         PQ/A==
X-Gm-Message-State: ANoB5pkmGhlb50qZ5Xfo7NHhUDsUV2GIza4/LSvjgcTzXdt+TPoQesC5
        Y3jDMqns48XMliJzoY2SXjVGMw==
X-Google-Smtp-Source: AA0mqf7wnUWstl0PLplOvicPucK7DelOR1xO2j/44KQMMefKL243dJw5bv0crlcV5NYVa0Eb5B7iAw==
X-Received: by 2002:a2e:730b:0:b0:279:fdf2:65a0 with SMTP id o11-20020a2e730b000000b00279fdf265a0mr4678370ljc.12.1670924057236;
        Tue, 13 Dec 2022 01:34:17 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id bf19-20020a2eaa13000000b0026fb1c3e6ddsm187254ljb.62.2022.12.13.01.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 01:34:16 -0800 (PST)
Message-ID: <cc9014eb-f7e5-53e4-64d0-f29a57f45589@linaro.org>
Date:   Tue, 13 Dec 2022 10:34:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 09/12] ARM: dts: qcom: ipq8064: drop second clock
 frequency from timer
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
 <20221212163532.142533-9-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221212163532.142533-9-krzysztof.kozlowski@linaro.org>
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



On 12.12.2022 17:35, Krzysztof Kozlowski wrote:
> Keep only one clock frequency for timer, because:
> 1. DT schema does not allow multiple frequencies in such property,
> 2. The Linux timer driver reads only first frequency.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 9daafe9de02a..ae018a7dc6fd 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -562,8 +562,7 @@ IRQ_TYPE_EDGE_RISING)>,
>  				     <GIC_PPI 5 (GIC_CPU_MASK_SIMPLE(2) |
>  						 IRQ_TYPE_EDGE_RISING)>;
>  			reg = <0x0200a000 0x100>;
> -			clock-frequency = <25000000>,
> -					  <32768>;
> +			clock-frequency = <25000000>;
>  			clocks = <&sleep_clk>;
>  			clock-names = "sleep";
>  			cpu-offset = <0x80000>;
