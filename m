Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9169EDFD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjBVEiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjBVEiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:38:23 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A787E26CE9;
        Tue, 21 Feb 2023 20:38:22 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31M4cH8A101401;
        Tue, 21 Feb 2023 22:38:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677040697;
        bh=GKvB4wt39wazvjgxLwBuc1i2ShFsTAl2PU+LuwkuYoE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Mnc60TBlDl34Hb9XecTmiaRL+4Br85sFrwJPHGPa2fdc43o7q8Q56G0IVKzx5t+93
         64qlS7aJS1MpEhgmruyZMJt7P7u8WE7JlJH14sNwnHiDz8wGMrfMeigADoweVe1RqD
         fM1gr77gD03G2KFVszIwAj+KA1Tz2ecZ9hNqkY2Q=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31M4cHFi030459
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Feb 2023 22:38:17 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Feb 2023 22:38:17 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Feb 2023 22:38:17 -0600
Received: from [10.24.69.79] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31M4cDqw028754;
        Tue, 21 Feb 2023 22:38:14 -0600
Message-ID: <fedc168f-d177-be1b-da0c-3a337857d923@ti.com>
Date:   Wed, 22 Feb 2023 10:08:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [EXTERNAL] Re: [PATCH v10 1/9] dt-bindings: mfd: ti,
 j721e-system-controller: Fix mux node regex
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <nm@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230221120612.27366-1-r-gunasekaran@ti.com>
 <20230221120612.27366-2-r-gunasekaran@ti.com>
 <fa789c44-d9b9-92a6-00f4-7bc2410c7642@ti.com>
 <CAL_JsqKcktHkexxPaneZjaUt=XwLA_5ypZxSZKnX5TozdgJ+Kg@mail.gmail.com>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <CAL_JsqKcktHkexxPaneZjaUt=XwLA_5ypZxSZKnX5TozdgJ+Kg@mail.gmail.com>
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



On 21/02/23 10:34 pm, Rob Herring wrote:
> On Tue, Feb 21, 2023 at 8:00 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>> On 21/02/23 5:36 pm, Ravi Gunasekaran wrote:
>>> mux-controller nodes may not have "reg" property. Update the regex
>>> for such nodes to resolve the dtbs warnings
>>>
>>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>> ---
> 
> Where's the change history? I doubt I ignored the last 9 versions...

This change was added newly in v8.
But based on the review comments, dtbs warnings can be fixed without
changes to bindings document. So this patch will be dropped in the next
series.

Ravi

> 
>>>  .../bindings/mfd/ti,j721e-system-controller.yaml          | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>>> index 76ef4352e13c..532bfa45e6a0 100644
>>> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>>> @@ -45,7 +45,7 @@ properties:
>>>
>>>  patternProperties:
>>>    # Optional children
>>> -  "^mux-controller@[0-9a-f]+$":
>>> +  "^mux-controller(@|-)[0-9a-f]+$":
>>
>> Hmm. mmio-mux bindings allow reg property. Why can't we add the same to
>> mux-controller node in 2/9 ?
> 
> Yes, do that.
> 
> Rob


