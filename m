Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7586866C269
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjAPOli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjAPOlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:41:20 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C938532E42
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:18:48 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m6so42912641lfj.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slDvNSXAJAnJLiEBukDiWieNTlz1AsAaE1WqqEMwQIQ=;
        b=ShC0ZOWyY8rS2sZui0cQWppHUDXFiAB3Kexyg0zzG5TBH73fw0ck3aNHoG+s04F31f
         qlawK3OhURIbgn0M1vLuL84r3kWgY3Eb6ma6raj53cnq7RkSWvIJ6zltENXFQSGDBbE5
         r7D+HksV9NM52wn7aI2eJTRrbyKGVJiQln9rPjQ7xYvsJW0FzEBAebD67IiohNJRhE5H
         t3aj/VAGKcw3am77haZ84qmlZODePFqqKIupgMVeI2hr21GyKYnUaMtX79Md29lo3bk0
         ZvLpWgkRkPUkeLBOzcy9XXRLg5MEOateBpfRDRiIr/bXbvlZHlrkY+W8ecXUOmNOd96G
         IIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slDvNSXAJAnJLiEBukDiWieNTlz1AsAaE1WqqEMwQIQ=;
        b=XIO87GRBpxADIyce7gwmoxsiskenDTdrNpTM/vKvCjxsrNcHzgeLh6/x+Cosm4RQkj
         C9jl2cPNnnY9VkuIF5ImIvqEpy2m5VKn/wCEIxdAfqMgHuWg3d2IIM22YQT/cxOH40X2
         dyn25U3hm2ViGGzErYwnTvDe0xAZFYo6+2nERGmLoNuZg+kMWmII64rBPLmFikABjASl
         YExCU9V6erM5ax7VvAyOR70KAQPFqkbD42PwkrMpT0fBLGNcnHmfOPXM/kExRIyP5PsV
         r6shV819ErKFWYtjyni4FYKmxl7JcSeSi3KZyqnvdHcazroLfu+DprhNtejrYm/ILHKj
         BV2g==
X-Gm-Message-State: AFqh2kojUwEtZ+479DKXheTv/SOTnY4iN+PoFaNWRP95aENn0kNQKaVe
        fzhwppaH017tnW3ciJjR9PYe7A==
X-Google-Smtp-Source: AMrXdXtm9IhxsXuJ3onLpyyBzZemmPaIMqa9NXW78S49UorNPyK233cYb/xj0vlWalHC+tSq3XtAaA==
X-Received: by 2002:a05:6512:3ba1:b0:4b5:8fbf:7dd6 with SMTP id g33-20020a0565123ba100b004b58fbf7dd6mr39391026lfv.61.1673878719081;
        Mon, 16 Jan 2023 06:18:39 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id g5-20020a056512118500b004d57ca1c96csm218388lfr.172.2023.01.16.06.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 06:18:38 -0800 (PST)
Message-ID: <e0230675-9451-f5d7-b85e-15066d611fe6@linaro.org>
Date:   Mon, 16 Jan 2023 15:18:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: msm/dsi: Don't require vdds-supply on 7nm
 PHY
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230116115132.348961-1-konrad.dybcio@linaro.org>
 <CAA8EJprNzLMnU7cguMit6Y4sgU0-SOkiiL+=s_BFBZiyvNvsAw@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJprNzLMnU7cguMit6Y4sgU0-SOkiiL+=s_BFBZiyvNvsAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.01.2023 13:52, Dmitry Baryshkov wrote:
> On Mon, 16 Jan 2023 at 13:51, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On some SoCs (hello SM6375) vdds-supply is not wired to any smd-rpm
>> or rpmh regulator, but instead powered by the VDD_MX/mx.lvl line,
>> which is voted for in the DSI ctrl node.
> 
> I think we should have an explicit `if compatible then required:
> vdds-supply' clause. WDYT?
Well, the driver will still probe and function without it,
so I'm not sure if it's strictly required..


Konrad
> 
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
>> index 9c9184f94c44..8e9031bbde73 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
>> @@ -48,7 +48,6 @@ required:
>>    - compatible
>>    - reg
>>    - reg-names
>> -  - vdds-supply
>>
>>  unevaluatedProperties: false
>>
>> --
>> 2.39.0
>>
> 
> 
