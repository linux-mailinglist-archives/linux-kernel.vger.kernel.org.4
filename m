Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBD669AE00
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBQOYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBQOYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:24:52 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890159779
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 06:24:50 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id eg30so4666932edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 06:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFjYG4jLURw1kYo7ShDSCBnd1OYlrQohbQF4zsR/gVk=;
        b=OJ7TQIHzJQsa9/EIpru1db+VCZ+X8QPOmP8Ua+5RufEjNaROgv5Dn9z0CgKGtVsa7X
         CNn1AyalhSJZY4Yyk818UgKQh8HiZo36uePEcFO6JiJavsq/SrbxryXvtXI2qPYjBsHQ
         GuF9Erxp4Uz3LxkoIF0rKcclWfy+iF8GSohzT0lI2imelyWfBKATTefqn5GExQgtaAox
         tzoYg81uHbP/ty0VRPfsz8fo4qWr22tRn3VwyvCUoZYcAhIhl3Zt8kUoa6pAOdOIw02F
         afh8zWhUZBDzuP3pY1+DT4w6RnVe70qzP41d4lnTSKDyX1AZljqUeG2KLhdEEUsxB0u+
         /t9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFjYG4jLURw1kYo7ShDSCBnd1OYlrQohbQF4zsR/gVk=;
        b=dbgwKEaZjn4amNYY61+2oGtgibVIAXKx9D9V6cMZNeQ85T4o5aErnq0guKaFASbExv
         HWUcAt0JqK3e1/8ejlQgbERLZa8o+97uH4nnT0+M3I6zhilGLR9dWpq2qK11leiIEliF
         4ujeITazRq8ZAn7RFvdUiaBtdsBA8bMnVz2WmjUAl65VKLA+Co7xZUjZvl2xMKNbK0la
         MpL+yFJuvTTSAqm++URYSeKRbVDjwC9vMNLFVIKdY+O1i+32+tOEA6gARsWjTj2iympt
         Xa7C58fgrbDUXFlZc6b4wQA9ZHJGbPdSIDsAVq5mzlfsKjRDl3tshP9u1ApAiwf7fBVY
         hOXw==
X-Gm-Message-State: AO0yUKU0n54NGuAgJ+sElMi3KqWM49v5303KWRU9nSFsemM937Q4kQ3H
        Z73AYTBT69V+aTdH0oCy6Npgag==
X-Google-Smtp-Source: AK7set8cRq4IQx60rnukD9fbsNxxPpGXqav2rSq1nDhiVMKrQpHtAHfPgWf+DofWiP2cGt75L4meVA==
X-Received: by 2002:a17:906:6454:b0:8b1:4507:eec with SMTP id l20-20020a170906645400b008b145070eecmr758694ejn.34.1676643889054;
        Fri, 17 Feb 2023 06:24:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f27-20020a170906139b00b008b14399b74fsm2155741ejc.201.2023.02.17.06.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 06:24:48 -0800 (PST)
Message-ID: <272c1291-dfea-3dcb-9462-5f84c55f7637@linaro.org>
Date:   Fri, 17 Feb 2023 15:24:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 01/10] dt-bindings: soc: fsl: cpm_qe: Add TSA
 controller
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230216134226.1692107-1-herve.codina@bootlin.com>
 <20230216134226.1692107-2-herve.codina@bootlin.com>
 <6ae9af19-1d52-c31f-79be-a36f06caaf80@linaro.org>
 <20230217145019.0def6f9a@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217145019.0def6f9a@bootlin.com>
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

On 17/02/2023 14:50, Herve Codina wrote:
> Hi Krzysztof,
> 
> On Fri, 17 Feb 2023 10:14:48 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 16/02/2023 14:42, Herve Codina wrote:
>>> Add support for the time slot assigner (TSA)
>>> available in some PowerQUICC SoC such as MPC885
>>> or MPC866.
>>>
>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>>> ---
>>>  .../bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml | 234 ++++++++++++++++++
>>>  include/dt-bindings/soc/fsl,tsa.h             |  13 +
>>>  2 files changed, 247 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
>>>  create mode 100644 include/dt-bindings/soc/fsl,tsa.h
> 
> [...]
>>> +
>>> +patternProperties:
>>> +  '^tdm@[0-1]$':
>>> +    description:
>>> +      The TDM managed by this controller
>>> +    type: object
>>> +
>>> +    additionalProperties: false
>>> +
>>> +    properties:
>>> +      reg:
>>> +        minimum: 0
>>> +        maximum: 1
>>> +        description:
>>> +          The TDM number for this TDM, 0 for TDMa and 1 for TDMb
> [...]
>>> +
>>> +      fsl,rx-frame-sync-delay-bits:
>>> +        enum: [0, 1, 2, 3]  
>>
>> maxItems: 1
> 
> The property is an enum
> Why this maxItems value ?

Hm, it's an array, but you are right that enum forces dtschema to
interpret it as scalar value, so your code is correct.
> 
> If I add the maxItems value, I've got some dt_binding_check errors:
>   /xxxx/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml:
>   patternProperties:^tdm@[0-1]$:properties:fsl,rx-frame-sync-delay-bits:
>   'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
> 	hint: Scalar and array keywords cannot be mixed
> 	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

Best regards,
Krzysztof

