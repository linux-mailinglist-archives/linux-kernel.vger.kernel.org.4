Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562A0654411
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbiLVPOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiLVPO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:14:29 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2342926AA1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:14:28 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id n1so2210154ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hJcEHNExNxST6Lgk42fV7p9jHJjh3wV2GauSE8OfYI=;
        b=phZTk5cphy9HXfhb6AWRQT6m8otcwgW4aIoXikuzaO5LwiISVNf2Z80iVrFHy9Iupn
         hh9vdEO0T3K1G1Kpow+zQwQJRIok7b1s+WjQBW0BNsDC0t+wSoBlwUGJuSYFqCTbxrQN
         JAOm7TjMF9ItJo9N11tTNIbOsMergZsZEIsD9djoGsdJrPhSe3gR9FHF3exoK77UvYlp
         n2aV8BjzgLukZKbpid4NRjM/E/CThCz2TgzY9W6Oq/zZiajgRgkNtOaJSI9u7/MsPbVR
         BIgVErUwRDo+OXDd1Xg/7eigVrxRL9FC2X5IWmq46KvdSaGbXHtXGkm5abGLvuCWJq8M
         UAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hJcEHNExNxST6Lgk42fV7p9jHJjh3wV2GauSE8OfYI=;
        b=AKlp1kcN/NWS1Q4m13/Xp1JmvRC3SZYz/chU5l0YaX1bh0RgMaoxtwBQaC3gQv8toC
         VGehpHDXJJhua4scpTlzSKsbe0WsooFPhSydCxSBCUAep/arH8X1XS/5m3XOPyoeLG1L
         v5kABckSsfrkMT2NYa2ZSBpq+ZYh+s+51EQPPKP6WiMK1BIkf+rzkr2O7eg/Bky2lW2w
         zDVHbhK+bJcsmsNgqPSgBvwNkfU1yT3ovbSJQLmE0hVNESV/ncwBESjJUJsJ8kmDQOR+
         rAGEGgFY1NKxi7emxDuKfXiHPCSQtVnPQhqwZ9E3OdyfE98XqJLgO5zslUZodWZXC4BM
         U53Q==
X-Gm-Message-State: AFqh2kqWZZ/ginjodCVg52JQGBwMxpbFgg/r+n19yakyTifgKJ2Wty7T
        qdhsqyakWc/7lIvrqmgOxrrKVg==
X-Google-Smtp-Source: AMrXdXsPiNouCzJDivhhECwkK+IQXW2byyi+qTZPygB6gdAWsmCNl/TPl2vf1NrVGAhxtYaxKH4B2w==
X-Received: by 2002:a2e:720a:0:b0:27f:82f8:c7f8 with SMTP id n10-20020a2e720a000000b0027f82f8c7f8mr2130644ljc.42.1671722066554;
        Thu, 22 Dec 2022 07:14:26 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id p23-20020a2ea4d7000000b00277201f6c81sm70294ljm.77.2022.12.22.07.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 07:14:26 -0800 (PST)
Message-ID: <3ff9b6f3-70b7-d6b1-9714-b51e3e867b6b@linaro.org>
Date:   Thu, 22 Dec 2022 16:14:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: sdm845-xiaomi-beryllium: fix
 audio codec interrupt pin name
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Doug Anderson <dianders@chromium.org>
References: <20221222151319.122398-1-krzysztof.kozlowski@linaro.org>
 <20221222151319.122398-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221222151319.122398-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.12.2022 16:13, Krzysztof Kozlowski wrote:
> The pin config entry should have a string, not number, for the GPIO used
> as WCD9340 audio codec interrupt.
> 
> Fixes: dd6459a0890a ("arm64: dts: qcom: split beryllium dts into common dtsi and tianma dts")
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Cc: Doug Anderson <dianders@chromium.org>
> 
> Changes since v3:
> 1. New patch.
> ---
>  arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> index eb6b2b676eca..85b8a1b5f0d5 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> @@ -472,7 +472,7 @@ sdc2_card_det_n: sd-card-det-n {
>  	};
>  
>  	wcd_intr_default: wcd_intr_default {
> -		pins = <54>;
> +		pins = "gpio54";
>  		function = "gpio";
>  
>  		input-enable;
