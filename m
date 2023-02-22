Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE49A69EDF7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjBVEfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjBVEft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:35:49 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B29D30B3B;
        Tue, 21 Feb 2023 20:35:45 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31M4Zahx101054;
        Tue, 21 Feb 2023 22:35:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677040536;
        bh=sBHlndvAYJ1XUTcqDA8Fwp7QHZxKnmsy0K249b6SPpU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LrvX3c6fMHDc9pilzaQ2TdHUuBAHevRJpy+OpknGw51SIGVWccumREr78FT5OQorB
         SkMtC9kJhJAdSjgevmxIbfjN2ccSz9sGVmmr1JPRemBjJzP0CMNCqjxyDx6CcVuizB
         CUbn0OmLqoXFh/2kDVtE34c+1aNQKX8k/DJ8ORy4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31M4Zaru020571
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Feb 2023 22:35:36 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Feb 2023 22:35:35 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Feb 2023 22:35:36 -0600
Received: from [10.24.69.79] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31M4ZWWc032555;
        Tue, 21 Feb 2023 22:35:33 -0600
Message-ID: <c814f58e-c266-f889-69b2-88c67aa1e041@ti.com>
Date:   Wed, 22 Feb 2023 10:05:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 1/9] dt-bindings: mfd: ti,j721e-system-controller: Fix
 mux node regex
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-vadapalli@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230221120612.27366-1-r-gunasekaran@ti.com>
 <20230221120612.27366-2-r-gunasekaran@ti.com>
 <fa789c44-d9b9-92a6-00f4-7bc2410c7642@ti.com>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <fa789c44-d9b9-92a6-00f4-7bc2410c7642@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/02/23 7:29 pm, Vignesh Raghavendra wrote:
> 
> 
> On 21/02/23 5:36 pm, Ravi Gunasekaran wrote:
>> mux-controller nodes may not have "reg" property. Update the regex
>> for such nodes to resolve the dtbs warnings
>>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>>  .../bindings/mfd/ti,j721e-system-controller.yaml          | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>> index 76ef4352e13c..532bfa45e6a0 100644
>> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>> @@ -45,7 +45,7 @@ properties:
>>  
>>  patternProperties:
>>    # Optional children
>> -  "^mux-controller@[0-9a-f]+$":
>> +  "^mux-controller(@|-)[0-9a-f]+$":
> 
> Hmm. mmio-mux bindings allow reg property. Why can't we add the same to
> mux-controller node in 2/9 ?

"reg" property can be added to the mux-controller node.
I will do so in the next series

> 
>>      type: object
>>      description:
>>        This is the SERDES lane control mux.
>> @@ -94,6 +94,12 @@ examples:
>>                  /* SERDES4 lane0/1/2/3 select */
>>          };
>>  
>> +        usb_serdes_mux: mux-controller-80 {
>> +                compatible = "mmio-mux";
>> +                #mux-control-cells = <1>;
>> +                mux-reg-masks = <0x0 0x8000000>;
>> +        };
>> +
>>          clock-controller@4140 {
>>              compatible = "ti,am654-ehrpwm-tbclk", "syscon";
>>              reg = <0x4140 0x18>;

-- 
Regards,
Ravi
