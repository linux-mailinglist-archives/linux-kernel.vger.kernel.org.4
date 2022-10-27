Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC0460F10C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiJ0HRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiJ0HRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:17:06 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF22F86FBC;
        Thu, 27 Oct 2022 00:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0S6rJiuhX8jNXI0rbgaAdCOGhsxaVNHZlzXhEJsPRHk=; b=VA6GdLu0uh+/tqe7+tLJIUzK6h
        MSzZK1GfYQh4DIuYWKAcPjU1VrdFOmkEa+yMEt+FVtifayp3gNcIecnDudnukj0JAosXut90+ql5u
        zqJkO+VdyyArKVfpkvmVae/NEXcO1o/lRoVfQF2vLzGvxG/GjjMZi5g0qhGbvqpqa+88JybWVqz69
        y/7IxmtvqKSezNnIGpRSCTa6Crha+mFK34zuZCjUAWzfc8OndnMXUE+vngSAf8BsBCdOihnBAkd0v
        tBtb34AU+OKFdUGlVTR//ysLDLk78an07EkiC0cAcjF2og/TmLPZ9+di7NE1hPGYfOX+PQp2X/GCv
        3oCxHjlw==;
Received: from [89.212.21.243] (port=48966 helo=[192.168.69.85])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1onx8E-0011CT-M0;
        Thu, 27 Oct 2022 09:16:58 +0200
Message-ID: <3909608a-9725-5bfa-a9ac-ca7546479dc2@norik.com>
Date:   Thu, 27 Oct 2022 09:16:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/3] dt-bindings: watchdog: fsl-imx: document suspend
 in wait mode
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-watchdog@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221025072533.2980154-1-andrej.picej@norik.com>
 <20221025072533.2980154-3-andrej.picej@norik.com>
 <ca484809-07e4-44ca-0ab3-26947bda7fa8@linaro.org>
 <a600b0e3-19ab-47df-4315-48b8554cb12f@norik.com>
 <91e83eeb-24b5-4602-c132-c23a2fb5d756@linaro.org>
From:   Andrej Picej <andrej.picej@norik.com>
In-Reply-To: <91e83eeb-24b5-4602-c132-c23a2fb5d756@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 10. 22 16:12, Krzysztof Kozlowski wrote:
> On 26/10/2022 02:38, Andrej Picej wrote:
>> On 25. 10. 22 15:48, Krzysztof Kozlowski wrote:
>>> On 25/10/2022 03:25, Andrej Picej wrote:
>>>> Property "fsl,suspend-in-wait" suspends watchdog in "WAIT" mode which
>>>> corresponds to Linux's Suspend-to-Idle S0 mode. If this property is not
>>>> set and the device is put into Suspend-to-Idle mode, the watchdog
>>>> triggers a reset after 128 seconds.
>>>>
>>>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>>>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>>>> ---
>>>> Changes in v2:
>>>>    - add a commit message,
>>>>    - add a list of devices which support this functionality
>>>> ---
>>>>    .../bindings/watchdog/fsl-imx-wdt.yaml        | 22 +++++++++++++++++++
>>>>    1 file changed, 22 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
>>>> index fb7695515be1..9289de97859b 100644
>>>> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
>>>> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
>>>> @@ -55,6 +55,28 @@ properties:
>>>>          If present, the watchdog device is configured to assert its
>>>>          external reset (WDOG_B) instead of issuing a software reset.
>>>>    
>>>> +  fsl,suspend-in-wait:
>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>> +    description: |
>>>> +      If present, the watchdog device is suspended in WAIT mode
>>>> +      (Suspend-to-Idle). Only supported on following devices:
>>>> +        - "fsl,imx25-wdt",
>>>
>>> You need to define such allow/disallow in allOf:if:then, instead. Like
>>> example-schema is doing for foo-supply, just disallow it for some types
>>> or use "if: not: ..."
>>
>> Sorry missed that. So something like that should be added?:
>>
>>> allOf:
>>>    - if:
>>>        not:
>>>          properties:
>>>            compatible:
>>>              contains:
>>>                enum:
>>>                  - fsl,imx25-wdt
>>>                  - fsl,imx35-wdt
>>>                  - fsl,imx50-wdt
>>>                  - fsl,imx51-wdt
>>>                  - fsl,imx53-wdt
>>>                  - fsl,imx6q-wdt
>>>                  - fsl,imx6sl-wdt
>>>                  - fsl,imx6sll-wdt
>>>                  - fsl,imx6sx-wdt
>>>                  - fsl,imx6ul-wdt
>>>                  - fsl,imx7d-wdt
>>>                  - fsl,imx8mm-wdt
>>>                  - fsl,imx8mn-wdt
>>>                  - fsl,imx8mp-wdt
>>>                  - fsl,imx8mq-wdt
>>>                  - fsl,vf610-wdt
> 
> Yes.
> 
>>>      then:
>>>        properties:
>>>          fsl,suspend-in-wait: false
>>
>> And I'm assuming I can then remove the supported devices list from
>> property description.
> 
> Yes.
> 
>>
>> Are you fine with this, so we don't have to split the compatible list
>> like Alexander suggested? Basically we have the same list of WDW
>> supported devices in the driver.
> 
> I don't know to what you refer.
> 
I'm referring to this comment by Alexander Stein: 
(https://lore.kernel.org/all/13126397.uLZWGnKmhe@steina-w/)

> So the models listed in Documentation/devicetree/bindings/watchdog/fsl-imx-
> wdt.yaml not supporting this feature are
> * fsl,imx21-wdt
> * fsl,imx27-wdt
> * fsl,imx31-wdt
> * fsl,ls1012a-wdt
> * fsl,ls1043a-wdt
> ?
> 
> But all models are listed as compatible to fsl,imx21-wdt. So there is 
> something wrong here. IMHO this sounds like the compatible list has to be 
> split and updated. Depending on that this feature can be detected. Maintaining 
> another list seems error prone to me.

Best regards,
Andrej.
