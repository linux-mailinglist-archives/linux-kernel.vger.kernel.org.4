Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C808562F616
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbiKRNaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiKRNaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:30:35 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E63667F6C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:30:34 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id s8so8204423lfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hoPLnQIWHGZiBfocuqhD68DppPhxPPYZcsfi2ooXQ0Q=;
        b=LIBcnPcwE+cq0K/MX/yErC/yiG5Fh34Sxfgouazyo+Nr92ett/A8koHUpXDvSIuoht
         GqW/7DNDALIw3qJmw1Np6hqudkyBT1e9jPwRAJUAKZsl8v2xEaCnOxeuDFnvQYN29H7B
         3xTznZiyn1IWlcMhz9lR6f3ullk5BVoMvATZLIfxLcycI3GMVeKCXmmm1GsNTmT0e3Cj
         qVoL9GDlznpB+M54vNS4apZHCx6W4r3tvnKbIwnM++DcK4alWYgup38PROQRQU68c8tu
         gCILPLcbNNB0oZ/kcMFZjsKfyno5MdA5dMB3oYHzpJsJL9rKxVWTWJE9CzO2EeL6P841
         UIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hoPLnQIWHGZiBfocuqhD68DppPhxPPYZcsfi2ooXQ0Q=;
        b=IT8EhkQJB17Ior9MRNep+bvkQ0+WLQDZ48d4K76+Zqo70+CUGWw4FnTZ3KIKkAvJG/
         x28ITvpvsG4ZhevcK1lzjLMQTQLocl70C7A3+SaZB5pTvTvF36Sbp2AlGMe+28O/KGMc
         H9+9GhjjskZlwI/gW0MJZaYCHG7X8KpCpnYfyqUknLHuUDdM2zm+KvzQhp/Ivp0o1V5b
         BKMGU/RtHQFGn33HXv1llhg0iMYfwmT0XKI9q0Zr3MZTWMAaHa2LoApVyUg57m7S02uz
         tb1T3iQvK0Kx7vooBvQXjJM9BYExcYcpBd+bH4+iqRwcoMxPrYavWru4zWRIsec5vqNt
         AvRQ==
X-Gm-Message-State: ANoB5pm8lZSIQNmDVjhFt6joGZKQMIR1Fe/gynRqeORjquRoRF21gI1W
        3jRmfSg5XaIuFCGkCfLZGF3JQw==
X-Google-Smtp-Source: AA0mqf7OZT9f7s8VRA0spaiqh80uqrm8D1jurdI5s/WAmu9eeAg1h/N5A/QUUqt1bvuMp8kMxtO90g==
X-Received: by 2002:ac2:454b:0:b0:4a2:3f01:8669 with SMTP id j11-20020ac2454b000000b004a23f018669mr2290100lfm.305.1668778232687;
        Fri, 18 Nov 2022 05:30:32 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id w25-20020a19c519000000b00498f3ebffb2sm661763lfe.25.2022.11.18.05.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:30:32 -0800 (PST)
Message-ID: <361a94f8-280c-89de-0681-9b662b67d7ba@linaro.org>
Date:   Fri, 18 Nov 2022 15:30:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 07/18] dt-bindings: msm: dsi-controller-main: Add
 compatible strings for every current SoC
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, quic_mkrishn@quicinc.com,
        linux-arm-msm@vger.kernel.org
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org>
 <20221107235654.1769462-8-bryan.odonoghue@linaro.org>
 <aeb59d3c-34d0-f00a-bfc3-524cd03acb71@linaro.org>
 <0993d2bd-c0f2-8139-8f02-84abe6b8ad8b@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <0993d2bd-c0f2-8139-8f02-84abe6b8ad8b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 15:29, Bryan O'Donoghue wrote:
> On 08/11/2022 12:46, Dmitry Baryshkov wrote:
>> On 08/11/2022 02:56, Bryan O'Donoghue wrote:
>>> Currently we do not differentiate between the various users of the
>>> qcom,mdss-dsi-ctrl. The driver is flexible enough to operate from one
>>> compatible string but, the hardware does have some significant 
>>> differences
>>> in the number of clocks.
>>>
>>> To facilitate documenting the clocks add the following compatible 
>>> strings
>>>
>>> - qcom,mdss-dsi-ctrl-apq8064
>>
>> Generic comment: I think we'd better follow the arm/qcom-soc.yaml and 
>> use qcom,soc-something as compat string. This would leave us with 
>> qcom,apq8064-dsi-ctrl
>>
>> I'm not sure if we want to follow the qcm2290 approach and encode the 
>> DSI ctrl revision here (6g vs v2).
> 
> For qcm2290 I'm thinking qcm2290-dsi-ctrl - without the 6g piece.

This sounds good too.

> 
> a) Nobody is using the compat at the moment
> b) I'm not sure what - if any real information the silicon version
>     number conveys here.
> 
> + Loic, Shawn
> 
> ---
> bod
> 

-- 
With best wishes
Dmitry

