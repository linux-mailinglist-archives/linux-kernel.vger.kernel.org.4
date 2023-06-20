Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A749B736C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjFTNAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjFTNAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:00:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3E519A2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:00:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-307d58b3efbso3709183f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687266003; x=1689858003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+elCcDfXZKuzDxi8bk9krk/t0/AVdCFoDUPSesylM0=;
        b=x9OMHTeXkE4gRObSwizT9qOmCj7avu5YFmrDEXhpwXqGRkRBCVAx9PGebZ+qEM3RDZ
         OvOgc7z0BeNlQdEsytlaLHZKwfmTP33fsNW6PJw8ZqAyFkXv18FMyk1DAut2nMN5JH/I
         zfNgBTR87OXG+4VydFkH32FlNYPGw9iKUJbAMWzHhTvNAEn3gwq/DajenzDfMflyfTCr
         AOsXZKoNUwCX8BN+56D093RNgyDZdDrRkC4hv61wAltfIvdCZ5Mh5YrI2UvFRcQoobA7
         e8UauKvf12qTrcdQ58msGnWJb8Vtb4sowzs/nKPy83OCl/aHK9PsYoALzgKcL/mQWVAb
         7yRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687266003; x=1689858003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+elCcDfXZKuzDxi8bk9krk/t0/AVdCFoDUPSesylM0=;
        b=Xpls8E+jBxSjJ/rfLG4nFHlJR0y/xlzHlJWKLjWOmtHWagFiWzIOEG8X9kG3XSKbrk
         b8I06Umr9DE/UUpy2laCWMWRklEfJyd04Kuo7KY0ocCY7LvawQSDlOErI9hJLK9Uzw7c
         5wmi2jtCqRXPjMZc0weUwFP/meRWISJQ2KNZg2p2DeS6MFZvL/AtgJ7ftvAiExEmwSf1
         le/KXJBWz0X58AYkqelLVJp54rDwEHT6Ms3qK7OzV4zDiw4naziGlro+XpL/OMjl9fvM
         u0bmQk82hZjHvYoRBXhnUfSl1KBeegXQLVwZNDaU3el9eioslgvqYtMLokDMVpNVO0EN
         xvEg==
X-Gm-Message-State: AC+VfDw5Ugh3aNe2s9oSjftE4siZpc5+lUXPZDK8fcEEXPVM96zedYve
        hsOFIqaX2v6iPdYYu1Wjm9Njng==
X-Google-Smtp-Source: ACHHUZ7+RTCp6Fqh2DGFZd4QI8q4rCVwvR1dP1d4BsM+sEN9iT/ExN2dSH4aidrmOPnQaMslTcJQwg==
X-Received: by 2002:adf:df12:0:b0:30d:af7c:5046 with SMTP id y18-20020adfdf12000000b0030daf7c5046mr7667598wrl.60.1687266003293;
        Tue, 20 Jun 2023 06:00:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e14-20020adfef0e000000b0030c2e3c7fb3sm1930310wro.101.2023.06.20.06.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:00:02 -0700 (PDT)
Message-ID: <cb2dd67a-d3df-f194-6595-789d12b38f3d@linaro.org>
Date:   Tue, 20 Jun 2023 15:00:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/6] media: dt-bindings: mediatek,vcodec: Remove
 VDEC_SYS for mt8183
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230620000349.2122191-1-nfraprado@collabora.com>
 <20230620000349.2122191-4-nfraprado@collabora.com>
 <8b5e4a9b-7496-02a1-d3b6-a0be8ea85798@linaro.org>
 <a82b7f2d-04d4-4ac0-9a72-ad1c17118e19@notapiano>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a82b7f2d-04d4-4ac0-9a72-ad1c17118e19@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2023 14:46, Nícolas F. R. A. Prado wrote:
