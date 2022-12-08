Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED833646CB2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiLHK1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLHK1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:27:35 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627C854779
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:27:31 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 1so1363137lfz.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08K5Vlx4IB2Dsl4MLI7dMUqa7FCe1uwxxccMSj5m7Jc=;
        b=IixV+1uuN0bY/bbX/+N1Lj3Yzho/GsLoaPm65A55jNVZnGBKdqqPJHjimnAVhl56jG
         KkHyze5xgI+sqQzAHIwAnyBQlnetfyzeAarswqTTSMXXcJNiQTtHWLlyr2HKy6RJHB3z
         ftbwsIEMBQHSadpP1Bt5ZwTO7fLPQ6u61hiDiuROWH4cjz5jlPIxKlw8V2u6uH5Ao8X6
         ghDfPPV54N7yzq3bpv7U8lCMbuW1HOhxWsVQ661f4FCHJfSLxQzRaiJTq2EIx/m89PDH
         15wEdAs1fzHM+kIxmA0U77aUjmrFCD3ZXlg68lUD2GXnrrxUfb7cp6sY2zmfuaNILclm
         Db6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08K5Vlx4IB2Dsl4MLI7dMUqa7FCe1uwxxccMSj5m7Jc=;
        b=XTkq6HYVeRzZwmG8TdAgu0sFaxlj6UDzpRwW97U6Q+rYbLbwwIg2Y6Mt0El+xQeUgW
         m7IZSZKf1gZOhN0auykwOusU8LjnfsnhW8pCr0KpghrRhSN4BwdH0ufYfOEpPTf/R2uZ
         MkcdxR72ijz2FR5zw/7EqzYr9RXErKy/tGxfKRooHLytqn8r8HTghnmHk2dnbrCYMxnw
         X5OazoTQCqC25N7bJreRQzQk4ODErReNA9I+MvacTmTSWy/J2l/86ArCTb66URw6goag
         IMxic/0QKUUNQE3gWV3huDquuTlBU6bKIblmZKpvmjiF0SXsWvdXmCUOltRy/tUuAi4p
         YYxg==
X-Gm-Message-State: ANoB5pmgvZbGm3WAWw93DOVGCJUeYaIfAQcSgPdhjv4qqnt/myVd83zC
        RCq/ZWtUdMpK/y+UEH+yn5C+sA==
X-Google-Smtp-Source: AA0mqf7/AP5zYXuEc0m0ov+YEb0CvMKWc7CDgcN+N/jX1BqZ0D2ehR+bjn3ZqxsyUTZwP+wrkY7e3w==
X-Received: by 2002:a05:6512:c29:b0:4b1:b061:4815 with SMTP id z41-20020a0565120c2900b004b1b0614815mr30077826lfu.18.1670495249722;
        Thu, 08 Dec 2022 02:27:29 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v7-20020ac25927000000b0048a982ad0a8sm3304728lfi.23.2022.12.08.02.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:27:29 -0800 (PST)
Message-ID: <f3e3a3d0-6d21-c782-38a2-c8b2c36242c3@linaro.org>
Date:   Thu, 8 Dec 2022 11:27:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 7/9] dt-bindings: mtd: Split ECC engine with rawnand
 controller
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221208062955.2546-1-xiangsheng.hou@mediatek.com>
 <20221208062955.2546-8-xiangsheng.hou@mediatek.com>
 <fe70d964-229a-8bda-a414-e009dd955e5e@linaro.org>
 <20221208110035.5649a051@xps-13>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221208110035.5649a051@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 11:00, Miquel Raynal wrote:
> Hi Krzysztof,
> 
> krzysztof.kozlowski@linaro.org wrote on Thu, 8 Dec 2022 10:44:17 +0100:
> 
>> On 08/12/2022 07:29, Xiangsheng Hou wrote:
>>> Split MediaTek ECC engine with rawnand controller and convert to
>>> YAML schema.
>>>
>>> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
>>> ---
>>>  .../bindings/mtd/mediatek,mtk-nfc.yaml        | 154 +++++++++++++++
>>>  .../mtd/mediatek,nand-ecc-engine.yaml         |  62 ++++++
>>>  .../devicetree/bindings/mtd/mtk-nand.txt      | 176 ------------------
>>>  3 files changed, 216 insertions(+), 176 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml
>>>  create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,nand-ecc-engine.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/mtd/mtk-nand.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml b/Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml
>>> new file mode 100644
>>> index 000000000000..eb1a44c7ae4e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml
>>> @@ -0,0 +1,154 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mtd/mediatek,mtk-nfc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek(MTK) SoCs raw NAND FLASH controller (NFC)
>>> +
>>> +maintainers:
>>> +  - Xiangsheng Hou <xiangsheng.hou@mediatek.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - mediatek,mt2701-nfc
>>> +      - mediatek,mt2712-nfc
>>> +      - mediatek,mt7622-nfc
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: Base physical address and size of NFI.
>>> +
>>> +  interrupts:
>>> +    items:
>>> +      - description: NFI interrupt
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: clock used for the controller
>>> +      - description: clock used for the pad
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: nfi_clk
>>> +      - const: pad_clk
>>> +
>>> +  ecc-engine:
>>> +    description: device-tree node of the required ECC engine.
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +
>>> +patternProperties:
>>> +  "^nand@[a-f0-9]$":
>>> +    type: object  
>>
>> This should be instead:
>>     $ref: nand-chip.yaml#
>>     unevaluatedProperties: false
>>
>> and then properties below (due to current dtschema limitations) should
>> list properties from nand-controller.yaml:
>>
>>       nand-on-flash-bbt: true
>>
>> Optionally, we could create additional schema - nand-controller-chip,
>> which would be referenced directly by nand-controller and itself would
>> ref nand-chip.
> 
> Isn't this enough? (in linux-next)
> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/Documentation/devicetree/bindings/mtd/nand-controller.yaml?h=mtd/next#n54

No, I tested it and it does not work as intended. In this particular
case. I think this is a limitation of dtschema, because binding itself
looks fine. The problem is that you have:
1. mtk-nfc having nand@ children. mtk-nfc references nand-controller
which brings these children.
2. However nand-controller while bringing these children does two things:
a. ref: nand-chip
b. add more propeties

3. The mtk-nfc must further extend the nand@ child.
4. If you add "unevaluatedProperties: false" you notice warnings of
unevaluated propertie from nand-controller children.

Best regards,
Krzysztof

