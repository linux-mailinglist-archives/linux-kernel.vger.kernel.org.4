Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E376D56BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 04:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjDDC04 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 22:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjDDC0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 22:26:52 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780181BFE;
        Mon,  3 Apr 2023 19:26:47 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 61CFD24E227;
        Tue,  4 Apr 2023 10:26:45 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 4 Apr
 2023 10:26:45 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 4 Apr
 2023 10:26:44 +0800
Message-ID: <d7f04e2c-270f-a7dd-726b-ca0073e4d6a3@starfivetech.com>
Date:   Tue, 4 Apr 2023 10:26:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 3/9] media: dt-bindings: cadence-csi2rx: Convert to DT
 schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        "Todor Tomov" <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230331121826.96973-1-jack.zhu@starfivetech.com>
 <20230331121826.96973-4-jack.zhu@starfivetech.com>
 <0aa3a039-daf3-7e05-6da9-258335a5ca20@linaro.org>
 <9c132e62-7830-90bf-2c3e-1568a54eb6ec@starfivetech.com>
 <c86d2388-609c-528e-b250-90bd85b97264@linaro.org>
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <c86d2388-609c-528e-b250-90bd85b97264@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/3 17:53, Krzysztof Kozlowski wrote:
> On 03/04/2023 11:48, Jack Zhu wrote:
>> 
>> 
>> On 2023/4/1 4:12, Krzysztof Kozlowski wrote:
>>> On 31/03/2023 14:18, Jack Zhu wrote:
>>>> Convert DT bindings document for Cadence MIPI-CSI2 RX controller
>>>> to DT schema format.
>>>>
>>>> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>>>> ---
>>>>  .../devicetree/bindings/media/cdns,csi2rx.txt | 100 ----------
>>>>  .../bindings/media/cdns,csi2rx.yaml           | 174 ++++++++++++++++++
>>>>  MAINTAINERS                                   |   1 +
>>>>  3 files changed, 175 insertions(+), 100 deletions(-)
>>>>  delete mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.txt
>>>>  create mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt b/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
>>>> deleted file mode 100644
>>>> index 6b02a0657ad9..000000000000
>>>> --- a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
>>>> +++ /dev/null
>>>> @@ -1,100 +0,0 @@
>>>> -Cadence MIPI-CSI2 RX controller
>>>> -===============================
>>>> -
>>>> -The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
>>>> -lanes in input, and 4 different pixel streams in output.
>>>> -
>>>> -Required properties:
>>>> -  - compatible: must be set to "cdns,csi2rx" and an SoC-specific compatible
>>>
>>>
>>> ...
>>>
>>>> +$id: http://devicetree.org/schemas/media/cdns,csi2rx.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Cadence MIPI-CSI2 RX controller
>>>> +
>>>> +maintainers:
>>>> +  - Maxime Ripard <mripard@kernel.org>
>>>> +
>>>> +description:
>>>> +  The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
>>>> +  lanes in input, and 4 different pixel streams in output.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: cdns,csi2rx
>>>
>>> That's not equivalent conversion and your commit msg does no mention any
>>> drops in compatibles.
>>>
>> The equivalent conversion refers to 'an SoC-specific compatible'?
> 
> Yes.
> 
>> I'm not sure that, is it enough to add a description (drop an 'SoC-specific compatible')
>> to my next version commit message?
> 
> Original binding did not allow csi2rx compatible alone. Your binding
> here allows it, thus it is not simple conversion.
> 
> I think patch 5 should be squashed here - with proper explanation.
> Usually new compatibles should not be messed with conversion, but this
> conversion on its own does not make much sense.
> 
Ok, I will merge patch 5 into the patch, and add explanation in my
commit msg.
> 
> 
> Best regards,
> Krzysztof
> 