> On Tue, Jun 20, 2023 at 10:12:14AM +0200, Krzysztof Kozlowski wrote:
>> On 20/06/2023 02:03, Nícolas F. R. A. Prado wrote:
>>> The binding expects the first register space to be VDEC_SYS. But on
>>> mt8183, which uses the stateless decoders, this space is used only for
>>> controlling clocks and resets, which are better described as separate
>>> clock-controller and reset-controller nodes.
>>>
>>> In fact, in mt8173's devicetree there are already such separate
>>> clock-controller nodes, which cause duplicate addresses between the
>>> vdecsys node and the vcodec node. But for this SoC, since the stateful
>>> decoder code makes other uses of the VDEC_SYS register space, it's not
>>> straightforward to remove it.
>>>
>>> In order to avoid the same address conflict to happen on mt8183,
>>> since the only current use of the VDEC_SYS register space in
>>> the driver is to read the status of a hardware controlled clock, remove
>>> the VDEC_SYS register space from the binding and describe an extra
>>> syscon that will be used to directly check the hardware status.
>>>
>>> Also add reg-names to be able to tell that this new register schema is
>>> used, so the driver can keep backward compatibility.
>>>
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>
>>> ---
>>> I dropped the tags from this commit since a syscon is now used instead
>>> of an extra clock.
>>>
>>> Changes in v3:
>>> - Removed the active clock
>>> - Added a mediatek,vdecsys syscon property
>>>
>>> Changes in v2:
>>> - Merged with patch 1 (media: dt-bindings: mediatek,vcodec: Allow single
>>>   clock for mt8183) to avoid changing number of clocks twice
>>> - Added maxItems to reg-names
>>> - Constrained clocks for each compatible
>>> - Reordered properties for each compatible
>>>
>>>  .../media/mediatek,vcodec-decoder.yaml        | 30 +++++++++++++++++++
>>>  1 file changed, 30 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
>>> index 1e56ece44aee..2f625c50bbfe 100644
>>> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
>>> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
>>> @@ -21,8 +21,13 @@ properties:
>>>        - mediatek,mt8183-vcodec-dec
>>>  
>>>    reg:
>>> +    minItems: 11
>>>      maxItems: 12
>>>  
>>> +  reg-names:
>>> +    minItems: 11
>>> +    maxItems: 11
>>
>> maxItems: 12
>>
>>> +
>>>    interrupts:
>>>      maxItems: 1
>>>  
>>> @@ -60,6 +65,10 @@ properties:
>>>      description:
>>>        Describes point to scp.
>>>  
>>> +  mediatek,vdecsys:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: Phandle to the vdecsys syscon node.
>>> +
>>>  required:
>>>    - compatible
>>>    - reg
>>> @@ -79,8 +88,26 @@ allOf:
>>>      then:
>>>        required:
>>>          - mediatek,scp
>>> +        - mediatek,vdecsys
>>>  
>>>        properties:
>>> +        reg:
>>> +          maxItems: 11
>>> +
>>> +        reg-names:
>>> +          items:
>>> +            - const: misc
>>> +            - const: ld
>>> +            - const: top
>>> +            - const: cm
>>> +            - const: ad
>>> +            - const: av
>>> +            - const: pp
>>> +            - const: hwd
>>> +            - const: hwq
>>> +            - const: hwb
>>> +            - const: hwg
>>> +
>>>          clocks:
>>>            minItems: 1
>>>            maxItems: 1
>>> @@ -101,6 +128,9 @@ allOf:
>>>          - mediatek,vpu
>>>  
>>>        properties:
>>> +        reg:
>>> +          minItems: 12
>>
>>
>> What about reg-names here? They should be also defined and in sync with
>> regs.
> 
> That's intentional. As described in the commit message, mt8173 will keep having
> the VDEC_SYS iospace, while mt8183 won't. And we use the presence of reg-names
> to tell them apart.
> 
> So, mt8173 has 12 regs, no reg-names and no syscon, while mt8183 has 11 regs,
> with reg-names and the syscon.

reg-names is not the way to tell apart variants. Compatible is. If you
add reg-names for one variant, it's expected to have it defined for
other as well, because the order of items in reg is always fixed.

Best regards,
Krzysztof

