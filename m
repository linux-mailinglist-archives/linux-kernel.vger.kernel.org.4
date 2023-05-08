Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AED26FB4F9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjEHQWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjEHQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:22:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB295BB7
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:22:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-965cc5170bdso654678766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683562960; x=1686154960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMEF0WSJvUh33vaUqnZYN4TcD7T+ib2FTpwoVdwEQJo=;
        b=l/NIc/dsRNlSKhlTsW9bWkIrz9i6BS17/75HwbDRDSKXuwaanmMEAWkIh5U6NpJtAS
         HTry0AGsF8CVTZuAmRklP+12M1w0nshCc207Bh7u0WFZJGgNwkQLJlYUtj6QzlRJrnEi
         yk7/FPWPC8JjoN8d+EvdosHsMd77HfsA2GmW1yj6DFw90KfBgs4RYTreMId5iWLZD5KA
         0OA/he+wy4/rVt7sZSo8/lHF5/9gWNqRGLTdykyRxUbMhcjkX8R1n5egOsZDHEdTuDEf
         4H+GUUc4Ho/xgMsZpg5Fm4mz09qhczMWpPJbYhR0AqY2O3HQiJBKSd8BSTnLqbdc5pu/
         MrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683562960; x=1686154960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMEF0WSJvUh33vaUqnZYN4TcD7T+ib2FTpwoVdwEQJo=;
        b=iYfGcC2HQsLSzk+2uKIQ+HsZ5Vjuinnk5vqVWXehyrx7S6ID1zPxyLuMLAabIjb3ll
         QRRu8/FgZPkVcJNGEcpveghl3aVRfSekS13oiEUAidKc1SxzedrTVl1GL0PFoiWNkDBu
         EIEVB3YI0RW2Zu3WgvERpDX+tbikwOMt8/zZR2tOlFY+6wILbrOpJ6xc4sT2et3PAjEI
         R+9drroT3065wXkJ3mLvfrbAq+rt3+umSWLNEGuqn0+UbXCX6pADUMPBN5pZ1bBykAUi
         RaFqoNqc6XIKkiEdhqGLBoDERoIBZruKLHrT1JVhj6Hqp3xdOUbxsiSfhRWV2G/1bvaQ
         8nUg==
X-Gm-Message-State: AC+VfDxrW2M/ddZQ5JLopehzQ2Pcb+Oo8UJUv4Be5b6Mrt9a0t90v1r+
        QTHyV9r/PisgSErlJRQ/+Y3RpXuJCBYUuhJ/1ZE=
X-Google-Smtp-Source: ACHHUZ5Semx0Qyf5W4lNDrOleMZGsYp1D2/sYQew3pVB4wfxYzRezsyJGhLL2oFddoN1GwGMiuNvJA==
X-Received: by 2002:a17:907:a409:b0:94e:ffcb:b15d with SMTP id sg9-20020a170907a40900b0094effcbb15dmr9564296ejc.71.1683562959901;
        Mon, 08 May 2023 09:22:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id ty20-20020a170907c71400b0096621340285sm141283ejc.198.2023.05.08.09.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 09:22:39 -0700 (PDT)
Message-ID: <095239ec-973a-c333-b7de-28b573e02422@linaro.org>
Date:   Mon, 8 May 2023 18:22:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert
 to yaml
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-clk@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org
References: <20230508104801.445261-1-claudiu.beznea@microchip.com>
 <20230508104801.445261-3-claudiu.beznea@microchip.com>
 <168354524853.789265.9741363586759296275.robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <168354524853.789265.9741363586759296275.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 13:27, Rob Herring wrote:
> 
> On Mon, 08 May 2023 13:47:58 +0300, Claudiu Beznea wrote:
>> Convert Atmel PMC documentation to yaml.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  .../devicetree/bindings/clock/at91-clock.txt  |  28 ----
>>  .../bindings/clock/atmel,at91rm9200-pmc.yaml  | 154 ++++++++++++++++++
>>  2 files changed, 154 insertions(+), 28 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml

These can be ignored.

Best regards,
Krzysztof

