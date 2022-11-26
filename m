Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667FC6397B2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 19:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiKZSyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 13:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKZSyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 13:54:16 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1BA15FCD
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:54:14 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f13so11505080lfa.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17Uu5jB5JSV5jcVLyNQKvZQt0F2pRwxcX8qU0oKH7qw=;
        b=hd/b35FcuDguYSlqryOQKYBHU9QtBMOiMyUdY5h4wx7KHyOf/l9+c/A9bDpNTpzl6i
         CeJtMBtmLLmS02vjN7cGtyelAF1womE/Ri0uolJ23roXhI4yop7dCkv4IaYPR0M2eKRq
         ELj83xM+6tCWZa6tqQHl2HchVMdCETh/zJV+grmE+lP8ZFZNe2xL+Hm+XO1zKflqkx84
         8dObKZontXoNls2yxo6gvW3jtTF0yUp3c85BmDNj/qgQ5Snv/+LNw4p9S3P9Rwump3Fp
         Ud3wbFLqTqj8Q5JpDKylWVU38ycyTvsa1ySRV0PW02NUVDfmXjw7Zbr7OueoALA/cKfA
         9KeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17Uu5jB5JSV5jcVLyNQKvZQt0F2pRwxcX8qU0oKH7qw=;
        b=Hh1VXflFaKxS27wfpE3OqWgcHUKwgL1GAOueaFKZ/BzkzEaCYNSy9gsNyFV9pfD04N
         vPx7N7ib0YOKX0LoyVf17SgKyNEClRHGzpsaL6z56LtorDhd6d45fquhUVM5HLEsSEpq
         J/9SvwJCi0wdXtYrWH8HxqNcCkenpy0JtQrNfICRlFIcjuqBDS/B9v1qmwu6WGV/9J0x
         emjJkSacnOYeI4cIcRZnV+7w07SZSJ+kWqNW4fSo9f8xRRa6eZ8cN3AbKRfz6j8kqeMs
         zY1uojHzRD5N5K+YzIddvYHhT4inhRGJQeoI5ue0wp5thM2bCenKFmesRzmwyqqHD84y
         yB+A==
X-Gm-Message-State: ANoB5pnVlt9pGiuh1ejQm5gzP+2sSHA89XrB+kgWJrLpkqEvzIw5vlFM
        jdx3HmwGmMMciJUTbjwA/qAlNQ==
X-Google-Smtp-Source: AA0mqf6Y7o7r7uQYiZDsghBFDuKtnMf9/K9SkY9AU9Mbkm5Kf98HI24HvIBkrxEmTFbQEGx9TreZMg==
X-Received: by 2002:a05:6512:63:b0:4b4:f7a2:e4f2 with SMTP id i3-20020a056512006300b004b4f7a2e4f2mr5034714lfo.272.1669488853033;
        Sat, 26 Nov 2022 10:54:13 -0800 (PST)
Received: from [192.168.1.8] ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id s2-20020a056512314200b004a2c447598fsm993270lfi.159.2022.11.26.10.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 10:54:12 -0800 (PST)
Message-ID: <dc5df66c-2e2b-14f1-ce88-705d831f37d9@linaro.org>
Date:   Sat, 26 Nov 2022 20:54:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 03/18] dt-bindings: msm: dsi-controller-main: Rename
 qcom,dsi-ctrl-6g-qcm2290 to qcom,qcm2290-dsi-ctrl
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        dianders@chromium.org, david@ixit.cz,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        konrad.dybcio@somainline.org, agross@kernel.org,
        andersson@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
 <20221125123638.823261-4-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221125123638.823261-4-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 14:36, Bryan O'Donoghue wrote:
> We will add in a number of compat strings to dsi-controller-main.yaml in
> the format "qcom,socname-dsi-ctrl" convert the currently unused
> qcom,dsi-ctrl-6g-qcm2290 to qcom,qcm2290-dsi-ctrl.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

I'd say, as you are going to introduce new bindings using two compat 
strings, just leave this binding as is, marking it as deprecated.

> ---
>   .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index cf782c5f5bdb0..67d08dc338925 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -16,7 +16,7 @@ properties:
>     compatible:
>       enum:
>         - qcom,mdss-dsi-ctrl
> -      - qcom,dsi-ctrl-6g-qcm2290
> +      - qcom,qcm2290-dsi-ctrl
>   
>     reg:
>       maxItems: 1

-- 
With best wishes
Dmitry

