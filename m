Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A2660DBA7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiJZG7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJZG7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:59:19 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF4672FD8;
        Tue, 25 Oct 2022 23:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dFkSfUaqcKDadnSdg6pAVIh7mRl2EJ6mB3zhqhRUTc0=; b=L9znhq3yWHiSTT5cSBNrHsQJWu
        s1SmVYFHFJ68pwuSQAb3FzZin6TELDoVt1sNv2ri95AXxo9EDm0f/m20+K2itl+VvgJgOLoi8qw4z
        gBrlnhdW1JR+ulCEjx15qy9a8i7IzdyQkPa4CD0a432PjuYRgwjeGWgoc0mBnhwOb2JIqp89Qkgcs
        UINtNuZu34vfg+IUTgNgg/x2iU6eU9xmKBSq9WUFYKXx1aMZKhIZbxEdJ3Ns3tOmU5Fy1GhEyMLfG
        XN6AGC1LoIAaZscte5tkujUWaV1+c9DFa2QPmyQG9D6wmR3tXupdDdK9xUcAwtEIVGMcujgCRAweq
        mv25GlNA==;
Received: from [89.212.21.243] (port=59376 helo=[192.168.69.85])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1onaNT-00CD8z-VC;
        Wed, 26 Oct 2022 08:59:13 +0200
Message-ID: <1badfe10-7f5f-9197-6d10-e34a586046df@norik.com>
Date:   Wed, 26 Oct 2022 08:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/3] watchdog: imx2_wdg: suspend watchdog in WAIT mode
Content-Language: en-GB
To:     Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221025072533.2980154-1-andrej.picej@norik.com>
 <20221025072533.2980154-2-andrej.picej@norik.com>
 <bea41e17-0269-d88e-fd22-ad5c5a4b8dac@roeck-us.net>
From:   Andrej Picej <andrej.picej@norik.com>
In-Reply-To: <bea41e17-0269-d88e-fd22-ad5c5a4b8dac@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 25. 10. 22 16:21, Guenter Roeck wrote:
> On 10/25/22 00:25, Andrej Picej wrote:
>> Putting device into the "Suspend-To-Idle" mode causes watchdog to
>> trigger and reset the board after set watchdog timeout period elapses.
>>
> 
> s/reset/resets/
> 
>> Introduce new device-tree property "fsl,suspend-in-wait" which suspends
>> watchdog in WAIT mode. This is done by setting WDW bit in WCR
>> (Watchdog Control Register) Watchdog operation is restored after exiting
> 
> '.' after ')' missing ?
> 
>> WAIT mode as expected. WAIT mode coresponds with Linux's
> 
> s/coresponds/corresponds/
> 
Will fix this in v3, thank you.

