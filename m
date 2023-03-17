Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AB96BE499
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjCQI6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjCQI6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:58:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442F89F077
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:57:19 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r11so17609504edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679043434;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lkYcGe56jj6Vu23+F5lwTMBHkX/FmQBfWkqpJWWWYE=;
        b=TlDILzKXaZD0Kq3gq8brL0V9KGYMn1MlUcsJmCQ6N8Os8b0Zb9R/UnDuUmG/Z1mPKX
         ofIXTtCcEXAlKitBVLxXjv8w5NJIxM0HdigIiCosn1JL2dy0BE2mFMlFekkgt9JfWuqZ
         zbEO1CbWvLsAxG8lPWQY7G/LM7vtFj543yyST/CgkV7zVHr3KKyeyPaVNBW57Q8v/Fel
         HLU2OZgzfGUlKC4SmKw79K4q9W7U2hjTP2nHlreP1A0US6L1BRX4ifFuOrLA9XSPgSIn
         k/KRyBvaki4C5dpYWA8ufKiLwqtC76WCvHpHG0NWUnGvumIkQ2Fsnhb5m7B2zwl02kLV
         qQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043434;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lkYcGe56jj6Vu23+F5lwTMBHkX/FmQBfWkqpJWWWYE=;
        b=vNP2szJAHr2KPwrcCmF4R5bGnzgApNmWSTQsTRERpt580N1rEdIhGaMeuRDst833O+
         Ruk2/DfPaUD1pOzkmJ6DD0+MrnqxYNNp+kI9EG9lS6cmzZbdz90egchwbMWwZrJxvU4K
         TLCfdj0GGFQm57xZ/IOWLtImjk157B/9JJA91nWuqzbivboMwEwZbUxfnkjJ2Vpu5Zkp
         BVSmjyMjs2putwIzFTyPKgWkzGjlIeeuJ9QcxJVmUHRuJnm/zOs4ywQL4CnzPVsfIAKF
         /c4Q3cj8TR96fAroqVLUWSsKbQMzt1Mg+HqJsoHsvuheinUJkD8WbgOEhdLeDcD6wmuO
         YVTg==
X-Gm-Message-State: AO0yUKWrULFKj0cdybJRcymDJgAoJqhpBIne444QzYPrg1AEgVJXCqt9
        SKrTXepBP1PVDnPKokVdJlpxsw==
X-Google-Smtp-Source: AK7set/k6Z9YbriJ3jF4jAfkZWdrmAilfpztMLAKLNEFDkO9cZBivKSH+N9TjwPwdkoNNUp4GpKUfA==
X-Received: by 2002:a17:907:2bc3:b0:92a:3b19:9a4c with SMTP id gv3-20020a1709072bc300b0092a3b199a4cmr2409377ejc.27.1679043433773;
        Fri, 17 Mar 2023 01:57:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id w3-20020a50c443000000b004ac54d4da22sm763279edf.71.2023.03.17.01.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:57:13 -0700 (PDT)
Message-ID: <2d4dae57-e46d-7e81-9b56-2148074c8406@linaro.org>
Date:   Fri, 17 Mar 2023 09:57:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/7] dt-bindings: sound: Add support for the Lantiq
 PEF2256 codec
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230316122741.577663-1-herve.codina@bootlin.com>
 <20230316122741.577663-6-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230316122741.577663-6-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 13:27, Herve Codina wrote:
> The Lantiq PEF2256, also known as Infineon PEF2256 or FALC256, is a
> framer and line interface component designed to fulfill all required
> interfacing between an analog E1/T1/J1 line and the digital PCM system
> highway/H.100 bus.
> 
> The codec support allows to use some of the PCM system highway
> time-slots as audio channels to transport audio data over the E1/T1/J1
> lines.
> 

Your other file should also have specific compatible, unless this codec
is actually part of the framer. Did not look like this in the binding -
not $ref.

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/sound/lantiq,pef2256-codec.yaml  | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
> new file mode 100644
> index 000000000000..acba3a0ccd1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/lantiq,pef2256-codec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lantiq PEF2256 codec device

Drop "device". Everything is "device".

> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description: |
> +  Codec support for PEF2256.
> +
> +  The Lantiq PEF2256, also known as Infineon PEF2256 or FALC256, is a framer and
> +  line interface component designed to fulfill all required interfacing between
> +  an analog E1/T1/J1 line and the digital PCM system highway/H.100 bus.
> +
> +  The codec support allows to use some of the PCM system highway time-slots as
> +  audio channels to transport audio data over the E1/T1/J1 lines.
> +
> +  The time-slots used by the codec must be set and so, the properties
> +  'dai-tdm-slot-num', 'dai-tdm-slot-width', 'dai-tdm-slot-tx-mask' and
> +  'dai-tdm-slot-rx-mask' must be present in the ALSA sound card node for
> +  sub-nodes that involve the codec. The codec uses 8bit time-slots.
> +  'dai-tdm-tdm-slot-with' must be set to 8.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: lantiq,pef2256-codec
> +
> +  lantiq,pef2256:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the PEF2256

Why not its child? Why this is in parallel ?

> +
> +  '#sound-dai-cells':
> +    const: 0
> +


Best regards,
Krzysztof

