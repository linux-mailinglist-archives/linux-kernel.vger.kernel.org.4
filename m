Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4952470154E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjEMIum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 04:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjEMIuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 04:50:40 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D8E4C25
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 01:50:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ad714536cfso88585581fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 01:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683967837; x=1686559837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZA+KVArcmXjb5W6mmCGUzDH85J25BuQco6W+6t2c4RM=;
        b=jeo/gJrKUI0IM8cpVDGXdRLOySjJYBKq46qyfunJdWGTofoXMFtLlVZNWK5jKIwmrc
         Jkb4JFU10nJ/S+lKp5mzoj7w5Bi6irzmRwad1/yihy3jGHZCeLIm/plOEkKhHhdqLDeH
         ZRuz8kJpW7LFknwxpccUDtYFdG5J5k/cSLPJiHe7USy22OaB1dZKsuYw7ohlsOY3OLJy
         MXWLNhtK6IEUVqv1dI+2w6FLgg92yEBewDVq94eTSMkv7wpnHf793rG1AaEed2mn/lqi
         8JLF9+RMgPrNyiXLNNoxxKVLP2PyaJijENINQkFT+7TDemICgTeb4MpaxnSdHir7+wVF
         G0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683967837; x=1686559837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZA+KVArcmXjb5W6mmCGUzDH85J25BuQco6W+6t2c4RM=;
        b=QjLXgYj9L1Fe2cSpVSRrxYqC+Oso0ejTAbpehhIrtpdsu5Y1UxH8rIM+kAR5oRgcm2
         7RST9oxJZmGTbZmlP+LCJWistmkJQX47w94pXFbnRNZaa1NESsB7mKiUBtX/sUYn+P0x
         zLMYqTS0d5yhYP+BhikRfNClaBCKCTfvjia2+KQmlBYlN8m4HNWov20PX09yqz7oD7ie
         +pZN94RRse13bjljxaNcy1fnWpT5tsuz2r92FXK1DANNtm7fskS3GMb1xJH4L2TkYpNL
         TBSe/cTX08sxXE+fZLiTEF1Y1VtNRRlMeTWZ47WboD7RVGz9ad4dOegcFRRFDuodiN0e
         EYAQ==
X-Gm-Message-State: AC+VfDwv/7zG+GPMQiUp4T7HSDozeSQCPVJ9HlrYLzuaovcFP6cyMERj
        V0dVVjFAWFJf2z87u+9QuE+4Tw==
X-Google-Smtp-Source: ACHHUZ5l3WP6SXF4/TAtrgwSMcYwjtbVgGIN2dCv9it8ot2NpYp2tlqdQ/CGgy9I7uZ+fnv0945pfA==
X-Received: by 2002:a05:651c:82:b0:2a8:ba49:a811 with SMTP id 2-20020a05651c008200b002a8ba49a811mr4673879ljq.25.1683967836975;
        Sat, 13 May 2023 01:50:36 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id x15-20020a2e9dcf000000b002adb566dc10sm1316566ljj.129.2023.05.13.01.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 01:50:36 -0700 (PDT)
Message-ID: <ff01b0d2-6e00-40dc-37bc-236c5510aaf5@linaro.org>
Date:   Sat, 13 May 2023 10:50:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] ARM: dts: qcom: msm8226: Provide clocks to mmcc node
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230509-msm8226-mmcc-parents-v1-0-83a2dfc986ab@z3ntu.xyz>
 <20230509-msm8226-mmcc-parents-v1-3-83a2dfc986ab@z3ntu.xyz>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230509-msm8226-mmcc-parents-v1-3-83a2dfc986ab@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.05.2023 23:16, Luca Weiss wrote:
> The mmcc needs several clocks that are being used as parents. Provide
> them in dt.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
> index 4dd4e26c73a2..3187b6853445 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> @@ -392,6 +392,21 @@ mmcc: clock-controller@fd8c0000 {
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  			#power-domain-cells = <1>;
> +
> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> +				 <&gcc GCC_MMSS_GPLL0_CLK_SRC>,
> +				 <&gcc GPLL0_VOTE>,
> +				 <&gcc GPLL1_VOTE>,
> +				 <&rpmcc RPM_SMD_GFX3D_CLK_SRC>,
> +				 <0>,
> +				 <0>;
> +			clock-names = "xo",
> +				      "mmss_gpll0_vote",
> +				      "gpll0_vote",
> +				      "gpll1_vote",
> +				      "gfx3d_clk_src",
> +				      "dsi0pll",
> +				      "dsi0pllbyte";
>  		};
>  
>  		tlmm: pinctrl@fd510000 {
> 
