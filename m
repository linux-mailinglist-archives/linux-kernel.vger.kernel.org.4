Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8F0704297
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245731AbjEPBHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245593AbjEPBHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:07:17 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557A859C1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:07:13 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ad819ab8a9so112882951fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684199231; x=1686791231;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CM/lSevDv8XjzRTSjTzIIM/SCKVVJzi2LgwGYfmNjT4=;
        b=NXAOh1IEio1Nx7BVRPjfwhLwEzJ0sHFCTGlM5p35PDwC66xXC1HZIkS9SjPwN0UxVK
         rsu2y0SlKjL+V26zo9r+5k0GKJv6ZYuLZjhJr+LIkEXaVSq6DLR8z+vTdl88VdpcTI0x
         NaFOsjBmSoA9oyVq6yvZSodqwXcVaTAj83gaFGRbrsB0NW5srpsN2BmC1ursaaqioEg4
         9TcvUp2c3sA/gpI/WlL66bq05xUTQXBkoSPsqvKelnCeKaKTiqVvZ208SvI2OuvBHBiO
         59QU+AxgMCYS2tkjPqxubB9tMyZtxFyQjLlUWMfAa+m11coDm3eiIRyN6HcClVDFJqyl
         j1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684199231; x=1686791231;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CM/lSevDv8XjzRTSjTzIIM/SCKVVJzi2LgwGYfmNjT4=;
        b=S1nKzn+o8PVhCUN4Hs/kCcl6iIPbS7mrN4MpQKWitHxyTmSm3wDWSSWRpMvN0CUQF3
         Hr7/d7r0ed/SWPVqYt1/Kz5+scX7BvhJDbUAsb2tvMLIoO3cNYo7A9GhIrNvX26H8t/s
         1RW1ANtXYGiPx+vTCZrbRpT7oQeWKPj6WbA56ABN+AlkriYd3sGz3eHECYDjpdA7JNvN
         9Dszna5vgxfEjM1zQ5wjt2eF+rDfRRUVDYWPpHD9+9yLd41hBdLFPcVQ5TUo+tvFlZTP
         qqp8vNTIEbcoNBw9eS94VmwDH6tiHACG1kjDexkwAI3DNeJfpLrhObb6WrvHRINszLfB
         WF6A==
X-Gm-Message-State: AC+VfDwsnWgT3n3ko8wijy2x1XZ7Z7iyGKeOh/VUUcd/L+Hq+YkRP2+f
        TNgFCKOUvHPjiXGIlQFAlnDShA==
X-Google-Smtp-Source: ACHHUZ40Ce3BmZXcXMME5urWr0CG8SeU1US+J4EHGbJPzj0vNXzvxEi/rHPtUFcRAGA9cJ4SfWaLhg==
X-Received: by 2002:a2e:8618:0:b0:2ad:9acb:484e with SMTP id a24-20020a2e8618000000b002ad9acb484emr7898066lji.49.1684199231595;
        Mon, 15 May 2023 18:07:11 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id a15-20020a056512020f00b004ecad67a925sm2837994lfo.66.2023.05.15.18.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:07:11 -0700 (PDT)
Message-ID: <e77647ec-4f77-541e-3df4-264c4f4f1bf7@linaro.org>
Date:   Tue, 16 May 2023 03:07:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/4] dt-bindings: thermal: tsens: Fix "make dtbs_check"
 error
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1684140883.git.quic_varada@quicinc.com>
 <72707b76a717b410b06ed7fcc854314104f5f845.1684140883.git.quic_varada@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <72707b76a717b410b06ed7fcc854314104f5f845.1684140883.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.05.2023 12:13, Varadarajan Narayanan wrote:
> While verifying make dtbs_check for ipq9574, qcm2290-tsens and
> sm6375-tsens threw the following errors.
> 	['qcom,qcm2290-tsens', 'qcom,tsens-v2'] is too long
> 	...
> 	['qcom,sm6375-tsens', 'qcom,tsens-v2'] is too long
> 
> Fix them by adding their entries.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
https://lore.kernel.org/linux-arm-msm/20230314-topic-2290_compats-v1-6-47e26c3c0365@linaro.org/
https://lore.kernel.org/linux-arm-msm/20230303-topic-sm6375_features0_dts-v2-1-708b8191f7eb@linaro.org/

These never got picked up..

I'll bump them.

Konrad
> [v3]:
> 	Fix the following 'make dtbs_check' error
> 		['qcom,qcm2290-tsens', 'qcom,tsens-v2'] is too long
> 		['qcom,sm6375-tsens', 'qcom,tsens-v2'] is too long
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index d1ec963..d9aa54c 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -48,6 +48,7 @@ properties:
>                - qcom,msm8953-tsens
>                - qcom,msm8996-tsens
>                - qcom,msm8998-tsens
> +              - qcom,qcm2290-tsens
>                - qcom,sc7180-tsens
>                - qcom,sc7280-tsens
>                - qcom,sc8180x-tsens
> @@ -56,6 +57,7 @@ properties:
>                - qcom,sdm845-tsens
>                - qcom,sm6115-tsens
>                - qcom,sm6350-tsens
> +              - qcom,sm6375-tsens
>                - qcom,sm8150-tsens
>                - qcom,sm8250-tsens
>                - qcom,sm8350-tsens
