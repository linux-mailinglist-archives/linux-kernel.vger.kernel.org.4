Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0982661AF1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 00:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjAHXJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 18:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbjAHXJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 18:09:16 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F176CB49D
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 15:09:14 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j17so10456374lfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 15:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHTsVemuZVdFBAOVhXekZDJCYjSFOYswDw57t68u+B0=;
        b=E2SiNKam01JLHyR4YRcH3H1AOyoxfAJhrsUEL3HMNuBD+T7O86muHUbPIhyNqZQBoO
         1x/8Cw6EqmvH06RHDUxYKdOzGPVvE/xCzYBt06+jNisp5GFGBCG6lqt5mSO2Rpw+DXlC
         r3eI8fWwaZaUuXyG8DfTWFX4LNaVIgFcmz89idXaf+yDGRPAR04KNrGX/+qx2kdJ2XXT
         cD51OX9AHyyVCX+66fWArOO5tf4UlR9o5d3NQwyN9X9VwgzmEGcvugECShDPCzEE9WWH
         flF6GB0BesE07Jh1AXla68inOUmM4U/QE1/LsBR+Wh+5wC57CisuUJqrxQk0pcXMPZeH
         v5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHTsVemuZVdFBAOVhXekZDJCYjSFOYswDw57t68u+B0=;
        b=arn2IMR3910Kgvjofb1VMm6qlEOKALKuxY8wSTW4AwWHJfnNO3AqAm36Y/pzNiTsvT
         DfJPhmzOfm9mQfh9sesAqkErCfi2QnmEevN2IzL7mNcUWqTwhuhnAjhu3sArCs/5eRO5
         vhmtxdQp1qRxRtB+cVF19LZM4BeGF1cCi/3LPQ8yd4sxeWWBvjQDUgPNxYogYBpLw9pg
         j+9UrtXdrYSHdwJeo2CBpvuT6vYZAydwH585xSmITRbqMda4NPFNorduqynsm7nGflmC
         6W0Ocu5bWYa8Ka5pxGe7mufnmvHRjAl70q//W6GJSbMYoHsYXmJvGaM+K5xfXBK65Cve
         c0Pw==
X-Gm-Message-State: AFqh2kq4geiiaytZAiQ1Dfj29GaST4jXznzynrdNVuMDGjyN6H35I5yB
        bTs8aG8ipuN5HGznpzSqqE2xdg==
X-Google-Smtp-Source: AMrXdXt81nlX2Mx4LeY8PwzwnMFJQKhvqwBI2Cbzu5dcQTpAyBJCqJ+hXQu2QCpa6S1il70ht/ItqQ==
X-Received: by 2002:a05:6512:2344:b0:4cb:90d:41b1 with SMTP id p4-20020a056512234400b004cb090d41b1mr15158956lfu.56.1673219353295;
        Sun, 08 Jan 2023 15:09:13 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id s9-20020ac24649000000b004cb02ed464esm1256597lfo.196.2023.01.08.15.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 15:09:12 -0800 (PST)
Message-ID: <5f1a846b-d536-f013-f311-2773945317bb@linaro.org>
Date:   Mon, 9 Jan 2023 01:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/6] dt-bindings: display/msm: document the SM8550 DSI PHY
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230103-topic-sm8550-upstream-mdss-dsi-v1-0-9ccd7e652fcd@linaro.org>
 <20230103-topic-sm8550-upstream-mdss-dsi-v1-1-9ccd7e652fcd@linaro.org>
 <f8c8076e-2ac3-f67b-7641-d0c324784cb5@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <f8c8076e-2ac3-f67b-7641-d0c324784cb5@linaro.org>
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

On 06/01/2023 17:41, Krzysztof Kozlowski wrote:
> On 04/01/2023 10:08, Neil Armstrong wrote:
>> Document the SM8550 DSI PHY which is very close from the 7nm
>> and 5nm DSI PHYs found in earlier platforms.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
>> index bffd161fedfd..f72727f81076 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
>> @@ -15,6 +15,7 @@ allOf:
>>   properties:
>>     compatible:
>>       enum:
>> +      - qcom,dsi-phy-4nm-8550
>>         - qcom,dsi-phy-5nm-8350
>>         - qcom,dsi-phy-5nm-8450
> 
> Poor patterns once allowed like to keep growing... I commented here:
> https://lore.kernel.org/all/ccbb47e4-d780-0b1d-814e-27e86b6c369c@linaro.org/
> 
> so let's wait for response about other compatibles.

I have fixed 8350 & 8450 while applying. Please rebase on top of 
msm-next-lumag-next with fixed compatibles.

Note: the DPU changes are not yet part of the msm-lumag-next.

> 
>>         - qcom,dsi-phy-7nm
>>
> 
> Best regards,
> Krzysztof
> 

-- 
With best wishes
Dmitry

