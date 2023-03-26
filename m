Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FB36C942C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjCZMVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCZMVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:21:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0267F6E89
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:21:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r11so25113608edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679833310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVP0q5GOX/hLCywa6jLtgJqXWgfu/GbW40t0aFqMMo8=;
        b=YLxk8yxVs1fPjuNnGaFCwQLNGp3e7Y/9Wg2D2IGIguuWdDBgnDYUF9VPitxIDLtMtj
         I4QT4K+o45AVEGQHhcnF3whlyuyKgOs+J65ZF1MYR1ru/sUvUXAYGH95tJHojhPpQDr2
         Xn7O9+g2JOZfjRO6rg0U/ZfG0nLzXQKVGcwOLkJivyd8ZhioI399UH5Neu6or37dsNUb
         HzcCadOOo3Xj76tIWFD9zAqqkMrpyamrQPYvpfRgVB47rehLXo2mF0OKNBk0NNFqL+Xm
         i3SfwBCkKvTQOqjw0m7tZWRMeHtYl3ABn7vkRBL/oKXNGcQjENXVCkwQVgIf698d8T1Z
         5ZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679833310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVP0q5GOX/hLCywa6jLtgJqXWgfu/GbW40t0aFqMMo8=;
        b=17zcuayITf0wgb9BxmLuY5ijSCjK5HpRb0sWXpal/15koANH9jwLvfdvR9fs5RbFZI
         Cabrp8WYS/rzH3B8GTPXEly6wh1rpo58lOcr6uGCuH0VPEFIYMhyp3xyakyxJYCbkudi
         1Nq71fQKpgpxnqMOyMAr210Ejc6nlikGbVNbVOv4hbHUOgXEjModfq0zCB9chJInu2A9
         5lqNVncHYpTqZjQpSFJa2iSdfZ+UujR+E7g/ZPJjhBEepJGl9jCbhznm+qYcXL9lBSBL
         Wvhvb4PhYxho95wbDKPkbTQIILxSMMP24XSFeqs+6dRpTagJkyuz6OUEcc8Fu2jkDq8T
         t00w==
X-Gm-Message-State: AAQBX9euG+/uIYH9v9YYcnanr10QlFn3eLdCTyb2Wihlk09wlXXP4o5d
        7rARBUV8whP7DjPTbxT76aWlyA==
X-Google-Smtp-Source: AKy350Z8Nm7ZuAbyxo/SHlOyBboWAXg4VgdJyW1Y8DzvipW26/qtmBdXEYn3fSxRT59u2Qgrogs/tg==
X-Received: by 2002:aa7:cd8b:0:b0:501:d3a1:9a52 with SMTP id x11-20020aa7cd8b000000b00501d3a19a52mr9063096edv.33.1679833310350;
        Sun, 26 Mar 2023 05:21:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6cac:926d:a4f2:aa09? ([2a02:810d:15c0:828:6cac:926d:a4f2:aa09])
        by smtp.gmail.com with ESMTPSA id ha8-20020a170906a88800b0093a6c591743sm7515800ejb.69.2023.03.26.05.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 05:21:49 -0700 (PDT)
Message-ID: <a0e15e8c-06d8-664a-a0ed-49361afdc078@linaro.org>
Date:   Sun, 26 Mar 2023 14:21:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/6] dt-bindings: sound: Add support for the Lantiq
 PEF2256 codec
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230322134654.219957-1-herve.codina@bootlin.com>
 <20230322134654.219957-5-herve.codina@bootlin.com>
 <cf87e7c0-b769-d1fc-0718-c5c2986993b8@linaro.org>
 <20230323082758.5e4385ff@bootlin.com>
 <5c82c731-3124-9eca-32a3-c974db95724a@linaro.org>
 <20230323091001.100ca343@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323091001.100ca343@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 09:10, Herve Codina wrote:
