Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837C06D4136
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjDCJuc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjDCJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:49:59 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A47125;
        Mon,  3 Apr 2023 02:49:10 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1268F24E36E;
        Mon,  3 Apr 2023 17:48:58 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 3 Apr
 2023 17:48:57 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 3 Apr
 2023 17:48:57 +0800
Message-ID: <9c132e62-7830-90bf-2c3e-1568a54eb6ec@starfivetech.com>
Date:   Mon, 3 Apr 2023 17:48:56 +0800
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
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <0aa3a039-daf3-7e05-6da9-258335a5ca20@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.3 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/1 4:12, Krzysztof Kozlowski wrote:
> On 31/03/2023 14:18, Jack Zhu wrote:
>> Convert DT bindings document for Cadence MIPI-CSI2 RX controller
>> to DT schema format.
>> 
>> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
>> ---
>>  .../devicetree/bindings/media/cdns,csi2rx.txt | 100 ----------
>>  .../bindings/media/cdns,csi2rx.yaml           | 174 ++++++++++++++++++
>>  MAINTAINERS                                   |   1 +
>>  3 files changed, 175 insertions(+), 100 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.txt
>>  create mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt b/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
>> deleted file mode 100644
>> index 6b02a0657ad9..000000000000
>> --- a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
>> +++ /dev/null
>> @@ -1,100 +0,0 @@
>> -Cadence MIPI-CSI2 RX controller
>> -===============================
>> -
>> -The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
>> -lanes in input, and 4 different pixel streams in output.
>> -
>> -Required properties:
>> -  - compatible: must be set to "cdns,csi2rx" and an SoC-specific compatible
> 
> 
> ...
> 
>> +$id: http://devicetree.org/schemas/media/cdns,csi2rx.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Cadence MIPI-CSI2 RX controller
>> +
>> +maintainers:
>> +  - Maxime Ripard <mripard@kernel.org>
>> +
>> +description:
>> +  The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
>> +  lanes in input, and 4 different pixel streams in output.
>> +
>> +properties:
>> +  compatible:
>> +    const: cdns,csi2rx
> 
> That's not equivalent conversion and your commit msg does no mention any
> drops in compatibles.
> 
The equivalent conversion refers to 'an SoC-specific compatible'?
I'm not sure that, is it enough to add a description (drop an 'SoC-specific compatible')
to my next version commit message?

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: CSI2Rx system clock
>> +      - description: Gated Register bank clock for APB interface
>> +      - description: pixel Clock for Stream interface 0
>> +      - description: pixel Clock for Stream interface 1
>> +      - description: pixel Clock for Stream interface 2
>> +      - description: pixel Clock for Stream interface 3
>> +
> 
> Best regards,
> Krzysztof
> 
