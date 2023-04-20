Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168656E8663
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjDTA0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjDTA0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:26:09 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B40D35AF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:26:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2a7af0cb2e6so1837211fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681950365; x=1684542365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Psl4T4YpjUg01XfnlEjBI8pEA1fZTD2Nzhy7cDEKavA=;
        b=vJMv3A7l2uf768EgIZu+u9ouZ7G0Jl/dK3aLvq56cvfi5VadrrlT+1ndg37h3ofzMl
         XYydubodYZpRp/sJ60Hd4ZjVSdARprGguczDF8A0P8orqve/vxsC1YWBvZ8J7+rJxg5/
         GRf+ppxO9HEjf+LFcruSnHgNXTd6y6ydht8fOltFOLLIms2PBWLN4sfKSnsffq3hhXdP
         J18wcfDn2k+BywOIITi8rcM0eRdITq3UfxZB8+ISAWEA7E8ilDZupJko95Jmz+8n7em1
         AH05H2mSw3tRt2S3hT7mdbAs5LCr4UacI03mDiuf8ViMGuYqXMbnpSoXRR9fn5SNZ94/
         eSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681950365; x=1684542365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Psl4T4YpjUg01XfnlEjBI8pEA1fZTD2Nzhy7cDEKavA=;
        b=Sa069bUlLUSOoq5n7L68pzsaPPEzpIw99VS9mITOlvfyuJUdgVQJdok1HWerGeIX9A
         qcc3UTx1L8aU/2+PtQk6yY4MmjrAgpxn3LGLmWnMT54X4PMTBBa4V9hJWyc2hpJgjdLX
         jHxNlNPcaqnHPyzsT0y+06auRZox34sJDJMuUY4OQw1ViayUax9XzjQee+pl9ctxqUGA
         sN6EE3eN9GyWoRgn91jMsABdnNQgdL/XnXsNiaVuWHQ+8/HRfp9RDA7eAUpuBSEfngCD
         IZyVCBHueezVhnmsOgB3Cyg21vAbcoRZmdQpp5CAQMQf+CzQBrDrkiv6O/rc6ZIQmf7N
         2ERg==
X-Gm-Message-State: AAQBX9cXEu2MhB0Fn8Ouq2Gq5cgGNT8nvDujcJuHLPdYPrc7kGmLcr/F
        Gx8d1qLJoLxJBsT3tSK7NHbWvg==
X-Google-Smtp-Source: AKy350bHHMfLKUnerA/JSf8lkT6nEjfYsQY40HJ6o/cWTpT9y6js94xXiQScUYrEnL+7ULilAE3lsw==
X-Received: by 2002:ac2:4a9c:0:b0:4eb:40d4:e0d2 with SMTP id l28-20020ac24a9c000000b004eb40d4e0d2mr4690145lfp.38.1681950365504;
        Wed, 19 Apr 2023 17:26:05 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u6-20020ac248a6000000b004eb51cfb147sm52251lfg.115.2023.04.19.17.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 17:26:04 -0700 (PDT)
Message-ID: <62f99cee-ecc2-2969-22da-d8f43b8b7064@linaro.org>
Date:   Thu, 20 Apr 2023 03:26:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Freedreno] [PATCH 1/5] dt-bindings: display/msm: Add reg bus
 interconnect
Content-Language: en-GB
To:     Jeykumar Sankaran <quic_jeykumar@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        freedreno@lists.freedesktop.org
References: <20230417-topic-dpu_regbus-v1-0-06fbdc1643c0@linaro.org>
 <20230417-topic-dpu_regbus-v1-1-06fbdc1643c0@linaro.org>
 <c20433cb-02e4-bd82-99ab-bd25a49771d4@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <c20433cb-02e4-bd82-99ab-bd25a49771d4@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 23:05, Jeykumar Sankaran wrote:
> Resending the question as the previous one was sent only to the 
> freedreno list. Apologies for spamming!
> 
> On 4/17/2023 8:30 AM, Konrad Dybcio wrote:
>> Apart from the already handled data bus (MAS_MDP_Pn<->DDR), there's
>> another path that needs to be handled to ensure MDSS functions properly,
>> namely the "reg bus", a.k.a the CPU-MDSS interconnect.
>>
>> Gating that path may have a variety of effects.. from none to otherwise
>> inexplicable DSI timeouts..
>>
>> Describe it in bindings to allow for use in device trees.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/display/msm/mdss-common.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml 
>> b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
>> index ccd7d6417523..9eb5b6d3e0b9 100644
>> --- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
>> @@ -72,6 +72,7 @@ properties:
>>       items:
>>         - const: mdp0-mem
>>         - const: mdp1-mem
>> +      - const: cpu-cfg
> If posted already, please point to the DTSI patch for this ICC path.

Probably it's worth updating the example in one of mdss schemas.

>>     resets:
>>       items:
>>

-- 
With best wishes
Dmitry

