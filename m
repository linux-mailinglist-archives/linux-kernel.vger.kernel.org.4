Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1807379B8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjFUD3P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 23:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjFUD3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:29:09 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80E31985;
        Tue, 20 Jun 2023 20:29:03 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 93F4C7FC9;
        Wed, 21 Jun 2023 11:29:01 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 21 Jun
 2023 11:29:01 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 21 Jun
 2023 11:29:00 +0800
Message-ID: <8e2a50b2-a9ab-e164-a3c2-b7bc11ccdb53@starfivetech.com>
Date:   Wed, 21 Jun 2023 11:28:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/2] dt-bindings: net: motorcomm: Add pad driver
 strength cfg
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Conor Dooley <conor@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20230526090502.29835-1-samin.guo@starfivetech.com>
 <20230526090502.29835-2-samin.guo@starfivetech.com>
 <20230526-glutinous-pristine-fed571235b80@spud>
 <1dbf113c-7592-68bd-6aaf-05ff1d8c538c@starfivetech.com>
 <15eb4ffe-ea12-9a2c-ae9d-c34860384b60@starfivetech.com>
 <b0a61cf4-adb1-4261-b6a5-aeb1e3c1b1aa@lunn.ch>
From:   Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <b0a61cf4-adb1-4261-b6a5-aeb1e3c1b1aa@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re: [PATCH v3 1/2] dt-bindings: net: motorcomm: Add pad driver strength cfg
From: Andrew Lunn <andrew@lunn.ch>
to: Guo Samin <samin.guo@starfivetech.com>
data: 2023/6/20

>> I just got the detailed data of Driver Strength(DS) from Motorcomm ,
>> which applies to both rx_clk and rx_data.
>>
>> |----------------------|
>> |     ds map table     |
>> |----------------------|
>> | DS(3b) | Current (mA)|
>> |--------|-------------|
>> |   000  |     1.20    |
>> |   001  |     2.10    |
>> |   010  |     2.70    |
>> |   011  |     2.91    |
>> |   100  |     3.11    |
>> |   101  |     3.60    |
>> |   110  |     3.97    |
>> |   111  |     4.35    |
>> |--------|-------------|
>>
>> Since these currents are not integer values
> 
> Integers is not a problem. Simply use uA.
> 
>> and have no regularity, it is not very good to use in the drive/dts
>> in my opinion.
> 
> I think they are fine to use. Add a lookup table, microamps to
> register value. Return -EINVAL if the requested value is not in the
> table. List the valid values in the schema, so the checker tool might
> point out problems.
> 
>       Andrew

Thanks Andrew,
I'll use a lookup table to try.
Another thing we need to deal with DS under different IO voltages(1.8V/2.5V/3.3V).

The IO voltage can be configured via a hardware pull-up resistor (visionfive 2 is configured to 1.8V by default), 
and then the IO voltage can be obtained or set through the register（0xA001）

Chip_Config (EXT_0xA001)
|Bit  |Symbol  |Access  |Default  |Description |
|5:4  |Cfg_ldo |RW      |0x0      |Rgmii ldo voltage and RGMII/MDC/MDIO PAD's level shifter control. Depends on strapping.|
                                  |2'b11: 1.8v   2'b10: 1.8v    2'b01: 2.5v    2'b00: 3.3v                                |

      |----------------------|            
      | ds map table(1.8V)   |
      |----------------------|
      | DS(3b) | Current (mA)|
      |   000  |     1.20    |
      |   001  |     2.10    |
      |   010  |     2.70    |
      |   011  |     2.91    |
      |   100  |     3.11    |
      |   101  |     3.60    |
      |   110  |     3.97    |
      |   111  |     4.35    |
      |--------|-------------|


      |----------------------|
      | ds map table(3.3V)   |
      |----------------------|
      | DS(3b) | Current (mA)|
      |   000  |     3.07    |
      |   001  |     4.08    |
      |   010  |     4.37    |
      |   011  |     4.68    |
      |   100  |     5.02    |
      |   101  |     5.45    |
      |   110  |     5.74    |
      |   111  |     6.14    |
      |--------|-------------|
 
(The current value of 2.5V is not available to us now)

When we need to deal with current values at different voltages, using register values in drives may be simpler, comparing the current value.
Of course, I will also follow your suggestion and use the current value + lookup table to implement a solution. Thanks!

Best regards,
Samin
