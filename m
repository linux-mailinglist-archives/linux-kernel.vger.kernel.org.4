Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C6860DB70
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiJZGin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZGik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:38:40 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CB978BE1;
        Tue, 25 Oct 2022 23:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=02WNvwWbhiZXAK+Og8doakRElfSqkd+xgpF6EcyVeOM=; b=nQR6d81So8H6ulfbWo6w7/62Tt
        9UIBku5apau5ZsllmmiPChLLKmg2pxmQU7Vwh0mDmmUvSJUruAs3oH6tGup7hPM3fIhPm7ElGJSFm
        loIwEsEpau1Z2sXlifkO1uBXoexL/1tlUscOzRH2Gn2OogFyejupy6hRPw+s10Jb+yD57lFuRPH4v
        rA/pw9R0qwNgRz98kheULOFiOl9FBZ09Cryy8CdLdEaoB9anCmzRj7CFfBqYEByudVfjQMIbKECdx
        wzpuzuFb3voX7p/rU8XrEeYSx+LTx5Wwq/dXdAqdTRlkGqTfvarMCLZbkxdXzAR7Y7BsjnUp1hBIJ
        MQWXxddQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:46054 helo=[192.168.69.85])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1ona3S-00C9YI-Mx;
        Wed, 26 Oct 2022 08:38:31 +0200
Message-ID: <a600b0e3-19ab-47df-4315-48b8554cb12f@norik.com>
Date:   Wed, 26 Oct 2022 08:38:32 +0200
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
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221025072533.2980154-1-andrej.picej@norik.com>
 <20221025072533.2980154-3-andrej.picej@norik.com>
 <ca484809-07e4-44ca-0ab3-26947bda7fa8@linaro.org>
From:   Andrej Picej <andrej.picej@norik.com>
In-Reply-To: <ca484809-07e4-44ca-0ab3-26947bda7fa8@linaro.org>
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
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 10. 22 15:48, Krzysztof Kozlowski wrote:
> On 25/10/2022 03:25, Andrej Picej wrote:
>> Property "fsl,suspend-in-wait" suspends watchdog in "WAIT" mode which
>> corresponds to Linux's Suspend-to-Idle S0 mode. If this property is not
>> set and the device is put into Suspend-to-Idle mode, the watchdog
>> triggers a reset after 128 seconds.
>>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>> ---
>> Changes in v2:
>>   - add a commit message,
>>   - add a list of devices which support this functionality
>> ---
>>   .../bindings/watchdog/fsl-imx-wdt.yaml        | 22 +++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
>> index fb7695515be1..9289de97859b 100644
>> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
>> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
>> @@ -55,6 +55,28 @@ properties:
>>         If present, the watchdog device is configured to assert its
>>         external reset (WDOG_B) instead of issuing a software reset.
>>   
>> +  fsl,suspend-in-wait:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description: |
>> +      If present, the watchdog device is suspended in WAIT mode
>> +      (Suspend-to-Idle). Only supported on following devices:
>> +        - "fsl,imx25-wdt",
> 
> You need to define such allow/disallow in allOf:if:then, instead. Like
> example-schema is doing for foo-supply, just disallow it for some types
> or use "if: not: ..."

Sorry missed that. So something like that should be added?:

> allOf:
>   - if:
>       not:
>         properties:
>           compatible:
>             contains:
>               enum:
>                 - fsl,imx25-wdt
>                 - fsl,imx35-wdt
>                 - fsl,imx50-wdt
>                 - fsl,imx51-wdt
>                 - fsl,imx53-wdt
>                 - fsl,imx6q-wdt
>                 - fsl,imx6sl-wdt
>                 - fsl,imx6sll-wdt
>                 - fsl,imx6sx-wdt
>                 - fsl,imx6ul-wdt
>                 - fsl,imx7d-wdt
>                 - fsl,imx8mm-wdt
>                 - fsl,imx8mn-wdt
>                 - fsl,imx8mp-wdt
>                 - fsl,imx8mq-wdt
>                 - fsl,vf610-wdt
>     then:
>       properties:
>         fsl,suspend-in-wait: false

And I'm assuming I can then remove the supported devices list from 
property description.

Are you fine with this, so we don't have to split the compatible list 
like Alexander suggested? Basically we have the same list of WDW 
supported devices in the driver.

Thank you for your review,
Andrej
