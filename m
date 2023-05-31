Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7060717A13
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjEaIaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbjEaIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:30:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DC4137
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:30:00 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96f99222e80so143725266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685521798; x=1688113798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqeVSaDQ2xCQutIzmyZDcrRktFLClt8bCyhV44jjeTM=;
        b=hb6XbWCmFp9iggCj+EtVdZ++OFKwRK7+1Vx3wg7FkPd9247QX3FqpNb96H+oJ6Ot5q
         Oyzs1ENPgnGJO4LHgiI8ffFPQR1Ifu1qsT5bIOt+cbSXo1vwJTz+dv8tpA1wPv1dTinn
         04Up8VvqXVhqL/HsXSZlB1+yT6v+M3qxDy65u96GiTHZSEAAMSVp0MMidnNCOpucvi+L
         qYVLZgpxbc3uSvooU5p4+jPOoN16Un2s+cllz/tQYw0vBi3fdSHUX6FqjZvgdnjjVDdJ
         t6ywCEzrvZzcJOd+3VjOZkWjoq/6oCb3eX2mjwFeiUjfR5WKhF41CLkcy3hJ16hpMLvK
         wFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685521798; x=1688113798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqeVSaDQ2xCQutIzmyZDcrRktFLClt8bCyhV44jjeTM=;
        b=g/1ICCjW5Rvq3JcBfKBbCQxlKn+RNOLHN6c3CwHedS+PHPZg6Ltg9b4G5TD6UcvaiL
         x/jhlSfbxyEH7iuBDr89kZrInk8zUGutNucZcbg69sW5ipe6JBp9eFsM5z+kV8rsxdO6
         CSjwse/EHUOoJRpswufZ5JjygQB7rmd0UlYq4tCOel+9bNuK+5pUPFSRDV83jekwEjSf
         LoZjfO5YEP5LbpRrwiAVhlQs76kVudBP2BUlLN4mZ0cqxpANNtFiG7UtXjJfmVryRwnw
         FIMLaASrh4LoVVcQfamQiyshL5sG6Mti8b5GrILfhLpf3HQMjpt8RYjR8KfmN7ITkvqC
         1s2w==
X-Gm-Message-State: AC+VfDzbDcTEl0zBo/OImCtt6HLTR1JoksOAhMSPY5Bgql7z8qg07qIX
        cLDEtazVT3mh7auuHCFEWvC3AQ==
X-Google-Smtp-Source: ACHHUZ7UCWGXisoHiCFtacjTJmCPyZNi4Z9A9Xf3XV640s4WvgXKU0SGx9ikpx9i/6XdnDRRu38Yuw==
X-Received: by 2002:a17:907:7e9e:b0:965:aa65:233f with SMTP id qb30-20020a1709077e9e00b00965aa65233fmr13240884ejc.2.1685521798567;
        Wed, 31 May 2023 01:29:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id r16-20020a056402019000b00514b3a2008esm1205699edv.2.2023.05.31.01.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:29:58 -0700 (PDT)
Message-ID: <2d11ba2d-7977-abf8-99df-6e3184ce6220@linaro.org>
Date:   Wed, 31 May 2023 10:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/5] dt-bindings: arm: ti: add toradex,verdin-am62 et
 al.
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230524143631.42471-1-francesco@dolcini.it>
 <20230524143631.42471-2-francesco@dolcini.it>
 <a87d493a-0f16-0096-0a01-5bbeddf4cfee@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a87d493a-0f16-0096-0a01-5bbeddf4cfee@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2023 19:48, Andrew Davis wrote:
> On 5/24/23 9:36 AM, Francesco Dolcini wrote:
>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>>
>> Add toradex,verdin-am62 for Toradex Verdin AM62 SoM, its
>> nonwifi and wifi variants and the carrier boards (Dahlia,
>> Verdin Development Board and Yavia) they may be mated in.
>>
>> Link: https://developer.toradex.com/hardware/verdin-som-family/modules/verdin-am62/
>> Link: https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>> ---
>>   .../devicetree/bindings/arm/ti/k3.yaml        | 20 +++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> index e1183f90bb06..e3aee191d403 100644
>> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> @@ -33,6 +33,26 @@ properties:
>>                 - ti,am62-lp-sk
>>             - const: ti,am625
>>   
>> +      - description: K3 AM62x SoC Toradex Verdin Modules and Carrier Boards
>> +        items:
>> +          - enum:
>> +              - toradex,verdin-am62-nonwifi-dahlia # Verdin AM62 Module on Dahlia
>> +              - toradex,verdin-am62-nonwifi-dev    # Verdin AM62 Module on Verdin Development Board
>> +              - toradex,verdin-am62-nonwifi-yavia  # Verdin AM62 Module on Yavia
>> +          - const: toradex,verdin-am62-nonwifi     # Verdin AM62 Module without Wi-Fi / BT
> 
> Does this add anything? Not sure we need to split compatibles based on this, things
> like wifi vs nowifi can be described in DT, same for different memory size models, etc..
> 
> In fact I'm not sure we get much value at all out of top level whole-SoC compatible
> strings. Maybe we did when there was matching in kernel to do device specific fixups,
> but that isn't really used much in ARM64.

If I understand correctly, this is different SoM, so different hardware.
 It is fine to have different board compatibles, because you will have
two different DTS.

Best regards,
Krzysztof

