Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A53F64F943
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 15:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLQOWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 09:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLQOWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 09:22:36 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C61E14D08
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 06:22:34 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id q6so7591612lfm.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 06:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZ5cHVqgvVJe/N0LNOPokBoYzo9K73QgpXdouMkj7zk=;
        b=VjvnmjLIx2zkaHhRBd1ERHGtVh0W/mMVfljst0WgMOtK2nRySeW2dA7k9bSBlCKYSL
         llQXDhxKpXYdkQc/mMzKeDeti4aUjqT+54Uo62G35tUuYe55/cLg48CEKjcPXa1/AZUr
         5GE9RwY/LyP+N2Vd9OZrbCLNGBRENX4yp3Dq5Lm39ugo9ALVXdwY06ozWrwfQuiMSizu
         UhVpvObscCcDWV4aM4X66MH8lT0iPgqRH3MwNDk+x7ulPZ8Rr6EZFfAt0dog7LKBsZug
         asbGSxCa8y1hYlDXC2sa3geARZWB+oOBPyHEM5D/ylpOvRAj/YPJnF6/iE8MMpo2Uj8k
         9cZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ5cHVqgvVJe/N0LNOPokBoYzo9K73QgpXdouMkj7zk=;
        b=WiKjhGl1rRNPGI5Eprq8h5xOn5JP3T/wwLz1RZbtp51+c/zBWCKJmxClHdjOyLlihn
         uoyvthtqL9Na1fjEQh1x8dlJto/VIPIkGwmHvrFCrXtKyBRzLW1BUAGExfgSUqCsGZny
         qho/KfVqEoD9uNYEdl7UJKl3LuZ01kOiTQYRFXOC6BGKvVUX9g87nX/sGPhWwfiWnATR
         7Ph2HNyKAIH68jUuFedBgts7CbSrzPENVYuVZdVvOcwmZsmxnAKpk3/818aFVeonztyN
         6dXgA6jGmRfBKW2HUATTjqVB45QZy7eqSQEc2MZtvs94zb1kZk+3DSLnWlzi1R6LVvd8
         2Q2w==
X-Gm-Message-State: ANoB5pleI5ActaEEL4h+Rgokc54927YU0yz5NFCTA6lQAKiEhnUJzwY2
        aCPi0ZBaj6OhLt9SOZm7v9eCuQ==
X-Google-Smtp-Source: AA0mqf4fD7u4aK9UvUQ6QAv1TPkAid7ix72nzfFyxbd9Mh63m2B4TewkspgqAxkOTuZo1hosYeQIxg==
X-Received: by 2002:a05:6512:308a:b0:4b6:f51e:b8b6 with SMTP id z10-20020a056512308a00b004b6f51eb8b6mr6952120lfd.56.1671286952812;
        Sat, 17 Dec 2022 06:22:32 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id a16-20020a19f810000000b004b54ca56cf9sm522157lff.303.2022.12.17.06.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 06:22:32 -0800 (PST)
Message-ID: <32bfd604-6fb6-51c6-5847-c87832ef1ebc@linaro.org>
Date:   Sat, 17 Dec 2022 15:22:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sa8295p-adp: use pm8450a dtsi
Content-Language: en-US
To:     Eric Chanudet <echanude@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>
References: <20221214210908.1788284-1-echanude@redhat.com>
 <20221214210908.1788284-2-echanude@redhat.com>
 <5ed623d6-3ca2-a1c4-9277-6768df5a63fe@linaro.org>
 <20221216195632.2wu5h4opfr46n7s4@echanude>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221216195632.2wu5h4opfr46n7s4@echanude>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.12.2022 20:56, Eric Chanudet wrote:
> On Thu, Dec 15, 2022 at 02:01:09PM +0100, Konrad Dybcio wrote:
>> On 14.12.2022 22:09, Eric Chanudet wrote:
>>> Include the dtsi to use a single pmic descriptions.
>>> Both sa8295p-adp and sa8540p-adp have the same spmi pmic apparently.
>>>
>>> Signed-off-by: Eric Chanudet <echanude@redhat.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 79 +-----------------------
>>>  1 file changed, 1 insertion(+), 78 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>>> index 84cb6f3eeb56..889259df3287 100644
>>> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>>> @@ -11,6 +11,7 @@
>>>  #include <dt-bindings/spmi/spmi.h>
>>>  
>>>  #include "sa8540p.dtsi"
>>> +#include "pm8450a.dtsi"
>> I feel like naming it  sa8540p-pmics.dtsi (like sc8280xp-pmics.dtsi)
>> would be more representative of what's really going on (unless it's
>> a single chip providing 4 virtual PMICs on different SIDs).
> 
> I can make a v3 renaming this. The initial commit from Parikshit
> mentions it is to be re-used on sa8540 based boards.
> 
> Side note: A quick look also shows pm8450.dtsi[1] is not included by
> any of its intended targets (sm8350 and sm8450 IIUC). Was this lost?
sm8450 only. They were not included, as SPMI was not enabled on sm8450.
They will be included in 6.3 once that's merged.

Konrad
> 
> Thanks,
> 
> [1] https://lore.kernel.org/r/20220226205035.1826360-8-dmitry.baryshkov@linaro.org
> 
