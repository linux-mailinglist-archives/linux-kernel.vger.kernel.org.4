Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FE274E8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGKIDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjGKIDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:03:15 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A24AF;
        Tue, 11 Jul 2023 01:03:13 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36B831jp003735;
        Tue, 11 Jul 2023 03:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689062581;
        bh=rjsooygLZp8hiL8v3o9Cz9avKfcSEri3Z+I7BSF1yjE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UhK+qwQ/UrMV//1lbDyCZrUR6y042aBa2zlkj70/Z1i3bmkBNbdOPbBvyJ9ZRN9z4
         m/iqXz1V9lhp1pNiWT7dS4BPpTpy7+18YTpFbSR0UcgkRSVfLACSJMGV4e/JZHQJqA
         flMKq29smBXXrKymw6IFHNKhO20ndxvcI+dGsa3I=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36B831Pe120719
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jul 2023 03:03:01 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jul 2023 03:03:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jul 2023 03:03:00 -0500
Received: from [10.24.68.113] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36B82vBh019881;
        Tue, 11 Jul 2023 03:02:58 -0500
Message-ID: <ebc34b27-31b2-b57a-ec0c-fb4e0fa25c1e@ti.com>
Date:   Tue, 11 Jul 2023 13:32:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: ti-serdes-mux: Add defines for SERDES4 in
 J784S4 SoC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <peda@axentia.se>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>
References: <20230710102712.155195-1-j-choudhary@ti.com>
 <d136d58d-9582-3833-861f-086b64c1ad36@linaro.org>
 <ecbb6d34-e024-f6c6-5921-ba7bc6fe2e5e@ti.com>
 <97436a92-2cbd-0498-8aad-444ac3fab99b@linaro.org>
 <d54b0cc2-91d9-b081-fc39-0bbba715ee5b@ti.com>
 <80a43533-f6d6-b498-b677-08f7e608155a@linaro.org>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <80a43533-f6d6-b498-b677-08f7e608155a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/07/23 13:05, Krzysztof Kozlowski wrote:
> On 11/07/2023 09:21, Jayesh Choudhary wrote:
>>
>>
>> On 11/07/23 11:34, Krzysztof Kozlowski wrote:
>>> On 11/07/2023 07:55, Jayesh Choudhary wrote:
>>>> Hello Krzysztof,
>>>>
>>>> On 10/07/23 17:11, Krzysztof Kozlowski wrote:
>>>>> On 10/07/2023 12:27, Jayesh Choudhary wrote:
>>>>>> SERDES4 has 4 lanes. Add lane definitions for it.
>>>>>>
>>>>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>>>>> ---
>>>>>>     include/dt-bindings/mux/ti-serdes.h | 20 ++++++++++++++++++++
>>>>>
>>>>> Where are the users of this binding constants? IOW, why do you need to
>>>>> add these?
>>>>>
>>>>> I don't see users of existing constants either...
>>>>>
>>>>
>>>> These constants are propagated in the idle-state property for the
>>>> mux-controller node (named serdes_ln_ctrl) usually in the final
>>>> board dts files and occasionally in the main dtsi files for TI SoCs.
>>>
>>> So they are not used.
>>
>> 'They' as in SERDES4 definition or others as well??
> 
> I made quick greps and it seems that none of the defines - existing and
> new - are used. But here anyway we talk about this patch, which without
> users does not have any rationale.
These defines are yet to be added. For reference:
https://lore.kernel.org/all/20230522092201.127598-3-s-vadapalli@ti.com/

SERDES4 by default is used for display but it can be configured for 
QSGMII too. There are users for that configuration as well. So it felt 
reasonable to add the definitions for SERDES4 which were missed earlier.

Warm Regards,
-Jayesh
