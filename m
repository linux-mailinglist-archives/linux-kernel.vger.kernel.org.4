Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17432663811
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 05:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjAJESS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 23:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjAJESM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 23:18:12 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8178E38AC4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 20:18:10 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bq39so16441961lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 20:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BAbrvIDX21sORhEpMRKBFBGE1ijyHzGfQa4j/vy210g=;
        b=wVcLbz6qKAkEDzLBDbrj0XoNmBd3D66kdBI5sin4HTu/Q65cWDdf5OCsrbv/Li4IOa
         QObJZ6e4KFlS1s1X9cUiYRj9xcSWnXCOqbXzoV8bllvVNnB837Gqs2zgyFd6MnyEaaQ1
         ovKJW8NUZZ2r/23tlF1yuvUBJpMoetpJzHrdsoKtvoEl7lw9k0fkJmq/plYMp5TjZ6Jt
         15NHN6kLVgt1aHPiosoYWouMabAQw5dcmLFgCKOqVfYI/JRu8Ch2m++wjbIb9rkaBZHF
         rL+g1xgixhUZ+AHUpQfxu7K3iu7kQGeyqqsQnOkQX+0tptqoNocsm6pLS6PpUybla9Sx
         VYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAbrvIDX21sORhEpMRKBFBGE1ijyHzGfQa4j/vy210g=;
        b=BsbO4du/4PWa/v2HSyRX8+aEXk6hgc7F9cKTk7+4mVKHOn4nTD+sjDBkzWRsqy3jAq
         hY+e4D3Xx50Jh9Tyr/jkU5TqxBUYQtpp6nvTHPmXCQ3mBdU8+GWnBKDDIBehv2Fg52ub
         xSSiNfK0NIt34kgPARjqOcJZ8eVvqbCBgJuB3WNqJU7it6fkySmTyImKIjlNSCWC/cxB
         aWaQwkZy26NQwsGwVmiy75iP7RkfvDjKBWcceu595dofihP08KI3wpZ3m5rNKTyyENoG
         4VfeFhH2XxnlvfhiGHZ/dRLIlIWZMu7pxtn7ghe1tyu84VyXXbFgQujicey2sO2d2anq
         Qj3g==
X-Gm-Message-State: AFqh2krCgPxQEwxQbY6p2++stszUlLAqkWb/VwvtkwVw5miY8g3RR2pg
        0Z7yOivV0AEWeuyEopBsRxXhVA==
X-Google-Smtp-Source: AMrXdXtGqxB5FWKeH4Hz54MIYp9cdc9vjkF+6IIeAl9xo/p4w1nnxoIC8iPDN9GOhuEaFdyvoT1vjw==
X-Received: by 2002:a05:6512:65:b0:4cb:4438:30a3 with SMTP id i5-20020a056512006500b004cb443830a3mr674653lfo.53.1673324288764;
        Mon, 09 Jan 2023 20:18:08 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a13-20020a056512200d00b004c57abccb8bsm1956949lfb.102.2023.01.09.20.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 20:18:08 -0800 (PST)
Message-ID: <e8f80539-f253-a6f7-3c5e-e6c94dac31c2@linaro.org>
Date:   Tue, 10 Jan 2023 06:18:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/7] drm/msm: add support for SM8550
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230103-topic-sm8550-upstream-mdss-dsi-v3-0-660c3bcb127f@linaro.org>
 <167330408777.609993.13359003796525315964.b4-ty@linaro.org>
In-Reply-To: <167330408777.609993.13359003796525315964.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 01:43, Dmitry Baryshkov wrote:
> 
> On Mon, 09 Jan 2023 11:15:17 +0100, Neil Armstrong wrote:
>> This adds support for the MDSS/DPU/DSI on the Qualcomm SM8550 platform.
>>
>> This patchset is based on the SM8450 display support serie at [1].
>>
>> In order to work, the following patchsets are required:
>> - PM8550 LDO fix at [2]
>> - DISPCC driver at [3]
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/7] dt-bindings: display/msm: document the SM8550 DSI PHY
>        https://gitlab.freedesktop.org/lumag/msm/-/commit/71917f654bae
> [2/7] dt-bindings: display/msm: document DPU on SM8550
>        https://gitlab.freedesktop.org/lumag/msm/-/commit/602082368233

These two patches were removed for now, until we have dispcc and 
interconnect bindings in place.

> [3/7] dt-bindings: display/msm: document MDSS on SM8550
>        https://gitlab.freedesktop.org/lumag/msm/-/commit/9cb8eacfb528
> [4/7] drm/msm/dpu: add support for SM8550
>        https://gitlab.freedesktop.org/lumag/msm/-/commit/c3cc4e88efb0
> [5/7] drm/msm: mdss: add support for SM8550
>        https://gitlab.freedesktop.org/lumag/msm/-/commit/f96cca5ed719
> [6/7] drm/msm/dsi: add support for DSI-PHY on SM8550
>        https://gitlab.freedesktop.org/lumag/msm/-/commit/0fd17f93661d
> [7/7] drm/msm/dsi: add support for DSI 2.7.0
>        https://gitlab.freedesktop.org/lumag/msm/-/commit/d797ca161b87
> 
> Best regards,

-- 
With best wishes
Dmitry

