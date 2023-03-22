Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEBB6C5931
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCVV7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCVV7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:59:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5504EC54
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:59:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w9so78910840edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679522379;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EvQSRIdRv5c+y5ikJcDqBTw6V/+X5LVUwyAPQo8flXU=;
        b=TViol1opIBVYgiZzibv+QeuWJpS7XEsNAEeA6AthKKfjIW6QQt1lv7Pma1f4QXsdXF
         5TyN88oQA+Mt6kX0tFUGAPxoaZuKYqkuvrbV2o1/LuFhm674nnXJDvq9777FcmeJbGvf
         lSdm9nYRMJZMN6q937AJcdGUiA366TsKqw7cinTjm82VqX0vh56Ci0TE2DzJB3QScdsl
         QVcwzaGhQjZHGhac7qLwdySCdH1J3bTwBe36sD4rVMEfFEeh7DkYpTeaGZ6ANkD9eCiK
         /B8X88eIw08Ot67aTYDqZltTvv8zEHEBIUlY/D8w+lsx6AoYztFyrZWdB88PGj64fb3u
         q6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679522379;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvQSRIdRv5c+y5ikJcDqBTw6V/+X5LVUwyAPQo8flXU=;
        b=UTbaO0jGBahWkqIwU/02CwiMd1HG2orT2AB6ACO5/NVoe4MQ9v3/q5iQMAMPfB4HHI
         8C/lAzHIt1e2sAgIsqqWYEDssLXnNUSqHf0oVssfZ8akEczIPND6sP9Hs46qJ4F606BV
         /BwQpfey3vtYwWDh3YvM8IOX4ChOP8dccO/PuG03Kh5VCb7IgT/J1BWBUMdUy4XlGNph
         cW/GgUMieguH7kLUe7F1O53c5TbdyZ0y9d+VoDEQkxupK1z/Ykv8sjFjKnb1JsssWvYi
         9+zX7xFwJWWLIkZEkS2csX8zIi2e9JGsNBq/VLj4CxCt1NmxSgh5wuv44WZn01rc17IS
         WbOA==
X-Gm-Message-State: AO0yUKXu1xNwlbqPjzHY+a/TzN2OSruemr4Dn4Aod8qjCIglrRj3aVaU
        aM3fmeJdwgt1gaKAhht3bo8n6w==
X-Google-Smtp-Source: AK7set88TbcnM/063JVFqc2VabiL6S//jkxBLWUWhSQKY5G4J0puIdYR1qJXou2K7kAYiGwtL5cXBQ==
X-Received: by 2002:a17:906:e97:b0:8af:2a97:91d4 with SMTP id p23-20020a1709060e9700b008af2a9791d4mr8279561ejf.14.1679522379374;
        Wed, 22 Mar 2023 14:59:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:626d:5729:6e71:4c22? ([2a02:810d:15c0:828:626d:5729:6e71:4c22])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090668cc00b008d044ede804sm5703652ejr.163.2023.03.22.14.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 14:59:39 -0700 (PDT)
Message-ID: <cf87e7c0-b769-d1fc-0718-c5c2986993b8@linaro.org>
Date:   Wed, 22 Mar 2023 22:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/6] dt-bindings: sound: Add support for the Lantiq
 PEF2256 codec
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230322134654.219957-1-herve.codina@bootlin.com>
 <20230322134654.219957-5-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230322134654.219957-5-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 14:46, Herve Codina wrote:
> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.
> 
> The codec support allows to use some of the PCM system highway
> time-slots as audio channels to transport audio data over the E1/T1/J1
> lines.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/sound/lantiq,pef2256-codec.yaml  | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
> new file mode 100644
> index 000000000000..da35b70cda99
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/lantiq,pef2256-codec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lantiq PEF2256 codec
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description: |
> +  Codec support for PEF2256.
> +
> +  The Lantiq PEF2256, also known as Infineon PEF2256 or FALC56, is a framer and
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
> +  The tx and rx masks define the PEF2256 time-slots assigned to the codec.
> +
> +  The PEF2256 codec node should be a child of a PEF2256 node.
> +  Refer to the bindings described in
> +  Documentation/devicetree/bindings/mfd/lantiq,pef2256.yaml
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: lantiq,pef2256-codec
> +
> +  '#sound-dai-cells':
> +    const: 0

You do not have here any resources, so the entire binding can be dropped
and merged into the parent.

Best regards,
Krzysztof

