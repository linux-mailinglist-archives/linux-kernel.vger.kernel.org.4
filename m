Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171D873C764
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 09:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjFXHjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 03:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjFXHjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 03:39:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E6BE7D
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 00:39:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51d885b0256so148171a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 00:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687592347; x=1690184347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVdAZfHRZ6u7osPMfY1qK+xI94SNWiX6MJMl3Svpx34=;
        b=AzlNBzAV19R9cgDJFcLQljjYVhJ/XvCe2JIZN1//+0MtkcJdBz7KpnpLco+q2jt33H
         6zjAgqYBLdCnP6loYtt3cP/qF6jVxOqReXdnP+LzWQQtYQR/7BOjnSRMWL5BkoRONk34
         i4ij3h6YDWhJIOpa1M0tPVY2zOu/iLE76cVfhuwN8+0TA4fMzDiOJIHv7ReRw8awdqrf
         Rz/SXJPISnwUr0t2IpOuX7XynFepgqMNrv5qvQ7B+z9fU9W6c2x/towRwkBN0iJfbdaL
         Luaxi9k30z9TnexneyQFansJlLTSGDzepPju7Flf51dPjiW07LKrkIZWW8+l5j7ym5Nk
         6Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687592347; x=1690184347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVdAZfHRZ6u7osPMfY1qK+xI94SNWiX6MJMl3Svpx34=;
        b=Yn3hERb8z+SPnqX6qXB/vsEJxsck0Kfh3MnosHcoOIK8zzVQMfnOeLXO0cnX2pYwq7
         18p63lw4gRNSdQrfK/SuT16gKivBgyq+b6Oh0I1fzoW/mamOV9XzCHrEelSqCNnD/0qy
         8HeigKCNZN5zJYLM0JsWeEgT7YN6rzPr+6smBj6gvCQwANKTTcuZsM/P4dVC9KDKhhrs
         ytdXcMW8mxD2x1oMjsDfglOaW2D3zLkZfGiAVGpjDb7U5FtDkgJY1f9NiMsvcQaIgAWC
         7AoszF1vqDOTy5/FkrfotJY6hcwBDeSdHf45xJOqH9lLxpvxVs3qD94F5YssyFEF6RL0
         VjfA==
X-Gm-Message-State: AC+VfDxjUSMRdrVtRWSuLOLlqyU1xNOmMyBHoTdauPmmSJWHTeQ/9fcl
        81knAksQcUHdKKM0uR+l1997Mg==
X-Google-Smtp-Source: ACHHUZ7tKT/4JTpFEGf6HPPRHWpY3Wpj7qBTPZ5d9erU7Y4QOGAHnB07BZ2jcM0YimyIpPzQjzaehQ==
X-Received: by 2002:a05:6402:1212:b0:51a:3e67:3514 with SMTP id c18-20020a056402121200b0051a3e673514mr18616484edw.24.1687592346828;
        Sat, 24 Jun 2023 00:39:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w15-20020a50fa8f000000b0051bfa07af4asm383979edr.93.2023.06.24.00.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 00:39:06 -0700 (PDT)
Message-ID: <a3ece9a5-7718-020d-66b1-be6885fb1da2@linaro.org>
Date:   Sat, 24 Jun 2023 09:39:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 09/15] arm64: dts: qcom: sc7280-crd: add dummy Bluetooth
 VDDIO supply
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
 <20230617171541.286957-9-krzysztof.kozlowski@linaro.org>
 <29f6fb78-c122-2b71-61b8-2dc9aa27ad1d@linaro.org>
 <CAD=FV=UMqrAU9cLy3Ew5o1MJyNDAAG2TY1mvMkY2-8kiw6qpjg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=UMqrAU9cLy3Ew5o1MJyNDAAG2TY1mvMkY2-8kiw6qpjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 20:34, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jun 19, 2023 at 6:14 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 17.06.2023 19:15, Krzysztof Kozlowski wrote:
>>> Bluetooth requires VDDIO supply.  Due to lack of schematics provide
>>> something dummy to satisfy `dtbs_check`:
>>>
>>>   sc7280-crd-r3.dtb: bluetooth: 'vddio-supply' is a required property
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>> For this:
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> +CC Doug to perhaps fix this properly (though I think we should have got
>> it through the cros list anyway)
>>
>> Konrad
>>>  arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
>>> index afae7f46b050..b1aa5b0ee95c 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
>>> @@ -24,6 +24,13 @@ aliases {
>>>       chosen {
>>>               stdout-path = "serial0:115200n8";
>>>       };
>>> +
>>> +     bt_vddio: regulator-bt-vddio {
>>> +             compatible = "regulator-fixed";
>>> +             regulator-name = "bt-vddio";
>>> +             regulator-min-microvolt = <1800000>;
>>> +             regulator-max-microvolt = <1800000>;
>>> +     };
>>>  };
>>>
>>>  &apps_rsc {
>>> @@ -38,6 +45,10 @@ vreg_s1k_1p0: smps1 {
>>>       };
>>>  };
>>>
>>> +&bluetooth {
>>> +     vddio-supply = <&bt_vddio>;
>>> +};
>>> +
> 
> I would have a hard time believing that the more correct fix wouldn't be:
> 
> vddio-supply = <&vreg_l18b_1p8>;
> 
> Specifically L18B is what we have on the newer CRD (the one that is
> considered a "herobrine" and includes Qcard) and also IDP2. In terms
> of timeline / similarities, CRD-rev3 falls in between IDP2 and newer
> CRD. These both agree on L18B. The only board that uses something
> different (L19B) is the very old IDP1.
> 
> That being said, Qualcomm has never provided (at least to me)
> schematics for any given reference board. Whenever asked, I was always
> pointed at schematics that were said to be "close enough". Thus, I
> can't really give a definitive answer here. Even so, pointing at L18B
> seems to me to be 99% likely to be correct.

99% is good enough for me. Thanks, I will send a v2 after the merge window.

Best regards,
Krzysztof

