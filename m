Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FEC69B6B0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBRA0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBRA0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:26:38 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440A268561
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:26:36 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g16so3717589lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iz+PpBCaN2eTF1bAhZ+2tgpCk6bNWDrT4b3aQDTLjn4=;
        b=C0d26VB/UL384OGHWCA1AXRo89XPr0JW09Y0bUgWGjPuT4pq2OCCGxWpqr9sDJiUkY
         MSB5QRvHJSGSDGrk/vlfxhtQCValpz9gpXANpLcU+p5H2Oc9VdszeuPZHz6MedQpKxIX
         eSXaDx5BLPhyMcKa854KKFdJjLpJxjvPMVCnCwO+Y0bl7TWn/TObzR7eYfwnYjku0U9N
         DAceDkHWSuiL+nvkuaHmkizuhe2PfiQ1lO+Xd42kKC3RV3J9mEE8mQ6bmGbEOECGX8mc
         XphU8SljyARdlMtk6jEg/5I4zBdHwKkCy30J+L9l/LUqaMgj1EELHqpcSvNxHs/YJogP
         d1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz+PpBCaN2eTF1bAhZ+2tgpCk6bNWDrT4b3aQDTLjn4=;
        b=5tLIKcU/9ukeLfinjwvMdqq6WIaSYX2WirJ6gJk0ivsy9O2nYKQaS5ej2lh8FkzWKa
         G9zVu3CdyJraE1D1Evg4ChgWnsDXb0foTGS873h9fycl3TALG+UdY2Wr5SocfXJkkSFa
         D8/krj8pqTbLD//n3VwIobnb3eav0QVMwGPYzRDuyTXlVGWZJlb+8ricRokf0r40BJ7N
         tBK7bsmRWdJw+xZ2c+f4IGM1Xi6JKnpWKdGpsJtJz16AF8d+LuyxZBO95R4CSgaW4nvu
         xvJa3Q0ETfHQm5+lhGUWOqbQNWsBdSA8P5PEI5J/4S6UEBCqDNPckX0ogR91YY7Qms1F
         1o5w==
X-Gm-Message-State: AO0yUKVs39h56uFxHu3ZxrmEimwF0/hinSUa9RPrPkgGqxT3n6sJHHuD
        WdzBUEulUCEHmVOh5FFjg1/pdQ==
X-Google-Smtp-Source: AK7set/blEr5tuwakVvUBgDfcxlFT/0GmnlBbcRkf7FavIpGqWDHjeJsNPnY+VrSOFq8PpELXzUChg==
X-Received: by 2002:ac2:4a87:0:b0:4db:2a28:6453 with SMTP id l7-20020ac24a87000000b004db2a286453mr745429lfp.25.1676679994477;
        Fri, 17 Feb 2023 16:26:34 -0800 (PST)
Received: from [192.168.1.101] (abxh184.neoplus.adsl.tpnet.pl. [83.9.1.184])
        by smtp.gmail.com with ESMTPSA id e1-20020a05651c038100b002950ce0ecd0sm143976ljp.114.2023.02.17.16.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 16:26:34 -0800 (PST)
Message-ID: <c2bfa6b0-edee-b492-d40e-cf43291b90d4@linaro.org>
Date:   Sat, 18 Feb 2023 01:26:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v10 2/6] dt-bindings: opp: v2-qcom-level: Document CPR3
 open/closed loop volt adjustment
To:     Rob Herring <robh@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
 <20230217-topic-cpr3h-v10-2-67aed8fdfa61@linaro.org>
 <20230217231330.GA2238521-robh@kernel.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230217231330.GA2238521-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.02.2023 00:13, Rob Herring wrote:
> On Fri, Feb 17, 2023 at 12:08:25PM +0100, Konrad Dybcio wrote:
>> CPR3 and newer can be fed per-OPP voltage adjustment values for both
>> open- and closed-loop paths to make better decisions about settling
>> on the final voltage offset target. Document these properties.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../devicetree/bindings/opp/opp-v2-qcom-level.yaml         | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
>> index a30ef93213c0..93cc88434dfe 100644
>> --- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
>> @@ -34,6 +34,20 @@ patternProperties:
>>          minItems: 1
>>          maxItems: 2
>>  
>> +      qcom,opp-cloop-vadj:
>> +        description: |
>> +          A value representing the closed-loop voltage adjustment value
> 
> A value?
> 
>> +          associated with this OPP node.
>> +        $ref: /schemas/types.yaml#/definitions/int32-array
>> +        maxItems: 2
> 
> Or 2 values?
Right, this description doesn't make any sense if you're just
looking at the documentation without looking at the driver..

Generally, each CPR3 instance can have multiple "threads"
(each one of which regulates voltage for some on-SoC IP or
part of it). The nth entry in the qcom,opp-[co]loop-vadj
array corresponds to a voltage offset for the nth thread.

If the nth entry in the array is missing, the driver assumes
the arr[0] one is "global" to this CPR3 instance at this OPP
level and applies it to all threads. ...and looking at it
again, this is sorta just bad design, especially if you
take into account that there's no known user of CPR3 that
employs more than 2 threads.

I'll remove that from the driver and make the description clearer.


Also, only noticed now.. "qcom,sdm630-cprh" was not documented,
so that's to be fixed for the next submission as well!


Konrad
> 
>> +
>> +      qcom,opp-oloop-vadj:
>> +        description: |
>> +          A value representing the open-loop voltage adjustment value
>> +          associated with this OPP node.
>> +        $ref: /schemas/types.yaml#/definitions/int32-array
>> +        maxItems: 2
>> +
>>      required:
>>        - opp-level
>>        - qcom,opp-fuse-level
>>
>> -- 
>> 2.39.1
>>
