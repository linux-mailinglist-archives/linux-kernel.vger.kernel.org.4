Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7E0661FE2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjAIIUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbjAIIUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:20:20 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE0AE0F3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:20:19 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t5so2898873wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CYyp5XDyMRmrPqmynKHIyJjVDqDm5Chh7Zml32+BipY=;
        b=zTOCGwY56/f5Z1Eki0rfCFmDAHRfvpvEOGhKsUuiVnhIHF8TTAukLvemA8Rh1gH6iH
         no9OCSVIsHO9GAp1dMmhukvQmYTsCwB+TtQIQkV73NFeuCNn0WR3g9N4gADoPNIT/Hlj
         5yInInLZM+Iw7CSkSkRg3XoIOMbxRN2BR5PQpzTKDrMiHgOUTTwahxrKoo3RJ1CgJ8tG
         DiVYxZUJDFr2orRWYQ0USmsHdvtJ1SmQWqwQq+mk53POs+rUSZVmtKEk0FrLtNpc0gG4
         2hGN5/l4ivWEd5JZgCHwtCO0r0Ete2u0g7YeCoJQfwV2MgsAsqibVzY84Uiu7AdcrGVm
         8fRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYyp5XDyMRmrPqmynKHIyJjVDqDm5Chh7Zml32+BipY=;
        b=thZptCwsnbUN6ZXKorv2t6oOb8vEgH9AsptHWO4R6rmE5d9y8f2SdPc/ftAIshselr
         s0QezSWKGO/niPEY4GuZTCkLssccZJBAMp/ZMtFoqlXRHt4cKiyxn/MfKaMe3mu1qYR8
         tCW3/fX8Jzuwmwhy87wqH1yxIAS9rjIHcmCallHOQno5m53WzHzMGnBE+cn2mx+JSNK5
         7lWgOIhZmx6nK+DQ8P2YtExw0Ti+kA/NtBnMew69bXTK6n9dbuD3aEcebSpoGVesNGrz
         qvk5PnrAvCIsaIYl2FPdh7sg+qbGCacWf7kHFpHFe3hGE2ZqqjRCRvqPFSG2oGTqIJ7E
         pRjg==
X-Gm-Message-State: AFqh2krIdFOt2p/ND+BFS5J3CsmTMVDO7Hz1Lc0sf9moVo+kggX+5pIH
        qbsT2R2s+28a2UxVttNJFWSCKQ==
X-Google-Smtp-Source: AMrXdXuS4SsXEvDjtamC9p7y7+wI0Z3KLE2gqiRlvwPweAiNeB7fCc1XlwUcmftBZTJTntulUNozMg==
X-Received: by 2002:adf:ea91:0:b0:2a3:44e9:4ebb with SMTP id s17-20020adfea91000000b002a344e94ebbmr11799768wrm.15.1673252417545;
        Mon, 09 Jan 2023 00:20:17 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d4590000000b0026fc5694a60sm7896542wrq.26.2023.01.09.00.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 00:20:17 -0800 (PST)
Message-ID: <129fa2ba-2399-067a-bc04-49e08eee2f55@linaro.org>
Date:   Mon, 9 Jan 2023 09:20:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/6] dt-bindings: display/msm: document the SM8550 DSI PHY
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230103-topic-sm8550-upstream-mdss-dsi-v1-0-9ccd7e652fcd@linaro.org>
 <20230103-topic-sm8550-upstream-mdss-dsi-v1-1-9ccd7e652fcd@linaro.org>
 <f8c8076e-2ac3-f67b-7641-d0c324784cb5@linaro.org>
 <5f1a846b-d536-f013-f311-2773945317bb@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <5f1a846b-d536-f013-f311-2773945317bb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 00:09, Dmitry Baryshkov wrote:
> On 06/01/2023 17:41, Krzysztof Kozlowski wrote:
>> On 04/01/2023 10:08, Neil Armstrong wrote:
>>> Document the SM8550 DSI PHY which is very close from the 7nm
>>> and 5nm DSI PHYs found in earlier platforms.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
>>> index bffd161fedfd..f72727f81076 100644
>>> --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
>>> +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
>>> @@ -15,6 +15,7 @@ allOf:
>>>   properties:
>>>     compatible:
>>>       enum:
>>> +      - qcom,dsi-phy-4nm-8550
>>>         - qcom,dsi-phy-5nm-8350
>>>         - qcom,dsi-phy-5nm-8450
>>
>> Poor patterns once allowed like to keep growing... I commented here:
>> https://lore.kernel.org/all/ccbb47e4-d780-0b1d-814e-27e86b6c369c@linaro.org/
>>
>> so let's wait for response about other compatibles.
> 
> I have fixed 8350 & 8450 while applying. Please rebase on top of msm-next-lumag-next with fixed compatibles.

Ack

Thanks,
Neil

> 
> Note: the DPU changes are not yet part of the msm-lumag-next.
> 
>>
>>>         - qcom,dsi-phy-7nm
>>>
>>
>> Best regards,
>> Krzysztof
>>
> 

