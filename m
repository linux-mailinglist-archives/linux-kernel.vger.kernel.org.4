Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E3F673DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjASPiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjASPiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:38:14 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A01282D7C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:38:08 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q10so2273665wrs.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OtQKUy3O/wxA8BJ9fjP5SexIZ7HSW4yV7WQUNilHvg=;
        b=qDUwzHhP9WiwfxC3rlJQQt3rmBKzAJQWEgZSjeuvbrGSHyfBIW/UX9axTeJ6b72khJ
         nuKAXboBweC0hJWpbxz8lKKA/LnMWK6FVlKVnTbRWCjSPEo64nNMp2KlZ34+2sRJOzIG
         w5Pkh1vzqJ+4Oh0VMMRTZdEF8LNYlPreCV4X3ezWjMhVWaV0vb4PR7FTNwmjuxDFFyH8
         j0gaTvYTvn02jK0UrXzu3iNyLVoRgyDu8v/Ga5OBWjGnHIsPe+YocS/3c9uyxbp8qwlq
         ntBWEClNF60A8WwLce1bSXWX4CdZHPYKzLpv0liw3XO2N4Ql2wVqCYtrPqZn8eEW9VYe
         enAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9OtQKUy3O/wxA8BJ9fjP5SexIZ7HSW4yV7WQUNilHvg=;
        b=0SGEUDk1zawjxVU6eLgGq0JYgt2VOGFK9Qtt82dRMZWnxDSwVUMccajzp1Gtz7OBNN
         QUleU2nkRi97OAeWDT/y6+aJaTI+0/aYde+Ldot8HLcK6sIg4TmEMTdDXtb6HViyfDwY
         49/Mwty8dHlxQQ2EOlh7i6ciBRzepOPXbKuWRmO7xE1uKt7rBdbXMc/ssKGTMquo9J8Q
         nOucaES9U8yt1AAMjL55+u9LUcI7Kt5BWCs7AmGaEKltCAQIfD8TsOU8tF3G/gzWjGZP
         kuiPxEqCu4M53c4OF8nFrNkCOeiaxw1YhFxkoqaExxrmoSesJK7tdCc8CXA4WbAoGaJT
         MttQ==
X-Gm-Message-State: AFqh2kojuYa4U4xBqBnjLlNYNfOuXXaaw/fVUjTuYuNlNEPpryblb+rI
        KatHxCxKpz1JiN774/Z4+P+NrQ==
X-Google-Smtp-Source: AMrXdXt3ur3QfDs3VlwSTaNjxSdTD7GrQQEI25qrf//XEtQ+vibijcjrDE3k3n/epLp7Qdx9CSeVCA==
X-Received: by 2002:adf:f501:0:b0:2ba:dce5:ee28 with SMTP id q1-20020adff501000000b002badce5ee28mr9249903wro.18.1674142686828;
        Thu, 19 Jan 2023 07:38:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b0025e86026866sm40281182wrs.0.2023.01.19.07.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 07:38:06 -0800 (PST)
Message-ID: <7b6603d6-3ca9-ff74-0a3e-c76ba555e554@linaro.org>
Date:   Thu, 19 Jan 2023 16:38:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v8 1/5] dt-bindings: PCI: ti,j721e-pci-*: add checks for
 num-lanes
To:     Achal Verma <a-verma1@ti.com>, mranostay@ti.com, rogerq@kernel.org,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, vigneshr@ti.com, tjoseph@cadence.com,
        sergio.paracuellos@gmail.com, pthombar@cadence.com,
        linux-pci@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230118125936.3456716-1-a-verma1@ti.com>
 <20230118125936.3456716-2-a-verma1@ti.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118125936.3456716-2-a-verma1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 13:59, Achal Verma wrote:
> From: Matt Ranostay <mranostay@ti.com>
> 
> Add num-lanes schema checks based on compatible string on available lanes
> for that platform.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> ---
>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 28 +++++++++++++++++--
>  .../bindings/pci/ti,j721e-pci-host.yaml       | 28 +++++++++++++++++--
>  2 files changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> index 10e6eabdff53..403cd3ef1177 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> @@ -10,9 +10,6 @@ title: TI J721E PCI EP (PCIe Wrapper)
>  maintainers:
>    - Kishon Vijay Abraham I <kishon@ti.com>
>  
> -allOf:
> -  - $ref: "cdns-pcie-ep.yaml#"
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -65,6 +62,31 @@ properties:
>      items:
>        - const: link_state
>  
> +allOf:
> +  - $ref: cdns-pcie-ep.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - ti,am64-pcie-ep
> +    then:
> +      properties:
> +        num-lanes:
> +          minimum: 1
> +          maximum: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - ti,j7200-pcie-ep
> +            - ti,j721e-pcie-ep
> +    then:
> +      properties:
> +        num-lanes:
> +          minimum: 1
> +          maximum: 2
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> index b0513b197d08..7bd78cfca845 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> @@ -10,9 +10,6 @@ title: TI J721E PCI Host (PCIe Wrapper)
>  maintainers:
>    - Kishon Vijay Abraham I <kishon@ti.com>
>  
> -allOf:
> -  - $ref: "cdns-pcie-host.yaml#"
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -98,6 +95,31 @@ properties:
>        interrupts:
>          maxItems: 1
>  
> +allOf:
> +  - $ref: cdns-pcie-host.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - ti,am64-pcie-host
> +    then:
> +      properties:
> +        num-lanes:
> +          minimum: 1
> +          maximum: 1

Why not what I asked for?

Best regards,
Krzysztof

