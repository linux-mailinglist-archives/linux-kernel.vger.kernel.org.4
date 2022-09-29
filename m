Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E3B5EF52D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiI2MVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiI2MV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:21:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DCF148A38
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:21:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m4so1919491wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=mg0kwtjeUT8KxpYKVt8lhu9JqZpRw9XPpU8hODhNwaE=;
        b=zzmMStMj17pXCh1rT/efTlhj3hrMWne9LQziG13HD+hX3j1nCHa9p8okHX+TKaBlZe
         +5hsNo8C2+LVz0MCkrq98TmP0w3peHYPLm+Zqi/RQXpq/Vj6QC+EIjtZTt3Ief9VeCOT
         uF4ALa5hqIuR9G2vEUbk4Emjl2bLBU3KNPP2+8qoraDFREXvvjm7qBlDC9Ot1oa0Q8Ey
         77Mou7Mgqg7YJm26mCh3XFoMaWDvRkDt9Sf7tuyFnWT9CLAvZl41PQCdX+iMVLcpkB77
         i8S9531ivxUTqAlbkRP6WfTN0piOdW1AIQ39/IHS6jZ2OuSxHPZBONs3Zq905IpmQG0A
         GBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=mg0kwtjeUT8KxpYKVt8lhu9JqZpRw9XPpU8hODhNwaE=;
        b=DxPYHsdJyhdqBIjc67VLzfOUyxXIKAlzpws2e5bQGFnnwl4XN1Dsv15MrO25v5VP+6
         hm0CpMp56e9mZDG4aSLL63N3kEdImHGa/fj/X+vpDR70gbhgfI7lFJj0NQy5OcQ0vXmF
         UAqqBDVo/77VBrnKWNOkftRiTm/eB28rJzheuYG0/v7fWjLBH7+tj+g3D2H0RGowosDR
         apYNjldwvTTKgmG11MBEFGlzEpesnz6Fq9ZK/LyO0Q9Cmd2IIr4KHuchx27jj1Og8sgz
         6sJd2dZlysOBoztRqW5A0r08KSq5ZD+D/18WFy7rHl0+B1Fz9WT5p/EEk8JdhTU+ZCoo
         fPkg==
X-Gm-Message-State: ACrzQf1vQ+qJMfJu5SWcSdtcGUrdWNY03mGQL8dzQzK2+xNNlH3b22Vo
        /lhEPDZlAqB7hFedpeCJPPv9IA==
X-Google-Smtp-Source: AMsMyM5UB/UB5Lben08ovN7AwC4mRwW8LIbZqwfAk3q/0DtJxl1KfhGnkZB2fpFxCfX+0Bw+3UPI2A==
X-Received: by 2002:a05:6000:178e:b0:22b:451:9f63 with SMTP id e14-20020a056000178e00b0022b04519f63mr1968489wrg.521.1664454084257;
        Thu, 29 Sep 2022 05:21:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff? ([2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff])
        by smtp.gmail.com with ESMTPSA id 189-20020a1c19c6000000b003b5054c6f87sm4201017wmz.21.2022.09.29.05.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 05:21:23 -0700 (PDT)
Message-ID: <9067ca94-cd5d-6883-d0e0-374ed7f599ad@linaro.org>
Date:   Thu, 29 Sep 2022 14:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 5/7] arm: dts: qcom: mdm9615: remove invalid pmic
 subnodes compatibles
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v1-5-b6e63a7df1e8@linaro.org>
 <0636d53f-508f-8a86-0973-2641c9020622@linaro.org>
 <6ed642ea-424d-49ed-eb30-e09588720373@linaro.org>
 <1a3c6766-9be5-1e55-95eb-bc9656e5c9a3@linaro.org>
 <7f8572ab-ff97-54bd-a5f3-fe0e179ee48e@linaro.org>
 <84cb8941-eb15-1bbf-59b7-bbcd6c15c30d@linaro.org>
 <07405d0d-8534-6470-21d1-26b85dbd7de0@linaro.org>
 <f54377f0-a152-9367-1b06-f49df7466282@linaro.org>
 <3fa19362-118b-232e-0baf-ee365fa2f2e2@linaro.org>
 <07c75827-b8e5-7c70-315b-48617b9818e0@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <07c75827-b8e5-7c70-315b-48617b9818e0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 14:02, Krzysztof Kozlowski wrote:
> On 29/09/2022 13:59, Neil Armstrong wrote:
>>> That's not really an answer... Bindings are correct because they are
>>> correct? What is exactly correct in the bindings? How they reflect the
>>> HW in a proper way, while DTS does not?
>>>
>>> Or let's focus on actual hardware - what are the properties of the
>>> hardware which indicate that DTS is wrong?
>>
>> The actual PMIC is an PM8018
> 
> And DTS is saying PMIC is PM8018, isn't it? I see clearly in DTS:
> qcom,pm8018
> qcom,pm8018-rtc
> qcom,pm8018-pwrkey
> qcom,pm8018-gpio

And this is why I pushed the removal of qcom,pm8921* fallback compatibles,
except for qcom,pm8018-pwrkey because I didn't managed to get it documented at the time.

> 
> Best regards,
> Krzysztof
> 

