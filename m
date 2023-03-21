Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BDB6C2907
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 05:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCUEM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 00:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjCUEMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 00:12:25 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7BE3B0DD;
        Mon, 20 Mar 2023 21:10:29 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32L49nWN035452;
        Mon, 20 Mar 2023 23:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679371789;
        bh=9/6jC/J1n3PyWbO7FcVOrORzNo8BISKcwWaH9PypUBA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Ez1Nd6lSYlIHMnka1DQjVRizMQii0ShFjQ0Tl1LzYmaxRGaHAf9sEFSkN0uJXulLl
         wLm/wmi79KvUXu57OiIylEvRRdsynBp0JikiCwonPLjD7vhapRazJ3aop/8Fy9zERa
         IC33PSI+CDjGwzUK8BPhRAh8vSvRN73VHntfhKec=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32L49n28008930
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 23:09:49 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 23:09:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 23:09:49 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32L49kbx009701;
        Mon, 20 Mar 2023 23:09:46 -0500
Message-ID: <647f6bc0-ea2a-7026-d5c8-148fb4bb8c04@ti.com>
Date:   Tue, 21 Mar 2023 09:39:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] dt-bindings: arm: ti: k3: Add compatible for AM62x LP
 SK
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230320051304.2730692-1-vigneshr@ti.com>
 <20230320051304.2730692-2-vigneshr@ti.com>
 <06cbcd7d-bc83-bfeb-0821-72c7caf9a5e7@linaro.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <06cbcd7d-bc83-bfeb-0821-72c7caf9a5e7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/23 20:50, Krzysztof Kozlowski wrote:
> On 20/03/2023 06:13, Vignesh Raghavendra wrote:
>> Add compatible for AM62x SoC based Low Power Starter Kit board[1]
>>
>> [1] https://www.ti.com/tool/SK-AM62-LP
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> index a60a4065caa8..56fdd94bf899 100644
>> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> @@ -29,6 +29,7 @@ properties:
>>          items:
>>            - enum:
>>                - ti,am625-sk
>> +              - ti,am62x-lp-sk
> 
> Don't use wildcards in compatibles... but judging by
> https://www.ti.com/tool/SK-AM62 it looks like model name. If it is truly
> model name, not wildcard, then:

I used the name on the EVM's silk screen. But I think its better to drop
the wildcard. Will respin with that fixed.

FWIW Correct URL is https://www.ti.com/tool/SK-AM62-LP (Boards look very
identical though ;) )

> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Thanks

-- 
Regards
Vignesh
