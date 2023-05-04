Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EB66F65FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjEDHnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjEDHnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:43:43 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2400B9D;
        Thu,  4 May 2023 00:43:41 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3447hRSe081816;
        Thu, 4 May 2023 02:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683186207;
        bh=O5z7OUIl+RE/4+MW1xm425hDaNSaOZc0dhC70MCKH5E=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=nvYrQvjfnwFOilOmv5kPPY3DVFCOiZ4pK3TZ9RrLtanlYHrwb8hYYY+a5hDmRiMe1
         j6uAO7iyndxAUGpA7W+HpGdasVei/2EjSOdOlx70gloeVHgN9DL0tD8LxVW7IkChf8
         TEuo613RrwvMukOSBG2B3DRLwyExLCv0FkyhQccI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3447hRBK083800
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 May 2023 02:43:27 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 May 2023 02:43:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 May 2023 02:43:27 -0500
Received: from [172.24.145.195] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3447hN3X028077;
        Thu, 4 May 2023 02:43:24 -0500
Message-ID: <fa6ad8a8-5cf0-0368-8ab4-991902ce38bf@ti.com>
Date:   Thu, 4 May 2023 13:13:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 1/3] dt-bindings: misc: esm: Add ESM support for TI K3
 devices
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <u-kumar1@ti.com>
References: <20230503123212.208457-1-n-francis@ti.com>
 <20230503123212.208457-2-n-francis@ti.com>
 <9ece615f-0a6b-fff4-e129-ea7ca224a6a8@linaro.org>
From:   Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <9ece615f-0a6b-fff4-e129-ea7ca224a6a8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On 04/05/23 12:21, Krzysztof Kozlowski wrote:
> On 03/05/2023 14:32, Neha Malcom Francis wrote:
>> Document the binding for TI K3 ESM (Error Signaling Module) block.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> 
> ???
> 
> You were already asked to keep it and it was in v4, so you had to
> explicitly remove it from your git... It takes me time to figure out
> what is happening here. But ok, if you do not keep my review, comment
> follows.
> 
> ...

Really sorry about that, forgot to add it back for v5. Sending next 
version soon...

> 
>> +  ti,esm-pins:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description:
>> +      integer array of ESM interrupt pins to route to external event pin
>> +      which can be used to reset the SoC.
>> +    minItems: 1
>> +    maxItems: 255
>> +
>> +additionalProperties: false
> 
> Put aditionalProperties after required:, just like in example-schema.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - ti,esm-pins
> 
> 
> 
> Best regards,
> Krzysztof
> 

-- 
Thanking You
Neha Malcom Francis
