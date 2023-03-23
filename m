Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038BF6C60CE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjCWHbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjCWHbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:31:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245141DB97
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:31:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cy23so82522067edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679556690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5ChIbM3Qu9cYE9/JYQEbMbsexRuuRfkau+JfqQg4DI=;
        b=hoS7Fj/0m8P05zkn9Uvr/zp7gy7XRIOimE7oyqwq06TvNS8qGp4hA0WKQ7H0hHvzmf
         8NO1v3C4erwpLr3JtGTHJftXehikibgYEscEhwDpJMF/mgVeafbPeaCRYqjBkEdvxT6q
         YGjsrmj4ffeBXkbszNn/iisu2j8XZeSF4379+hsf5QmzsvCJPHs6bl8pLOcT9XqXTV7D
         cqkk3xT+DQEVUAs7pEklV6HRxK5O3F7O/nN5liE6PZvh4p/zRrniPBt7x1J+lAieCgtZ
         Ytr+rskvynSiZHvuYzFDtZnreklMkHdvmOCOL7DHcVc8ehIHGP+8AVAQU0k6E01SXx4q
         ubIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679556690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5ChIbM3Qu9cYE9/JYQEbMbsexRuuRfkau+JfqQg4DI=;
        b=8G0oI4rEeN9Sxi4DbwfXvpgbcmDO+KChag+vdub3H6kzlx+0Q1jaALc6Mp14kDozIi
         k/F48UsZqI5xJ/2Cny+BuqoNAGq/JUjTnHUWbJVvMXqFtF0bRVKeah5ttQ+3jHV65r1C
         KwPpEOnfvaPMdzIPXNk1p/1t7mxnLIpbCYVIkwl+DvVWS4rPTsIdKt+2eJcVNixTc94Z
         PCejNBgc7M9a7L0tr+9zBR5I4Rtir7nSb69MHKy4HY5NPqaTh7oE6ELrG1h2dlg/8fIx
         QjHCZTqHXy+4oEkvwDvUZWctnP+QC+g6p59RrOhsSlaEeNn0ZNeMz7e/wi0IrhvjcoYF
         Tifg==
X-Gm-Message-State: AO0yUKXdX3GbBpeQ80XuDs3A9MS3FnrHqMFSErIK+7WDpwQBZhM3zbEs
        CT0UdaBLeqiTrRUbVFjRszSC2g==
X-Google-Smtp-Source: AK7set/u84Igs1dO94sjxb6l3wT4qaQBKY13NHmmVCto22WbyjOAs4OzumOGHYX91oGEEdGwUZ7Xyw==
X-Received: by 2002:a17:906:5a8f:b0:931:41af:8ecb with SMTP id l15-20020a1709065a8f00b0093141af8ecbmr9061709ejq.49.1679556690656;
        Thu, 23 Mar 2023 00:31:30 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a665:ed1e:3966:c991? ([2a02:810d:15c0:828:a665:ed1e:3966:c991])
        by smtp.gmail.com with ESMTPSA id m20-20020a170906721400b00922b009fc79sm8225490ejk.164.2023.03.23.00.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 00:31:29 -0700 (PDT)
Message-ID: <5c82c731-3124-9eca-32a3-c974db95724a@linaro.org>
Date:   Thu, 23 Mar 2023 08:31:28 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323082758.5e4385ff@bootlin.com>
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

On 23/03/2023 08:27, Herve Codina wrote:
> Hi Krzysztof
> 
> On Wed, 22 Mar 2023 22:59:37 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 22/03/2023 14:46, Herve Codina wrote:
>>> The Lantiq PEF2256 is a framer and line interface component designed to
>>> fulfill all required interfacing between an analog E1/T1/J1 line and the
>>> digital PCM system highway/H.100 bus.
>>>
>>> The codec support allows to use some of the PCM system highway
>>> time-slots as audio channels to transport audio data over the E1/T1/J1
>>> lines.
>>>
>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>>> ---
>>>  .../bindings/sound/lantiq,pef2256-codec.yaml  | 54 +++++++++++++++++++
>>>  1 file changed, 54 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
>>> new file mode 100644
>>> index 000000000000..da35b70cda99
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
>>> @@ -0,0 +1,54 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/sound/lantiq,pef2256-codec.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Lantiq PEF2256 codec
>>> +
>>> +maintainers:
>>> +  - Herve Codina <herve.codina@bootlin.com>
>>> +
>>> +description: |
>>> +  Codec support for PEF2256.
>>> +
>>> +  The Lantiq PEF2256, also known as Infineon PEF2256 or FALC56, is a framer and
>>> +  line interface component designed to fulfill all required interfacing between
>>> +  an analog E1/T1/J1 line and the digital PCM system highway/H.100 bus.
>>> +
>>> +  The codec support allows to use some of the PCM system highway time-slots as
>>> +  audio channels to transport audio data over the E1/T1/J1 lines.
>>> +
>>> +  The time-slots used by the codec must be set and so, the properties
>>> +  'dai-tdm-slot-num', 'dai-tdm-slot-width', 'dai-tdm-slot-tx-mask' and
>>> +  'dai-tdm-slot-rx-mask' must be present in the ALSA sound card node for
>>> +  sub-nodes that involve the codec. The codec uses 8bit time-slots.
>>> +  'dai-tdm-tdm-slot-with' must be set to 8.
>>> +  The tx and rx masks define the PEF2256 time-slots assigned to the codec.
>>> +
>>> +  The PEF2256 codec node should be a child of a PEF2256 node.
>>> +  Refer to the bindings described in
>>> +  Documentation/devicetree/bindings/mfd/lantiq,pef2256.yaml
>>> +
>>> +allOf:
>>> +  - $ref: dai-common.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: lantiq,pef2256-codec
>>> +
>>> +  '#sound-dai-cells':
>>> +    const: 0  
>>
>> You do not have here any resources, so the entire binding can be dropped
>> and merged into the parent.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Ok,
> Do you expect all these properties (except compatible) merged at the parent

You have only two properties here - dai cells and name-prefix...

> level or may I keep a child node with these properties including the
> compatible property (ie. yaml file merge).

I was thinking that these should be merged into parent because usually
you do not need child node for this. However now I started to think how
the codec driver would look like. Essentially the parent MFD driver
would need to register dais...

Best regards,
Krzysztof

