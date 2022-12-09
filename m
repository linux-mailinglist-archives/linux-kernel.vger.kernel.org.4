Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDD6647A89
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 01:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLIALY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 19:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLIALV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:11:21 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2AA880C5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:11:19 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x28so4541027lfn.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 16:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/kIc8Jj1a1zmKoEz2W+SDkXTo4yVcxbbD8qSkeEWknU=;
        b=wpW0fdECuuJrTEYsX2yYgZWZ94l+6CDLy44QJYzfcrdDvT3FVluT2PIIue7K0zHWIl
         yWbXC5qmqKdBjroFeUNhwn+52y8vm1V2Pi+swxXu0n3b/MBdRSu4p5jHMc/SUWXuTu2D
         +ui/QQZZ1Imtb4NqfTRdhG3QWMqRgYVP3MhQkT0qy5OhT7DkHvlWydlKifKmZY69pgx5
         JLMSayHDdRDisFheLffB+0OhxHvh4VF+UrdMNXCt0/kRVqnyzT0oqAF8fqdlSfjSZ8gt
         QmWnJ/gVN3h0nmrb5d9VYYaHcM/550dxtaYjcYuHVcffCbwLv5a4saFZ4OrcAtXikoVs
         Ip/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kIc8Jj1a1zmKoEz2W+SDkXTo4yVcxbbD8qSkeEWknU=;
        b=0uNqGjUHnlC9W9PVgIQxHpgqDYVh1bYkMoPxiq/wTBVwJESG8qY4S3Y1if2CCOCcij
         gzjd9VNEDkEUj61b1+gVfozSGviPJ8gCvnhO5cgJcBHmuSQdEOVRlGHL2hGC2HZajE+z
         uw+illgDnpnIXX1te8Pqto8VSqWtcvYEOK6A4XAcMzRlMVqbCT1Use/md7GgQSyjm7cC
         nfaukWJOb6Dcrh06IfjrUK/JHb05lw5+0onFTTmQ84k3xWo0z4T9+K7Bn2pIKx4CUg2a
         zPN6Qpj0GJs5UQmj+yBSFvJ2bePkzdq5iL8HDeLLccW9/Zbr0hPIBiw7aNUPleEtdpG3
         86/Q==
X-Gm-Message-State: ANoB5plN2vsSsw6i7/dSAS3HME69T7bN8OLeQ4x9B17MyMRVzszMpYvY
        pA7ODfxSjWoYNOlD3do/m6JVUg==
X-Google-Smtp-Source: AA0mqf7SZW85DZNUtkIqiFI//txZoeVxBcWArnYfSQ9s5TyjKffDnECzuHeD3eEzjBG5bsn3sqZBSg==
X-Received: by 2002:ac2:4f16:0:b0:4a4:68b8:9c4b with SMTP id k22-20020ac24f16000000b004a468b89c4bmr946096lfr.51.1670544677678;
        Thu, 08 Dec 2022 16:11:17 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d9-20020a2e3309000000b0027a00aab48fsm24069ljc.66.2022.12.08.16.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 16:11:17 -0800 (PST)
Message-ID: <be1411e8-1d07-7643-977c-a306016fd660@linaro.org>
Date:   Fri, 9 Dec 2022 02:11:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v11 2/5] dt-bindings: msm/dp: add data-lanes and
 link-frequencies property
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        airlied@gmail.com
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1670539015-11808-1-git-send-email-quic_khsieh@quicinc.com>
 <1670539015-11808-3-git-send-email-quic_khsieh@quicinc.com>
 <5a3865ed-8847-db04-3d60-f35438250bef@linaro.org>
 <5aa16223-dbf6-996c-1985-794302dcce91@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <5aa16223-dbf6-996c-1985-794302dcce91@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2022 01:38, Kuogee Hsieh wrote:
