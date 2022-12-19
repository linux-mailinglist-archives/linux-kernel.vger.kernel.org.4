Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C15650D29
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiLSOXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiLSOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:23:36 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205D8F006;
        Mon, 19 Dec 2022 06:23:35 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so21871783ejc.4;
        Mon, 19 Dec 2022 06:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gkz73r1Eb7Lcu2UFxAAgyawdXAVgK+nUDNDZI6NypmI=;
        b=lrK6/UvA0iB5QyZKs21O4DDtfVksA/wJmDdFI3vbYuBtAGlQGsgPT2fh0Cf4N2QS6x
         oamZ0dNV7Qyl2NQRqZAx42e2t8jodmut605Os1ZviwfCuRiKPFa7UIqCkRYYjq5iIE55
         hEIjMexAke+0iT2SP4qc2qmrW/R0KoWPj8ALc7WK51KklI+NqE8Wf762Qu2/w/3XbJtp
         O6P7AsGQKBIiPvXrnV2bsYc6rb9mJmfvnzQYgHZX1LzfzTbSzXUhzk+m1P114Q4srqx9
         v9QAGqLXUIfVAcjksSORECeS8nRpfNkYx52r1KboWugeZ6Cx1qlSg2h8+vhuLgBQ6/vu
         ws+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gkz73r1Eb7Lcu2UFxAAgyawdXAVgK+nUDNDZI6NypmI=;
        b=KDIsXlxqqhZTzi2msBA0V/dZ5CtI6a5jYX5PWtXYwmTrjJepzcZcayx+Mt+hbhtym0
         Ot7r2AGDEJOvddtLvWSue9yELryE4OVfNpnBs4/fio8jhVr/wru3cnO51lj7ugb2L2R/
         ixM+QDmjWwFVz+4yWgc58BDKWmxZnC7AaA/Q5uGeiZ9gNDa5s118KY4Qnk6mpmNPFpfS
         2vg7daHYoIxYu0YyM1QRi9ZN9WzH53hOsKj7Wq0OkxGAKKkBzy0InCAhrCMf8KhGFBUI
         r8QfoUupPhX5FkOZInwB2xbxK0ZMyOpqZ3MU9Jq9YVCt3KaE+tLFh/SS+zPeJE5Pd3gR
         2G3g==
X-Gm-Message-State: ANoB5pkt57EsSlQDteIRaLCszbEnsqJRuPSD8qii27F2EuJPa0AmPN2A
        e1uhMYh1+lPC9ST8rF/CzmQ=
X-Google-Smtp-Source: AA0mqf4Glrj80Pn6SO+5YOa1CODh03vabAMBUtymLKCKDN//Cz/MMQ0Pk5yKzavBrdNqIg2OJ2YxFA==
X-Received: by 2002:a17:906:1711:b0:7c1:3fbd:d569 with SMTP id c17-20020a170906171100b007c13fbdd569mr33253033eje.8.1671459813432;
        Mon, 19 Dec 2022 06:23:33 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090652c500b007c4fbb79535sm4399120ejn.82.2022.12.19.06.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 06:23:32 -0800 (PST)
Message-ID: <5e05a6d5-bc89-fb66-fcae-2e1194e23c12@gmail.com>
Date:   Mon, 19 Dec 2022 15:23:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3] dt-bindings: display: rockchip: convert
 rockchip-lvds.txt to YAML
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <fd51df66-147d-d40f-913e-385625a71984@gmail.com>
 <8db62d1a-365c-d41d-90aa-4c78c5d5e9ce@linaro.org>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <8db62d1a-365c-d41d-90aa-4c78c5d5e9ce@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/19/22 14:04, Krzysztof Kozlowski wrote:
> On 19/12/2022 13:32, Johan Jonker wrote:
>> Convert rockchip-lvds.txt to YAML.
>>
>> Changed:
>>   Add power-domains property.
>>   Requirements between PX30 and RK3288
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>
>> Changed V3:
>>   Filename matching compatible style
>>   Drop "Regulator phandle for "
>>   Specify properties and requirements per SoC
>>   Sort order and restyle
>>
>> Changed V2:
>>   Fix title
>> ---
>>  .../display/rockchip/rockchip,lvds.yaml       | 170 ++++++++++++++++++
>>  .../display/rockchip/rockchip-lvds.txt        |  92 ----------
>>  2 files changed, 170 insertions(+), 92 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
>> new file mode 100644
>> index 000000000..03b002a05
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
>> @@ -0,0 +1,170 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/rockchip/rockchip,lvds.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Rockchip low-voltage differential signal (LVDS) transmitter
>> +
>> +maintainers:
>> +  - Sandy Huang <hjc@rock-chips.com>
>> +  - Heiko Stuebner <heiko@sntech.de>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - rockchip,px30-lvds
>> +      - rockchip,rk3288-lvds
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: pclk_lvds
>> +
>> +  avdd1v0-supply:
>> +    description: 1.0V analog power.
>> +
>> +  avdd1v8-supply:
>> +    description: 1.8V analog power.
>> +
>> +  avdd3v3-supply:
>> +    description: 3.3V analog power.
>> +
>> +  rockchip,grf:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: Phandle to the general register files syscon.
>> +
>> +  rockchip,output:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    enum: [rgb, lvds, duallvds]
>> +    description: This describes the output interface.
>> +
>> +  phys:
>> +    maxItems: 1
>> +
>> +  phy-names:
>> +    const: dphy
>> +
>> +  pinctrl-names:
>> +    const: lcdc
>> +
>> +  pinctrl-0: true
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +      port@0:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description:
>> +          Video port 0 for the VOP input.
>> +          The remote endpoint maybe vopb or vopl.
>> +
>> +      port@1:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description:
>> +          Video port 1 for either a panel or subsequent encoder.
>> +
>> +    required:
>> +      - port@0
>> +      - port@1
>> +
>> +required:
>> +  - compatible
>> +  - rockchip,grf
>> +  - rockchip,output
>> +  - ports
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: rockchip,px30-lvds
>> +
>> +    then:
>> +      properties:
>> +        reg: false
>> +        clocks: false
>> +        clock-names: false
>> +        avdd1v0-supply: false
>> +        avdd1v8-supply: false
>> +        avdd3v3-supply: false
>> +
> 

> I see one compatible expects regmap from parent (grf is the parent here)
> and other is directly on MMIO bus. Not the best combination... Maybe
> this  should be just split to two separate bindings? Looking at driver,
> their code is also very different between these two variants.

Looking at the manufacturer tree we can expect the rest with grf parent, but also in the same driver combined with different registers and common probe.
Due to common probe I prefer one common document.

Johan

===

https://github.com/rockchip-linux/kernel/blob/develop-5.10/drivers/gpu/drm/rockchip/rockchip_lvds.c#L671


rockchip,rk3126-lvds
https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm/boot/dts/rk312x.dtsi#L914

rockchip,rk3368-lvds
https://github.com/rockchip-linux/kernel/blob/develop-4.4/arch/arm64/boot/dts/rockchip/rk3368.dtsi#L1196

rockchip,rk3568-lvds
https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64/boot/dts/rockchip/rk3568.dtsi#L734

> 
> Best regards,
> Krzysztof
> 
