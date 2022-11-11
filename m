Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5868625F94
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiKKQfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbiKKQfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:35:09 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CB9833BE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:35:08 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i10-20020a1c3b0a000000b003cfd36eff5fso825135wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLecHsefSGwTn9OHylqjdg2CdAZ+fI//h3Wum+aYsyY=;
        b=vuKd5X/Zu33J2300xeVTEJMptBmVJg8pwE4EcgBrRhflJwsp9pAXxy7yunna6bVdvS
         F3muHms18Q7avaPWYVemZ60zDLavmZ+hVPMmJ8if/mnmVosRpd2Z7wvUuu31bU+TR1x5
         KfsPH//VuI6xIKaWLj9H5l3cAhzM8U9R/+/ax78gZ9EkTEW0x86MqaxmH4n+pcAuPTF/
         abB8BLvG48bQp5A9QVp4SrkWKejkz72cmd5Vag+W0rJuJS0HygaDI85gJP/zDj0KZace
         fPCf143+O3+mOjRc0u1wmGFF//Yn3lvuu7FrrRn3QHW9AnVAUpOmLNLIRGJPVIDr9nGe
         LV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLecHsefSGwTn9OHylqjdg2CdAZ+fI//h3Wum+aYsyY=;
        b=lUw1PspbW64a4CI+Kb6yM+/WorPUwtWKGMCuypPUAHiTvPNK95yNfUPwJhK3InfCyv
         rOqS6ZQPf89VmEZ1N9K/vQKigLVqFyLf4M7Au7fHlbbJbKCCouGuRdxwcSZ0ta9aKqcI
         HZK72xfj2JyWZu9lfN9pClzasSWFB8olCBUIGmFgnRmBS1hxGS5km10x/Pxd4+dVF1pv
         8IeUNW2Gsr54uHr8KclS+iXIIIMeYuSPYKTelvDf7TUeH1nA8FFPKDGoo/Se4a0ZakK4
         5ssi5n3F5GBIBCQfJD62OeoqbDe4UukHhLyrAYHwJwZeh8UV5+E+sLErmhqf+6coUf0L
         hODg==
X-Gm-Message-State: ANoB5plAR8GDDVsOaeRzNTiY/8C/6jGrgsdeJAutLb+YOoket4Xze8dp
        bpjCf4rUiXBOGYVJ2L1fzZciRA==
X-Google-Smtp-Source: AA0mqf5iRWGYftAb/MYMip4SBBbOkKMeTG7lLAQ35eX7p9PjCA11YT4U3IIcJqguyMfeSqERTn64MQ==
X-Received: by 2002:a05:600c:5d5:b0:3cf:74ef:3313 with SMTP id p21-20020a05600c05d500b003cf74ef3313mr1855841wmd.41.1668184506380;
        Fri, 11 Nov 2022 08:35:06 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id i18-20020a5d5592000000b002365921c9aesm2358895wrv.77.2022.11.11.08.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 08:35:05 -0800 (PST)
Message-ID: <5207a28b-9c8c-5014-28c1-15635ad30143@linaro.org>
Date:   Fri, 11 Nov 2022 16:35:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 02/10] ASoC: dt-bindings: qcom,apr: Split services to
 shared schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrick Lai <plai@qti.qualcomm.com>,
        Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>
References: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
 <20221111113547.100442-3-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221111113547.100442-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2022 11:35, Krzysztof Kozlowski wrote:
> The APR/GPR nodes are organized like:
> 
>    apr-or-gpr-device-node <- qcom,apr.yaml
>      apr-gpr-service@[0-9] <- qcom,apr.yaml
>        service-specific-components <- /schemas/sound/qcom,q6*.yaml
> 
> The schema for services (apr-gpr-service@[0-9]) already grows

I have not seen these grow or change alteast in the past 9 years.

Old APR (Elite f/w) and new GPR (AudioReach) interface provides access 
to static services on the DSP.

> considerably and is still quite not specific.  It allows several
> incorrect combinations, like adding a clock-controller to a APM device.

This should be fixed for sure for validation.

We had dedicated bindings per service before.

As the service has changed as part of new AudioReach Firmware, we could 
have added new bindings for these services again. But as we are dealing 
with the same audio hardware and clock resources a new bindings per 
service did not make sense. Since then we moved all the lpass audio 
ports and clocks related bindings to qcom,q6dsp-lpass-clocks.yaml and 
qcom,q6dsp-lpass-ports.yaml.

--srini

