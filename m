Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FB562EE01
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiKRG5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240662AbiKRG5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:57:00 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4341152
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:56:59 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g12so7787546wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8e6rRpvY1utUAM1R1YfWwwuUchnWq32QH8sI3dudXPg=;
        b=f2FtTNvIEOxpR4zIofkbg9K2ZiAzfj0uUyeFw5/i9nRu5yazy4hoVq+LFTkFKhGWln
         r1jkxXZ/stDuUVtgukxi47AtvUEpl5NFpYvoGnDrMKj6XKHF1JBMwXElY6B/uFE4In93
         fC+q0L7gZamfMkq8bIvzU2sms1RfZq0rnzZOYT3KMUVDSq+3wjoBS18MaBNhdL0BaH9+
         N6PacWzgkFqU/nisYUYdtcMzj1Fx+Z874GEIg+qcs4wqStpN8Dj28XLB/2s3dmJJOOzS
         ZoUJoNnAL3l2s/0WZhxbHAf9SFH1z4T9warsXfDEmMMDDAY2Zq4wTvO0+AEwjXl1BINH
         VF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8e6rRpvY1utUAM1R1YfWwwuUchnWq32QH8sI3dudXPg=;
        b=Ti8IJr2CJn0CWnDlKjgqECnkA0Qh5bJyeg9tTQd5Z/pAFDknQpqh3MoENR3DEdDS4F
         FGGmsMdZEn8lhaZwkUrpO/lrHaeqAxrKVMFIwKTCrEBGDDA3zMU+VAMoOa05FJVvwmyB
         eV3yX37LF1tByK9p1uYjaXggpdEnOSyfsSBeB1emGOMrU7Jcby9EXIpxmYmZhAqukZVL
         sqjpbyXOP6U1VTv/qYOQh7vjlWon+veOYo6wVZFyx9nAUDT4+b5zUK0w50rLaKAhpVBx
         qweKqzaly9pZNkA75lt+k7QqDHKiupQQf3sxRme2yxGTydwKUCHdgHa2+dld37T4QJFZ
         R8Ug==
X-Gm-Message-State: ANoB5pla/9GZRjkKlS4yQkXgLePfRBtnaN1AZ6pyBXuHc9dSx4uR/guq
        7m9ue2+EYJGwYKFqrG3S/fRb9w==
X-Google-Smtp-Source: AA0mqf4NVcmP6MCkOZV0FixgkVpInlUhb9xP5GP2pFw3rwQWyUmfKZ6q+vOdvnzk/Th4LDU/1Ybnzw==
X-Received: by 2002:adf:e3cd:0:b0:241:bc27:f8b6 with SMTP id k13-20020adfe3cd000000b00241bc27f8b6mr2589924wrm.367.1668754617597;
        Thu, 17 Nov 2022 22:56:57 -0800 (PST)
Received: from [192.168.22.132] ([167.98.215.174])
        by smtp.googlemail.com with ESMTPSA id m29-20020a05600c3b1d00b003c6b7f5567csm13771670wms.0.2022.11.17.22.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 22:56:56 -0800 (PST)
Message-ID: <6ca00c5f-a405-da68-8286-fd6d02138c30@linaro.org>
Date:   Fri, 18 Nov 2022 06:56:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: lpass-va: add npl clock for new VA
 macro
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
References: <20221115105541.16322-1-srinivas.kandagatla@linaro.org>
 <20221115105541.16322-2-srinivas.kandagatla@linaro.org>
 <f3a6a7b1-b196-0abb-0c18-8a13908c6891@linaro.org>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <f3a6a7b1-b196-0abb-0c18-8a13908c6891@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Krzystof,

On 15/11/2022 14:21, Krzysztof Kozlowski wrote:
> On 15/11/2022 11:55, Srinivas Kandagatla wrote:
>> LPASS VA Macro now has soundwire master to deal with access to
>> analog mic in low power island use cases. This also means that VA macro
>> now needs to get hold of the npl clock too. Add clock bindings required
>> for this.
>>
>> As part of adding this bindings, also update bindings to be able to
>> specific and associate the clock names specific to the SoC.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/sound/qcom,lpass-va-macro.yaml   | 72 ++++++++++++++++---
>>   1 file changed, 64 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
>> index c36caf90b837..848e34111df1 100644
>> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
>> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
>> @@ -27,16 +27,13 @@ properties:
>>       const: 0
>>   
>>     clocks:
>> -    maxItems: 3
>> +    minItems: 1
>> +    maxItems: 4
>> +
>>   
>>     clock-names:
>> -    oneOf:
>> -      - items:   #for ADSP based platforms
>> -          - const: mclk
>> -          - const: core
>> -          - const: dcodec
>> -      - items:   #for ADSP bypass based platforms
>> -          - const: mclk
>> +    minItems: 1
>> +    maxItems: 4
>>   
>>     clock-output-names:
>>       maxItems: 1
>> @@ -61,6 +58,65 @@ required:
>>     - reg
>>     - "#sound-dai-cells"
>>   
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,sc7280-lpass-va-macro
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 1
> 
> You can skip minItems here.

I have addressed all the comments including this, will send a v2 with 
these changes.

--srini
> 
>> +          maxItems: 1
>> +        clock-names:
>> +          items:
>> +            - const: mclk
>> +      required:
>> +        - clock-names
>> +        - clocks
> 
> IIUC, all variants require now clocks, so these two lines should be part
> of top level "required:".
> 
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,sm8250-lpass-va-macro
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 3
>> +          maxItems: 3
>> +        clock-names:
>> +          items:
>> +            - const: mclk
>> +            - const: core
>> +            - const: dcodec
>> +      required:
>> +        - clock-names
>> +        - clocks
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sc8280xp-lpass-va-macro
>> +              - qcom,sm8450-lpass-va-macro
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 4
>> +          maxItems: 4
>> +        clock-names:
>> +          items:
>> +            - const: mclk
>> +            - const: npl
> 
> How about making it the last clock so the order matches with sm8250?
> 
> 
> Best regards,
> Krzysztof
> 
