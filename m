Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5495E6B654E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCLLQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCLLQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:16:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7A852913
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:16:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cy23so37799337edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678619780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VJk1cf7YX+9rXWwnRHZmf/825IC6tmEEXRO88RyzB68=;
        b=aObJIqYLHzyBdCSGiSMgu2V5ijUMMxoSbT3we7KjenIGnAMgP2uM6dyLmJu9kqUXPT
         yVFsPyjzRYRZ70CbljITZ5xB1cifV5F2zSUoB5PlhW9r854nfNweUu9tTQSkGDzT1dE/
         Dza8o00ndz3/syUVuXksECwuYIMmNLoTBZoh6xHF4tzunXsyQUDg3qK3M1UD6eU8cYgJ
         rQh2aM2063Tk4FiSeLAOHPnyF/kJIU0bmkJNeLoyDrfuBWMQyfiJ+oXFiIH5u8QSefRX
         alZXwYIZMmttVc8w9jU4u9FlxPeesR9qIVw7/Ow/TTcXoi22PjJzzNsjFOfTTAGNDP5d
         ifKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678619780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJk1cf7YX+9rXWwnRHZmf/825IC6tmEEXRO88RyzB68=;
        b=lAHHSJPsAFsC1W4skF2eECuxOQgQwXdS4cagMBk3gctIElkn7WMhVKtNeY9URrucQD
         03MVncYCTq/BQQ+XZIe5Cp159SVQ0hEFE6/qtNfhFQbPXQyU9i4XQUzQQo9mAPEdkVIe
         +ThEK12u+LvMLuDtGzO7SLG9BVgREN6gXVn4M2q1Amx7s3rj3XRGFA+vqOW0Z91V2JOt
         MNnAa0kKS++UnpWDfNi+BXD9tfOCB8TPbAcJ2Sr0kccT+YNrRzXM50JzFwZI7HcuuQEO
         1cFS4SVW0/Pq/eq075dZGTkkZuirQzuoKB3KZj35PAXpUNn4lClvBWkXkMTuMI/kFLDZ
         3+NQ==
X-Gm-Message-State: AO0yUKUJe6Cm3m4ylam0TrASvcElRKiFCihqx9cDKFTKsROEq79ozlQD
        J62Sh5ttkRfnzHKsmVDUKiPxLQ==
X-Google-Smtp-Source: AK7set9DHxm1GJBvuohaCcev+6Pq6ZkywQoIA9oBGxjfPB+gojOkRzekIEZ+s/j1vFFKNRROopd1iA==
X-Received: by 2002:a17:906:b007:b0:870:d9a:9ebb with SMTP id v7-20020a170906b00700b008700d9a9ebbmr29403333ejy.38.1678619780339;
        Sun, 12 Mar 2023 04:16:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id jg30-20020a170907971e00b0091ec885e016sm2106948ejc.54.2023.03.12.04.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 04:16:19 -0700 (PDT)
Message-ID: <c0abd0ea-98ce-2f42-043e-bcafdc157788@linaro.org>
Date:   Sun, 12 Mar 2023 12:16:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/6] media: dt-bindings: Add bindings for JH7110 Camera
 Subsystem
Content-Language: en-US
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230310120553.60586-1-jack.zhu@starfivetech.com>
 <20230310120553.60586-2-jack.zhu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230310120553.60586-2-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 13:05, Jack Zhu wrote:
> Add the bindings documentation for Starfive JH7110 Camera Subsystem
> which is used for handing image sensor data.
> 
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> ---
>  .../bindings/media/starfive,jh7110-camss.yaml | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> new file mode 100644
> index 000000000000..3f348dd53441
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> @@ -0,0 +1,144 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/starfive,jh7110-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Starfive SoC CAMSS ISP
> +
> +maintainers:
> +  - Jack Zhu <jack.zhu@starfivetech.com>
> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> +
> +description:
> +  The Starfive CAMSS ISP is a Camera interface for Starfive JH7110 SoC.It
> +  consists of a VIN controller(Video In Controller, a top-level control until)
> +  and an ISP.
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-camss
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: syscon
> +      - const: isp
> +
> +  clocks:
> +    maxItems: 7
> +
> +  clock-names:
> +    items:
> +      - const: apb_func
> +      - const: wrapper_clk_c
> +      - const: dvp_inv
> +      - const: axiwr
> +      - const: mipi_rx0_pxl
> +      - const: ispcore_2x
> +      - const: isp_axi
> +
> +  resets:
> +    maxItems: 6
> +
> +  reset-names:
> +    items:
> +      - const: wrapper_p
> +      - const: wrapper_c
> +      - const: axird
> +      - const: axiwr
> +      - const: isp_top_n
> +      - const: isp_top_axi
> +
> +  power-domains:
> +    items:
> +      - description: JH7110 ISP Power Domain Switch Controller.
> +
> +  interrupts:
> +    maxItems: 4
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:

You should have here port@0. The binding does not represent what is
supported by Linux. Binding represents hardware and you said you have
port@0 for the sensor.


> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port for receiving CSI data.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +    required:
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - power-domains
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    stfcamss: isp@19840000 {
> +        compatible = "starfive,jh7110-camss";
> +        reg = <0x19840000 0x10000>,
> +              <0x19870000 0x30000>;
> +        reg-names = "syscon", "isp";
> +        clocks = <&ispcrg 0>,
> +                 <&ispcrg 13>,
> +                 <&ispcrg 2>,
> +                 <&ispcrg 12>,
> +                 <&ispcrg 1>,
> +                 <&syscrg 51>,
> +                 <&syscrg 52>;
> +        clock-names = "apb_func",
> +                      "wrapper_clk_c",
> +                      "dvp_inv",
> +                      "axiwr",
> +                      "mipi_rx0_pxl",
> +                      "ispcore_2x",
> +                      "isp_axi";
> +        resets = <&ispcrg 0>,
> +                 <&ispcrg 1>,
> +                 <&ispcrg 10>,
> +                 <&ispcrg 11>,
> +                 <&syscrg 41>,
> +                 <&syscrg 42>;
> +        reset-names = "wrapper_p",
> +                      "wrapper_c",
> +                      "axird",
> +                      "axiwr",
> +                      "isp_top_n",
> +                      "isp_top_axi";
> +        power-domains = <&pwrc 5>;
> +        interrupts = <92>, <87>, <88>, <90>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +

Same here, DTS describes the hardware, so you need port@0.



Best regards,
Krzysztof

