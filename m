Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485F067E517
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjA0MYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbjA0MXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:23:24 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D857F69F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:20:58 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hw16so13155446ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qOYF+3qUnJddQFsYUcJ62Jiu4L7Qu1GdHxMgw91mBqU=;
        b=myQhG9HDilY1GzeyfrFZNBO6j6Vlr2z1Y0aOBwNCEQU88JAH6Wnx8VMVCKEYs2zO/A
         JeQEYVITFZb4JiEB1Jl049r2+OAdm5TxTjaPc89TYuElKEnVSkwOYHCjmWB3wh6dJqJr
         XzlXJoN0EUioPWdc3srO4aRMu/Ov4XzZmPNq+8NgVwZ8yZy6M/dzo0lBSbDY+FpDTeFs
         RVQ27K7WCXTa/djkEME4lKfy7/aola4sHmFaRAWImaCd1W5bMEZ4bCIJdhkYd9TCealL
         /D363b6qmei8TwI3XNheNIPm2g1yRqkmGEDanzmfg47ff6ZAErV8RsBoA/ATkr/PJP20
         5GyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qOYF+3qUnJddQFsYUcJ62Jiu4L7Qu1GdHxMgw91mBqU=;
        b=g0WA5esxRK1Q/3bDrvZJ/4ExdP8rnxbSmD5SxKskhipebZwpyunfKH+wkKDj7k8FcE
         O76wnohu9Dg3ZpOR9ch+Nl4sZX/AaU7r+qLVzdz6TnQ6JjALNEIVkflUUX879kpCAdb8
         kEF+qu0Sd3JDZgIhmvK4ZHHCcDlwgIBIFfKfra6CpRtX5aUkBFNqiQrrXUpS3/3jLhxz
         0Tew3/KWRQin2dL0ktLXHjhrvIKSXZCRcgaOWt+NhRuV7Uzoy2xUtWzBDXTmX3bo6+Fx
         OuWXH90gEvU4CcbAH9eyAD4el0j0cQi3eW9RcYAeNSCx7LBrvPau6UZwjqzIWYp8eSu8
         9M2Q==
X-Gm-Message-State: AO0yUKUPWhX2XAJA04sBs5oIkoRhX55A8ft3qWF70XxjKCY6+JzDQwyR
        OUr5tFmmrksmk1pI1VE4ypG9x44oiIfG2sE5
X-Google-Smtp-Source: AK7set/bzLSICsz6SEla+oD3HPGPduOExiC7tvy1uIHl9zjLgo+hkCneJg2VyI6NObv3OXJ0Y1NKVw==
X-Received: by 2002:a17:906:2dd6:b0:878:714b:5e16 with SMTP id h22-20020a1709062dd600b00878714b5e16mr5563467eji.28.1674822055032;
        Fri, 27 Jan 2023 04:20:55 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id gn19-20020a1709070d1300b008512e1379dbsm2207959ejc.171.2023.01.27.04.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 04:20:54 -0800 (PST)
Message-ID: <0841c8ee-de55-3592-1e34-6a6890bfb165@linaro.org>
Date:   Fri, 27 Jan 2023 13:20:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8550-mtp: correct
 vdd-l5-l16-supply
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230127121843.349738-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230127121843.349738-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.01.2023 13:18, Krzysztof Kozlowski wrote:
> Fix typo in vdd-l5-l16 supply of qcom,pm8550-rpmh-regulators.
> 
> Fixes: 71342fb91eae ("arm64: dts: qcom: Add base SM8550 MTP dts")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
> 1. Correct, not drop (Abel, Konrad).
> ---
>  arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> index 725d3bc3ee72..5db6e789e6b8 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> @@ -47,7 +47,7 @@ regulators-0 {
>  		vdd-bob2-supply = <&vph_pwr>;
>  		vdd-l2-l13-l14-supply = <&vreg_bob1>;
>  		vdd-l3-supply = <&vreg_s4g_1p3>;
> -		vdd-l6-l16-supply = <&vreg_bob1>;
> +		vdd-l5-l16-supply = <&vreg_bob1>;
>  		vdd-l6-l7-supply = <&vreg_bob1>;
>  		vdd-l8-l9-supply = <&vreg_bob1>;
>  		vdd-l11-supply = <&vreg_s4g_1p3>;
