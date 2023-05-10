Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C09B6FD89B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbjEJHwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbjEJHwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:52:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7841E1FEF
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:51:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9659c5b14d8so1120331566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683705114; x=1686297114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9sZ0/8EovSIVbd5AFaZe/dkBXV3RZ8rTX6k+VIL7rd4=;
        b=e8aIWPr+BEmBTl5Ja69WLppVzCkVAIOoaeeLgvNObfsN5wQLd0YAml7nw0+qZZ1PL0
         UhF4FR8wKNwb5HXVNUyseHYPaBkEAeO7I/Fxw6hZUFeJpydOvePJPb3ohp35suuHDCDw
         QvriOZSDJQisEEvPVNim3W3+0bbGHdkjYz7Ow/qbIRoNUY9s/D0K37beZDaxvOGvSe2Z
         d/uMqO1NFUBNKT78u0Pa0RhJVplJ9pAEbSvb2QFXSUf80a/FgeoIAnjNOYIFhaQzEXyI
         9FMCHwN/C7evyXJOj0YgwPkbIythdN5/kPMzgqqhpY33OCfXu/NL8PDj+89GRNQPZNbO
         Zi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683705114; x=1686297114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sZ0/8EovSIVbd5AFaZe/dkBXV3RZ8rTX6k+VIL7rd4=;
        b=BkZezci7xqsHsTqiNANOCF9kIc1yWWoV6HRaKEUme4eukKhnyYqDEzCt4P2KoGfSFT
         XJyyY4plHht5wCd9WaLDHlP3egkKuJRp9R1fg+toXRvkDYmDDIIa2/MUr/kdERtGmprm
         1+qCmVELp1Uat1PYJ4uqCBMXudToMgziQtjlsmK/amtovcAoWeX+OM6yZTPUtEscLqgH
         hJWc2P1mWbg67wjezmOYZz+5f2SLAqDrto7/Li6aBEFDinwPQkiIJGWoN0tk+KfiTMj7
         K17oQW+4/SFiQQjQsR1eg/KchJuv64EkEx5IpfgSEyLzwkCVnVH9PxIL61L7BqmaWICX
         yAPQ==
X-Gm-Message-State: AC+VfDzfjO/Xtq0uulSbiHVO8jp3X/QFeUdMTIieX6wR4lh1WX1vDbWZ
        qrv8G1iVqxWLvbb+x0FNYjmGDA==
X-Google-Smtp-Source: ACHHUZ6exavcj5UmA9VcbxCwK35ZHL+3F10nUmd/jcwMNBcB51eEB2rJ74He9CSe0YwNB+NB6rHmmA==
X-Received: by 2002:a17:907:8694:b0:96a:1c2a:5a38 with SMTP id qa20-20020a170907869400b0096a1c2a5a38mr1858388ejc.11.1683705113851;
        Wed, 10 May 2023 00:51:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id lf23-20020a170906ae5700b0094ee700d8e4sm2309055ejb.44.2023.05.10.00.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:51:52 -0700 (PDT)
Message-ID: <f38b984c-e49a-0686-a907-5d86ea93d7bc@linaro.org>
Date:   Wed, 10 May 2023 09:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Add adi,ssm3515 amp schema
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230509163828.86003-1-povik+lin@cutebit.org>
 <20230509-marxism-plug-759c99ac601c@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230509-marxism-plug-759c99ac601c@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 20:25, Conor Dooley wrote:
> Hey Martin,
> 
> On Tue, May 09, 2023 at 06:38:27PM +0200, Martin Povišer wrote:
>> Add a DT schema for the SSM3515 amp by Analog Devices. It's a simple
>> mono amplifier with digital input.
>>
>> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
>> ---
>>  .../bindings/sound/adi,ssm3515.yaml           | 66 +++++++++++++++++++
>>  1 file changed, 66 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml b/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
>> new file mode 100644
>> index 000000000000..19b7185ae8e2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
>> @@ -0,0 +1,66 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2019-20 Texas Instruments Incorporated
> 
> Copyright here looks a little odd, copy & paste from the TI bindings you
> send patches for earlier, or intended?
> 
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/sound/adi,ssm3515.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> 
> Drop the quotes on these please.
> 
>> +
>> +title: Analog Devices SSM3515 Audio Amplifier
>> +
>> +maintainers:
>> +  - Martin Povišer <povik+lin@cutebit.org>
>> +
>> +description: |
>> +  SSM3515 is a mono Class-D audio amplifier with digital input.
>> +
>> +  https://www.analog.com/media/en/technical-documentation/data-sheets/SSM3515.pdf
>> +
>> +allOf:
>> +  - $ref: dai-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - adi,ssm3515
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  adi,ana-gain:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1, 2, 3]
>> +    description: |
>> +      The value to be set in the ANA_GAIN register field on the codec. This determines
>> +      the full voltage span of the codec's analog output.
>> +
>> +      To quote the datasheet on the available options:
>> +
>> +        00: 8.4 V Full-Scale Gain Mapping
>> +        01: 12.6 V Full-Scale Gain Mapping
>> +        10: 14 V Full-Scale Gain Mapping
>> +        11: 15 V Full-Scale Gain Mapping
> 
> Putting register values into the DT does not seem correct, although
> I know nothing about sound and will have to defer to Krzysztof & Co. on
> that front.

Depends whether these are really voltages or something else (e.g. gain)
just related to voltage.

Best regards,
Krzysztof

