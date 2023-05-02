Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A606F3F96
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjEBItR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjEBIsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:48:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07C14C2B
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 01:47:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so1585414a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683017260; x=1685609260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCflCmx5CoveGF/v/9+Y+5fkMVwZkJVQ2C0NfAviXuo=;
        b=jfSZLnSQ7eGu+JLRyXFjIPROXJzAOkbNbawnzcyHatN1RxRnbULg5LNS9bPF4m+9VA
         FdWsLO4VWRYqChh1hWTldOX5pfkl4riNFSSSWrI8Cn0b5SuDynZrZu13khAQ/NVQx6My
         JVeLBMBlgvVdz2b2Z7Zt3fy8zqVOAYXnU3SjhekdwxngD4ZktHm+EoLDiHByfDfpL2Nd
         ZVDH1oQdqsFUkwYyo8Fx63S12c8GDvh8w7+Rc+MK9rJ+84IAjB2HXNNUaZdYkK/JeL0D
         HLvn4UI91CLASIecCEPcPw0mwvc0SRqTu1vUgEyfDiQB1rZzqdXVgmJTWkJF0LTW4IsH
         yOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683017260; x=1685609260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCflCmx5CoveGF/v/9+Y+5fkMVwZkJVQ2C0NfAviXuo=;
        b=EgHbG+YSmEZDDUCikyB71c5kr/7DBSoqwDWn27yOL0r8U5kqCeEd/VkXwGZhas5k5b
         0vdOSJl03gsJ+B/AI5al6a/lIaXrfWjFLqv1e7L8n5xyVtr/hUEzWEClIWZ/86ICGeY1
         T2VDkYvOmauhHFI4BqnrBDOwzUiGWqwYeOFfUyaiFnRkxSe2/cAwr0/p89DowC2gPcLY
         +eUaTCRnK4DlKIN5BLGAjFOse6ME/6oKqhIkYFqxEEDmbXDVgsN+ZffGvGxbuQ3DtUnU
         mVwr4RLxgN7Musmog8OUqNFRkuhxSzFMLUs5SASJxkTNycUCDB05xkW7JdmTE6peCa+I
         b5fA==
X-Gm-Message-State: AC+VfDy0g1aRJSeZERN5pKunsAXYjfoSTS6GEKOrYECPXmU2hWO0bi9V
        Kt1uIsrjdqJfZ/Tu2kG045ISsA==
X-Google-Smtp-Source: ACHHUZ63B0Ahr5OE/6ydoe7FknwEhIFEj7JmTTSg83HbaHGsBbokJ8+Be0zQlKhO6TeLKYXynAHw6Q==
X-Received: by 2002:a05:6402:1285:b0:506:8838:45cc with SMTP id w5-20020a056402128500b00506883845ccmr7733735edv.6.1683017260075;
        Tue, 02 May 2023 01:47:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id m18-20020a056402051200b0050bcd197549sm887925edv.38.2023.05.02.01.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 01:47:38 -0700 (PDT)
Message-ID: <0f2dea5a-b6f7-b659-f41e-55d1777b4dd1@linaro.org>
Date:   Tue, 2 May 2023 10:47:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v7 1/9] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
Content-Language: en-US
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-2-quic_kriskura@quicinc.com>
 <df24efb2-8279-ef15-a118-2a24885288c8@linaro.org>
 <a001c9c0-f186-f125-daab-e646790badfe@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a001c9c0-f186-f125-daab-e646790badfe@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 10:35, Krishna Kurapati PSSNV wrote:
> 
> 
> On 5/2/2023 1:18 PM, Krzysztof Kozlowski wrote:
>> On 01/05/2023 16:34, Krishna Kurapati wrote:
>>> Add the compatible string for SC8280 Multiport USB controller from
>>> Qualcomm.
>>>
>>> There are 4 power event irq interrupts supported by this controller
>>> (one for each port of multiport). Added all the 4 as non-optional
>>> interrupts for SC8280XP-MP
>>>
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> ---
>>>   .../devicetree/bindings/usb/qcom,dwc3.yaml    | 21 +++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>>> index d84281926f10..2c96da1ce5b8 100644
>>> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
>>> @@ -26,6 +26,7 @@ properties:
>>>             - qcom,sc7180-dwc3
>>>             - qcom,sc7280-dwc3
>>>             - qcom,sc8280xp-dwc3
>>> +          - qcom,sc8280xp-dwc3-mp
>>
>> SC8280xp comes with two USB controllers: one single-port and one multi-port?
> 
> Hi Krzysztof,
> 
>    SC8280XP comes with 3 controllers. The first two are single port 
> controller and the third one is a multiport controller. In DTSI:
> usb_0 / usb1: have compatible set to : "qcom,sc8280xp-dwc3"
> 
> And multiport controller has it set to "qcom,sc8280xp-dwc3-mp"

OK, then this looks fine.

Please add the compatible to existing allOf:if:then to constrain clocks
and other pieces. If none of existing if:then: matches your case, add
new one.

Best regards,
Krzysztof

