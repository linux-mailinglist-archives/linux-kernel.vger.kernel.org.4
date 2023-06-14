Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46270730550
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbjFNQoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjFNQoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:44:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAD010E9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:44:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f62b552751so8988178e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686761041; x=1689353041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LoRkuZWKxXpO3J/KC+IKFD8g8mKdOUzqHFsg3wN8y24=;
        b=OnQ4J+jdcEF8VPuCQDInjVYV4JwdlOb2uvVVI05qtvi/p0SU8D9rnDxfo3GRb2ZtGb
         LXruHGFdfkWmbo6TJCvIoso9MpI4WYFMboDAMCUI0jWwpSOUFoDIpzZYP5g+eSD4aegP
         DjIoOAHJy28Nd85oH5LylGUtrLxjdRPfYdcZfCfDaLZEE3zq/42Ome55seVJu3Q+6I6d
         givuBku+v16WAbkT7HcmejIgL1/etgKHVdWpI1H6LEuKEKIIJh0hNOhK6IF53bOWsE1e
         4II6o6MHxr8bjwIYBmA6+HvlEbMVmpN2jcCttVlxTpwHUNUs8Ab9Y7cAukYV3C42tBjg
         R5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686761041; x=1689353041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoRkuZWKxXpO3J/KC+IKFD8g8mKdOUzqHFsg3wN8y24=;
        b=leZkk321GLmOHd4S6FjKfmtD0r7yGL5NV3KK0D7nuKYSBbQD4VzW3lk4oHnjdlRmqE
         hZE23ULi9NBo9YOVCgsZvBI4hkJvRA02oOtwIN3e0RjhuZD2BAQb0YA5nGA2wrMmOp+P
         9wbGyhQ62yU9eH1Lqk+Sh6HzetHf2GbxSFUdF4cRZBHjXACzGdiv5ATbx3k4l7sBIr+i
         rGxJ0nRYLW32O9RQB30X7nlvtaQTHt0Mh3Rpea7HT8MlCdq7aFSU+ET2THpELrl6JomL
         piMBZdJXvYMzs3BJqB5VZH6zFYgW2KlNO0kswISMbwSrbk8lflN2gVf7tx2CHvQB+tbC
         sDXg==
X-Gm-Message-State: AC+VfDzj/noo2jcWtrug1wNmirE4g+c91LA27SnMm9vqgtBjURQoTecZ
        WakzHxOQB0DY0QntcNujWYpfRA==
X-Google-Smtp-Source: ACHHUZ703F8I5NcUh0f3StepCVewSGbe/tDeK2wzqjBWf/RxopRjyygwdOi2PuxGfI4iFdELFB9mHQ==
X-Received: by 2002:a19:6d1c:0:b0:4f3:82a8:dcfc with SMTP id i28-20020a196d1c000000b004f382a8dcfcmr7433304lfc.55.1686761041289;
        Wed, 14 Jun 2023 09:44:01 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm2180612lfn.147.2023.06.14.09.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 09:44:00 -0700 (PDT)
Message-ID: <e7a083f6-e885-113b-bb6c-d20108777c5e@linaro.org>
Date:   Wed, 14 Jun 2023 18:43:58 +0200
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <c8573d08-d4e2-41a8-f0b1-e1d7a0c9ce17@linaro.org>
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

On 14.06.2023 18:43, Krzysztof Kozlowski wrote:
> On 14/06/2023 12:22, Konrad Dybcio wrote:
>> The SMD RPM interconnect driver requires different icc tags to the
>> RPMh driver. Add bindings to reflect that.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  include/dt-bindings/interconnect/qcom,rpm-icc.h | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/include/dt-bindings/interconnect/qcom,rpm-icc.h b/include/dt-bindings/interconnect/qcom,rpm-icc.h
>> new file mode 100644
>> index 000000000000..2cd56f91e5c5
>> --- /dev/null
>> +++ b/include/dt-bindings/interconnect/qcom,rpm-icc.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Copyright (c) 2023, Linaro Limited
>> + */
>> +
>> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_RPM_ICC_H
>> +#define __DT_BINDINGS_INTERCONNECT_QCOM_RPM_ICC_H
>> +
>> +#define RPM_ACTIVE_TAG		(1 << 0)
>> +#define RPM_SLEEP_TAG		(1 << 1)
>> +#define RPM_ALWAYS_TAG		(RPM_ACTIVE_TAG | RPM_SLEEP_TAG)
> 
> Where are these used? I don't see any DTS in your patchset. Did you send
> it separately?
In the driver for now, e.g. patch 19. DTS can only come after the
driver is fixed or things will explode!

Konrad
> 
> Best regards,
> Krzysztof
> 
