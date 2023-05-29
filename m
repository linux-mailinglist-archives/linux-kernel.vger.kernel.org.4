Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77917714261
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 05:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjE2Dqe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 28 May 2023 23:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjE2Dqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 23:46:31 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE214B1;
        Sun, 28 May 2023 20:46:29 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 96CD1809C;
        Mon, 29 May 2023 11:46:21 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 29 May
 2023 11:46:21 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 29 May
 2023 11:46:20 +0800
Message-ID: <1dbf113c-7592-68bd-6aaf-05ff1d8c538c@starfivetech.com>
Date:   Mon, 29 May 2023 11:46:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/2] dt-bindings: net: motorcomm: Add pad driver
 strength cfg
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
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
From:   Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <20230526-glutinous-pristine-fed571235b80@spud>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX062.cuchost.com
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
From: Conor Dooley <conor@kernel.org>
to: Samin Guo <samin.guo@starfivetech.com>
data: 2023/5/27

> On Fri, May 26, 2023 at 05:05:01PM +0800, Samin Guo wrote:
>> The motorcomm phy (YT8531) supports the ability to adjust the drive
>> strength of the rx_clk/rx_data, the value range of pad driver
>> strength is 0 to 7.
>>
>> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
>> ---
>>  .../devicetree/bindings/net/motorcomm,yt8xxx.yaml    | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>> index 157e3bbcaf6f..29a1997a1577 100644
>> --- a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>> @@ -52,6 +52,18 @@ properties:
>>        for a timer.
>>      type: boolean
>>  
>> +  motorcomm,rx-clk-driver-strength:
>> +    description: drive strength of rx_clk pad.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
> 
> I think you should use minimum & maximum instead of these listed out
> enums.

Thanks Conor, This can be improved in the next version.

 You have also had this comment since v1 & were reminded of it on
> v2 by Krzysztof: "What do the numbers mean? What are the units? mA?"
> 


The good news is that we just got some data about units from Motorcomm. 
Maybe I can post the data show of the unit later after I get the complete data.



> This information should go into the binding, not sit in a thread on a
> mailing list that noone will look at when trying to write a DT :(
> 
> Thanks,
> Conor.
>

Yes，when we have the complete 'unit' data, it will be placed in DT.

Best regards,
Samin
 
>> +    default: 3
>> +
>> +  motorcomm,rx-data-driver-strength:
>> +    description: drive strength of rx_data/rx_ctl rgmii pad.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
>> +    default: 3
>> +
>>    motorcomm,tx-clk-adj-enabled:
>>      description: |
>>        This configuration is mainly to adapt to VF2 with JH7110 SoC.
>> -- 
>> 2.17.1
>>
