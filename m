Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8179A72E14F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbjFMLVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240821AbjFMLVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:21:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A137098
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:21:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f642a24568so6584328e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686655260; x=1689247260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJexvCUYaVmjQj1NIVnYpyS9P6fcRoHfQo7408YP75I=;
        b=cpBLc9LMzv8sqmwV7f8UA+wHe9C/gVsv+v5KCfGXCI2E9sbv+7QuBgOeYHzCEnXiVp
         AMTcfBvxnUfnaGbVd+Ne8HppMXbmNl0vKQQtuZdw0E0Mm9SsgrAdix39usLPr2nW5mV4
         WjwNvAPxCK68KQijNbR7uiMoFk5WEl5ZB+zdpxPrHCuRVfyApDz6XTpiYrZ32ZkJCY5d
         fQI3NU6SGFQtZB5geNFrYmIVBc8g2joCOecrIpCULUSIblTacgeauiLjHctupdq7qSTP
         mZJJqCDxJwjOvf9YCOIpdCvcRZe75NfqoA1wXVwoYQcP0utcmLIUuBWrp98krWbrN/jx
         P2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686655260; x=1689247260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJexvCUYaVmjQj1NIVnYpyS9P6fcRoHfQo7408YP75I=;
        b=LVLuAvq8wPfpEJtPak2w4dukE8fLrvgla6T3A6HmsuVszIyB5WvWRDHIBsgggRKpu3
         7Kt+fwUlDrh5FG5fG+vRm9XNw3EzKRRVotQzwTuwtMpumU+AVu8JVRUUzFw1xB9gFN1E
         bxOAyjzDxCSX1cimz++0fugVHkEBvEeIBVmCpW7KAyDcg2y1wQt+FTeyNsrXyW5l50KN
         iqBEl63hLvtUUPP5LNUPij8tlu/7H89hnEd77YOH+nFGg87jOkROtcClJVoPGMbV/pza
         p4u0JSuUpSl9NrqROo2732trLkR0ehvQB6Ik1w8Hs093f20WBdv5PolzcfKPdim8XGTd
         S0JA==
X-Gm-Message-State: AC+VfDxD/uqAtU5WxURKBV2iiDUcrl7aQlsXGvYtGOdFIAa9I00EIl1D
        lXWg/MIB6yWGDQHVmo1HGz7zM8jJg2btZyocO/Q=
X-Google-Smtp-Source: ACHHUZ4Un3Kd8jYCXhk2BJfqRhFBDEwVeoA47+e7X2GVgEKjVn+3QHyO17A5QxxVIZ/nmWXXwWk6zw==
X-Received: by 2002:a2e:890d:0:b0:2a8:b579:225b with SMTP id d13-20020a2e890d000000b002a8b579225bmr4029208lji.40.1686655259830;
        Tue, 13 Jun 2023 04:20:59 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id y22-20020a2e3216000000b002a8e8c776e9sm2121628ljy.56.2023.06.13.04.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 04:20:59 -0700 (PDT)
Message-ID: <35c3fe5b-0c8f-4a2e-e3b3-f181edbdc956@linaro.org>
Date:   Tue, 13 Jun 2023 13:20:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 01/23] dt-bindings: interconnect: Add Qcom RPM ICC
 bindings
Content-Language: en-US
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
 <20230526-topic-smd_icc-v3-1-5fb7d39b874f@linaro.org>
 <ZIhO2Tgh5q4heBi6@kernkonzept.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZIhO2Tgh5q4heBi6@kernkonzept.com>
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



On 13.06.2023 13:11, Stephan Gerhold wrote:
> On Mon, Jun 12, 2023 at 08:24:18PM +0200, Konrad Dybcio wrote:
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
>> index 000000000000..ef61006c9c58
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
>> +#define RPM_ACTIVE_TAG		BIT(0)
>> +#define RPM_SLEEP_TAG		BIT(1)
> 
> BIT(n) doesn't work in dt-bindings (syntax error), can you change this
> to (1 << 0) / (1 << 1)?
Just including the binding did not show it.. You're right..

Konrad
> 
> Thanks!
> 
