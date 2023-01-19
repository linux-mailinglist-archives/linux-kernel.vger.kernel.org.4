Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B4B673977
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjASNIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjASNHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:07:43 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A7B64D82
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:07:04 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w14so2785112edi.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXODrPsAw+WxnGMS9ryh6u+wd5DwP7P3JwcF8GuVJm0=;
        b=L807A/l2Noy+D3jGMrMFebZrU4oXQEMFtkrog97/fPeOcgCba7MrctXgvN0uLveygF
         3HWFy4CqHQB9JA5o8/pwpEpckUwUQj9CoUFCl0PW/qRcFw4p3SSM5kXJ5ezeI2SRgGj5
         R28LH/thHBCYtmQKfSvEOxpx72jkU/qRvOnWLylUgGEFOmSNn6d1RoHxNWqO5hSk2dEq
         zjHrbsVLthzarGnZHcG3kwQ+UIXgwJolTA91+2vnRm1//alHK1RM2rqwXE4zkGARDuiL
         rQkRySKAeF8DKirTwNBZXiwS95eRurYoKHu9oXMPuudwXbiX1IpkAogcAGeQ5VY46t+w
         8DUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXODrPsAw+WxnGMS9ryh6u+wd5DwP7P3JwcF8GuVJm0=;
        b=1zib9jC+2gQr79rfzrU4m7Ti6N0Yhn/VwDnmNHmdQgDHkqBddeURrR+BJ5JYt0P0Uo
         quqGpz6rOq08ziMt+cuGlJ9zTLyfz3BihGAstuQ5uHfZdN44/grD+aAC3lYa0P7aCXcX
         B0rbwxgm41Gs/CVb7dldGf+aWmNc8GRPnZrEKncDtbmyHLA85P8J7JZZCln/O97fwYen
         3AH/Vx7BVJIfOEiU2SvezemQ5RdHGC5sOa2Ogq/TmIcOgy4WGTkg6c8/H+j88fKnxITu
         3fwEDK7F/9aOmvtZv1LlYlk7GOkEuiEv1DTd1O8NoGvYRAnMo+2Dru053dcDjOgjzEoa
         hnBQ==
X-Gm-Message-State: AFqh2ko5bz8vBIR3p5l7DmLDpzJ9V2bOsQqOf7MeHg0z97bczGhsQZO6
        QPI/Y8kkioCdMbhW+GdtwhInrA==
X-Google-Smtp-Source: AMrXdXuCspeStoCPA/c7cDkJ87Z65zeI5mX53jM6IpeoCJAMXRN9bIUD9BN5sBY7JZ12Rnm7f309QA==
X-Received: by 2002:aa7:cac2:0:b0:497:948b:e8 with SMTP id l2-20020aa7cac2000000b00497948b00e8mr9756962edt.6.1674133623023;
        Thu, 19 Jan 2023 05:07:03 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x22-20020aa7dad6000000b0048789661fa2sm15554559eds.66.2023.01.19.05.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 05:07:02 -0800 (PST)
Message-ID: <5c4c6ee7-e202-716b-a3ac-04d7620b8c58@linaro.org>
Date:   Thu, 19 Jan 2023 15:07:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 8/8] phy: qcom-qmp-pcie: Add support for SM8550 g3x2
 and g4x2 PCIEs
Content-Language: en-GB
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230118005328.2378792-1-abel.vesa@linaro.org>
 <20230118005328.2378792-9-abel.vesa@linaro.org>
 <7fe0c49e-a628-8e76-8294-ab8faadb3a70@linaro.org>
 <Y8iCAPOyrYXd7e/3@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y8iCAPOyrYXd7e/3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 01:34, Abel Vesa wrote:
> On 23-01-18 06:34:41, Dmitry Baryshkov wrote:
>> On 18/01/2023 02:53, Abel Vesa wrote:
>>> Add the SM8550 both g4 and g3 configurations. In addition, there is a
>>> new "lane shared" table that needs to be configured for g4, along with
>>> the No-CSR list of resets.
>>>
>>> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>    drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 369 +++++++++++++++++++++++
>>>    1 file changed, 369 insertions(+)
>>>
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> index bffb9e138715..6f82604bd430 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> @@ -1506,6 +1506,234 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl[] =
>>>    	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x08),
>>>    };
>>
>> I see that the last two patches still use 'shrd' a lot. Does this correspond
>> to hw register names or is it just a vendor kernel code convention?
> 
> It corresponds to the hw register names..

Ack, then:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
>>
>> -- 
>> With best wishes
>> Dmitry
>>

-- 
With best wishes
Dmitry