> 
> On 12/8/2022 3:33 PM, Dmitry Baryshkov wrote:
>> On 09/12/2022 00:36, Kuogee Hsieh wrote:
>>> Add both data-lanes and link-frequencies property into endpoint
>>>
>>> Changes in v7:
>>> -- split yaml out of dtsi patch
>>> -- link-frequencies from link rate to symbol rate
>>> -- deprecation of old data-lanes property
>>>
>>> Changes in v8:
>>> -- correct Bjorn mail address to kernel.org
>>>
>>> Changes in v10:
>>> -- add menu item to data-lanes and link-frequecnis
>>>
>>> Changes in v11:
>>> -- add endpoint property at port@1
>>>
>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>`
>>
>> Applying: dt-bindings: msm/dp: add data-lanes and link-frequencies 
>> property
>> .git/rebase-apply/patch:47: trailing whitespace.
>>
>> .git/rebase-apply/patch:51: trailing whitespace.
>>
>>
>> Also the dt_binding_check fails with an error for this schema. And 
>> after fixing the error in the schema I faced an example validation 
>> error. Did you check that the schema is correct and that the example 
>> validates against the schema?
> 
> yes, but i run "make dt_binding_check 
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/msm/dp-controller.yaml" at mu v5.15 branch since

I wouldn't ask you to post the log here. But I don't think that either 
of the errors that I see here is related to 5.15 vs 6.1-rc.

In fact after applying this patch against 5.15 I saw the expected failure:

Documentation/devicetree/bindings/display/msm/dp-controller.yaml: 
properties:required: ['port@0', 'port@1'] is not of type 'object', 'boolean'
Documentation/devicetree/bindings/display/msm/dp-controller.yaml: 
properties: 'required' should not be valid under {'$ref': 
'#/definitions/json-schema-prop-names'}
Documentation/devicetree/bindings/display/msm/dp-controller.yaml: 
ignoring, error in schema: properties: required

> 
> "make dt_binding_check" does not work at msm-next branch.

I went ahead and just checked.

`make dt_binding_check DT_SCHEMA_FILES=display/msm`  works cleanly in 
msm-next and reports a single example-related warning in msm-next-lumag. 
I pushed a patch to fix that warning (wich can hopefully be picked up by 
Abhinav into msm-fixes). So you can assume that both these branches have 
consistent error-free display/msm schemas.

> 
> But I did not check trainiling whitespace this time.
> 
>>
>>> ---
>>>   .../bindings/display/msm/dp-controller.yaml        | 27 
>>> ++++++++++++++++++++++
>>>   1 file changed, 27 insertions(+)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml 
>>> b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> index f2515af..2a7fdef8 100644
>>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> @@ -81,6 +81,7 @@ properties:
>>>       data-lanes:
>>>       $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    deprecated: true
>>>       minItems: 1
>>>       maxItems: 4
>>>       items:
>>> @@ -96,6 +97,7 @@ properties:
>>>       ports:
>>>       $ref: /schemas/graph.yaml#/properties/ports
>>> +
>>>       properties:
>>>         port@0:
>>>           $ref: /schemas/graph.yaml#/properties/port
>>> @@ -105,6 +107,29 @@ properties:
>>>           $ref: /schemas/graph.yaml#/properties/port
>>>           description: Output endpoint of the controller
>>>   +        properties:
>>> +          endpoint:
>>> +            $ref: /schemas/media/video-interfaces.yaml#
>>> +
>>> +            properties:
>>> +              remote-endpoint: true
>>
>> PLease add empty lines between the property definitions
>>
>>> +              data-lanes:
>>> +                $ref: /schemas/types.yaml#/definitions/uint32-array
>>
>> This is already a part of video-interfaces, so you don't need $ref
>>
>>> +                minItems: 1
>>> +                maxItems: 4
>>> +                items:
>>> +                  maximum: 3
>>
>> enum: [0, 1, 2, 3]
>>
>>> +              link-frequencies:
>>> +                $ref: /schemas/types.yaml#/definitions/uint64-array
>>> +                minItems: 1
>>> +                maxItems: 4
>>> +                items:
>>> +                  maximum: 8100000000
>>
>> I think we can have enum here too.
>>
>>> +
>>> +  required:
>>> +    - port@0
>>> +    - port@1
>>> +
>>>   required:
>>>     - compatible
>>>     - reg
>>> @@ -193,6 +218,8 @@ examples:
>>>                   reg = <1>;
>>>                   endpoint {
>>>                       remote-endpoint = <&typec>;
>>> +                    data-lanes = <0 1>;
>>> +                    link-frequencies = /bits/ 64 <1620000000 
>>> 2700000000 5400000000 8100000000>;
>>>                   };
>>>               };
>>>           };
>>

-- 
With best wishes
Dmitry

