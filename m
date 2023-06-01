Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458A471951F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjFAIL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjFAIL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:11:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20DEC0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:11:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96ff9c0a103so67610266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685607110; x=1688199110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/aAPNbwdm0BPn5PUgLp4hktWQaK2+uFNT4kN1UiiV4=;
        b=noBu4GFo9o3K31KSzM6zLXaqNSmfMChm9oSwgyqduSqkh+q29FAY/1uCqxBNWnDE43
         d36A38bwZ64J5xryHZzKKXCirlaQPolkLgkuTj3Pb7gf1KSetTMW6TL4DCTmrrW0YJCJ
         8kFPneS+nrSiGsbgg1frnaP32OKmvDUSmXcwWQsIkWpQG7F5TJEHIb9rX8VXJf/dwQo+
         uIOloDXkzuvmT7sLEkHBgH1woFhKHNTWj/nNRvpvGNJ3RenBcG6vT5LEoOrU5+vWiYMM
         d9ozFrKUIgtc++4ieYsff8RQrU482JbaPkGCCgQC+n2nE72CBBvN8GvSQCLHXoIKZM6O
         D8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685607110; x=1688199110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/aAPNbwdm0BPn5PUgLp4hktWQaK2+uFNT4kN1UiiV4=;
        b=VjqNlkXOQZ7lvps/Tb5Woq8q8yhiWqJX/M9P6YMZH6P1KArDoZkoZVVIKrhGiGqQei
         dsIw938a1WT5CdNKFHTaH+fd3E/RA+i6dotXVNmnBCSQ8O7vkal/ctFCcmzrasPp/xrr
         rwD2/XSQlkq9KKnNo3K8JVn6nBsmW+y/cHe+8qWNIByDyzwLFMaKmRNhrARXdyUfLIxc
         1iJQev/CoQIvoBuAIw2wwtdbL0bSy0SkMNVLb1jR1UkdkVAHuSDujYHSxrks4y11ptL2
         NgNtyHFQCFTv7JTR3SqKYzJFA/m8r6unSzMqbyzJ8aoRMPZZ1EBt1/NT2uKpavmYaMEJ
         vfJQ==
X-Gm-Message-State: AC+VfDx+v4uUkBMEGPBHogVmh9axEx050QLyVm3iHb7pJejzlvHlf3Wj
        kpb/zFZ7rf/zcHWyreGNlQETxBR6e21V5ZeWJw8=
X-Google-Smtp-Source: ACHHUZ59OUxz1x6flGeMGoLbNndoi2EK6EwfZcyjgNCpA1L9+RbhXlv0PBwyXltBSS9baZu1GRh/2A==
X-Received: by 2002:a17:907:7b92:b0:96a:52e:5379 with SMTP id ne18-20020a1709077b9200b0096a052e5379mr7774277ejc.63.1685607110379;
        Thu, 01 Jun 2023 01:11:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709067d5100b0096f72424e00sm10129750ejp.131.2023.06.01.01.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 01:11:49 -0700 (PDT)
Message-ID: <65124d19-474a-ce95-2cb3-bb8273a8e3b7@linaro.org>
Date:   Thu, 1 Jun 2023 10:11:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 23/43] dt-bindings: mtd: Add ts7250 nand-controller
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-5-nikita.shubin@maquefel.me>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601054549.10843-5-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 07:45, Nikita Shubin wrote:
> Add YAML bindings for ts7250 NAND Controller.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>     v0 -> v1:
>     
>     make it a nand contoller
> 
>  .../bindings/mtd/technologic,nand.yaml        | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/technologic,nand.yaml b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> new file mode 100644
> index 000000000000..26d1d9c3331d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/technologic,nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Technologic Systems NAND controller
> +
> +maintainers:
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +allOf:
> +  - $ref: nand-controller.yaml
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: technologic,ts7200-nand
> +      - items:
> +          - enum:
> +              - technologic,ts7300-nand
> +              - technologic,ts7260-nand
> +              - technologic,ts7250-nand
> +          - const: technologic,ts7200-nand
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells': true
> +  '#size-cells': true

Except what Miquel wrote - drop these two.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: true
> +
> +examples:
> +  - |
> +    nand-controller@60000000 {
> +      compatible = "technologic,ts7200-nand";
> +      reg = <0x60000000 0x8000000>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;

Incomplete example. address/size cells do not make sense here alone.
Finish the example.

> +    };
> +
> +...

Best regards,
Krzysztof

