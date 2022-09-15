Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FAA5B93EE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 07:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiIOF3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 01:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiIOF3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 01:29:05 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCC38A1F6;
        Wed, 14 Sep 2022 22:29:03 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28F5SiwT069455;
        Thu, 15 Sep 2022 00:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663219724;
        bh=K0Smy6+dcZ3+jbrkiTBsT2EN7qk27a0ML3lu4mrkYSk=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=a3JK2oAeIy2caPv/gh4aon6eVcU+f6SrFLgeWaAmOlV3fyvyvKJWofaVs+c6B8teG
         JzRHatAadZUsNxmc2Nc2GksFLbAwxZ2RR2kmxbC59V6IO8tkkd76Eu81MYDhnuuiM/
         CtBCZKdOvHbw4rLG2twIHiQxiGjnziJMJ24eCWvI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28F5Siuo009104
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Sep 2022 00:28:44 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 15
 Sep 2022 00:28:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 15 Sep 2022 00:28:44 -0500
Received: from [10.24.69.241] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28F5Sdbe001244;
        Thu, 15 Sep 2022 00:28:40 -0500
Message-ID: <d48e5ef4-6d5b-0977-ed45-de810e42356c@ti.com>
Date:   Thu, 15 Sep 2022 10:58:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
CC:     <lee.jones@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <sjakhade@cadence.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH 1/6] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for
 J721e
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
References: <20220914093911.187764-1-s-vadapalli@ti.com>
 <20220914093911.187764-2-s-vadapalli@ti.com>
 <20220914161527.GA2269201-robh@kernel.org>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20220914161527.GA2269201-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 14/09/22 21:45, Rob Herring wrote:
> On Wed, Sep 14, 2022 at 03:09:06PM +0530, Siddharth Vadapalli wrote:
>> TI's J721e SoC supports additional PHY modes like QSGMII and SGMII
>> that are not supported on earlier SoCs. Add a compatible for it.
>>
>> Extend ti,qsgmii-main-ports property to support selection of upto
>> two main ports at once across the two QSGMII interfaces.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 52 ++++++++++++++++---
>>  1 file changed, 46 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>> index da7cac537e15..1e19efab018b 100644
>> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>> @@ -54,6 +54,7 @@ properties:
>>        - ti,dm814-phy-gmii-sel
>>        - ti,am654-phy-gmii-sel
>>        - ti,j7200-cpsw5g-phy-gmii-sel
>> +      - ti,j721e-cpsw9g-phy-gmii-sel
>>  
>>    reg:
>>      maxItems: 1
>> @@ -65,12 +66,19 @@ properties:
>>      description: |
>>        Required only for QSGMII mode. Array to select the port for
>>        QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
>> -      ports automatically. Any one of the 4 CPSW5G ports can act as the
>> -      main port with the rest of them being the QSGMII_SUB ports.
>> -    maxItems: 1
>> -    items:
>> -      minimum: 1
>> -      maximum: 4
>> +      ports automatically. For J7200 CPSW5G with the compatible:
>> +      ti,j7200-cpsw5g-phy-gmii-sel, ti,qsgmii-main-ports is an
>> +      array of only one element, which is the port number ranging from
>> +      1 to 4. For J721e CPSW9G with the compatible:
>> +      ti,j721e-cpsw9g-phy-gmii-sel, ti,qsgmii-main-ports is an array
>> +      of two elements, which corresponds to two potential QSGMII main
>> +      ports. The first element and second element of the array can both
>> +      range from 1 to 8 each, corresponding to two QSGMII main ports.
>> +      For J721e CPSW9G, to configure port 2 as the first QSGMII main
>> +      port and port 7 as the second QSGMII main port, we specify:
>> +      ti,qsgmii-main-ports = <2>, <7>;
>> +      If only one QSGMII main port is desired, mention the same main
>> +      port twice.
> 
> Two different forms for the same property name is not great. Just make a 
> new property if you need something different.

Thank you for reviewing the patch. Based on the discussion for the
previous series at [1], I had planned to reuse the same property
"ti,qsgmii-main-ports" for TI's J721e device too. The reason for this is
that the property represents the same feature on both devices which is
that of the QSGMII main port. The only difference between the two of
them is that J7200's CPSW5G has 4 external ports while J721e's CPSW9G
has 8 external ports. Thus, J7200 can have at most one QSGMII main port
while J721e can have up to two. Adding a new property which describes
the same feature appears to be redundant to me. Please let me know.

[1]-> https://lore.kernel.org/r/48080f45-ea9d-e8dc-7720-ef82fc84e3b3@linaro.org/

Regards,
Siddharth.
