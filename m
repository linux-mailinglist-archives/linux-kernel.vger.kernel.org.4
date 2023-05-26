Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7F6712490
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242906AbjEZKZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242910AbjEZKZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:25:06 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A41BFB;
        Fri, 26 May 2023 03:25:01 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id E400724E206;
        Fri, 26 May 2023 18:24:49 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 26 May
 2023 18:24:49 +0800
Received: from [192.168.125.108] (183.27.98.143) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 26 May
 2023 18:24:48 +0800
Message-ID: <5124e6a8-8ca6-71a5-19d6-8c15e954c458@starfivetech.com>
Date:   Fri, 26 May 2023 18:24:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 5/7] dt-bindings: usb: Add StarFive JH7110 USB
 controller
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
References: <20230518112750.57924-1-minda.chen@starfivetech.com>
 <20230518112750.57924-6-minda.chen@starfivetech.com>
 <20230525-shopper-handbrake-27fc06aede32@spud>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230525-shopper-handbrake-27fc06aede32@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.143]
X-ClientProxiedBy: EXCAS065.cuchost.com (172.16.6.25) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/26 5:34, Conor Dooley wrote:
> On Thu, May 18, 2023 at 07:27:48PM +0800, Minda Chen wrote:
>> StarFive JH7110 platforms USB have a wrapper module around
>> the Cadence USBSS-DRD controller. Add binding information doc
>> for that.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> Reviewed-by: Peter Chen <peter.chen@kernel.org>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../bindings/usb/starfive,jh7110-usb.yaml     | 115 ++++++++++++++++++
>>  1 file changed, 115 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml b/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
>> new file mode 100644
>> index 000000000000..24aa9c10d6ab
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
>> @@ -0,0 +1,115 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/usb/starfive,jh7110-usb.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive JH7110 wrapper module for the Cadence USBSS-DRD controller
> 
> I think you told Krzysztof you'd rename this to "StarFive JH7110 Cadence
> USBSS-DRD SoC controller"?
> 
The previous title describe whole USB controller for previous dts node is merged. Now the dts node is split. 
"starfive,jh7110-usb" just contain starfive wrapper layer dts configuration.
> Otherwise, it looks like all the stuff from him and Rob have been sorted
> out, so other than $title this is
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor..
Thanks
