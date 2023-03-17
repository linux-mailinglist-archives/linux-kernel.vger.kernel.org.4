Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD346BE4DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCQJGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjCQJFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:05:48 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013B33B852
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:04:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id ip21-20020a05600ca69500b003ed56690948so2582935wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679043872;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MsOeH5VTIJLvj266rkHX55Fde/Bb5Keky5mnCISQsH4=;
        b=sd0h8SxnEaPFkX2Ud7MfNZvoReK4uV/7qxpxBxk3xZNM+tmtsKaPyezXdyFkieGIJc
         0dAQmQwRAPKZhYDo8xIZRl6VVMR92PTktVWVR8Q0z+vDXYswjUSsVY7wlUIFkthM+20l
         UDj9+aGUleTQW9Ey5UxTr4So32e0lHEiq9mLQI408omO7fB5G9ivC5Qd1oOp4TH7Zs+5
         IhAy8bnnVlm7+b12UimMblITYQesVU1arR7gYrybPcxAmy1t/iBfxpnRdVz7YWFmUplW
         qnEwesi7jE7q/FsQ9bFv2NC7ty5F/KXLGYCECuc9O2FLPeUD2lLEmJwVPKYVEKmWw7U6
         xWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043872;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsOeH5VTIJLvj266rkHX55Fde/Bb5Keky5mnCISQsH4=;
        b=0hByiQcX8V5kxX9Ghkqg0qBEdMcTzfsQ1IqXinY+NFhaR4By6VIpUwR3M5YlKoaVdT
         Rdz+D3CadWShFAYKjmAVnIZH/d6MDdQtCdvUoO5CB0HTxkboQ5P3a013B+npKUHN6E0+
         U3wppU+153uRYyg7ppD/niCdg6RK6moHAqgktLv/DXDMdyma7W2lFeZBMfQLV81WR8mo
         NIOOT2lw5pPas2dAs0/ExeGqpQomM6yJO6de3Yizg925fjAMDp/U3IHEP2wwYWjm0cKt
         ZhIN46QU/PD+0hSfHSFFfynO8VlVW+z1hWoJwWgowdhk+VvAjEtqdqoBVGiCeVk8uZUB
         wW0w==
X-Gm-Message-State: AO0yUKVc7OEi6CeBcS0zzXtslVUUvHk+7unMb0Mjas1CAZRJfIQWqurS
        B0sALrw5JEfkomUcohALAibXaA==
X-Google-Smtp-Source: AK7set+OoHD95yvZIthSsT6vMUzbdSIlC1qogPX4UgrFrwcsvTC1CiCc4Q7krtb17ucGOJ/QoYalvw==
X-Received: by 2002:a05:600c:154d:b0:3ed:23d5:4c4c with SMTP id f13-20020a05600c154d00b003ed23d54c4cmr19408344wmg.12.1679043871668;
        Fri, 17 Mar 2023 02:04:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:9ed5:bad0:e925:7938? ([2a01:e0a:982:cbb0:9ed5:bad0:e925:7938])
        by smtp.gmail.com with ESMTPSA id h9-20020a1ccc09000000b003db01178b62sm7154127wmb.40.2023.03.17.02.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:04:31 -0700 (PDT)
Message-ID: <f9606b1b-2981-4874-4763-ef3ce96cc6f2@linaro.org>
Date:   Fri, 17 Mar 2023 10:04:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 3/5] arm64: dts: qcom: sm8350: add dp controller
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230206-topic-sm8450-upstream-dp-controller-v4-0-dca33f531e0d@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v4-3-dca33f531e0d@linaro.org>
 <68a26435-4f00-1571-88ef-1f3c0a254cef@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <68a26435-4f00-1571-88ef-1f3c0a254cef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 23:10, Konrad Dybcio wrote:
> 
> 
> On 9.03.2023 10:19, Neil Armstrong wrote:
>> Add the Display Port controller subnode to the MDSS node.
>>
>> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #SM8350-HDK
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> [...]
>> +				dp_opp_table: opp-table {
>> +					compatible = "operating-points-v2";
>> +
>> +					opp-160000000 {
>> +						opp-hz = /bits/ 64 <160000000>;
>> +						required-opps = <&rpmhpd_opp_low_svs>;
>> +					};
> Downstream doesn't seem to use this lowest freq

Now I know to look at, indeed, will remove.

Thanks,
Neil

> 
> Konrad
>> +
>> +					opp-270000000 {
>> +						opp-hz = /bits/ 64 <270000000>;
>> +						required-opps = <&rpmhpd_opp_svs>;
>> +					};
>> +
>> +					opp-540000000 {
>> +						opp-hz = /bits/ 64 <540000000>;
>> +						required-opps = <&rpmhpd_opp_svs_l1>;
>> +					};
>> +
>> +					opp-810000000 {
>> +						opp-hz = /bits/ 64 <810000000>;
>> +						required-opps = <&rpmhpd_opp_nom>;
>> +					};
>>   				};
>>   			};
>>   
>>

