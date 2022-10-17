Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BB66004C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 03:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJQBMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 21:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiJQBMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 21:12:18 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363F62C676
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:12:17 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id d13so5826669qko.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIpkj7PNl3x4kd8kCMZjcXTrj9dYxfRdONvhgTcQd9U=;
        b=NC9hMtO2yqx/uCHBnCPDIp/mwn6t9/xFP7apUMLbDuBpcc99gPP4KidJF7b/vpqXhy
         rfHR7rh/cL1tvcAWAGNmaTFwHZdsSE63FTkKL0pWZNnqqzKb+kmV6qKt2tRiZE90sACz
         4r131b2FGolg1iEtduVKU2cs4XCPFl3xfYTQltSk/sbeo5NQhT85NT9oxsH/DwkdtsPO
         W+XLMSEcSzD6VGk+98Yba+Mn/1ohZNZigzzLzr4rwg8lo9hwa+7+HP9dzrgKE6WodEzM
         aT92uioX9qByiZtCmXGpavskDagmnQdc4Brw2x0ersfFFxj89S2Ul+PMqTxJxKwFAPyT
         PIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIpkj7PNl3x4kd8kCMZjcXTrj9dYxfRdONvhgTcQd9U=;
        b=VGW2banr2YxmLWTfvS7pA9XhM8bqXiXlUQ2H7AC16xXUfGSHAELiZUa0EGyCotixe4
         XN6FiDCYe6hyTW2ucjEW4ZN9VTnoaiTKABkWy7CviDXZReznLU6LxPH6dWvuoEEENW8z
         ZRf17Ki3mWIG8WzlZY6nABc8P6WkJLNkjsJbbThAs0aR2f6D6wYZjbweoArZ+E1I8CQD
         hFjRRDVJR0dygIB7S3sbJFLJ5YfUTSCe1YQn8farpzfbZ1muKKoICjs2WRvDYt4lZMZo
         ZhNjPia7u4sNoe/wMfx7FtfkOM/TBuEvuYuHZokp1SQnpLZ7ZKnJ1HJAbtCLSzyfqeR7
         gEJg==
X-Gm-Message-State: ACrzQf2VzJLos4MlxBvRIkc5hZeMTpS7f9xiqV9uHfSwBL74zqe9sWrs
        /QknklAaoukvOPWpFjcVb7Fh1Q==
X-Google-Smtp-Source: AMsMyM4CiqXRkIRY/bHzhCVZzgzRQn8WphHd/0BNguFkJvwgOV6mHbNcwt+Rhwe2XuwrutSNQRdnvw==
X-Received: by 2002:a05:620a:12fb:b0:6ee:79f2:3716 with SMTP id f27-20020a05620a12fb00b006ee79f23716mr5969617qkl.348.1665969136380;
        Sun, 16 Oct 2022 18:12:16 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:bb7d:1aa4:bef8:ec27? ([2601:42:0:3450:bb7d:1aa4:bef8:ec27])
        by smtp.gmail.com with ESMTPSA id l4-20020a37f904000000b006ced5d3f921sm8069960qkj.52.2022.10.16.18.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 18:12:15 -0700 (PDT)
Message-ID: <bf4db82c-aaba-0fc4-ed6c-4945193a4e92@linaro.org>
Date:   Sun, 16 Oct 2022 21:12:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sdm845: commonize bluetooth UART
 pinmux
Content-Language: en-US
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20221016172944.1892206-1-kc@postmarketos.org>
 <20221016172944.1892206-2-kc@postmarketos.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221016172944.1892206-2-kc@postmarketos.org>
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

On 16/10/2022 13:29, Caleb Connolly wrote:
> From: Caleb Connolly <caleb@connolly.tech>
> 
> The 4-pin configuration for UART6 is used for all or almost all SDM845
> devices with built in Bluetooth. Move the pinmux configuration to
> sdm845.dtsi in preparation to be removed from individual devices in
> future patches.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>

(...)

> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index f0e286715d1b..55de40bea684 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2971,6 +2971,28 @@ pinmux {
>  				};
>  			};
>  
> +			qup_uart6_4pin: qup-uart6-4pin-state {
> +

No need for blank line here.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