> Restricting it would complicate the schema even more.  Bringing new
> support for sound on Qualcomm SM8450 and SC8280XP SoC would grow it as
> well.
> 
> Simplify the qcom,apr.yaml by splitting the services to a shared file
> which will be:
> 1. Referenced by qcom,apr.yaml with additionalProperties:true,
> 2. Referenced by specific bindings for services with
>     additionalProperties:false (not yet in this commit).
> 
> While moving the code, add also required 'reg' and
> 'qcom,protection-domain' to further constrain the bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/soc/qcom/qcom,apr-services.yaml  |  54 +++++++++
>   .../bindings/soc/qcom/qcom,apr.yaml           | 108 +-----------------
>   MAINTAINERS                                   |   2 +-
>   3 files changed, 58 insertions(+), 106 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml
> new file mode 100644
> index 000000000000..290555426c39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/qcom,apr-services.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm APR/GPR services shared parts
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description:
> +  Common parts of a static service in Qualcomm APR/GPR (Asynchronous/Generic
> +  Packet Router).
> +
> +properties:
> +  reg:
> +    minimum: 1
> +    maximum: 13
> +    description: |
> +      APR Service ID
> +        3 = DSP Core Service
> +        4 = Audio  Front End Service.
> +        5 = Voice Stream Manager Service.
> +        6 = Voice processing manager.
> +        7 = Audio Stream Manager Service.
> +        8 = Audio Device Manager Service.
> +        9 = Multimode voice manager.
> +        10 = Core voice stream.
> +        11 = Core voice processor.
> +        12 = Ultrasound stream manager.
> +        13 = Listen stream manager.
> +      GPR Service ID
> +        1 = Audio Process Manager Service
> +        2 = Proxy Resource Manager Service.
> +        3 = AMDB Service.
> +        4 = Voice processing manager.
> +
> +  qcom,protection-domain:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: |
> +      Protection domain service name and path for APR service
> +      possible values are::
> +      "avs/audio", "msm/adsp/audio_pd".
> +      "kernel/elf_loader", "msm/modem/wlan_pd".
> +      "tms/servreg", "msm/adsp/audio_pd".
> +      "tms/servreg", "msm/modem/wlan_pd".
> +      "tms/servreg", "msm/slpi/sensor_pd".
> +
> +required:
> +  - reg
> +  - qcom,protection-domain
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
> index 0a7a34cb2497..9302ffe567d6 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
> @@ -80,115 +80,13 @@ properties:
>     '#size-cells':
>       const: 0
>   
> -#APR/GPR Services
>   patternProperties:
>     "^service@[1-9a-d]$":
>       type: object
> +    $ref: /schemas/soc/qcom/qcom,apr-services.yaml
> +    additionalProperties: true
>       description:
> -      APR/GPR node's client devices use subnodes for desired static port services.
> -
> -    properties:
> -      compatible:
> -        enum:
> -          - qcom,q6core
> -          - qcom,q6asm
> -          - qcom,q6afe
> -          - qcom,q6adm
> -          - qcom,q6apm
> -          - qcom,q6prm
> -
> -      reg:
> -        minimum: 1
> -        maximum: 13
> -        description:
> -          APR Service ID
> -            3 = DSP Core Service
> -            4 = Audio  Front End Service.
> -            5 = Voice Stream Manager Service.
> -            6 = Voice processing manager.
> -            7 = Audio Stream Manager Service.
> -            8 = Audio Device Manager Service.
> -            9 = Multimode voice manager.
> -            10 = Core voice stream.
> -            11 = Core voice processor.
> -            12 = Ultrasound stream manager.
> -            13 = Listen stream manager.
> -          GPR Service ID
> -            1 = Audio Process Manager Service
> -            2 = Proxy Resource Manager Service.
> -            3 = AMDB Service.
> -            4 = Voice processing manager.
> -
> -      clock-controller:
> -        $ref: /schemas/sound/qcom,q6dsp-lpass-clocks.yaml#
> -        description: Qualcomm DSP LPASS clock controller
> -        unevaluatedProperties: false
> -
> -      dais:
> -        type: object
> -        oneOf:
> -          - $ref: /schemas/sound/qcom,q6apm-dai.yaml#
> -          - $ref: /schemas/sound/qcom,q6dsp-lpass-ports.yaml#
> -          - $ref: /schemas/sound/qcom,q6asm-dais.yaml#
> -        unevaluatedProperties: false
> -        description: Qualcomm DSP audio ports
> -
> -      routing:
> -        type: object
> -        $ref: /schemas/sound/qcom,q6adm-routing.yaml#
> -        unevaluatedProperties: false
> -        description: Qualcomm DSP LPASS audio routing
> -
> -      qcom,protection-domain:
> -        $ref: /schemas/types.yaml#/definitions/string-array
> -        description: protection domain service name and path for apr service
> -          possible values are
> -          "avs/audio", "msm/adsp/audio_pd".
> -          "kernel/elf_loader", "msm/modem/wlan_pd".
> -          "tms/servreg", "msm/adsp/audio_pd".
> -          "tms/servreg", "msm/modem/wlan_pd".
> -          "tms/servreg", "msm/slpi/sensor_pd".
> -
> -    allOf:
> -      - if:
> -          properties:
> -            compatible:
> -              enum:
> -                - qcom,q6afe
> -        then:
> -          properties:
> -            dais:
> -              properties:
> -                compatible:
> -                  const: qcom,q6afe-dais
> -
> -      - if:
> -          properties:
> -            compatible:
> -              enum:
> -                - qcom,q6apm
> -        then:
> -          properties:
> -            dais:
> -              properties:
> -                compatible:
> -                  enum:
> -                    - qcom,q6apm-dais
> -                    - qcom,q6apm-lpass-dais
> -
> -      - if:
> -          properties:
> -            compatible:
> -              enum:
> -                - qcom,q6asm
> -        then:
> -          properties:
> -            dais:
> -              properties:
> -                compatible:
> -                  const: qcom,q6asm-dais
> -
> -    additionalProperties: false
> +      APR/GPR static port services.
>   
>   required:
>     - compatible
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3df7b9a3f5ba..804e4a700477 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16893,7 +16893,7 @@ M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>   M:	Banajit Goswami <bgoswami@quicinc.com>
>   L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>   S:	Supported
> -F:	Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
> +F:	Documentation/devicetree/bindings/soc/qcom/qcom,apr*
>   F:	Documentation/devicetree/bindings/sound/qcom,*
>   F:	drivers/soc/qcom/apr.c
>   F:	include/dt-bindings/sound/qcom,wcd9335.h