>> "Suspend-To-Idle".
>>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>> ---
>> Changes in v2:
>>   - validate the property with compatible string, as this functionality
>>     is not supported by all devices.
>> ---
>>   drivers/watchdog/imx2_wdt.c | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
>> index d0c5d47ddede..dd9866c6f1e5 100644
>> --- a/drivers/watchdog/imx2_wdt.c
>> +++ b/drivers/watchdog/imx2_wdt.c
>> @@ -35,6 +35,7 @@
>>   #define IMX2_WDT_WCR        0x00        /* Control Register */
>>   #define IMX2_WDT_WCR_WT        (0xFF << 8)    /* -> Watchdog Timeout 
>> Field */
>> +#define IMX2_WDT_WCR_WDW    BIT(7)        /* -> Watchdog disable for 
>> WAIT */
>>   #define IMX2_WDT_WCR_WDA    BIT(5)        /* -> External Reset 
>> WDOG_B */
>>   #define IMX2_WDT_WCR_SRS    BIT(4)        /* -> Software Reset 
>> Signal */
>>   #define IMX2_WDT_WCR_WRE    BIT(3)        /* -> WDOG Reset Enable */
>> @@ -67,6 +68,27 @@ struct imx2_wdt_device {
>>       bool ext_reset;
>>       bool clk_is_on;
>>       bool no_ping;
>> +    bool sleep_wait;
>> +};
>> +
>> +static const char * const wdw_boards[] __initconst = {
>> +    "fsl,imx25-wdt",
>> +    "fsl,imx35-wdt",
>> +    "fsl,imx50-wdt",
>> +    "fsl,imx51-wdt",
>> +    "fsl,imx53-wdt",
>> +    "fsl,imx6q-wdt",
>> +    "fsl,imx6sl-wdt",
>> +    "fsl,imx6sll-wdt",
>> +    "fsl,imx6sx-wdt",
>> +    "fsl,imx6ul-wdt",
>> +    "fsl,imx7d-wdt",
>> +    "fsl,imx8mm-wdt",
>> +    "fsl,imx8mn-wdt",
>> +    "fsl,imx8mp-wdt",
>> +    "fsl,imx8mq-wdt",
>> +    "fsl,vf610-wdt",
>> +    NULL
>>   };
>>   static bool nowayout = WATCHDOG_NOWAYOUT;
>> @@ -129,6 +151,9 @@ static inline void imx2_wdt_setup(struct 
>> watchdog_device *wdog)
>>       /* Suspend timer in low power mode, write once-only */
>>       val |= IMX2_WDT_WCR_WDZST;
>> +    /* Suspend timer in low power WAIT mode, write once-only */
>> +    if (wdev->sleep_wait)
>> +        val |= IMX2_WDT_WCR_WDW;
>>       /* Strip the old watchdog Time-Out value */
>>       val &= ~IMX2_WDT_WCR_WT;
>>       /* Generate internal chip-level reset if WDOG times out */
>> @@ -313,6 +338,18 @@ static int __init imx2_wdt_probe(struct 
>> platform_device *pdev)
>>       wdev->ext_reset = of_property_read_bool(dev->of_node,
>>                           "fsl,ext-reset-output");
>> +
>> +    if (of_property_read_bool(dev->of_node, "fsl,suspend-in-wait"))
>> +        if (of_device_compatible_match(dev->of_node, wdw_boards))
>> +            wdev->sleep_wait = 1;
> 
> Since sleep_wait is bool:
>              wdev->sleep_wait = true;
> 
>> +        else {
>> +            dev_warn(dev, "Warning: Suspending watchdog during " \
>> +                "WAIT mode is not supported for this device.\n");
> 
> Do not split strings. "Warning:" is redundant. Please handle the error 
> first.
> 
>> +            wdev->sleep_wait = 0;
> 
> Unnecessary; false by default. Also, this should fail and return -EINVAL.
> Devicetree files should be correct, and warning messages tend to be 
> ignored.
> 
>> +        }
> 
> All branches of if/else need to wither use {} or no {}.
> 
>> +    else
>> +        wdev->sleep_wait = 0;
>> +
> Unnecessary.
> 
> I would suggest to replace the above code with something like
> 
>      if (of_property_read_bool(dev->of_node, "fsl,suspend-in-wait")) {
>          if (!of_device_compatible_match(dev->of_node, wdw_boards)) {
>              dev_err(dev, "Suspending watchdog in WAIT mode is not 
> supported for this device\n");
>              return -EINVAL;
>          }
>          wdev->sleep_wait = true;
>      }

OK, this look cleaner, will use this, thanks.

> 
>>       /*
>>        * The i.MX7D doesn't support low power mode, so we need to ping 
>> the watchdog
>>        * during suspend.
> 
> I still wonder how that interacts with fsl,suspend-in-wait, but since we 
> have a
> property for that we can leave that for someone else to find out. Maybe 
> add a
> comment explaining that interaction with "fsl,suspend-in-wait" is unknown.
I'm assuming that i.MX7D doesn't enter any of low-power modes including 
WAIT mode. If this is the case the watchdog wouldn't get disabled.

Anyway, I will add a short comment regarding the unknown behaviour of 
this property with i.MX7D device.

Best regards,
Andrej
