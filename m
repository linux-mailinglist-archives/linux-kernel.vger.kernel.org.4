Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA769B475
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBQVOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjBQVOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:14:06 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8265E5BA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:14:02 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg35so13044wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EW4MkRsSt97nP2OjfvV/HrGYB4OX6Pt48nDkauxGyVI=;
        b=wRikKBLe7U1qL1RunGMOmQJZb52SbsdTuBi/QKYTXpD0L7ZK1id5boXGjsYdHFf8vf
         LJIvZGWBbdvPssG79W2NBPBD75X7A6RH3cNtPCVKPvFqCP9aLLd/PFXKwRykabDpdeon
         pe3DsWjPFB+lDLA6LFksZBcxs6+Swd+CyVvO0XFJuKhvATe5hgC9jVAQm3gntTZ+ORAD
         SdDTQC8/KwWbbb/fr8ZnSKCffiPh1iLNrmCxO054pkTVH1udo2qXQjw/PEEiPXm15HNI
         HHDrLgIPXsXTUxzCcODGO1YDtlYrmsI2h3zYCsjB9yOc0J5SPItWlTZKDK8ZERv1rHiA
         F/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EW4MkRsSt97nP2OjfvV/HrGYB4OX6Pt48nDkauxGyVI=;
        b=s0Oz4Y1KzcHLhXhlhqLgeELnT58oy6wRmuaLdBcrl9CHXHbuCra+cSE7647Oew5xNq
         /pLzdrOhk6/+CN/GtBFKnsTcWVxazRp/qcukJ6C+gYoYn90jd7m4kcUwWuLuiWCsePxS
         hj3wwjJ0ZQqeF6Fim4Djzw6MyFSlSwhne4oKIQ4bnN3j2PRHp7VptLOzH5FBVjWhF7EN
         bWou958bluu9AB3lJEJQiJUqQoV2n9TpdgajbWbc6ysZFBO0rJ4nU7p7hK+vwoJAve4l
         Ez7PAREPMV3/Km2+OzvwLw09GRUZeVSvOw5nmf8gtpCbtceW2hyPAttEgTfZ5Em3ETb6
         OYrQ==
X-Gm-Message-State: AO0yUKUup86tI2awqLWmL718zQBvIGu+9j9Gqdr6Hbq2Qu3mfxJp0Te8
        ittaNG0L7YrmtFWD7N/mtkIeRw==
X-Google-Smtp-Source: AK7set9bJWwf6VPImlBjocxK7OpKYe1M5pUpgHsEVTe3rlCdpxBRrmj8mEol2u8NhQQD66+cxhN0VA==
X-Received: by 2002:a05:600c:1895:b0:3e2:589:2512 with SMTP id x21-20020a05600c189500b003e205892512mr1723935wmp.21.1676668441188;
        Fri, 17 Feb 2023 13:14:01 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id ip24-20020a05600ca69800b003e223fe0a3asm2771609wmb.27.2023.02.17.13.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 13:14:00 -0800 (PST)
Message-ID: <d4ffa9f0-797e-7a32-147e-64aa46d7e197@linaro.org>
Date:   Fri, 17 Feb 2023 21:13:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: display/msm: dsi-controller-main: Fix
 deprecated QCM2290 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <48cb00cd-961c-b72f-fba8-1842d658e289@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 17/02/2023 12:24, Krzysztof Kozlowski wrote:
> First, it would be nice to know what was the intention of Bryan's commit?

Sorry I've been grazing this thread but, not responding.

- qcom,dsi-ctrl-6g-qcm2290

is non-compliant with qcom,socid-dsi-ctrl which is our desired naming 
convention, so that's what the deprecation is about i.e. moving this 
compat to "qcom,qcm2290-dsi-ctrl"

Actually I have the question why we are deciding to go with "sm6115" 
instead of "qcm2290" ?

The stamp on the package you receive from Thundercomm says "qcm2290" not 
"sm6115"

?

---
bod


