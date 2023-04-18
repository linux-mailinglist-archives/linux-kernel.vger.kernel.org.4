Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C376D6E65E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjDRNap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDRNan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:30:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FAD1444D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:30:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id q23so63731908ejz.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681824641; x=1684416641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rffFnl7mfjezGYLAktfVaaITh/gwflzEth7uD6ZC/cM=;
        b=I5eEix0qVq0SZl6LePburT2lrcPY9omUYZ8PmE++6NBF67yQ0ze2mpF6wb4Cmgw/pD
         xWQ3ro43dl+zw8hza5uydu/o8vSq++PgPVK98u3A0Wnl5bqZmGyd310bZwWkP0l2sMw5
         z6Yy1SBbFdx7bDyMWYsKVEcaqhj7vQmOjGkGgaANM1pku79ENItxKjp7376/TOeeCGdF
         pjZ85FFvXds7Wx7buAgos6OwLt6OqkOaNvxGaxOlSTWzKPGJ9IlrJeLI5KhaeGhuvLv/
         RpTP/paZReyjbfUlSPraITZm06nQ6fAs77PjQ/DVe1oP8hWzpW+5hmyncPufTmVZFH0Z
         h6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681824641; x=1684416641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rffFnl7mfjezGYLAktfVaaITh/gwflzEth7uD6ZC/cM=;
        b=inNmFj2cuPzhlN92vzZnS11vOOtZo2Jv2JFuCqGL4Oa8kOgudV4WmJfQB20Jbml0aM
         R6v6jdC7X7LNiJ5knLS06nnGz8rqeCOmc8xp0VMQsIbw/440IlegYyGLujI/oNdrPzyG
         Z5mJLksF6ueL8JQ1xC3wXaD88qL8/cByoiIInq7eIr+T7kedpLI71K8BiYWgbDgUjR0g
         lPpi4PJ3uroyF1YCiiL/kwo4oC5C1g6ezk6SHSahkARg+WrcmMk3aI6L7iCS8VaJKziv
         5x11mXXGqlJ1m/4z9cWw12IZonl6JUlEl40E4MM7tdTGjo6u//7OxGpwr+BUpGuAZIqI
         wX9g==
X-Gm-Message-State: AAQBX9dtImXbMDBPXMVNQHY00eBlvPJ/ZR0dVNtBdfRbTiCO4BQLRBzB
        /XLMqfyPZSJN87FwQ3HYmAkNvQ==
X-Google-Smtp-Source: AKy350ZW4dBad0JSllW5uCiWq3kVnCQW9P3yk9AHbLDu7uN4k47WQuQO54FdCJYumwP+hDNYtSM5ew==
X-Received: by 2002:a17:906:b802:b0:94e:61d3:d13b with SMTP id dv2-20020a170906b80200b0094e61d3d13bmr10632661ejb.75.1681824640821;
        Tue, 18 Apr 2023 06:30:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id kt2-20020a170906aac200b0094f6458157csm3523268ejb.223.2023.04.18.06.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 06:30:40 -0700 (PDT)
Message-ID: <b781b14a-0bc0-3e3a-e803-a54f24cd58d3@linaro.org>
Date:   Tue, 18 Apr 2023 15:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/5] dt-bindings: display/msm: Add reg bus interconnect
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230417-topic-dpu_regbus-v2-0-91a66d04898e@linaro.org>
 <20230417-topic-dpu_regbus-v2-1-91a66d04898e@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230417-topic-dpu_regbus-v2-1-91a66d04898e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 14:10, Konrad Dybcio wrote:
> Apart from the already handled data bus (MAS_MDP_Pn<->DDR), there's
> another path that needs to be handled to ensure MDSS functions properly,
> namely the "reg bus", a.k.a the CPU-MDSS interconnect.
> 
> Gating that path may have a variety of effects.. from none to otherwise
> inexplicable DSI timeouts..
> 
> Describe it in bindings to allow for use in device trees.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

