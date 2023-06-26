Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBF273DBAA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjFZJnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjFZJnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:43:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A35C6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:43:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f96d680399so3832290e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687772622; x=1690364622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wa4sSEA7B28vGW7cZkSmi2ta/a82zz6uw3G1/9bh3+4=;
        b=Glvda0Sq1DktwYHBHGnIKm6y/v1J/ivavoXEZ5Yzh5ppJdiQIjuPTz8MombSSC+pSK
         gXHLhMxdSPFSFl3HBrUNoGr2jrBJaMpPkL8QZU7fuJRnMB51L3AHtgfGQ4oYB6CP6Rli
         +0c4N0JGOIJcKH3olOwzgAunyS7kl5qpKpCJfpC7X1wS0FV0Pe/3lajiLKZIC1Tq4Qfc
         nnrCI2KaXdn51Fqjm0B0OvaZrxy0Oni3g4ofVDtef9ugjleF3FdubBaJQRM/WXX7kz1g
         5Ln/ntZyUChM4LyLMVRCEUXhXpMUlfKZkwPsm6euDjeNHWN6Lrtno7Y5ZGhrvrYGE151
         aZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687772622; x=1690364622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wa4sSEA7B28vGW7cZkSmi2ta/a82zz6uw3G1/9bh3+4=;
        b=L8rG61Xov+YwSbSa2OGCZYzLHh+y3rmBuPnQZnZYUcD3m1GkpjTt2M6ptKEyOR8W4n
         RR8zAX5iGQkh2XjeVrs03JVZoBzR8u1qrDa1JgiTbJtOGfHHwAfjpAli5LpME9hrvKlx
         tl+1/EFK9vXjMFgGSq2D2wfxZ38Om26+N8Ow4dIYZfQGwdhsdhjH553yJUP4j6q5WFbw
         tl34wjjlhWTMvUfhpvAVSfoIJdMNaCC2Lj9TcZepmwV0QWb4RUPN7TfYzvmO0qouIFo0
         +GwwEoWrCWPltAs13pkyYd+7p2NPPPIEQ9jfEN/eJYoOtJeelr79vrz9aQeUcDkmcPaA
         8FSw==
X-Gm-Message-State: AC+VfDwt/m4ttQJA+eFDT9ecFMwkdCC+Ujgsnocv3C/1YG0MWnfFzacD
        EYpevYxo8RsGzHzCKyD/x6BTr0Xh7t0mVqljods=
X-Google-Smtp-Source: ACHHUZ6F1v7pFN28t/+mbYAP/qNkuiQynLLEVdAGA02D77327AAmiQMZUi291CRiOVoLaRv03kmHRA==
X-Received: by 2002:a05:6512:3e24:b0:4fa:d147:9df with SMTP id i36-20020a0565123e2400b004fad14709dfmr2833708lfv.19.1687772622267;
        Mon, 26 Jun 2023 02:43:42 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id d13-20020ac241cd000000b004db1a7e6decsm1026500lfi.205.2023.06.26.02.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 02:43:41 -0700 (PDT)
Message-ID: <f62d750e-da73-fece-c3de-0dac1fbb9827@linaro.org>
Date:   Mon, 26 Jun 2023 11:43:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/15] dt-bindings: clock: qcom,dispcc-sm6125: Require GCC
 PLL0 DIV clock
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-3-1d5a638cebf2@somainline.org>
 <c9681bce-efa8-9b79-4bf6-837dd6a2dc12@linaro.org>
 <edrftxqhywiaxvbonyh25cmubrg77y4dryqoy7id4ndan2lfa7@rhvcoavtg5vl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <edrftxqhywiaxvbonyh25cmubrg77y4dryqoy7id4ndan2lfa7@rhvcoavtg5vl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.2023 21:48, Marijn Suijten wrote:
> On 2023-06-24 03:45:02, Konrad Dybcio wrote:
>> On 24.06.2023 02:41, Marijn Suijten wrote:
>>> The "gcc_disp_gpll0_div_clk_src" clock is consumed by the driver, will
>>> be passed from DT, and should be required by the bindings.
>>>
>>> Fixes: 8397c9c0c26b ("dt-bindings: clock: add QCOM SM6125 display clock bindings")
>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>> ---
>> Ideally, you'd stick it at the bottom of the list, as the items: order
>> is part of the ABI
> 
> This isn't an ABI break, as this driver nor its bindings require/declare
> a fixed order: they declare a relation between clocks and clock-names.
Bindings describe the ABI, drivers implement compliant code flow.

> 
> This orders the GCC clock just like other dispccs.  And the previous
> patch dropped the unused cfg_ahb_clk from the bindings, so all bets are
> off anyway.
Thinking about it again, the binding has not been consumed by any upstream
DT to date, so it should (tm) be fine to let it slide..

Konrad
> 
> - Marijn
> 
>>
>> Konrad
>>>  Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
>>> index 2acf487d8a2f..11ec154503a3 100644
>>> --- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
>>> @@ -23,6 +23,7 @@ properties:
>>>    clocks:
>>>      items:
>>>        - description: Board XO source
>>> +      - description: GPLL0 div source from GCC
>>>        - description: Byte clock from DSI PHY0
>>>        - description: Pixel clock from DSI PHY0
>>>        - description: Pixel clock from DSI PHY1
>>> @@ -32,6 +33,7 @@ properties:
>>>    clock-names:
>>>      items:
>>>        - const: bi_tcxo
>>> +      - const: gcc_disp_gpll0_div_clk_src
>>>        - const: dsi0_phy_pll_out_byteclk
>>>        - const: dsi0_phy_pll_out_dsiclk
>>>        - const: dsi1_phy_pll_out_dsiclk
>>> @@ -65,12 +67,14 @@ examples:
>>>        compatible = "qcom,sm6125-dispcc";
>>>        reg = <0x5f00000 0x20000>;
>>>        clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
>>> +               <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>,
>>>                 <&dsi0_phy 0>,
>>>                 <&dsi0_phy 1>,
>>>                 <&dsi1_phy 1>,
>>>                 <&dp_phy 0>,
>>>                 <&dp_phy 1>;
>>>        clock-names = "bi_tcxo",
>>> +                    "gcc_disp_gpll0_div_clk_src",
>>>                      "dsi0_phy_pll_out_byteclk",
>>>                      "dsi0_phy_pll_out_dsiclk",
>>>                      "dsi1_phy_pll_out_dsiclk",
>>>
