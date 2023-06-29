Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB96742448
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjF2KuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjF2KuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:50:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78AE1BE8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:50:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb7acaa7a5so799137e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688035812; x=1690627812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AlWKrukg5MkoBr6pmLqgyqkqs3HWwrV9mYN/fyCAiOY=;
        b=WBlfWCh+qhrVWdYpLZ45TxWD+z+z59deD4crcXaYxzldSoovleEsfQTWo8vQ+fEygu
         MknhUiiWRRkpolb/Yzvak/bdgHVGSmM0dLxUIA2eOCuaESZqD5gNPn2ZvQSM2AqHCiU1
         Skv5s73xK4dr6rLkqrmN/8w+WBBn4Ysp5Qks3qGcBN91lBrOEguZRKWyaI8BaZigtVqU
         HssxCXJRtl+KcFwdptvdA+hw6O2mhRpQuHTgd2ns1JpN54rm+n7Rbl/IUMfqls/YdAht
         0XOzm0qMxB3367Uzv2CJnsMthpbxHJ8/NM+m+GZic3sFYgsgJx49jR6H5RlZMSpHsGpa
         Zssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035812; x=1690627812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlWKrukg5MkoBr6pmLqgyqkqs3HWwrV9mYN/fyCAiOY=;
        b=l0GySQrEI9O13IYqyKhEn6r5ItSYCS5/52Xz0bQeArHsgI7IOt6LQKP9s/gXis4/b+
         WuXAK9D9YPaJxmfqczOPDmoggnqbxCu2YorwGZCwVJDvRdyWExvo83YfFtopsCxAARvk
         +rQW+XMjSUYVcPPKQjoSMFun/hCEaQEySbqg8ADItqAPPR99Tj7Km6EFFfV78wHZu8kW
         coXnezHSl67lSMmC5TGWaOZ5JMAvWQ7g2KBcxH1865AJTSNtrGbZ42osTmAdMpeIF7zm
         1ECk08MaCIrjmlmPt5n44cX2hCletugFMVWziQXj5mKq5W24Gn/QuAYYwxKu59pfyU+T
         qL4g==
X-Gm-Message-State: AC+VfDyIjrBciBy8sEBc2MJ5CXiccSaIBJO5OthHYw6nbrdNSP0FU6hi
        hreoPRbgOMuXPpBhwzWmrEoQ9w==
X-Google-Smtp-Source: ACHHUZ4MUaOhGLj+rMVCwGhuYzQmktcGM6s56V38iEDGRih5bps9QVtmpsk9PuqcaKJZSP1bMwcr+Q==
X-Received: by 2002:a19:5f44:0:b0:4f6:2317:f387 with SMTP id a4-20020a195f44000000b004f62317f387mr20026659lfj.35.1688035812045;
        Thu, 29 Jun 2023 03:50:12 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id b12-20020a056512024c00b004f87571a5c8sm2264826lfo.48.2023.06.29.03.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 03:50:11 -0700 (PDT)
Message-ID: <bf82cadd-025d-58b9-15b0-5fd4d7a5603e@linaro.org>
Date:   Thu, 29 Jun 2023 13:50:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/15] drm/msm/dsi: Drop unused regulators from QCM2290
 14nm DSI PHY config
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
 <20230627-sm6125-dpu-v2-1-03e430a2078c@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230627-sm6125-dpu-v2-1-03e430a2078c@somainline.org>
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
> The regulator setup was likely copied from other SoCs by mistake.  Just
> like SM6125 the DSI PHY on this platform is not getting power from a
> regulator but from the MX power domain.
> 
> Fixes: 572e9fd6d14a ("drm/msm/dsi: Add phy configuration for QCM2290")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

