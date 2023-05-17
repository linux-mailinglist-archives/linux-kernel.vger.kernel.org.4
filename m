Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE5E706F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjEQROR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjEQROP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:14:15 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D5626B6;
        Wed, 17 May 2023 10:14:13 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34HHE9N1129523;
        Wed, 17 May 2023 12:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684343649;
        bh=rIqgp7czyztNTxjbeT0TWDy5/cpNONc7nlh+3hBbUYk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=U1Ec+9mkcyHnF7+AkMh0oVvZFhqsJJSCXedT55UfFHAzlLQnEYDYZpQczcQI31vcd
         tdjzJYw+1HGx2OpaN4d7a803GvhobfdCNAgTU8j9TXSh84gk1Dftg0unvDoq5omEJU
         qWV7a7zAmHkWNiwJQKAxNBK616OKvL0qRMIuXhuc=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34HHE9J8125638
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 May 2023 12:14:09 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 May 2023 12:14:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 May 2023 12:14:08 -0500
Received: from [10.250.35.184] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34HHE8ta001597;
        Wed, 17 May 2023 12:14:08 -0500
Message-ID: <40a828bc-c1f2-d865-72e5-2171338c6839@ti.com>
Date:   Wed, 17 May 2023 12:14:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] dt-bindings: clock: ehrpwm: Remove unneeded syscon
 compatible
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230516184626.154892-1-afd@ti.com>
 <20230516184626.154892-2-afd@ti.com>
 <373ce50d-37ab-5c25-c50b-20e4f6ae6859@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <373ce50d-37ab-5c25-c50b-20e4f6ae6859@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/23 11:36 PM, Vignesh Raghavendra wrote:
> 
> 
> On 17/05/23 00:16, Andrew Davis wrote:
>> This node's register space is not accessed by any other node, which
>> is the traditional use for the "syscon" hint.
> 
> Unfortunately that's not the case across SoCs. Eg AM65x See  TRM section
> Table 5-582. CTRLMMR_EPWM0_CTRL Register Field Descriptions
> 

Not sure what version of the TRM you have, latest (Rev. E) has this
register as Table 5-636.. but I found it and see your point here.

> TB_CLKEN is clubbed with SYNCIN_SEL and ePWM tripzone configuration
> signals which may require register to be shared with other drivers in future
> 

This looks to only be a problem in AM65x, all later devices we have fixed
the issue and now group the clock enable bits all together.

Do we actually expect this to be an issue and have a user of these
other bits? If so then we modeled this region wrong in AM65x DT, these
registers are not "tbclk gate registers" any more then they are to the
other functions they provide. These registers should be a syscon node
and then each function within should be a child node.

syscon@4140 {
	compatible = "ti,am654-epwm-crtl", "syscon";
	reg = <0x4140 0x18>;

	ehrpwm_tbclk: clock {
		compatible = "ti,am654-ehrpwm-tbclk";
		#clock-cells = <1>;
	};

	pwm_mux: mux-controller {
		compatible = "mmio-mux";
		#mux-control-cells = <1>;
	};
};

Something like that. That way we do not give preference to one device
and have to have it give out shared registers.

Either that or split the binding compatible, one for AM65x with syscon
and one for all later device compatibles that do not share the register:

compatible:
     oneOf:
       - items:
           - const: ti,am654-ehrpwm-tbclk
           - const: syscon
       - items:
         - enum:
           - ti,am64-epwm-tbclk
           - ti,am62-epwm-tbclk

Would rather the first option.

Andrew

> 
>> It looks to have been
>> added here to make use of a Linux kernel helper syscon_node_to_regmap().
>> The Linux driver now uses a more appropriate helper that does not
>> require the hint, so let's remove it from the binding.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   .../devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml     | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
>> index 66765116aff5..64b8bce5962c 100644
>> --- a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
>> +++ b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
>> @@ -16,7 +16,6 @@ properties:
>>             - ti,am654-ehrpwm-tbclk
>>             - ti,am64-epwm-tbclk
>>             - ti,am62-epwm-tbclk
>> -      - const: syscon
>>   
>>     "#clock-cells":
>>       const: 1
>> @@ -33,8 +32,8 @@ additionalProperties: false
>>   
>>   examples:
>>     - |
>> -    ehrpwm_tbclk: syscon@4140 {
>> -        compatible = "ti,am654-ehrpwm-tbclk", "syscon";
>> +    ehrpwm_tbclk: clock@4140 {
>> +        compatible = "ti,am654-ehrpwm-tbclk";
>>           reg = <0x4140 0x18>;
>>           #clock-cells = <1>;
>>       };
> 
