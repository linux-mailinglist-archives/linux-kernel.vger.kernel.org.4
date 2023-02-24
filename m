Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5898D6A1B97
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBXLuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBXLuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:50:20 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE824A1E8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:50:19 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s22so17471509lfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677239417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRGKNu8+nQtfgk+o8BnV6TsJOhtE3fIGeixZ72M30Es=;
        b=uojecS0jnQXyMuuky7+8Vn/P7ewJIsjqAc3BoNM/P5nAtzjlKb4SirE0DjYHlJpjvz
         z3EKqL0jDsd8NR7RDXyMwa6xjn9wkI6u+d3GBN/5jjjH476wsPpfwWWy6V3mBfv3UbCZ
         DIou4j3WeZiCnPxaxwGX9fmJlS3oMwNBmNgJhmALSozd4XxHuv945xEallYyT2EAW7LF
         diRZdC1w6O8nhRfVyvScyPlSbvquMn+kH/heYVf136h8yfk94HXgUNKyi0izUE71OFdC
         3uGwdxy/ulhsQrR/ISC9gewvLsEUMux4stdSTnKR7/wRCa+5vm7T0wie+/Ily77QEP40
         0aVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677239417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRGKNu8+nQtfgk+o8BnV6TsJOhtE3fIGeixZ72M30Es=;
        b=jZIzOnAiN4N42jbrFFMFa5LTcwad3Z9wS3k5S+qGU30pqvqECHzWcI2uDfRL7SlnBK
         kWNiKY5wWUiw9cuJ4cMsphG2UGqqUZ98NuSd8DaAYnmVEMFMtN5no5e8CcnI4NBUIfAp
         SmkhlXZ3v87x9AU1VidMGlvzaSmEER9zRqGDkO6ane+VleXURm2QhwUx5G3DbPfUpKZj
         Lwv+FCbwc8LYAqCzttZxlBGfCc8I55EYvRzXuomBJ2FZ8WKo5q6nRrjnQTpi2BrDyxWy
         Gv6HeLR69ZauFJHGFdZtNHY2Z94/U42XDf7dNF7TLKolRIdws33I9ROVi0YjoBo6nshx
         n89Q==
X-Gm-Message-State: AO0yUKXSl8n3kKu/WO2W1LoG0pxVf2Ba+l0H89cK+pemFgEAaEeMtMcK
        7wKAJWzE/7Digh5G3ceveMiobg==
X-Google-Smtp-Source: AK7set8zYxXQDEr3DaHDzu+XwBKc4RGTc9rFYpzvi/qL+BFDOihLu6FJODBvD7IcUJVtll2G21yhYQ==
X-Received: by 2002:ac2:43d5:0:b0:4d5:a689:cd73 with SMTP id u21-20020ac243d5000000b004d5a689cd73mr4906894lfl.55.1677239417328;
        Fri, 24 Feb 2023 03:50:17 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id l26-20020ac2555a000000b004cb45148027sm1600980lfk.203.2023.02.24.03.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 03:50:16 -0800 (PST)
Message-ID: <40c42e36-9da7-73e1-8ae6-5a0a4abf17b1@linaro.org>
Date:   Fri, 24 Feb 2023 12:50:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/15] dt-bindings: display/msm/gmu: Add GMU wrapper
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>
References: <20230223-topic-gmuwrapper-v3-0-5be55a336819@linaro.org>
 <20230223-topic-gmuwrapper-v3-2-5be55a336819@linaro.org>
 <2fb0ba58-c011-7896-9792-005d0ed9ad55@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2fb0ba58-c011-7896-9792-005d0ed9ad55@linaro.org>
Content-Type: text/plain; charset=UTF-8
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



On 24.02.2023 12:19, Krzysztof Kozlowski wrote:
> On 23/02/2023 13:06, Konrad Dybcio wrote:
>> GMU wrapper is essentially a register space within the GPU, which
>> Linux sees as a dumbed-down regular GMU: there's no clocks,
>> interrupts, multiple regs, iommus and OPP. Document it.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../devicetree/bindings/display/msm/gmu.yaml       | 49 ++++++++++++++++------
>>  1 file changed, 37 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
>> index ab14e81cb050..021373e686e1 100644
>> --- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
>> @@ -19,16 +19,18 @@ description: |
>>  
>>  properties:
>>    compatible:
>> -    items:
>> -      - pattern: '^qcom,adreno-gmu-6[0-9][0-9]\.[0-9]$'
>> -      - const: qcom,adreno-gmu
>> +    oneOf:
>> +      - items:
>> +          - pattern: '^qcom,adreno-gmu-6[0-9][0-9]\.[0-9]$'
>> +          - const: qcom,adreno-gmu
>> +      - const: qcom,adreno-gmu-wrapper
> 
> Why wrapper is part of this binding then? Usually wrapper means there is
> wrapper node with a GMU child (at least this is what we call for all
> wrappers of custom IP blocks like USB DWC). Where is the child?
"GMU wrapper" is a sorta confusing name that Qualcomm chose for
the "fake GMU" which has the GMU_CX and GMU_GX registers responsible
for things like powering up some GPU things internally and some
perf/pwr counters. It is _not_ a wrapper in the sense of a parent-child
relationship. The GMU wrapper has no HFI (Hardware Firmware Interface)
to communicate through crafted messages, but relies on plain register
accesses.

Konrad
> 
> 
> Best regards,
> Krzysztof
> 
