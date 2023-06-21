Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5FB739261
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjFUWST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFUWSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:18:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127C11733
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:18:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so8775522e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687385894; x=1689977894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zyWuSVMXh2Y/fSXjuElkXOGDHtemipt9fq/ZZgliCDQ=;
        b=y8vrACxzMcCef2j1eZMvyDCcR4g1WySOtRYSYJyZqwUKM4+gk+I3LPSGmrGtyQtqtw
         MvYjd6Ib3r6rZHSZMSh2yH4aFQ2E5lARS+WYZhB25P8fxa7ICZ4Qgkd4Pp8w9bXLnyho
         +ar+OFjHQwc86zWWpU8XRSIiyeaCC4yhtSx+qG3huWbBmuVl8wB9vQhzdp1pbIiG7gFR
         TNBjkEBdyO4mDXxeWtkUcajbdQUpSFA5Ry9I0WU8whd+wL7QnnRihow0MxwPSsiGzE4E
         u55FKvTNWFZz8Mtwv8f/FtYsbWr82ukB4r4QkAHYfcfIxQRRWxoxf58G1LJNcR1LfFcG
         4hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687385894; x=1689977894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyWuSVMXh2Y/fSXjuElkXOGDHtemipt9fq/ZZgliCDQ=;
        b=lwaZGlDn8RSEPHMUgacEYonBTR7sBRjgrBkdTLPkJ0GC+ZkbA0kGh/BbIjcy0LbwRN
         xD8PWkqchRrgm5qIJeOkruKqY4WgEvJC1m8KV7lxdd0hwrCoTRdTw88KOfsgPKxUYOPe
         OoeEXT/jaaaOBtyAZVXFHUzp/ZkwQbCtoyAZVBYld2xaOJDvYYI+nSdapJ6v2BRGH4SL
         L1cDoXmCLtbbLOpc+xL2TtpuQLid1B8OZ9iYl/VBSgTWlvDJPfbeWzPx365hPXA/MZW/
         qBp5qxv4EaW+Ws4BI3vz1zLFZaxE0IPPAWCvjJGma88VeaY4PYV4vVeDOJDaXzCsw7Sc
         XQLA==
X-Gm-Message-State: AC+VfDwSyXkL3Plt7QfFplFvvXerCWR3+hk6S6MSN1L6p7gLinBe5XY6
        dHVfR3+uYGT7ubM03sNioqWhkQ==
X-Google-Smtp-Source: ACHHUZ5Si4dCWNPr03XUSarW8gCPbkN/erz8YhdBHCibOFkHWzUSZhPV12IA2841vnOqzTcqJaHntg==
X-Received: by 2002:ac2:4988:0:b0:4f9:535e:cdca with SMTP id f8-20020ac24988000000b004f9535ecdcamr4407924lfl.7.1687385894197;
        Wed, 21 Jun 2023 15:18:14 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id h16-20020ac25970000000b004f85858e52dsm893503lfp.138.2023.06.21.15.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 15:18:13 -0700 (PDT)
Message-ID: <c05a9a02-0a33-6160-9072-717efe30031a@linaro.org>
Date:   Thu, 22 Jun 2023 01:18:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 2/2] dt-bindings: msm: dsi-controller-main: Document
 clocks on a per compatible basis
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230118171621.102694-1-bryan.odonoghue@linaro.org>
 <20230118171621.102694-3-bryan.odonoghue@linaro.org>
 <qew6nd3jqnasb3mivvdxcwugfrvxdeafilaxk35v7uihagk2qi@oxe3oqdgfwpe>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <qew6nd3jqnasb3mivvdxcwugfrvxdeafilaxk35v7uihagk2qi@oxe3oqdgfwpe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 00:45, Marijn Suijten wrote:
> Hi!
> 
> On 2023-01-18 17:16:21, Bryan O'Donoghue wrote:
>> Each compatible has a different set of clocks which are associated with it.
>> Add in the list of clocks for each compatible.
> 
> So if each set of compatibles have their own unique set of clocks, is
> there a reason to have so many duplicate then: blocks?  I ran into this
> while preparing for submitting SM6125 DPU and having no clue where to
> add it.
> 
>> Acked-by: Rob Herring <robh@kernel.org>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   .../display/msm/dsi-controller-main.yaml      | 218 ++++++++++++++++--
>>   1 file changed, 201 insertions(+), 17 deletions(-)
>>

[skipped most of the comments]

> 
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sc7180-dsi-ctrl
>> +              - qcom,sc7280-dsi-ctrl
>> +              - qcom,sm8250-dsi-ctrl
>> +              - qcom,sm8150-dsi-ctrl
>> +              - qcom,sm8250-dsi-ctrl
>> +              - qcom,sm8350-dsi-ctrl
>> +              - qcom,sm8450-dsi-ctrl
>> +              - qcom,sm8550-dsi-ctrl
>> +    then:
>> +      properties:
>> +        clocks:
>> +          maxItems: 6
>> +        clock-names:
>> +          items:
>> +            - const: byte
>> +            - const: byte_intf
>> +            - const: pixel
>> +            - const: core
>> +            - const: iface
>> +            - const: bus
> 
> ... and here ...
> 
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sdm660-dsi-ctrl
>> +    then:
>> +      properties:
>> +        clocks:
>> +          maxItems: 9
>> +        clock-names:
>> +          items:
>> +            - const: mdp_core
>> +            - const: byte
>> +            - const: byte_intf
>> +            - const: mnoc
>> +            - const: iface
>> +            - const: bus
>> +            - const: core_mmss
>> +            - const: pixel
>> +            - const: core
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sdm845-dsi-ctrl
>> +    then:
>> +      properties:
>> +        clocks:
>> +          maxItems: 6
>> +        clock-names:
>> +          items:
>> +            - const: byte
>> +            - const: byte_intf
>> +            - const: pixel
>> +            - const: core
>> +            - const: iface
>> +            - const: bus
> 
> and here, we have *three* identical lists of clocks.  Should they (have
> been) combined?
> 
> I can send a patch fixing these all if desired!

Probably it would be logical to split follow DPU and MDSS schema and 
split this file into per-SoC compatibles and a generic file. Then it 
would be easier to review different SoC parts.

Regarding reordering of clocks. I think we have 5 different 
configurations in dsi_cfg.c, but we definitely can optimize the schema.

> 
> - Marijn
> 
>> +
>>   additionalProperties: false
>>   
>>   examples:
>> -- 
>> 2.38.1
>>

-- 
With best wishes
Dmitry

