Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9C46FEC23
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbjEKHBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjEKHAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:00:55 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DB85265;
        Thu, 11 May 2023 00:00:51 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id BB6A324E1D3;
        Thu, 11 May 2023 15:00:48 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 11 May
 2023 15:00:48 +0800
Received: from [192.168.125.131] (113.72.146.187) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 11 May
 2023 15:00:47 +0800
Message-ID: <2b1c8f8b-eb1f-eca2-8c18-5dd3c8881ee3@starfivetech.com>
Date:   Thu, 11 May 2023 14:59:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
Content-Language: en-US
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230414024157.53203-1-xingyu.wu@starfivetech.com>
 <20230414024157.53203-6-xingyu.wu@starfivetech.com>
 <20230424-footsie-compost-d6624c8ef4e8@spud>
 <20230508-margarita-fondling-c9b970ad73a9@spud>
 <014dd7b2-9623-805c-97a6-5b3c5f120b79@starfivetech.com>
 <7527C059-95A2-49EA-AFE0-B089D3651A6B@kernel.org>
 <735dd2fb-107c-5ecf-4477-70b569cad884@starfivetech.com>
In-Reply-To: <735dd2fb-107c-5ecf-4477-70b569cad884@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.187]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/9 14:52, Xingyu Wu wrote:
> On 2023/5/9 14:35, Conor Dooley wrote:
>> 
>> 
>> On 9 May 2023 07:23:18 IST, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>>>On 2023/5/9 3:24, Conor Dooley wrote:
>>>> On Mon, Apr 24, 2023 at 06:15:47PM +0100, Conor Dooley wrote:
>>>>> On Fri, Apr 14, 2023 at 10:41:55AM +0800, Xingyu Wu wrote:
>>>>> > From: William Qiu <william.qiu@starfivetech.com>
>>>>> > 
>>>>> > Add documentation to describe StarFive System Controller Registers.
>>>>> > 
>>>>> > Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>>>> > ---
>>>>> >  .../soc/starfive/starfive,jh7110-syscon.yaml  | 58 +++++++++++++++++++
>>>>> >  MAINTAINERS                                   |  6 ++
>>>>> >  2 files changed, 64 insertions(+)
>>>>> >  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>>> > 
>>>>> > diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>>> > new file mode 100644
>>>>> > index 000000000000..de086e74a229
>>>>> > --- /dev/null
>>>>> > +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>>> > @@ -0,0 +1,58 @@
>>>>> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>> > +%YAML 1.2
>>>>> > +---
>>>>> > +$id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-syscon.yaml#
>>>>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> > +
>>>>> > +title: StarFive JH7110 SoC system controller
>>>>> > +
>>>>> > +maintainers:
>>>>> > +  - William Qiu <william.qiu@starfivetech.com>
>>>>> > +
>>>>> > +description: |
>>>>> > +  The StarFive JH7110 SoC system controller provides register information such
>>>>> > +  as offset, mask and shift to configure related modules such as MMC and PCIe.
>>>>> > +
>>>>> > +properties:
>>>>> > +  compatible:
>>>>> > +    oneOf:
>>>>> > +      - items:
>>>>> > +          - enum:
>>>>> > +              - starfive,jh7110-aon-syscon
>>>>> > +              - starfive,jh7110-sys-syscon
>>>>> > +          - const: syscon
>>>>> > +          - const: simple-mfd
>>>>> > +      - items:
>>>>> > +          - const: starfive,jh7110-stg-syscon
>>>>> > +          - const: syscon
>>>>> > +
>>>>> > +  reg:
>>>>> > +    maxItems: 1
>>>>> > +
>>>>> > +  clock-controller:
>>>>> > +    $ref: /schemas/clock/starfive,jh7110-pll.yaml#
>>>>> > +    type: object
>>>>> > +
>>>>> > +  power-controller:
>>>>> > +    $ref: /schemas/power/starfive,jh7110-pmu.yaml#
>>>>> > +    type: object
>>>>> 
>>>>> My plan was to grab this patch after the merge window, but there's been
>>>>> some back and forth [1] about what exactly should be a power-controller
>>>>> here. Given the merge window is open & I know Emil wants to look at the
>>>>> various clock bits for the JH7110, I don't think there's a pressing need
>>>>> for you to do anything here, but figured I'd at least mention how things
>>>>> are going on this thread too.
>>>> 
>>>> To follow up on this, it transpired in that thread that this node, not a
>>>> child node, should be the power controller.
>>>> 
>>>> Up to you StarFive folk how you wish to resend, but I am fine with it
>>>> being in this series, I shall just not pick up the soc driver patches
>>>> until the resent binding is applied by Stephen.
>>>> 
>>>
>>>Thanks. I had discussed with changhuang.liang about this. And I will drop
>>>the 'starfive,jh7110-aon-syscon' and 'power-controller' in next patchset.
>>>Changhuang will take these in his patchset.
>> 
>> Won't that result in broken bindings, since there's a ref to the pll binding?
>> Keeping it in the same series (i.e. this one) makes
>> the most sense to me.
>> 
> 
> I will keep the 'sys-syscon' and 'stg-syscon'. The ref just follows the 'sys-syscon'
> so I also keep it and the pll binding.
> I also hope to add the 'aon-syscon' in this same series but it should be the power
> controller, so I have to give up it.
> 

I synchronized with Chang Huang. It is decided to keep 'aon-syscon' as the power
controller in this and do not add child node in 'aon-syscon'.
And I will update it in the next version of patch.

Best regards,
Xingyu Wu
