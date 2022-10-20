Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF8360683D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJTSfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJTSfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:35:02 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E895B736
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:34:56 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id m6so519883qkm.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HY9CsyVy0myxvaLITwUS3Qt0lBRKhpdzPVxX3EBA/CY=;
        b=pipBb0x+cr2R0D3fuF6NLkbPQDO0qI5bzzvLkE1sgy/MUEA7P6YiYSeCFkzr45wkyp
         76YJPkPeQNs/Kg3itSirub4zm2GEh2NYUWsqKOHai15PQ1N6jFWHPXhRbw7VC60dsT2K
         myD8HBZtN6L34bwnOnLzTYgH7EjRrxaPyvPHfQWf8g+pmsWPY5jGVtu6COzIOnYVFih3
         YJU+geOvXw+G2zx/9MLP55wKP1I9dAPZPzb1NWdnww8gC5kkY7ZMeoBuDMbTK1t132k0
         XzSKbAUg2qjY6iMTgJ8t4W2MgiYfFj0KZDte+9Xj3zgI3pOj5ICnGJLkhxaqfx9rYbfz
         yRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HY9CsyVy0myxvaLITwUS3Qt0lBRKhpdzPVxX3EBA/CY=;
        b=IKnmdpt4irflQlyWJma7bgrOFBueHHKo7HLVQSewf4hltMryk5GJcUHzD09vJAje+Q
         72ApgYHI5InCdZdmmfIt4YPfMFPorJ4DyTwUFwx96Y7X223VBTgb8Nd5i/QkxpnZ71wA
         OWH/acf9wzQx0IhF4f0k1hFlLK7eCWMhoGulYJwJ+8hdzqyGOC0KYVSON9ggCTbPUwn3
         SphjGJqvK/7ymRN5JYLdAIsCdoQu6rELaxclonwSBynvqnMlw30Y5pKgNQ3j2NrkDZ5/
         YRzrXfT0eWuhCOvRO1dXyBVmWLEG2fqWICX1Hz9L33Y7JH5+EmEYaT68uadfVZbaG3ap
         8r1A==
X-Gm-Message-State: ACrzQf3CQvBdyx5C1KoUlSBm36xRPAlF6wY/iI3TtbLk1/SNJRvQRo2e
        Zm3NCLUxqE7OM4gzK//1rRISiw==
X-Google-Smtp-Source: AMsMyM6/i6uGqja8uWjQHRC3kvF+iBiGDVTF7QSKqI8YynKmQZGi7xBdrUtDnUCwkHk0gZiKfL3PQA==
X-Received: by 2002:a37:5d2:0:b0:6ee:7931:825a with SMTP id 201-20020a3705d2000000b006ee7931825amr10334659qkf.591.1666290895303;
        Thu, 20 Oct 2022 11:34:55 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006ec59941acasm7980520qko.11.2022.10.20.11.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 11:34:54 -0700 (PDT)
Message-ID: <77087a4a-ac21-c622-59ec-1b308c37cc2c@linaro.org>
Date:   Thu, 20 Oct 2022 14:34:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3] dt-bindings: soundwire: Convert text bindings to DT
 Schema
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        vkoul@kernel.org, agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
References: <1666271160-22424-1-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1666271160-22424-1-git-send-email-quic_srivasam@quicinc.com>
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

On 20/10/2022 09:06, Srinivasa Rao Mandadapu wrote:
> Convert soundwire text bindings to DT Schema format.
> 
> Update interrupt property items as per device tree,
> as it is not appropriately described in text file.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> ---

Thank you for your patch. There is something to discuss/improve.

> -};
> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> new file mode 100644
> index 0000000..12cd3c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
> @@ -0,0 +1,184 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soundwire/qcom,soundwire.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SoundWire Controller
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +  - Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> +
> +description:
> +  The Qualcomm SoundWire controller along with its board specific bus parameters.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,soundwire-v1.3.0
> +      - qcom,soundwire-v1.5.0
> +      - qcom,soundwire-v1.5.1
> +      - qcom,soundwire-v1.6.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: specify the SoundWire controller core.
> +      - description: specify the Soundwire controller wake IRQ.

The second property was optional. You need to test DTS before sending
the bindings. Please run `make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

IOW, you need here:
  minItems: 1

> +
> +  interrupt-names:

  minItems: 1

> +    items:
> +      - const: wakeup
> +      - const: core

That's definitely wrong order and should not pass any tests...

> +
> +  clocks:
> +    items:
> +      - description: iface clock
> +
> +  clock-names:
> +    items:
> +      - const: iface
> +
> +  resets:
> +    items:
> +      - description: SWR_AUDIO_CGCR RESET
> +
> +  reset-names:
> +    items:
> +      - const: swr_audio_cgcr
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 0
> +
> +  wakeup-source: true
> +
> +  qcom,din-ports:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: count of data in ports
> +
> +  qcom,dout-ports:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: count of data out ports
> +
> +  qcom,ports-word-length:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: size of payload channel sample.
> +    maxItems: 5
> +
> +  qcom,ports-sinterval-low:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: sample interval low of each data port.
> +    maxItems: 5
> +
> +  qcom,ports-offset1:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: payload transport window offset1 of each data port.

You miss here some pieces of original description,

> +    maxItems: 5
> +
> +  qcom,ports-offset2:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: payload transport window offset2 of each data port.

Ditto - and in other places.

> +    maxItems: 5
> +
> +  qcom,ports-lane-control:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: identify which data lane the data port uses.
> +    maxItems: 5
> +
> +  qcom,ports-block-pack-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: indicate the block packing mode.
> +    maxItems: 5
> +
> +  qcom,ports-hstart:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: identifying lowerst numbered coloum in SoundWire frame.
> +    maxItems: 5
> +
> +  qcom,ports-hstop:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: identifying highest numbered coloum in SoundWire frame.
> +    maxItems: 5
> +
> +  qcom,ports-block-group-count:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: indicate how many sample intervals are combined into a payload.
> +    maxItems: 5
> +
> +  codec@4:

It's too specific. What if different device uses different address?

You need patternProperties "^codec@[0-9a-f]+$"


> +    $ref: ../sound/qcom,wcd938x-sdw.yaml#

Full path, so /schemas/sound/qcom,wcd.....

Cannot we have other codecs attached? For example check SC7280 IDP,
SM8250 MTP, RB5.


> +    description:
> +      Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC.
> +      It has RX and TX Soundwire slave devices. This bindings is for the
> +      slave devices.
> +    type: object
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - '#sound-dai-cells'
> +  - '#address-cells'
> +  - '#size-cells'
> +  - qcom,dout-ports
> +  - qcom,din-ports
> +  - qcom,ports-sinterval-low
> +  - qcom,ports-offset1
> +  - qcom,ports-offset2
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
> +
> +    soundwire@3210000 {
> +        compatible = "qcom,soundwire-v1.6.0";
> +        reg = <0x03210000 0x2000>;
> +
> +        interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +                     <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
> +

Missing interrupt names.

Best regards,
Krzysztof

