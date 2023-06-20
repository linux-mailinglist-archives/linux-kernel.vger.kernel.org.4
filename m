Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA8273620C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFTDKX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jun 2023 23:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjFTDKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:10:09 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61050119;
        Mon, 19 Jun 2023 20:10:03 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1DB288109;
        Tue, 20 Jun 2023 11:09:56 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 20 Jun
 2023 11:09:56 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 20 Jun
 2023 11:09:55 +0800
Message-ID: <15eb4ffe-ea12-9a2c-ae9d-c34860384b60@starfivetech.com>
Date:   Tue, 20 Jun 2023 11:09:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/2] dt-bindings: net: motorcomm: Add pad driver
 strength cfg
Content-Language: en-US
From:   Guo Samin <samin.guo@starfivetech.com>
To:     Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "Heiner Kallweit" <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20230526090502.29835-1-samin.guo@starfivetech.com>
 <20230526090502.29835-2-samin.guo@starfivetech.com>
 <20230526-glutinous-pristine-fed571235b80@spud>
 <1dbf113c-7592-68bd-6aaf-05ff1d8c538c@starfivetech.com>
In-Reply-To: <1dbf113c-7592-68bd-6aaf-05ff1d8c538c@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Re: [PATCH v3 1/2] dt-bindings: net: motorcomm: Add pad driver strength cfg
From: Guo Samin <samin.guo@starfivetech.com>
to: Conor Dooley <conor@kernel.org>; Andrew Lunn <andrew@lunn.ch>
data: 2023/5/29

> Re: [PATCH v3 1/2] dt-bindings: net: motorcomm: Add pad driver strength cfg
> From: Conor Dooley <conor@kernel.org>
> to: Samin Guo <samin.guo@starfivetech.com>
> data: 2023/5/27
> 
>> On Fri, May 26, 2023 at 05:05:01PM +0800, Samin Guo wrote:
>>> The motorcomm phy (YT8531) supports the ability to adjust the drive
>>> strength of the rx_clk/rx_data, the value range of pad driver
>>> strength is 0 to 7.
>>>
>>> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
>>> ---
>>>  .../devicetree/bindings/net/motorcomm,yt8xxx.yaml    | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>>> index 157e3bbcaf6f..29a1997a1577 100644
>>> --- a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>>> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>>> @@ -52,6 +52,18 @@ properties:
>>>        for a timer.
>>>      type: boolean
>>>  
>>> +  motorcomm,rx-clk-driver-strength:
>>> +    description: drive strength of rx_clk pad.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
>>
>> I think you should use minimum & maximum instead of these listed out
>> enums.
> 
> Thanks Conor, This can be improved in the next version.
> 
>  You have also had this comment since v1 & were reminded of it on
>> v2 by Krzysztof: "What do the numbers mean? What are the units? mA?"
>>
> 
> 
> The good news is that we just got some data about units from Motorcomm. 
> Maybe I can post the data show of the unit later after I get the complete data.
>

Hi Andrew & Conor,

Sorry, haven't updated in a while.
I just got the detailed data of Driver Strength(DS) from Motorcomm , which applies to both rx_clk and rx_data.

|----------------------|
|     ds map table     |
|----------------------|
| DS(3b) | Current (mA)|
|--------|-------------|
|   000  |     1.20    |
|   001  |     2.10    |
|   010  |     2.70    |
|   011  |     2.91    |
|   100  |     3.11    |
|   101  |     3.60    |
|   110  |     3.97    |
|   111  |     4.35    |
|--------|-------------|

Since these currents are not integer values and have no regularity, it is not very good to use in the drive/dts in my opinion.

Therefore, I tend to continue to use DS(0-7) in dts/driver, and adding a description of the current value corresponding to DS in dt-bindings. 

Like This:

+  motorcomm,rx-clk-driver-strength:
+    description: drive strength of rx_clk pad.
+      |----------------------|
+      | rx_clk ds map table  |
+      |----------------------|
+      | DS(3b) | Current (mA)|
+      |   000  |     1.20    |
+      |   001  |     2.10    |
+      |   010  |     2.70    |
+      |   011  |     2.91    |
+      |   100  |     3.11    |
+      |   101  |     3.60    |
+      |   110  |     3.97    |
+      |   111  |     4.35    |
+      |--------|-------------|
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+    default: 3
+
+  motorcomm,rx-data-driver-strength:
+    description: drive strength of rx_data/rx_ctl rgmii pad.
+      |----------------------|
+      | rx_data ds map table |
+      |----------------------|
+      | DS(3b) | Current (mA)|
+      |   000  |     1.20    |
+      |   001  |     2.10    |
+      |   010  |     2.70    |
+      |   011  |     2.91    |
+      |   100  |     3.11    |
+      |   101  |     3.60    |
+      |   110  |     3.97    |
+      |   111  |     4.35    |
+      |--------|-------------|
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+    default: 3
+


Or use minimum & maximum instead of these listed out enums(Suggested by Conor)

+  motorcomm,rx-clk-driver-strength:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 3
+    minimum: 0
+    maximum: 7
+    description: drive strength of rx_clk pad.
+      |----------------------|
+      | rx_clk ds map table  |
+      |----------------------|
+      | DS(3b) | Current (mA)|
+      |   000  |     1.20    |
+      |   001  |     2.10    |
+      |   010  |     2.70    |
+      |   011  |     2.91    |
+      |   100  |     3.11    |
+      |   101  |     3.60    |
+      |   110  |     3.97    |
+      |   111  |     4.35    |
+      |--------|-------------|
+
+  motorcomm,rx-data-driver-strength:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 3
+    minimum: 0
+    maximum: 7
+    description: drive strength of rx_data/rx_ctl rgmii pad.
+      |----------------------|
+      | rx_data ds map table |
+      |----------------------|
+      | DS(3b) | Current (mA)|
+      |   000  |     1.20    |
+      |   001  |     2.10    |
+      |   010  |     2.70    |
+      |   011  |     2.91    |
+      |   100  |     3.11    |
+      |   101  |     3.60    |
+      |   110  |     3.97    |
+      |   111  |     4.35    |
+      |--------|-------------|
+


Looking forward to your suggestions.


Best regards,
Samin

> 
> 
>> This information should go into the binding, not sit in a thread on a
>> mailing list that noone will look at when trying to write a DT :(
>>
>> Thanks,
>> Conor.
>>
> 
> Yes，when we have the complete 'unit' data, it will be placed in DT.
> 
> Best regards,
> Samin
>  
>>> +    default: 3
>>> +
>>> +  motorcomm,rx-data-driver-strength:
>>> +    description: drive strength of rx_data/rx_ctl rgmii pad.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
>>> +    default: 3
>>> +
>>>    motorcomm,tx-clk-adj-enabled:
>>>      description: |
>>>        This configuration is mainly to adapt to VF2 with JH7110 SoC.
>>> -- 
>>> 2.17.1
>>>
