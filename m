Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441077420A0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 08:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjF2Gq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 02:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjF2Gpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 02:45:50 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A10187;
        Wed, 28 Jun 2023 23:45:44 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 2682F817A;
        Thu, 29 Jun 2023 14:45:41 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 29 Jun
 2023 14:45:41 +0800
Received: from [192.168.125.128] (183.27.97.206) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 29 Jun
 2023 14:45:40 +0800
Message-ID: <2270fd7f-1751-066a-0da5-e35cdd59fd2f@starfivetech.com>
Date:   Thu, 29 Jun 2023 14:42:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 2/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230613125852.211636-1-xingyu.wu@starfivetech.com>
 <20230613125852.211636-3-xingyu.wu@starfivetech.com>
 <7e2d6bfe-5687-97c5-778b-c02e9c0894af@linaro.org>
 <a83c98ae-2f6c-00c4-5d05-fc304718e05a@starfivetech.com>
 <20230628-affix-maverick-84a08905f05b@spud>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <20230628-affix-maverick-84a08905f05b@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.206]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/29 1:34, Conor Dooley wrote:
> On Wed, Jun 28, 2023 at 02:44:10PM +0800, Xingyu Wu wrote:
>> On 2023/6/14 2:31, Krzysztof Kozlowski wrote:
>> > On 13/06/2023 14:58, Xingyu Wu wrote:
>> >> From: William Qiu <william.qiu@starfivetech.com>
>> >> 
>> >> Add documentation to describe StarFive System Controller Registers.
>> >> 
>> >> Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> >> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> >> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> >> ---
>> >>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 62 +++++++++++++++++++
>> >>  MAINTAINERS                                   |  7 +++
>> >>  2 files changed, 69 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>> >> 
>> >> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>> >> new file mode 100644
>> >> index 000000000000..a81190f8a54d
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>> >> @@ -0,0 +1,62 @@
>> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> >> +%YAML 1.2
>> >> +---
>> >> +$id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-syscon.yaml#
>> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> >> +
>> >> +title: StarFive JH7110 SoC system controller
>> >> +
>> >> +maintainers:
>> >> +  - William Qiu <william.qiu@starfivetech.com>
>> >> +
>> >> +description: |
>> >> +  The StarFive JH7110 SoC system controller provides register information such
>> >> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
>> >> +
>> >> +properties:
>> >> +  compatible:
>> >> +    oneOf:
>> >> +      - items:
>> >> +          - const: starfive,jh7110-sys-syscon
>> >> +          - const: syscon
>> >> +          - const: simple-mfd
>> >> +      - items:
>> >> +          - enum:
>> >> +              - starfive,jh7110-aon-syscon
>> >> +              - starfive,jh7110-stg-syscon
>> >> +          - const: syscon
>> >> +
>> >> +  reg:
>> >> +    maxItems: 1
>> >> +
>> >> +  clock-controller:
>> >> +    $ref: /schemas/clock/starfive,jh7110-pll.yaml#
>> >> +    type: object
>> >> +
>> >> +  "#power-domain-cells":
>> >> +    const: 1
>> >> +
>> >> +required:
>> >> +  - compatible
>> >> +  - reg
>> >> +
>> >> +allOf:
>> >> +  - if:
>> >> +      properties:
>> >> +        compatible:
>> >> +          contains:
>> >> +            const: starfive,jh7110-aon-syscon
>> >> +    then:
>> >> +      required:
>> >> +        - "#power-domain-cells"
>> > 
>> > Where did you implement the results of the discussion that only some
>> > devices can have power and clock controller?
>> > 
>> > According to your code all of above - sys, aon and stg - have clock and
>> > power controllers. If not, then the code is not correct, so please do
>> > not respond with what is where (like you did last time) but actually
>> > implement what you say.
>> > 
>> 
>> Hi Krzysztof, I need to modify the code to implement it.
>> If I drop the 'clock-controller' and '"#power-domain-cells"' in properites, and change to this:
>> 
>> --- a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>> @@ -29,28 +29,33 @@ properties:
>>    reg:
>>      maxItems: 1
>>  
>> -  clock-controller:
>> -    $ref: /schemas/clock/starfive,jh7110-pll.yaml#
>> -    type: object
>> -
>> -  "#power-domain-cells":
>> -    const: 1
>> -
>>  required:
>>    - compatible
>>    - reg
>>  
>>  allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: starfive,jh7110-sys-syscon
>> +    then:
>> +      properties:
>> +        clock-controller:
>> +          $ref: /schemas/clock/starfive,jh7110-pll.yaml#
>> +          type: object
> 
> Why do this?
> Why not define the property has you have been doing, but only allow it
> on the syscons that support it?
> See the section starting at L205 of example-schema.yaml.
> 
>> +
>>    - if:
>>        properties:
>>          compatible:
>>            contains:
>>              const: starfive,jh7110-aon-syscon
>>      then:
>> -      required:
>> -        - "#power-domain-cells"
>> +      properties:
>> +        "#power-domain-cells":
>> +          const: 1
>>  
> 
>> -additionalProperties: false
>> +additionalProperties: true
> 
> Why do you need this?
> Allowing "additionalProperties: true" sounds like you've got some prblem
> that you are trying to hide...
> 
>> Would it be better to show that sys-syscon only has clock-controller and aon-syscon is power controller?
> 
> You should only permit the properties where they are valid, yes.
> 

Yeah, following your advice, I modified the codes and there are two options:

--- a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
+++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
@@ -41,6 +41,16 @@ required:
   - reg
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7110-sys-syscon
+    then:
+      required:
+        - clock-controller
+      properties:
+        "#power-domain-cells": false
   - if:
       properties:
         compatible:
           contains:
             const: starfive,jh7110-aon-syscon
     then:
       required:
         - "#power-domain-cells"
+      properties:
+        clock-controller: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7110-stg-syscon
+    then:
+      properties:
+        clock-controller: false
+        "#power-domain-cells": false
 
 additionalProperties: false

Or :

--- a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
+++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
@@ -41,6 +41,17 @@ required:
   - reg
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7110-sys-syscon
+    then:
+      required:
+        - clock-controller
+    else:
+      properties:
+        clock-controller: false
   - if:
       properties:
         compatible:
           contains:
             const: starfive,jh7110-aon-syscon
     then:
       required:
         - "#power-domain-cells"
+    else:
+      properties:
+        "#power-domain-cells": false
 
 additionalProperties: false

Which one is better? Thanks.

Best regards,
Xingyu Wu
