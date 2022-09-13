Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA945B6B21
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiIMJqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiIMJp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:45:58 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59185E67D;
        Tue, 13 Sep 2022 02:45:44 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28D9jUwI040710;
        Tue, 13 Sep 2022 04:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663062330;
        bh=AU++iYqWva29bjfI9XPz8HMqFvoP8KDo2s0Fll1WpH4=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=GOna1rC0nCv/Dng5o3Q8QaywDzCvKovFlIV4Oq1JEi/JQhJJFnknFCrfF115lC2cF
         uwnFcbaImkbxaQ3Qjglgb4JzD/NAg1+v6x/Z1v1zPiwjwEOpQ1X6cNShvD9aJq3TE6
         noTtnQyYQI1sr8k9S9pf2kXBsIeqP11fuLRbmyb0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28D9jUhE016051
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Sep 2022 04:45:30 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 13
 Sep 2022 04:45:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 13 Sep 2022 04:45:30 -0500
Received: from [10.24.69.241] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28D9jQcd076907;
        Tue, 13 Sep 2022 04:45:26 -0500
Message-ID: <d802f419-f2d6-faca-e0a9-591f4d705b28@ti.com>
Date:   Tue, 13 Sep 2022 15:15:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
CC:     <robh+dt@kernel.org>, <lee.jones@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: phy: ti: phy-gmii-sel: Add bindings
 for J7200
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
References: <20220912085650.83263-1-s-vadapalli@ti.com>
 <20220912085650.83263-3-s-vadapalli@ti.com>
 <7a673b7c-9e04-2a23-98b9-243696597bba@linaro.org>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <7a673b7c-9e04-2a23-98b9-243696597bba@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 13/09/22 14:57, Krzysztof Kozlowski wrote:
> On 12/09/2022 10:56, Siddharth Vadapalli wrote:
> 
>>  required:
>>    - compatible
>>    - reg
>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>> index 016a37db1ea1..da7cac537e15 100644
>> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>> @@ -53,12 +53,25 @@ properties:
>>        - ti,am43xx-phy-gmii-sel
>>        - ti,dm814-phy-gmii-sel
>>        - ti,am654-phy-gmii-sel
>> +      - ti,j7200-cpsw5g-phy-gmii-sel
>>  
>>    reg:
>>      maxItems: 1
>>  
>>    '#phy-cells': true
>>  
>> +  ti,qsgmii-main-ports:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description: |
>> +      Required only for QSGMII mode. Array to select the port for
> 
> Not really an array...
> 
>> +      QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
>> +      ports automatically. Any one of the 4 CPSW5G ports can act as the
>> +      main port with the rest of them being the QSGMII_SUB ports.
>> +    maxItems: 1
> 
> 
> You say it is an array, but you have here just one item, so it is just
> uint32. Do you expect it to grow? If so, when? Why it cannot grow now?

Thank you for reviewing the patch.

I have defined it as an array because I plan to reuse this property for
other TI devices like J721e which supports up to two QSGMII main ports.
J7200 on the other hand can have at most one QSGMII main port, which is
why I have restricted the array size to one element as of this series.
In the upcoming patches that I will be posting for J721e, I will be
changing the maxItems to 2 for J721e's compatible while it will continue
to remain 1 for J7200's compatible. This is the reason for defining the
property as an array.

Regards,
Siddharth.
