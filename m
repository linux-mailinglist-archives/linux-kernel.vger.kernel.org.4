Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABEA746BE1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjGDI3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjGDI3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:29:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918FDDC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 01:29:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51dfa0771cdso3806182a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 01:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688459387; x=1691051387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nSydRmjgws15bedxlErnljNbotaBQn+Lbon5YDX6p44=;
        b=SwFgQHSvuSl1/DEHWu/vKT9xPNWOMD9kYSXxsFEdq2Bu1SSTPFLaYLMwBuuXv/6xU+
         TC5KnjiNEYjYPvBprtpThRKC9aeHzF2y7iEh47MBa5JRXQkVWhSVFW1qOj/s9A/dYbuz
         WdAhApzqqj6oLXLGeFcQol1FenabtCfl99Ny0f+ZvVaeSj4SfFdHEyI5i8TxwUm/DeVq
         mJkLPkD1J1zhZJH7eD7JzxP45xTDVyU/9ablIfkEDaCogUFW5ygML7q5RIRhoCLIMunX
         MIOn1NelXRZnT1ZFEfxNgVBffQKiF3SlBaU74KqzC8sz2xQzSdJ5JO5DWkSzDqeA0mZw
         QR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688459387; x=1691051387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSydRmjgws15bedxlErnljNbotaBQn+Lbon5YDX6p44=;
        b=fjvoVL59cv2G6aQtLApe9fRyIfRKopQTY6GkV2Z1Sx+GkGjxhw774FnCgYNeWfgpNB
         qbDewsa9YeQNQmjxd5opG+afLCV7omqDIBpAiP41H4HlNBHzkeQfpmEWFkdEV3RXqQ+n
         NAzp91OXXU9FDRvhExsEZQled/kyX8meifkifUY+g6MGtkju8OXndlwK4Dj/9eXsUD/u
         i2FejqALD8CviwAVKYImCwx1Mcb3dCX+Xg+2bb9kKHcrAWo8CXD0phBKX5NsqyTCuWaq
         ZGlx74xtOC2vf3NpHC+mcgW7DkoHSBs68fGyh6dWXJo+qUHMJ5IIKR7g3t/iZSLR1/68
         7RNQ==
X-Gm-Message-State: ABy/qLZA9sW6XETbjUqkj5A9JMwe4AvX+/k/qeb728EGJxFWXtqRKkqg
        kianiLEuqryv2Z/dvvVv4pRTBQ==
X-Google-Smtp-Source: APBJJlHW9oT1caeFSgmLOSMzk0XFqnO4q4Z/spxGyuonofeoCOXIDrcjbbQr+AwH54okYEESIpe43A==
X-Received: by 2002:aa7:c711:0:b0:51d:d4c0:eea5 with SMTP id i17-20020aa7c711000000b0051dd4c0eea5mr7695607edq.40.1688459387051;
        Tue, 04 Jul 2023 01:29:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n22-20020a056402515600b0051e0f100c48sm2566127edd.22.2023.07.04.01.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 01:29:46 -0700 (PDT)
Message-ID: <9256aa76-ded3-3fad-4564-e3451cf74065@linaro.org>
Date:   Tue, 4 Jul 2023 10:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 02/14] dt-bindings: display/msm/gmu: Allow passing QMP
 handle
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
 <20230628-topic-a7xx_drmmsm-v1-2-a7f4496e0c12@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v1-2-a7f4496e0c12@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2023 22:35, Konrad Dybcio wrote:
> When booting the GMU, the QMP mailbox should be pinged about some tunables
> (e.g. adaptive clock distribution state). To achieve that, a reference to
> it is necessary. Allow it and require it with A730.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/gmu.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
> index 20ddb89a4500..9e6c4e0ab071 100644
> --- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
> @@ -64,6 +64,10 @@ properties:
>    iommus:
>      maxItems: 1
>  
> +  qcom,qmp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the QMP mailbox

mailbox would suggest you should use mailbox properties. Instead maybe
"Always On Subsystem (AOSS)" or just use existing description. I assume
it's exactly the same.


Best regards,
Krzysztof

