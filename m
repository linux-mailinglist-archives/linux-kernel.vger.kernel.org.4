Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562DA7069CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjEQN0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjEQNZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:25:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690486A5B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:25:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f00d41df22so10464372e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684329955; x=1686921955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hp2kPkd9ZRMUETaRmMSuFYktMxLqAJpnJYXLcv1M178=;
        b=DOZPjNgiUJXEqkKXk4r1H9T/X1RO3QycJmsfSKRJDT0ywuMtmEThWzay9RJd/02bXz
         K9crsDQ4XBjHukL47XolUY4KUzlkAYHS7y6rZWxTl3Q6+L1VtVfqc1mv3ALiq+MsnK17
         9UrwxgcpNEjYK9g8xDGE3hkJMcO2LzhZYl6pzGg7zQMUxvQ9EiUnou/9DP7328Y7e/JY
         P8CGC/9waKK5Tl0OAWTOFpP5R6/h+gX50ThUEW5a6KRi29F0BIO6gXTLZqShxKiZS0BD
         0REdjaGjkZr5U5zcNockugIowaJhAos0A22cgSGjAadjb7jVzF5u2GvaMX8ndcrNzSmQ
         DhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684329955; x=1686921955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hp2kPkd9ZRMUETaRmMSuFYktMxLqAJpnJYXLcv1M178=;
        b=HPoxwPPs5Jp753fZCjK03cgvexQI6VUrH6lCf9ZyDSViMLswkkG8XfabmtTR9VVkVG
         RH0vM2gSN4x/mVGswxRmIM4TeZJVyYGJsV4sv4xk0l6JL0NLtS9YeggzzHV8JJwV5JML
         tThpU0IWPMRCZJ+VdJsZUeEoS6VSzb8K5vY3KrzVix4W4T0I1ZU+kCLm4b28UDvPffrH
         5Zib0+QJDs9HaprqEp2LpRmI3RIX90OaiJIEAvf8cWwiLHF5n5Mygs3DF1Xc9eA2KYQZ
         nOnUTbYTV1+xnETuj8pG7dcZaMgH20m++ln91BH0B2B9AYTndbLSbLd/uKdVjbs8sckX
         dDyQ==
X-Gm-Message-State: AC+VfDw33VfpXPEuptDNEvR5/PVsL3cf9ZQ6R1GMDYfSwxL9U9XStvy0
        E6eYHsW14pQdZx5IpuK+jOVN6w==
X-Google-Smtp-Source: ACHHUZ66A49Q8pGQ0boPoaDUf9DyQZ5nKb/JogEyVnTLZ5Rb2ZpAmgkYB3QVLfG1JUif5LnjOcdTPw==
X-Received: by 2002:a2e:b623:0:b0:2ac:7fc5:e4a9 with SMTP id s3-20020a2eb623000000b002ac7fc5e4a9mr697973ljn.16.1684329955606;
        Wed, 17 May 2023 06:25:55 -0700 (PDT)
Received: from ?IPV6:2a00:f41:c93:874f:be7b:fb6c:26f9:307c? ([2a00:f41:c93:874f:be7b:fb6c:26f9:307c])
        by smtp.gmail.com with ESMTPSA id n14-20020a2e904e000000b002a8ac166e55sm4594646ljg.44.2023.05.17.06.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 06:25:55 -0700 (PDT)
Message-ID: <d6bc4b56-3a0c-44f4-2e21-ff07c69100a6@linaro.org>
Date:   Wed, 17 May 2023 15:25:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8550: Add missing RPMhPD OPP
 levels
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230517-topic-kailua-rpmhpd-v1-0-cd3013d051a6@linaro.org>
 <20230517-topic-kailua-rpmhpd-v1-3-cd3013d051a6@linaro.org>
 <CAA8EJppaZSXeRP661g65WtadZAuJo1T8=Yk8AfX6n4Jg04BvZA@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJppaZSXeRP661g65WtadZAuJo1T8=Yk8AfX6n4Jg04BvZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.05.2023 15:25, Dmitry Baryshkov wrote:
> On Wed, 17 May 2023 at 16:20, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> We need more granularity for things like the GPU. Add the missing levels.
>>
>> This unfortunately requires some re-indexing, resulting in an ugly diff.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 36 ++++++++++++++++++++++++++++--------
>>  1 file changed, 28 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> index 6e9bad8f6f33..0c987dd4e4e5 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> @@ -3616,35 +3616,55 @@ rpmhpd_opp_min_svs: opp2 {
>>                                                 opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
>>                                         };
>>
>> -                                       rpmhpd_opp_low_svs: opp3 {
>> +                                       rpmhpd_opp_lov_svs_d2: opp3 {
>> +                                               opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
>> +                                       };
>>
> 
> Maybe we should stop using the indices for OPP entries and switch to
> encoding levels instead?
I think we should just retire this and register a hardcoded OPP table
in the .c driver.

Konrad
> 
