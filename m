Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FA860CCE7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiJYNDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJYNDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:03:11 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFC4DBE68;
        Tue, 25 Oct 2022 06:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IevFOjm1jG20XuMQioGWhi3yG2tjhE/B9gkbzFk4dC4=; b=ZxA4KToyOCJ46HayGSwvEQULkG
        rj7wNvfcIBjPqlENft6SrsfV2VjS91PpmLnDR3vyXxdzcBVxv81JI7OqT4MpMcQCPfCKj1BUxfDCY
        5ZU5RRWjJG4SaHWwIeRTWd7EStXtIfU8Elxq3gm57YEeaJGVpIrpIs7J1kFbiiNjaDCDESTN1CT7l
        OAFG/WZ30ZnK16rQ7Tqz8FmmsA55Pl8MdcAsM0EcpaSbbZrRaTWY5pefGC0OKoK678vsfZWamYE7T
        U3sK9DILJRbHWEwUDwfxLkLzVJsKNKfilwMdUku3wPPIlG82eivEIESfkScnT0JH30c7D2caOnjL8
        5FT+fR7A==;
Received: from [89.212.21.243] (port=39850 helo=[192.168.69.85])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1onJYO-007IqY-Ry;
        Tue, 25 Oct 2022 15:01:12 +0200
Message-ID: <a4d3aa78-709a-3aca-c9ff-2a8aedeeb197@norik.com>
Date:   Tue, 25 Oct 2022 15:01:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/3] watchdog: imx2_wdg: suspend watchdog in WAIT mode
Content-Language: en-GB
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, Anson.Huang@nxp.com, festevam@gmail.com,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-imx@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, wim@linux-watchdog.org,
        shawnguo@kernel.org, linux@roeck-us.net
References: <20221025072533.2980154-1-andrej.picej@norik.com>
 <20221025072533.2980154-2-andrej.picej@norik.com>
 <20221025122723.yl5vax7y33ueo2p5@pengutronix.de>
From:   Andrej Picej <andrej.picej@norik.com>
In-Reply-To: <20221025122723.yl5vax7y33ueo2p5@pengutronix.de>
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

Hi Marco,

On 25. 10. 22 14:27, Marco Felsch wrote:
> On 22-10-25, Andrej Picej wrote:
>> Putting device into the "Suspend-To-Idle" mode causes watchdog to
>> trigger and reset the board after set watchdog timeout period elapses.
>>
>> Introduce new device-tree property "fsl,suspend-in-wait" which suspends
>> watchdog in WAIT mode. This is done by setting WDW bit in WCR
>> (Watchdog Control Register) Watchdog operation is restored after exiting
>> WAIT mode as expected. WAIT mode coresponds with Linux's
>> "Suspend-To-Idle".
>>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>> ---
>> Changes in v2:
>>   - validate the property with compatible string, as this functionality
>>     is not supported by all devices.
>> ---
>>   drivers/watchdog/imx2_wdt.c | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
>> index d0c5d47ddede..dd9866c6f1e5 100644
>> --- a/drivers/watchdog/imx2_wdt.c
>> +++ b/drivers/watchdog/imx2_wdt.c
>> @@ -35,6 +35,7 @@
>>   
>>   #define IMX2_WDT_WCR		0x00		/* Control Register */
>>   #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
>> +#define IMX2_WDT_WCR_WDW	BIT(7)		/* -> Watchdog disable for WAIT */
>>   #define IMX2_WDT_WCR_WDA	BIT(5)		/* -> External Reset WDOG_B */
>>   #define IMX2_WDT_WCR_SRS	BIT(4)		/* -> Software Reset Signal */
>>   #define IMX2_WDT_WCR_WRE	BIT(3)		/* -> WDOG Reset Enable */
>> @@ -67,6 +68,27 @@ struct imx2_wdt_device {
>>   	bool ext_reset;
>>   	bool clk_is_on;
>>   	bool no_ping;
>> +	bool sleep_wait;
>> +};
>> +
>> +static const char * const wdw_boards[] __initconst = {
>> +	"fsl,imx25-wdt",
>> +	"fsl,imx35-wdt",
>> +	"fsl,imx50-wdt",
>> +	"fsl,imx51-wdt",
>> +	"fsl,imx53-wdt",
>> +	"fsl,imx6q-wdt",
>> +	"fsl,imx6sl-wdt",
>> +	"fsl,imx6sll-wdt",
>> +	"fsl,imx6sx-wdt",
>> +	"fsl,imx6ul-wdt",
>> +	"fsl,imx7d-wdt",
>> +	"fsl,imx8mm-wdt",
>> +	"fsl,imx8mn-wdt",
>> +	"fsl,imx8mp-wdt",
>> +	"fsl,imx8mq-wdt",
>> +	"fsl,vf610-wdt",
>> +	NULL
>>   };
> 
> For such things we have the data pointer within the struct of_device_id.
Ok, that might clear it up a bit. Thanks.

> 
>>   
>>   static bool nowayout = WATCHDOG_NOWAYOUT;
>> @@ -129,6 +151,9 @@ static inline void imx2_wdt_setup(struct watchdog_device *wdog)
>>   
>>   	/* Suspend timer in low power mode, write once-only */
>>   	val |= IMX2_WDT_WCR_WDZST;
>> +	/* Suspend timer in low power WAIT mode, write once-only */
>> +	if (wdev->sleep_wait)
>> +		val |= IMX2_WDT_WCR_WDW;
>>   	/* Strip the old watchdog Time-Out value */
>>   	val &= ~IMX2_WDT_WCR_WT;
>>   	/* Generate internal chip-level reset if WDOG times out */
>> @@ -313,6 +338,18 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>>   
>>   	wdev->ext_reset = of_property_read_bool(dev->of_node,
>>   						"fsl,ext-reset-output");
>> +
>> +	if (of_property_read_bool(dev->of_node, "fsl,suspend-in-wait"))
> 
> Why do we need this special property? If the device has problems when
> "freeze" is used as suspend mode and this is fixed by this special bit
> then we should enable it if the device supports it.

That was our initial plan and it would be the easiest to do. But since 
it looks like nobody experienced this problem so far, we are somehow 
reluctant to set it by default. What if someone is relying on this 
feature to reset the device if the device is not waken up from "freeze" 
by some other interrupt source?

Best regards,
Andrej
> 
> Regards,
>    Marco
> 
> 
>> +		if (of_device_compatible_match(dev->of_node, wdw_boards))
>> +			wdev->sleep_wait = 1;
>> +		else {
>> +			dev_warn(dev, "Warning: Suspending watchdog during " \
>> +				"WAIT mode is not supported for this device.\n");
>> +			wdev->sleep_wait = 0;
>> +		}
>> +	else
>> +		wdev->sleep_wait = 0;
>> +
>>   	/*
>>   	 * The i.MX7D doesn't support low power mode, so we need to ping the watchdog
>>   	 * during suspend.
>> -- 
>> 2.25.1
>>
>>
>>
