Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E74C691D60
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjBJK5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjBJK5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:57:08 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DF55ACC6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:57:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so3773238wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gxFJW5wMWFSgwofHY83IGRmWRME/u231OOEuiB6E6rw=;
        b=aojESYChzWo8ja2Kpou77qQnRGwHD/xM1FLKoOgU2+BUcxjCuMdr/DOSA8Czp96JMv
         oOXOKEnkyR2GZR+rTnQ/Kfviro+4IzQsUjV+1MmrRHZtQmqZEUzWHad2LRH7+ChV75RZ
         uNgaqTMUEf7u2mZOEwK+t8/OpqmRjkb79BHAqwcG/XbqPmZIfm3bzRCn7Ka7mCar5N/k
         8Znz0mrYBjzQIPj3w+xm5jD0g/EbXotm8FyD/F7Qn2dQ9mNa1tGMcK9UDlALy7UKcTe0
         X0eCejYgMDP0HO5so1SnMVqUdb1VIa2PQLIOOLK4+ADT95E8jgMUH5Enzgu6i3W6AfjE
         +v1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxFJW5wMWFSgwofHY83IGRmWRME/u231OOEuiB6E6rw=;
        b=PxPFXS1twG45mLxsAK0Ccluf6ReC70BelLu8LfrnynwKmAThiS/Irh1RVqaaI1Q/55
         WK08wb9eV6sf/cc6w6oWNVMIsT3SADKbnkjNOnSv4fxpRdo2ypKGFT3hNS6X/nVddTFt
         OuOItlcHu9/DHdu/EbrKSGNWAT6vzCztHncDPyN50G9wkiBD9pdfd2AOuGixyw9/3MNq
         F2S6gfPhPJGr5KqSoeAIxybXWwChQLKJaW4ee+fWYUIMGs7mH5fpAKHe6Ox/STVwy3NJ
         QuDylwvHni9WoKMycGf1R1U5Is4QSnIj9F380KGpbU1Tw+D2Xo7Md2yqyCGjyPfDfPS3
         axgQ==
X-Gm-Message-State: AO0yUKWEMW7cau8mDHe8cBee/pH0J/RKhETgU2Vt0JKO/KxbQrk5887P
        CjHTwWsffamufYcDljBkP0Zasg==
X-Google-Smtp-Source: AK7set+prGY1H0ukKTktyiVy+Uhot76X1GyOTcxgbUK9hltwD8dL7jvL/W4wECXhkHKsN6qrlPghnQ==
X-Received: by 2002:a05:600c:993:b0:3e1:577:80f5 with SMTP id w19-20020a05600c099300b003e1057780f5mr10446539wmp.31.1676026625087;
        Fri, 10 Feb 2023 02:57:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w19-20020a05600c475300b003e11f280b8bsm1961050wmo.44.2023.02.10.02.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 02:57:04 -0800 (PST)
Message-ID: <039b8306-04a8-ead3-7a5f-3593c01496a5@linaro.org>
Date:   Fri, 10 Feb 2023 11:57:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/5] dt-bindings: display: msm: dp-controller: document
 SM8450 compatible
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230206-topic-sm8450-upstream-dp-controller-v2-0-529da2203659@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v2-1-529da2203659@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v2-1-529da2203659@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 11:34, Neil Armstrong wrote:
> The SM8450 & SM350 shares the same DT TX IP version, use the
> SM8350 compatible as fallback for SM8450.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

