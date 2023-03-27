Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043CD6CA20A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjC0LE7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 07:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjC0LEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:04:48 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A994F3C3F;
        Mon, 27 Mar 2023 04:04:46 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 99C8324E1BE;
        Mon, 27 Mar 2023 19:04:38 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Mar
 2023 19:04:38 +0800
Received: from [192.168.125.108] (113.72.145.117) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Mar
 2023 19:04:37 +0800
Message-ID: <2d46a4ab-f5d3-60b2-6650-3a35395c0eb8@starfivetech.com>
Date:   Mon, 27 Mar 2023 19:04:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 3/5] dt-binding: Add JH7110 USB wrapper layer doc.
Content-Language: en-US
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20230315104411.73614-1-minda.chen@starfivetech.com>
 <20230315104411.73614-4-minda.chen@starfivetech.com>
 <7799e176e73d1385322e5efba8479e56544c664b.camel@pengutronix.de>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <7799e176e73d1385322e5efba8479e56544c664b.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.145.117]
X-ClientProxiedBy: EXCAS063.cuchost.com (172.16.6.23) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/23 17:23, Philipp Zabel wrote:
> On Mi, 2023-03-15 at 18:44 +0800, Minda Chen wrote:
>> The dt-binding doc of Cadence USBSS-DRD controller wrapper
>> layer.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>  .../bindings/usb/starfive,jh7110-usb.yaml     | 119 ++++++++++++++++++
>>  1 file changed, 119 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml b/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
>> new file mode 100644
>> index 000000000000..b1a8dc6d7b4b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
>> @@ -0,0 +1,119 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/usb/starfive,jh7110-usb.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive JH7110 wrapper module for the Cadence USBSS-DRD controller
>> +
>> +maintainers:
>> +  - Minda Chen <minda.chen@starfivetech.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-usb
>> +
>> +  clocks:
>> +    items:
>> +      - description: lpm clock
>> +      - description: stb clock
>> +      - description: apb clock
>> +      - description: axi clock
>> +      - description: utmi apb clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: lpm
>> +      - const: stb
>> +      - const: apb
>> +      - const: axi
>> +      - const: utmi_apb
>> +
>> +  resets:
>> +    items:
>> +      - description: PWRUP reset
>> +      - description: APB reset
>> +      - description: AXI reset
>> +      - description: UTMI_APB reset
> 
> I'd add a "reset-names" property, just in case there is ever a reason
> to trigger any of the resets independently from the others.
> 
OK, Thanks
> regards
> Philipp
