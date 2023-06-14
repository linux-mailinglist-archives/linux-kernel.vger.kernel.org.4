Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856E5730567
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbjFNQs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbjFNQsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:48:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894792137
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:48:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f62b552751so8996277e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686761298; x=1689353298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NjxCr0Eyh5XbtZr9j4fPMosNiG88CLowvSkvH9o00qg=;
        b=dUQrEGguhCOeiIreuYJckzj9xEbYgKzR9O7bg7RaQiFUr1CtuR3rCQGKo6uIAEdSza
         fmA68LBIw3hiGK2Zbv3M2hAIqtnhquH9BMBSEAvIhpxG/Sb5boKP+IgIlhRv7yI8jc2q
         tDH2NULoUW/ZrXHZqIOwNiTX3NivoyMoSHFQ8juQuQuhGqoabWt3FGP2JTMGpqj9Uw14
         h+xHLCZ72QUhJnmzHxfxXVA+tXYijosWSwZf5dZe2W9hmqmZBb7oApWBs3VYsftpLyMy
         tTervyWNSTQ/s8E2R2+DHqNSV9ILxU8EY/toBbxeBMOMK2FDSLNmvCBfBskvipbofMbz
         RRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686761298; x=1689353298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NjxCr0Eyh5XbtZr9j4fPMosNiG88CLowvSkvH9o00qg=;
        b=KSDbdZ3naW8WrerGW16+gWe6elk7ZvZTKj3Ej5ykLuQmtSUJxLI41WQ2elyrLZ0m4J
         IB4vf5aJF/kpp9Fjy86QPMYmv1hFa6rzBG79Va/ansF9ZiZhcc/cBJyc+Y9e6nM98mu6
         SC3L1U8iV7uBTupOZ1jw0NEDmzfgEGozRzrll8TjMPREAMTEnlGVN9AR2JhI5uluDBFA
         z0IrdyTAUuHF8uutfBWVV8++LkMGygIdAch/+OGcVIGA/bz92x6935awP4bo4doBkMoz
         Nn3lbxpkk6wye5Fx0U+Wl5qQglD1uDSlm8qpHFYnGafLh6w43Ls8ek5WExSugjAjN0b5
         hL6g==
X-Gm-Message-State: AC+VfDyle/yyEa4kVTVwCZc27Xdoi92u86VI8iQEgKkIM/m6AUGX/+Tc
        tOVpnQ00TF3Gu8zCC69OCgf9YA==
X-Google-Smtp-Source: ACHHUZ6vRWUxacyXAGtcmWUgz5ZEqNlOF23a3xrKApRe3wLOIxFWW0iDZdKnR17e48t+x/c+7FJClg==
X-Received: by 2002:a05:6512:1c6:b0:4f7:672a:453 with SMTP id f6-20020a05651201c600b004f7672a0453mr1514602lfp.17.1686761297596;
        Wed, 14 Jun 2023 09:48:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id w8-20020a05651204c800b004f640b0fb04sm2196761lfq.212.2023.06.14.09.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 09:48:17 -0700 (PDT)
Message-ID: <c1c84eef-ee43-fcb9-de93-ba609b842d87@linaro.org>
Date:   Wed, 14 Jun 2023 18:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 01/22] dt-bindings: interconnect: Add Qcom RPM ICC
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
 <20230526-topic-smd_icc-v5-1-eeaa09d0082e@linaro.org>
 <c8573d08-d4e2-41a8-f0b1-e1d7a0c9ce17@linaro.org>
 <e7a083f6-e885-113b-bb6c-d20108777c5e@linaro.org>
 <47cfe777-45b9-6303-1374-bc96803d26d4@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <47cfe777-45b9-6303-1374-bc96803d26d4@linaro.org>
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

On 14.06.2023 18:47, Krzysztof Kozlowski wrote:
> On 14/06/2023 18:43, Konrad Dybcio wrote:
>> On 14.06.2023 18:43, Krzysztof Kozlowski wrote:
>>> On 14/06/2023 12:22, Konrad Dybcio wrote:
>>>> The SMD RPM interconnect driver requires different icc tags to the
>>>> RPMh driver. Add bindings to reflect that.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>  include/dt-bindings/interconnect/qcom,rpm-icc.h | 13 +++++++++++++
>>>>  1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/include/dt-bindings/interconnect/qcom,rpm-icc.h b/include/dt-bindings/interconnect/qcom,rpm-icc.h
>>>> new file mode 100644
>>>> index 000000000000..2cd56f91e5c5
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/interconnect/qcom,rpm-icc.h
>>>> @@ -0,0 +1,13 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>> +/*
>>>> + * Copyright (c) 2023, Linaro Limited
>>>> + */
>>>> +
>>>> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_RPM_ICC_H
>>>> +#define __DT_BINDINGS_INTERCONNECT_QCOM_RPM_ICC_H
>>>> +
>>>> +#define RPM_ACTIVE_TAG		(1 << 0)
>>>> +#define RPM_SLEEP_TAG		(1 << 1)
>>>> +#define RPM_ALWAYS_TAG		(RPM_ACTIVE_TAG | RPM_SLEEP_TAG)
>>>
>>> Where are these used? I don't see any DTS in your patchset. Did you send
>>> it separately?
>> In the driver for now, e.g. patch 19. DTS can only come after the
>> driver is fixed or things will explode!
> 
> You reference it in patch 19, but I still do not see the constants being
> used.

Fragment of P19:

 	if (!tag)
-		tag = QCOM_ICC_TAG_ALWAYS;
+		tag = RPM_ALWAYS_TAG;
 

Konrad
> 
> Best regards,
> Krzysztof
> 
