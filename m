Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E10574248B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjF2K5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjF2K44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:56:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872381BE8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:56:54 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f8735ac3e3so789493e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688036213; x=1690628213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XudBHNh6EIvicDJvP3l5PakLMCO2XVjkw1Un1jKRhd0=;
        b=uu7ZjOBoQU8Zuc6xF9IASCisl5i3RJN+o5oEwL0m8WNpxK4h7tBhSvxhOCqQRrjq87
         Hkg7yfdzH0v8pIDmxRQAGR0u2DHKqAjQaV2OCkDaYZObNHJXM4/nLOXobEn13seseI6X
         T/XY7LDx1LM++ixk5soYZgowssC0pWDGzuVTcdV5WnF/uIYj0WWxjOZn2qju8TU2Emgw
         10SG3XblmYyhBTrBCl95QTy0tnbNfHFsKBYPqn6sxYmBUku97ztxomjEPhya+HRs9NYt
         gEodLw7pzi0dZm1rldmPfx3Obbtqx7P3KOpXnk3n28Rucp/+1cm01JhaxQmMww0TL7bL
         sAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688036213; x=1690628213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XudBHNh6EIvicDJvP3l5PakLMCO2XVjkw1Un1jKRhd0=;
        b=C0Lrna/g30380PL4Dc9cNRq9qC3OuFajcygnlpjlT+gyM8XipDBSpaaWIVFkiZ788u
         gHF8aWnMaTVUGy7LEbDSgP7x6hH8uA7fTl2cXxLq+KjnF5ORTgLGFVO7ho6Oy8IAfh0T
         xxRUq8GGuzTlSw6gf8XGfKipaUlx4d0Immxot6ADha+DhxHi+hpvfxcwHoFWggDmRjQe
         JzSLUpIr91q80obcG1rSjjWwviYf/3OzQujlD3IqDkKOf7azTvgGxKPRgaNsBMaMuVaP
         qsW2EAK4Rz3Pk/5DwsDlHijwcvfUm76EJ0GHk+KS94LWF8z8mpTzNR5eV1XrYQV1ArqJ
         x7lA==
X-Gm-Message-State: AC+VfDz3HP15H3ULc2iEgDg7YG/ZMK/krH8Xr96vUoufYc2WQyqK9LxL
        s/7APdzHbf128ZXX8xrogobb7g==
X-Google-Smtp-Source: ACHHUZ67QQf0NeeCiPkk8c2GdI8jXCRn30dGTaBROv29CmYfqAcSa310+UuNTx97NP8aEBPeMY55Vg==
X-Received: by 2002:a19:4f04:0:b0:4f8:56c8:e6b4 with SMTP id d4-20020a194f04000000b004f856c8e6b4mr22003723lfb.47.1688036212712;
        Thu, 29 Jun 2023 03:56:52 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u27-20020ac248bb000000b004f861e64f24sm2276659lfg.113.2023.06.29.03.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 03:56:52 -0700 (PDT)
Message-ID: <9ea758a7-236a-6367-1832-fb65cb2ec75b@linaro.org>
Date:   Thu, 29 Jun 2023 13:56:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: sm6125: Add display hardware
 nodes
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org>
 <20230627-sm6125-dpu-v2-14-03e430a2078c@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230627-sm6125-dpu-v2-14-03e430a2078c@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 23:14, Marijn Suijten wrote:
> Add the DT nodes that describe the MDSS hardware on SM6125, containing
> one MDP (display controller) together with a single DSI and DSI PHY.  No
> DisplayPort support is added for now.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   arch/arm64/boot/dts/qcom/sm6125.dtsi | 191 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 189 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index a5cc0d43d2d9..b21fa1256f95 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -1204,12 +1204,199 @@ sram@4690000 {
>   			reg = <0x04690000 0x10000>;
>   		};
>   

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

