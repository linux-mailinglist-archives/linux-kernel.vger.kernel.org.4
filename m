Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB896AB8DC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCFIy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCFIyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:54:55 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF6715CB7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:54:54 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ay14so31627560edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678092893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLAhqnNFboMZ3Xspb0HEH0L2QkUdVCAZTGMLZDTo/AI=;
        b=jczTpg4zXHb1ZQneDL/piIaCwC5Mr18d9VYx8iHeFhWIhnuV4wlFycQOhptE/+OUf5
         rmR4fXrJzuHTIxI5k2HLJ2iQY/r1ZomAhCjBOL7w2vVguAg/NuPpOuBqyQoLUGaKOSqa
         10uGpZ8NjOstj/WxKtZ700TO0vzwyX66VvCmxiF7VC4yforcMxQ96jDi7Po7n+8u5o9n
         iAR0l28grFRon15ZCjmeDxZoqaR6psgehevlGDPfG9gFJkg6dqQsk4nd0Fm+zPJExFX6
         QbrXxWa08Os3KE0V6eIoyAXU7PzanR95PNpvXtD8Oz1Nvv3R3oTI2G898drqhtt7hRsP
         wbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678092893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLAhqnNFboMZ3Xspb0HEH0L2QkUdVCAZTGMLZDTo/AI=;
        b=Yi1/EErWK1cISjkwOhnOl+Ti3rm1Qbkvp7P7/oHB3bIyTkgy8gp/buKwgN6032fkQ2
         rfrEbBNWSxygnJj5Vj3oRZh38ReuEQf5AtK9qUez2ArNaDesyVpAQKA/vNZoMjPksc8U
         XKoC26hep66o1sT0IxW+mBrX+0wB1m8bQBOAtGibYgyRcp7KkQqOh+60+vswwc0Jzo6k
         xLNtPraZtEwXF8rzuN/9zqpQ1Io3oZW52eciexORg7jnDQhsUqcjmBdlnymlZLM4o4QM
         h+GcIqmPezDJEIsPgj6Q2JxgOIeonXgTGSnIW8BsB30XEcqlM9MhIrHOJsfG775duA1P
         RjKQ==
X-Gm-Message-State: AO0yUKVzLAXbgQWHu3m7Az9/rbtNuM/UQls9LTb6ePcT96x2NQdWcPzc
        9A6EMmdNHVynyFYZvu/GxgeZUA==
X-Google-Smtp-Source: AK7set/zYZbv8I8sb/J/hGNNCCXKArT9QRhK0vtY2AqjURZK5qxhyca6vR86eJgWBZt8MJTCfklSWg==
X-Received: by 2002:a17:906:32d9:b0:8aa:bf4e:7b2c with SMTP id k25-20020a17090632d900b008aabf4e7b2cmr10892941ejk.21.1678092893196;
        Mon, 06 Mar 2023 00:54:53 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id d5-20020a170906640500b008be0b7242d5sm4317499ejm.90.2023.03.06.00.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 00:54:52 -0800 (PST)
Message-ID: <67d51c44-7599-39d2-9616-573e07194550@linaro.org>
Date:   Mon, 6 Mar 2023 09:54:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] dt-bindings: display/msm: dsi-controller-main: Fix
 deprecated compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230304-topic-dsi_fixup-v3-0-b8565944d0e6@linaro.org>
 <20230304-topic-dsi_fixup-v3-1-b8565944d0e6@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230304-topic-dsi_fixup-v3-1-b8565944d0e6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2023 16:55, Konrad Dybcio wrote:
> The point of the previous cleanup was to disallow "qcom,mdss-dsi-ctrl"
> alone. This however didn't quite work out and the property became

s/property/compatible/

> undocumented instead of deprecated. Fix that.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

