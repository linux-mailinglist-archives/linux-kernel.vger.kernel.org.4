Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C27069B946
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 11:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBRKOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 05:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBRKOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 05:14:10 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF4C38EAE
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 02:14:09 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ek11so1916500edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 02:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XlYpUpe2mvgMM93e/W7QPf63bpnY6+x3AWjdp9vVuto=;
        b=vHc8eWnXv559cPUvTjAwx4fjMkcCMs3PZaTCVmo9y2AIJhUH/Mp2yT8Pl2aIjne5Hm
         KM5BtTCbsjyE1g6mTFetLELJG5SuG2FcFLlfDE5lmVnZ9t1KhJ2sisOUBxAjaTFdBE/1
         3+SLrC/KB4z3DqbF8ibLbezZrcFMTxC86DohLdKexLBV9EpJ8UQliQ5S4Biqy1/ffceD
         B5kgjXdVmJpXyFY8lzfVNuzm3X8y+gTKXD1MR1RxR+5cFrSwBalH5q0OblIADiPaNM/E
         xSvsyeoqlLkWo4YTSQcM5VIzUyz2fqIH/S/h4hfwP+5/O6wx+dCtKD1n05e1WBaORrEF
         6klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlYpUpe2mvgMM93e/W7QPf63bpnY6+x3AWjdp9vVuto=;
        b=3Z/cs9w3eTbtSWhJynhEA8w1fvy3s2LCQElk/cQaWvvOpTalSXiXMdwrVLlVSqmDCe
         T/bquloZ/oMvCDED6FBzTtqzx2pwAh2bgprnY9gE96jh2efDKAmVS1kpST5FnJiQVgNz
         KLDHULbDqNPSvjeL2d/M4/n95b6T2h0ixk4wFRrKsoFunqe0jb+Vnpl/1yfIP8kOvjxK
         f/vyIO4f6Zst6BtUgAVwlH4J7xN1o7ZLkVU0Zt11hBN6CE06RDhgqPOHpizSq/t79knf
         48yHMLZRtdAK7UlV0qgWB2Z2oOS+qDc1quNqSL+4SSM/q1IVkp7mcnAyKWxCadXsP1iH
         lNpA==
X-Gm-Message-State: AO0yUKW6Bp7o9EeUrTcup07idwkh5xTva3pmu6c864jkE47/SgzMJ0am
        nL2hDQPh4RdF/yeyrhfO3DvCDg==
X-Google-Smtp-Source: AK7set+3xynx3gDPCY9sAfEctMu3DjKAusUU/V/7HxqiREWds9wQjauq9fvyl47NEeCBkmqS4EqKcw==
X-Received: by 2002:a05:6402:d2:b0:4ab:4ad1:a37e with SMTP id i18-20020a05640200d200b004ab4ad1a37emr98905edu.16.1676715247702;
        Sat, 18 Feb 2023 02:14:07 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r23-20020a50c017000000b004a233e03afdsm3381118edb.46.2023.02.18.02.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 02:14:07 -0800 (PST)
Message-ID: <e6d397bb-dd5d-8308-eb07-3aeb2589115c@linaro.org>
Date:   Sat, 18 Feb 2023 11:14:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] dt-bindings: display/msm: dsi-controller-main: Fix
 deprecated QCM2290 compatible
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230217111316.306241-1-konrad.dybcio@linaro.org>
 <c49904be-d842-fc12-a443-17f229d53166@linaro.org>
 <a4eaccfd-34ba-15f3-033f-165b46c43317@linaro.org>
 <a158bca2-78bf-5b38-60fe-88118e8b4ad7@linaro.org>
 <ab35cdcf-53ae-a3f2-fc08-d0f58c51a0ae@linaro.org>
 <48cb00cd-961c-b72f-fba8-1842d658e289@linaro.org>
 <d4ffa9f0-797e-7a32-147e-64aa46d7e197@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d4ffa9f0-797e-7a32-147e-64aa46d7e197@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 22:13, Bryan O'Donoghue wrote:
> On 17/02/2023 12:24, Krzysztof Kozlowski wrote:
>> First, it would be nice to know what was the intention of Bryan's commit?
> 
> Sorry I've been grazing this thread but, not responding.
> 
> - qcom,dsi-ctrl-6g-qcm2290
> 
> is non-compliant with qcom,socid-dsi-ctrl which is our desired naming 
> convention, so that's what the deprecation is about i.e. moving this 
> compat to "qcom,qcm2290-dsi-ctrl"

OK, then there was no intention to deprecate qcom,mdss-dsi-ctrl and it
should be left as allowed compatible.

Best regards,
Krzysztof

