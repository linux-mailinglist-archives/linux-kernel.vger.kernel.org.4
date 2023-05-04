Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E536F6C7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjEDM5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjEDM5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:57:09 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22E2D7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:57:07 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f315712406so62666845e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 05:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683205026; x=1685797026;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JhEPtfZr+9cfDFkYEs5Deqb0QgVZN1XabpIEoEj4cvk=;
        b=hDS/6FJmG1vcXmIU0e4bcSnhK74uaQn0jSwNGZxO2WfePsQDyMBGTuSCOLy2FbK0qW
         /ve9M0xS5NYWAg7uRKDj4Q8/aV6VcmdLrhYWt0tT3aHPftQOYQQoUNtjVqs91EnnXuY9
         X9Qjr2lDJC64+7JN20gWW/bN7JkKAL6+rWqAMAAeKZJDp9KT4F6ZBFMXwRfd9XcssqHT
         m5sFKMsV39mXGrwxDENjAWodwWB+tIFd5QuyUb915xqDeFrjABYFpRBBmb/Km9qORi9Z
         FO5zbx7H5C3FFZO7UW7FFV8R/W7XPNzvYa2Drr1SkqbCf3u+T4mSF9oXvCb2ZArSu+pl
         bxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683205026; x=1685797026;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhEPtfZr+9cfDFkYEs5Deqb0QgVZN1XabpIEoEj4cvk=;
        b=j7ANT34Icp3vsSOF9qVQ/HaXTOGxRvc8cjeprPRyf/VMehma3ZLF6WXhOyaRR9lVzK
         b8ScTDJxXA6yEIj3U38WxMMfjlegl1Hxbpumr5wXWFyX+ET8E2dHYWDvuEM74HsysxL7
         1akLXVQELrSOWC6F2tvmOZ4Pr4RiuIpGB+6HdYSfSr7MH1kBII6XRVUOZ7rFcCv0KZAM
         nYlUzEGrb7W2cE/vD2UjgfrHPMfclaIAqbsNS2cuMUWjuoGuRsvPn4PmFyYgS+fLNNm2
         AfJ5eoFyvzRtGZ9DrT1CKXY7RVL7/aQMew/a2nK8pkWHY7YuIKbCoH9P9vrVZ0h2iWks
         L+3Q==
X-Gm-Message-State: AC+VfDxjtfJBjNyu33du2x3nsmYBsLb6TQAruXrLBwytSc+pOwBAb72G
        L7EG8MKPcMXn7iol4M4sbR2oIw==
X-Google-Smtp-Source: ACHHUZ5rqd3wHqCuOO0fJ1hW47ySy9xRiVsKwGXyfYQeycNMmT7FHnDTtsiXs54rb1SDpyWuTvez2Q==
X-Received: by 2002:a5d:4686:0:b0:2fa:88d3:f8b8 with SMTP id u6-20020a5d4686000000b002fa88d3f8b8mr2379888wrq.12.1683205026087;
        Thu, 04 May 2023 05:57:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:52fb:80bd:bee3:f741? ([2a01:e0a:982:cbb0:52fb:80bd:bee3:f741])
        by smtp.gmail.com with ESMTPSA id l9-20020a7bc449000000b003f2390bdd0csm4847131wmi.32.2023.05.04.05.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 05:57:05 -0700 (PDT)
Message-ID: <4eda7a33-991c-598e-0531-13959be0a912@linaro.org>
Date:   Thu, 4 May 2023 14:57:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sm8350: add ports subnodes in usb1
 qmpphy node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
 <20230503-topic-sm8450-graphics-dp-next-v1-1-d1ee9397f2a6@linaro.org>
 <4ce083f8-1ad1-c5c9-59cb-7511211b574f@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <4ce083f8-1ad1-c5c9-59cb-7511211b574f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 09:38, Konrad Dybcio wrote:
> 
> 
> On 3.05.2023 15:10, Neil Armstrong wrote:
>> Add the USB3+DP Combo QMP PHY port subnodes in the SM8350 SoC DTSI
>> to avoid duplication in the devices DTs.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> index ebcb481571c2..d048f4d35c89 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> @@ -2149,6 +2149,32 @@ usb_1_qmpphy: phy@88e9000 {
>>   			#phy-cells = <1>;
>>   
>>   			status = "disabled";
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +
>> +					usb_1_qmpphy_out: endpoint {
>> +					};
>> +				};
>> +
>> +				port@1 {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +					reg = <1>;
>> +
>> +					usb_1_qmpphy_usb_ss_in: endpoint@0 {
>> +						reg = <0>;
>> +					};
>> +
>> +					usb_1_qmpphy_dp_in: endpoint@1 {
>> +						reg = <1>;
>> +					};
> Shouldn't dp be a separate port@2?

Probably yes, but it should be the same issue for makena, but on makena
we do not describe the USB SS and HS links separately, but only a single
port for QMP input has been defined in the bindings.

Neil

> 
> Konrad
>> +				};
>> +			};
>>   		};
>>   
>>   		usb_2_qmpphy: phy-wrapper@88eb000 {
>>

