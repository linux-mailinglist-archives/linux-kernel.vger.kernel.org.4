Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB2369EDF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjBVEdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBVEdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:33:39 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88584D522;
        Tue, 21 Feb 2023 20:33:37 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31M4XIV6129769;
        Tue, 21 Feb 2023 22:33:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677040398;
        bh=luTSlM0jLaRwDCvwsf1mGSsndoZNg6aHMOfoXwySXow=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cT+TzKTxmQe1l5ywU1OpUbltIDJk+VNP2Ua+HoKQnqyg+M8Sw8/GO1lqAukR30beJ
         mThzDjC5mXGMnYpFYriG52uwoxIsrBW+irlwrFD8qXjhTMp7O/apV1XbvM6SfI4QTy
         pYueoc7v7LMd86nE45A1WalxSIoxkrzlWZmifqtM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31M4XIEh019336
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Feb 2023 22:33:18 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Feb 2023 22:33:18 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Feb 2023 22:33:18 -0600
Received: from [10.24.69.79] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31M4XFdP030368;
        Tue, 21 Feb 2023 22:33:15 -0600
Message-ID: <436873a6-c181-926e-2187-360eb9f7ec4d@ti.com>
Date:   Wed, 22 Feb 2023 10:03:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 1/9] dt-bindings: mfd: ti,j721e-system-controller: Fix
 mux node regex
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230221120612.27366-1-r-gunasekaran@ti.com>
 <20230221120612.27366-2-r-gunasekaran@ti.com>
 <20230221134120.hveyczujflmfjbsz@matted>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20230221134120.hveyczujflmfjbsz@matted>
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



On 21/02/23 7:11 pm, Nishanth Menon wrote:
> On 17:36-20230221, Ravi Gunasekaran wrote:
>> mux-controller nodes may not have "reg" property. Update the regex
>> for such nodes to resolve the dtbs warnings
>>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>>  .../bindings/mfd/ti,j721e-system-controller.yaml          | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> 
> Are you expecting for me to pick this up? Looks like something
> Lee Jones needs to pick up? He is'nt in the CC either?
> 
> If Lee Jones is willing to give me an immutable tag, I can pick the same
> up and pick up dependent patches. Else, please split the series for each
> of the maintainers to pick up without dependency.
> 

I apologize for the inconvenience. Based on the other review comments in this series,
I can update the mux node instead of updating the bindings document.

Regardless of it, in future I will take care of sending the patch to the right
maintainer.

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
>> -- 
>> 2.17.1
>>

-- 
Regards,
Ravi
