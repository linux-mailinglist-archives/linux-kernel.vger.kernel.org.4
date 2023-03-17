Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176EF6BE404
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjCQIlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjCQIkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:40:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296976700E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:39:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ek18so17417551edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679042357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3EomA/n20CDkYUZt9tuM0ynxqq+YecAeDoRjuMt6INc=;
        b=vaTOc9LH+cgYLqY/Rz77mcA4ZJWgSa001RXDNFebWbrvOMPdPznT7zAb6TnMDY4Vyr
         Nlw1gvG7zdomDE728zHu65C2GZs3dVyYh5TcTvEgK6r2hG5VIPnH2BlIxgrhfl7arkPH
         bx1/o+OOUbWh541mcbCTVAMpncadXVlwEA9L82v9luOwVO9O+7WrBHz2zw4H0e/ZkA8m
         utgXErJ2DQh3+t6OxeOgVWfPaDtxbuUUdSqewUe290atzi9Y3dsVP1DiSdGreX7EV1mE
         A4mm2ZpXTMRPhEmue+RRLHBRQA8F2WJY4VXGIDkxDQg605ENdtwgHJV0Oor0AeOhrPH2
         +ZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679042357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EomA/n20CDkYUZt9tuM0ynxqq+YecAeDoRjuMt6INc=;
        b=RAXtQ1MAV+shbIaH+uxV5LhNQ6dXINFI+ySsGSBJdUwMAsJLun/D+eZDCc8Ai47Opm
         Z3yU0U10KpWUtHdQnwQLa6UQ+mvGyI6KIL8VgF153eEdvRganK6Nlu0YaQiDYDyiRkIz
         0V3lmfCUxpsbSGsEUSMhbeFJvaJsW0+4RNYUcOZWWS4CzatkFSg/L3+b4hMFCVj6qGmJ
         JM+eGui00Ne4OxNGjMHDBZjeQX9/CCX2CtsfT0Yi6K1xnAX0lcHCCxSC8g1As79knKDw
         SQElrCh9CnIwz4Fpdaqp0eiU7RV8fK0x/Dicumy/ZxexmOO4jpr5q36EeWLJ1GG3GxHt
         +ivg==
X-Gm-Message-State: AO0yUKWcakg7XgGkhWxUDiLy/jEM1DYaUJ1muxum9Pwon+DSG7v3qk2Q
        ac/dXLVvIUa7hKu5bDm+67+tfw==
X-Google-Smtp-Source: AK7set9abg8fHSCfxU3N0o6BHt3OijsaEDSIA5zOwAbtKTKRYcKlml4Ijs9Yr5PZKkZvc+5L3W0kBA==
X-Received: by 2002:a17:907:b021:b0:92f:b8d0:746c with SMTP id fu33-20020a170907b02100b0092fb8d0746cmr5663825ejc.20.1679042357510;
        Fri, 17 Mar 2023 01:39:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id j10-20020a170906094a00b008cafeec917dsm701864ejd.101.2023.03.17.01.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:39:16 -0700 (PDT)
Message-ID: <f7752f68-11a6-cbf4-2f28-1de4c7ff9da2@linaro.org>
Date:   Fri, 17 Mar 2023 09:39:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/5] dt-bindings: phy: Add StarFive JH7110 USB/PCIe
 document
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20230315104411.73614-1-minda.chen@starfivetech.com>
 <20230315104411.73614-2-minda.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315104411.73614-2-minda.chen@starfivetech.com>
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

On 15/03/2023 11:44, Minda Chen wrote:
> Add StarFive JH7110 SoC USB 2.0/3.0 and PCIe 2.0 PHY dt-binding.
> PCIe 2.0 phy can use as USB 3.0 PHY.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../phy/starfive,jh7110-usb-pcie-phy.yaml     | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-pcie-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-pcie-phy.yaml
> new file mode 100644
> index 000000000000..aa1c3fe93100
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-pcie-phy.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/starfive,jh7110-usb-pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive USB 2.0 and PCIe 2.0 PHY
> +
> +maintainers:
> +  - Minda Chen <minda.chen@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - starfive,jh7110-usb-phy
> +      - starfive,jh7110-pcie-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  clocks:
> +    items:
> +      - description: usb 125m clock
> +      - description: app 125m clock
> +
> +  clock-names:
> +    items:
> +      - const: 125m
> +      - const: app_125
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +

It seems pci phy does not take these clocks, thus you should have
allOf:if:then which will customize it per variant. Otherwise binding is
incorrect for the pci.

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    phy@10200000 {
> +      compatible = "starfive,jh7110-usb-phy";
> +      reg = <0x10200000 0x10000>;
> +      clocks = <&syscrg 95>,
> +               <&stgcrg 6>;
> +      clock-names = "125m", "app_125";
> +      #phy-cells = <0>;
> +    };
> +
> +    phy@10210000 {
> +      compatible = "starfive,jh7110-pcie-phy";
> +      reg = <0x10210000 0x10000>;
> +      #phy-cells = <0>;
> +    };
> +
> +    phy@10220000 {
> +      compatible = "starfive,jh7110-pcie-phy";
> +      reg = <0x10220000 0x10000>;
> +      #phy-cells = <0>;
> +    };

Drop duplicated examples. Keep usb and maybe one phy.

Best regards,
Krzysztof