> On Thu, 23 Mar 2023 08:31:28 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 23/03/2023 08:27, Herve Codina wrote:
>>> Hi Krzysztof
>>>
>>> On Wed, 22 Mar 2023 22:59:37 +0100
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>   
>>>> On 22/03/2023 14:46, Herve Codina wrote:  
>>>>> The Lantiq PEF2256 is a framer and line interface component designed to
>>>>> fulfill all required interfacing between an analog E1/T1/J1 line and the
>>>>> digital PCM system highway/H.100 bus.
>>>>>
>>>>> The codec support allows to use some of the PCM system highway
>>>>> time-slots as audio channels to transport audio data over the E1/T1/J1
>>>>> lines.
>>>>>
>>>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>>>>> ---
>>>>>  .../bindings/sound/lantiq,pef2256-codec.yaml  | 54 +++++++++++++++++++
>>>>>  1 file changed, 54 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..da35b70cda99
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
>>>>> @@ -0,0 +1,54 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/sound/lantiq,pef2256-codec.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Lantiq PEF2256 codec
>>>>> +
>>>>> +maintainers:
>>>>> +  - Herve Codina <herve.codina@bootlin.com>
>>>>> +
>>>>> +description: |
>>>>> +  Codec support for PEF2256.
>>>>> +
>>>>> +  The Lantiq PEF2256, also known as Infineon PEF2256 or FALC56, is a framer and
>>>>> +  line interface component designed to fulfill all required interfacing between
>>>>> +  an analog E1/T1/J1 line and the digital PCM system highway/H.100 bus.
>>>>> +
>>>>> +  The codec support allows to use some of the PCM system highway time-slots as
>>>>> +  audio channels to transport audio data over the E1/T1/J1 lines.
>>>>> +
>>>>> +  The time-slots used by the codec must be set and so, the properties
>>>>> +  'dai-tdm-slot-num', 'dai-tdm-slot-width', 'dai-tdm-slot-tx-mask' and
>>>>> +  'dai-tdm-slot-rx-mask' must be present in the ALSA sound card node for
>>>>> +  sub-nodes that involve the codec. The codec uses 8bit time-slots.
>>>>> +  'dai-tdm-tdm-slot-with' must be set to 8.
>>>>> +  The tx and rx masks define the PEF2256 time-slots assigned to the codec.
>>>>> +
>>>>> +  The PEF2256 codec node should be a child of a PEF2256 node.
>>>>> +  Refer to the bindings described in
>>>>> +  Documentation/devicetree/bindings/mfd/lantiq,pef2256.yaml
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: dai-common.yaml#
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: lantiq,pef2256-codec
>>>>> +
>>>>> +  '#sound-dai-cells':
>>>>> +    const: 0    
>>>>
>>>> You do not have here any resources, so the entire binding can be dropped
>>>> and merged into the parent.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>  
>>>
>>> Ok,
>>> Do you expect all these properties (except compatible) merged at the parent  
>>
>> You have only two properties here - dai cells and name-prefix...
>>
>>> level or may I keep a child node with these properties including the
>>> compatible property (ie. yaml file merge).  
>>
>> I was thinking that these should be merged into parent because usually
>> you do not need child node for this. However now I started to think how
>> the codec driver would look like. Essentially the parent MFD driver
>> would need to register dais...
>>
> 
> There is also something specific to audio, the slots definition
> 'dai-tdm-slot-tx-mask' and 'dai-tdm-slot-rx-mask'. These slots definitions
> are set at the ALSA sound card sub-nodes.
> So, I can have multiple codec in the PEF2256.
> 
> For instance:
>   framer {
>     compatible = "lantiq,pef2256", "simple-mfd";
>     ...
>     pef2256_codec0: codec0 {
>       compatible = "lantiq,pef2256-codec";
>       #sound-dai-cells = <0>;
>     };
>     pef2256_codec1: codec1 {
>       compatible = "lantiq,pef2256-codec";
>       #sound-dai-cells = <0>;
>     };
>   };

Then include it in the example. It would cut short this discussion.


Best regards,
Krzysztof

