Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C159D6B906E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCNKpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjCNKpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:45:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F1D2915D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:44:34 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r27so19363777lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678790671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CufXOi5c6WNCFc2hn9WjIYddQXgO4QrrUY1LyXBd3X8=;
        b=W56mMayMPeN2W9jPfcdDtVhOQuRfeApv6Ko8Of8fiDNwRm+gYduoghDxuSMmCPEv7Y
         QHnEtHcMkPIOn6/+RaeXQmeSh3GZJbzVbIbLHPSWiKN8ZfCQhY21sa71xxdtr/VUWvh0
         7Y7pV9nuW+tLel3NvtvqdprIGffvByw0pYaIazoyqEP8xHMjRYf/S6UaXD/rhxq57Gan
         Jh4RaRCq6BZE8FqZ5uV8QG3JVW00I7r4Pyds3rnf0HLhW7sXbajOrFxpPqtjT+ZXxg0K
         1MqdYeCOzm1VObwiIH/NnojnF/0YlaEK/u15nhjyawJKRK3OH91xU8qtEpBMLeIkr/4B
         la1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678790671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CufXOi5c6WNCFc2hn9WjIYddQXgO4QrrUY1LyXBd3X8=;
        b=nBMtH3gR7LRHkajtoB82wNIOF22Ry2NiFaWshCQSQqe5XbXdtfAdrLLC6NRmsaWZ+8
         jFy6yMxb7TjsPBzbNjdMshMbjvT+l2qEUNSAE6goQnNfuOmhLsohkG9x4Pe4ptfCzjYV
         QhGCLxc/HepYHpj8DKeufOsWjxGMmtEoDwa6og4zfHhz9KIS1NfSVzdl6aI22ctRJORo
         Kw0dpBFF5us75IXJnQlqwHici9sqQrwbq7kd4EkOQiJJ7OYqFWr4lrnbIt8+9DOQAH+g
         iNsSaMz1wHk5T3A5j7RaxfssgzJxNp3I/QWO4H+zYGih9QK36rsQSQXWC2e8WhfrUZ1b
         6jIA==
X-Gm-Message-State: AO0yUKVfYuGFC9DQHjpTakI/XaVbxIvFvgEXEuxqp4gmP3phNhLm62wj
        9gdqmcyBJ09y+bdkKEh+Pm/dbA==
X-Google-Smtp-Source: AK7set+nMsNuL1g/hWyGWiP+PNe3XYuVxVqLi7qVVRwksPTVN6qKnSykp82XjB1fUFB8Wj9TpeVKBw==
X-Received: by 2002:ac2:5a0f:0:b0:4e1:36a:eda5 with SMTP id q15-20020ac25a0f000000b004e1036aeda5mr738730lfn.30.1678790671265;
        Tue, 14 Mar 2023 03:44:31 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id i2-20020ac25222000000b004ddaea30ba6sm348369lfl.235.2023.03.14.03.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 03:44:30 -0700 (PDT)
Message-ID: <a8a3f655-13de-46ce-5af9-177cb5e003c8@linaro.org>
Date:   Tue, 14 Mar 2023 11:44:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 08/10] dt-bindings: display/msm: dsi-controller-main:
 Fix deprecated compatible
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
 <20230307-topic-dsi_qcm-v3-8-8bd7e1add38a@linaro.org>
 <20230314001527.lrd65j42esfomcje@SoMainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230314001527.lrd65j42esfomcje@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.03.2023 01:15, Marijn Suijten wrote:
> On 2023-03-07 14:01:46, Konrad Dybcio wrote:
>> The point of the previous cleanup was to disallow "qcom,mdss-dsi-ctrl"
>> alone. This however didn't quite work out and the property became
>> undocumented instead of deprecated. Fix that.
>>
>> Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Yes.  From the previous binding (prior to that patch) either
> qcom,mdss-dsi-ctrl _or_ qcom,dsi-ctrl-6g-qcm2290 was allowed, not a pair
> of both.
> 
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> 
>> ---
>>  Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
>> index 2494817c1bd6..94f4cdf88c95 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
>> @@ -34,7 +34,7 @@ properties:
>>        - items:
>>            - enum:
>>                - qcom,dsi-ctrl-6g-qcm2290
> 
> No comment that it was simply renamed?
That was mostly handled by Bryan's series.

Konrad
> 
>> -          - const: qcom,mdss-dsi-ctrl
>> +              - qcom,mdss-dsi-ctrl # This should always come with an SoC-specific compatible
>>          deprecated: true
>>  
>>    reg:
>>
>> -- 
>> 2.39.2
>>
