Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5B773C9D8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjFXJIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjFXJIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:08:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D0110FC
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:08:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98934f000a5so165905866b.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687597714; x=1690189714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6JzkVRa8sMgqt4wOZNLb6V0TofrH1Kd7ev3kFxK2xc=;
        b=Rh8pbD9W2/mmo4vpLwjYYWuICUk4g/xZiRykDWLdyyaNcYKkKFf6TC+hX59iPXhc7M
         m5Mx927JbOZZSiDpI0jqZut6z0twtjvDu7+/APy5ALdjHKtkEAIoCzGHIdh/guaCxSMC
         oPyZzW50fzbPIvzCUsmNlennD/6einpbBEDAudDYS6TPzm64u0db39jTTys5sUcDD/mL
         TMGtGLgXaWbg3nboMjSS3FlLmT+dOSZrJUQvoW9EBQ4gC9m84otAZv1cC9I3IsPux4xg
         Df8l8aR7Xz/s+tGAQMybg4+gRuO04k+gHoMl4TRnFb3c/JGOIJkgQSTQtfEuQo5+Z0bZ
         xLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687597714; x=1690189714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6JzkVRa8sMgqt4wOZNLb6V0TofrH1Kd7ev3kFxK2xc=;
        b=bS5a/nv6e+kKZFHDKxnxF6lKlcBrkDxaxip/FDHPvrVWPPhJQbOnhjFxbpW5g5ELNn
         CEk/hP7ucLZiPHG1pF7I1Jgax1VEL9B6jTxa8tOu8v8FKzJowSzUFEnAxYy1ej2TOKzI
         NVWRi4Xvmqq36wCUeMFLihJhVhyu0Za1iNNvq+h3n5j3Ot7MjIxsDttEwZiwqbe/avfN
         8t1tCdChuxlBdMQdb552g+bhJwojDZugaR5ZzXzHLljs11skyz8aS389Q2rrjx6lIgPX
         KuUUlUaXJvUf7C4M0itf0s5Vu8LH36QoH0/9yM23ivQK21Q0ffJ82KThwtULSJgOMC1/
         p4xA==
X-Gm-Message-State: AC+VfDxmYvKxC+PU46n2RPmPI5rtj/XUDXNeALrxF9VS5eTGRKerM9f2
        rxMqodXfNCE5A5RQsqqXGPv6ug==
X-Google-Smtp-Source: ACHHUZ6WDJEt8kVafAtj06USOxNi1vO5kwV8GgXL8AtGVdivZUyr0N1GgeF04ko574WKyptwyPK0cA==
X-Received: by 2002:a17:907:a408:b0:98d:3ae:b683 with SMTP id sg8-20020a170907a40800b0098d03aeb683mr6395204ejc.19.1687597713874;
        Sat, 24 Jun 2023 02:08:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id gv18-20020a170906f11200b0098e0a937a6asm108250ejb.69.2023.06.24.02.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 02:08:33 -0700 (PDT)
Message-ID: <1d782241-f0ef-848b-9b42-a8a6234bbfae@linaro.org>
Date:   Sat, 24 Jun 2023 11:08:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 02/15] dt-bindings: clock: qcom,dispcc-sm6125: Remove
 unused GCC_DISP_AHB_CLK
Content-Language: en-US
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
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
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-2-1d5a638cebf2@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230624-sm6125-dpu-v1-2-1d5a638cebf2@somainline.org>
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

On 24/06/2023 02:41, Marijn Suijten wrote:
> The downsteam driver for dispcc only ever gets and puts this clock
> without ever using it in the clocktree; this unnecessary workaround was
> never ported to mainline, hence the driver doesn't consume this clock
> and shouldn't be required by the bindings.
> 
> Fixes: 8397c9c0c26b ("dt-bindings: clock: add QCOM SM6125 display clock bindings")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---

In perfect would we would like to know whether hardware needs this clock
enabled/controlled, not whether some driver needs it. I understand
though that with lack of proper docs we rely on drivers, so:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

